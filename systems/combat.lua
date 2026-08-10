local CombatMath = require("systems.combat_math")
local EventQueue = require("core.event_queue")
local Weapons = require("data.weapons")
local Shields = require("data.shields")
local Spells = require("data.spells")
<<<<<<< HEAD
local Potions = require("systems.potion_system")
=======
local Status = require("data.status")
local Potions = require("systems.potion_system")
local Type = require("data.enemies")
>>>>>>> v0.1.0

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

<<<<<<< HEAD
=======
local function CombatTickStatus(state)
    local player, enemy = state.player, state.enemy
    if player.status and player.status.type then
        local status = Status.List[player.status.type]
        if status and status.tick then
            local damage = status.tick(player, enemy)
            Push(state, "STATUS_TICK", { target = player.name, status = player.status.type, damage = damage })
        end
    end

    if enemy.status and enemy.status.type then
        local status = Status.List[enemy.status.type]
        if status and status.tick then
            local damage = status.tick(enemy, player)
            Push(state, "STATUS_TICK", { target = enemy.name, status = enemy.status.type, damage = damage })
        end
    end
end

>>>>>>> v0.1.0
local function EnemyTurn(state)
    if state.finished then return end
    local player, enemy = state.player, state.enemy

<<<<<<< HEAD
=======
    -- FIX: Apply status effects at the start of the enemy's turn
    CombatTickStatus(state)

>>>>>>> v0.1.0
    if enemy.paralyzed then
        Push(state, "TEXT", { text = enemy.name .. " is paralyzed and cannot move!" })
        enemy.paralyzed = false
        return
    end

<<<<<<< HEAD
=======
    if enemy.rooted then
        local movement = enemy.rooted.atkchance or 0
        if math.random(4) == movement then
            Push(state, "TEXT", { text = enemy.name .. " is rooted and cannot move!" })
        end
    end

>>>>>>> v0.1.0
    local shield = Shield(player)
    local result = CombatMath.EnemyDamage(enemy, player, shield, player.defending)
    player.hp = math.max(0, player.hp - result.damage)

    Push(state, "ENEMY_ATTACK", { attacker = enemy.name, damage = result.damage, critical = result.critical })
<<<<<<< HEAD

=======
>>>>>>> v0.1.0
    if (result.reflected or 0) > 0 then
        enemy.hp = math.max(0, enemy.hp - result.reflected)
        Push(state, "TEXT", { text = "Reflected " .. result.reflected .. " damage back!" })
        if enemy.hp <= 0 then return Victory(state) end
    end
<<<<<<< HEAD
=======
    
    if (enemy.id == "red_slime" or enemy.element == "fire") and enemy.burnAttack == 0.1 then
        player.status = player.status or { id = {} }
        player.status.id = player.status.id or {}
        player.status.id.burn = true
        Push(state, "TEXT", { text = player.name .. " is burned by the fire attack!" })
    end

    if enemy.element == "thunder" then
        local par_chance = math.random(1, 100)
        if par_chance <= 25 then
            player.status = player.status or { id = {} }
            player.status.id = player.status.id or {}
            player.status.id.paralysis = true
            Push(state, "TEXT", { text = player.name .. " is paralyzed by the enemy's thunder attack!" })
        end
    end

    if enemy.element == "ice" then
        local frostbite_chance = math.random(1, 100)
        if frostbite_chance <= 10 then
            player.status = player.status or { id = {} }
            player.status.id = player.status.id or {}
            player.status.id.frostbite = true
            player.frostbited = true
            Push(state, "TEXT", { text = player.name .. " is frostbited by the enemy's ice attack!" })
        end
    end

    -- FIX: Real damage from burn, scorch, rooted, hail, and flower effects on the enemy
    if enemy.burn and enemy.burnDamageEnemy then
        enemy.hp = math.max(0, enemy.hp - enemy.burnDamageEnemy)
        Push(state, "TEXT", { text = enemy.name .. " is burned and takes " .. enemy.burnDamageEnemy .. " damage!" })
        if enemy.hp <= 0 then return Victory(state) end
    end

    if enemy.scorch and enemy.scorchDamage then
        enemy.hp = math.max(0, enemy.hp - enemy.scorchDamage)
        Push(state, "TEXT", { text = enemy.name .. " is scorched and takes " .. enemy.scorchDamage .. " damage!" })
        if enemy.hp <= 0 then return Victory(state) end
    end

    if enemy.rooted and enemy.rootedDamage then
        enemy.hp = math.max(0, enemy.hp - enemy.rootedDamage)
        Push(state, "TEXT", { text = enemy.name .. " is rooted and takes " .. enemy.rootedDamage .. " damage!" })
        if enemy.hp <= 0 then return Victory(state) end
    end

    if enemy.hail and enemy.hailDamageEnemy then
        enemy.hp = math.max(0, enemy.hp - enemy.hailDamageEnemy)
        Push(state, "TEXT", { text = enemy.name .. " takes " .. enemy.hailDamageEnemy .. " damage from the hail!" })
        if enemy.hp <= 0 then return Victory(state) end
    end

    if enemy.flower and enemy.flowerDamageEnemy then
        enemy.hp = math.max(0, enemy.hp - enemy.flowerDamageEnemy)
        Push(state, "TEXT", { text = enemy.name .. " is drained by the flower and takes " .. enemy.flowerDamageEnemy .. " damage!" })
        if enemy.hp <= 0 then return Victory(state) end
    end
>>>>>>> v0.1.0

    if player.hp <= 0 then Defeat(state) end
end

local function Attack(state)
    local player, enemy = state.player, state.enemy
<<<<<<< HEAD
    
=======
>>>>>>> v0.1.0
    if enemy.isRuler then
        Push(state, "TEXT", { text = "The Ruler is immune to physical attacks!" })
        return EnemyTurn(state)
    end

<<<<<<< HEAD
=======
    -- FIX: Validation of paralyzed & frostbited status before allowing the player to attack
    if player.paralyzed then
        Push(state, "TEXT", { text = player.name .. " is paralyzed and cannot move!" })
        player.paralyzed = false
        return EnemyTurn(state)
    end

    if player.frostbited then
        Push(state, "TEXT", { text = player.name .. " is frostbited and cannot move!" })
        return EnemyTurn(state)
    end

>>>>>>> v0.1.0
    local weapon = Weapon(player)
    local result = CombatMath.PlayerDamage(player, enemy, weapon)

    enemy.hp = math.max(0, enemy.hp - result.damage)
    Push(state, "PLAYER_ATTACK", { weapon = weapon.name, damage = result.damage, critical = result.critical })

<<<<<<< HEAD
    -- ANGER POINT ABILITY (Fixed text to match the 1.5x multiplier!)
=======
>>>>>>> v0.1.0
    if result.critical and enemy.ability == "anger_point" then
        enemy.atk = enemy.atk * 1.5
        Push(state, "TEXT", { text = enemy.name .. "'s Anger Point triggered! Its attack surged!" })
    end
<<<<<<< HEAD

=======
>>>>>>> v0.1.0
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

<<<<<<< HEAD
    -- THE FIX: Push the spell's flavour text to the combat log before resolving it!
=======
>>>>>>> v0.1.0
    if spell.flavour then
        Push(state, "TEXT", { text = spell.flavour })
    end

    if enemy.isMaster then
        player.mana = player.mana - spell.manaCost
<<<<<<< HEAD
        Push(state, "TEXT", { text = "The Slime Master is a wall of flesh! Spells do nothing!" })
        return EnemyTurn(state)
    end

    -- Elemental Matchups
=======
        Push(state, "TEXT", { text = "The " .. enemy.name .. " Master is a wall of flesh! Spells do nothing!" })
        return EnemyTurn(state)
    end

>>>>>>> v0.1.0
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
<<<<<<< HEAD
        Push(state, "TEXT", { text = "The Ruler shrugs off the attack. Only its weakness can pierce its aura!" })
=======
        Push(state, "TEXT", { text = "The " .. enemy.name .. " Ruler shrugs off the attack. Only its weakness can pierce its aura!" })
>>>>>>> v0.1.0
    end

    player.mana = player.mana - spell.manaCost

    local function spellPushEvent(eventType, data)
        if eventType == "SPELL_CAST" then data.damage = math.floor(data.damage * damageMult) end
        Push(state, eventType, data)
<<<<<<< HEAD
=======
        if eventType == "STATUS_APPLIED" then
            local status = Status.List[data.status]
            if status and status.apply then status.apply(enemy, player) end
        end
>>>>>>> v0.1.0
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
<<<<<<< HEAD
=======

    if enemy.isRuler then
        Push(state, "TEXT", { text = "The " .. enemy.name .. " Ruler's aura is overwhelming! Find a way to pierce it!" })
    end

    if enemy.isMaster then
        Push(state, "TEXT", { text = "The " .. enemy.name .. " Master is a wall of flesh! Spells do nothing!" })
    end
>>>>>>> v0.1.0
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