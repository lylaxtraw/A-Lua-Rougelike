local CombatMath = require("systems.combat_math")
local EventQueue = require("core.event_queue")
local Weapons = require("data.weapons")
local Shields = require("data.shields")
local Spells = require("data.spells")
local Potions = require("systems.potion_system")

local Combat = {}

-- Spell Elements Mapping
local SpellElements = {
    itchy_pollen = "grass", leafy_brew = "grass", rooted_beating = "grass", sundowmer_bloom = "grass",
    fire_ball = "fire", lava_burst = "fire", magmatic_downpour = "fire",
    icicle_rush = "ice", iceberg_crush = "ice", frozen_barrage = "ice",
    zappy_touch = "thunder", lightning_dodge = "thunder", thunderous_roaring = "thunder",
    rocky_punch = "earth", spiky_cannon = "earth", meteor_impact = "earth",
    superior_mana_blast = "true"
}

-- Type Chart (Key takes x2 from Value, takes x0 from what it resists)
local Weaknesses = { earth = "grass", thunder = "earth", fire = "thunder", ice = "fire", grass = "ice" }
local Resists = { earth = "thunder", thunder = "fire", fire = "ice", ice = "grass", grass = "earth" }

local function Weapon(player) return Weapons.Get(player.weapon) end
local function Shield(player) return Shields.Get(player.shield) end
local function Push(state, eventType, data) EventQueue.Push(state.events, eventType, data) end

local function Victory(state)
    local player = state.player
    local enemy = state.enemy
    player.gold = player.gold + (enemy.gold or 0)
    player.xp = player.xp + (enemy.xp or 0)
    Push(state, "ENEMY_DEFEATED", { enemy = enemy.name, gold = enemy.gold, xp = enemy.xp })
    state.finished = true
    state.result = "victory"
end

local function Defeat(state)
    Push(state, "PLAYER_DEFEATED", { player = state.player.name })
    state.finished = true
    state.result = "defeat"
end

local function EnemyTurn(state)
    if state.finished then return end
    local player, enemy = state.player, state.enemy

    if enemy.paralyzed then
        Push(state, "TEXT", { text = enemy.name .. " is paralyzed and cannot move!" })
        enemy.paralyzed = false
        return
    end

    local shield = Shield(player)
    local result = CombatMath.EnemyDamage(enemy, player, shield, player.defending)
    player.hp = math.max(0, player.hp - result.damage)

    Push(state, "ENEMY_ATTACK", { attacker = enemy.name, damage = result.damage, critical = result.critical })

    if (result.reflected or 0) > 0 then
        enemy.hp = math.max(0, enemy.hp - result.reflected)
        Push(state, "TEXT", { text = "Reflected " .. result.reflected .. " damage back!" })
        if enemy.hp <= 0 then return Victory(state) end
    end

    if player.hp <= 0 then Defeat(state) end
end

local function Attack(state)
    local player, enemy = state.player, state.enemy
    
    if enemy.isRuler then
        Push(state, "TEXT", { text = "The Ruler is immune to physical attacks!" })
        return EnemyTurn(state)
    end

    local weapon = Weapon(player)
    local result = CombatMath.PlayerDamage(player, enemy, weapon)

    enemy.hp = math.max(0, enemy.hp - result.damage)
    Push(state, "PLAYER_ATTACK", { weapon = weapon.name, damage = result.damage, critical = result.critical })

    -- ANGER POINT ABILITY (Fixed text to match the 1.5x multiplier!)
    if result.critical and enemy.ability == "anger_point" then
        enemy.atk = enemy.atk * 1.5
        Push(state, "TEXT", { text = enemy.name .. "'s Anger Point triggered! Its attack surged!" })
    end

    if enemy.hp <= 0 then return Victory(state) end
    EnemyTurn(state)
end

local function CastSpell(state, spellId)
    local player, enemy = state.player, state.enemy
    local spell = Spells.Get(spellId)
    local element = SpellElements[spellId] or "true"

    if player.mana < spell.manaCost then
        Push(state, "NOT_ENOUGH_MANA", { spell = spell.name })
        return
    end

    -- THE FIX: Push the spell's flavour text to the combat log before resolving it!
    if spell.flavour then
        Push(state, "TEXT", { text = spell.flavour })
    end

    if enemy.isMaster then
        player.mana = player.mana - spell.manaCost
        Push(state, "TEXT", { text = "The Slime Master is a wall of flesh! Spells do nothing!" })
        return EnemyTurn(state)
    end

    -- Elemental Matchups
    local damageMult = 1.0
    if enemy.element then
        if Weaknesses[enemy.element] == element then
            damageMult = 2.0
            Push(state, "TEXT", { text = "It's super effective!" })
        elseif Resists[enemy.element] == element then
            damageMult = 0.0
            Push(state, "TEXT", { text = "It's not very effective... (0 DMG)" })
        end
    end

    if enemy.isRuler and damageMult < 2.0 and element ~= "true" then
        damageMult = 0.0
        Push(state, "TEXT", { text = "The Ruler shrugs off the attack. Only its weakness can pierce its aura!" })
    end

    player.mana = player.mana - spell.manaCost

    local function spellPushEvent(eventType, data)
        if eventType == "SPELL_CAST" then data.damage = math.floor(data.damage * damageMult) end
        Push(state, eventType, data)
    end

    spell.cast(player, enemy, spellPushEvent)

    if enemy.hp <= 0 then return Victory(state) end
    EnemyTurn(state)
end

local function UsePotion(state, potionId)
    local success, message = Potions.Use(state.player, potionId)
    if not success then return end
    Push(state, "POTION_USED", { potion = potionId, text = message })
    EnemyTurn(state)
end

function Combat.CreateState(player, enemy)
    local state = { player = player, enemy = enemy, finished = false, events = EventQueue.Create() }
    Push(state, "COMBAT_START", { enemy = enemy.name })
    if enemy.isElite then
        Push(state, "TEXT", { text = "Elite " .. enemy.name .. "'s aura has manifested! All of its stats received a boost!" })
    end
    return state
end

function Combat.ProcessAction(state, action, data)
    if state.finished then return end
    EventQueue.Clear(state.events)
    if action == "attack" then Attack(state)
    elseif action == "defend" then state.player.defending = true; Push(state, "PLAYER_DEFENDING", {}); EnemyTurn(state); state.player.defending = false
    elseif action == "spell" then CastSpell(state, data)
    elseif action == "potion" then UsePotion(state, data)
    elseif action == "flee" then Push(state, "PLAYER_FLED", {}); state.finished = true; state.result = "flee" end
end

return Combat