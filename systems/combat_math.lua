local Constants = require("core.constants")

local CombatMath = {}

local function ClampMinimum(value, minimum)
    if value < minimum then return minimum end
    return value
end

function CombatMath.PlayerDamage(player, enemy, weapon)
    local atk = player.atk or 1
    local enemyDef = enemy.def or 1
    local multiplier = weapon and weapon.damageMultiplier or 1

    local flatBonus = weapon and weapon.damageMultiplier and (weapon.damageMultiplier * 2) or 0

    -- NEW MATH: Subtraction instead of division
    local baseDamage = ((atk * multiplier) + flatBonus) - enemyDef
    local critical = math.random(100) <= (player.critChance or Constants.Combat.PLAYER_CRIT_CHANCE)

    if critical then
        baseDamage = baseDamage * Constants.Combat.CRIT_MULTIPLIER
    end

    local damage = ClampMinimum(math.floor(baseDamage), Constants.Combat.MIN_DAMAGE)

    return {
        damage = damage,
        critical = critical,
        paralysis = weapon and weapon.paralysis or false,
        burn = weapon and weapon.burn or false,
        scorch = weapon and weapon.scorch or false
    }
end

function CombatMath.EnemyDamage(enemy, player, shield, defending)
    local enemyAtk = enemy.atk or 1
    local playerDef = player.def or 1
    local shieldMultiplier = shield and shield.defenseMultiplier or 1
    local totalDefense = playerDef * shieldMultiplier

    -- NEW MATH: Subtraction instead of division
    local baseDamage = enemyAtk - totalDefense
    local critical = math.random(100) <= (enemy.critChance or enemy.criticalChance or Constants.Combat.ENEMY_CRIT_CHANCE)

    if critical then
        baseDamage = baseDamage * Constants.Combat.CRIT_MULTIPLIER
    end

    if defending then
        baseDamage = baseDamage * Constants.Combat.DEFEND_MULTIPLIER
    end

    local damage = ClampMinimum(math.floor(baseDamage), Constants.Combat.MIN_DAMAGE)

    return {
        damage = damage,
        critical = critical,
        reflected = shield and shield.reflectedDamage or 0
    }
end

<<<<<<< HEAD
=======
-- ========================================================
-- TDD/BUSTED TESTS
-- ========================================================

-- Type Chart (Key takes x2 from Value, takes x0 from what it resists)
local Weaknesses = { earth = "grass", thunder = "earth", fire = "thunder", ice = "fire", grass = "ice" }
local Resists = { earth = "thunder", thunder = "fire", fire = "ice", ice = "grass", grass = "earth" }

function CombatMath.calculate_damage(attack_element, defense_element, base_damage, is_critical)
    local multiplier = 1

    if Weaknesses[defense_element] == attack_element then
        multiplier = 2
    elseif Resists[defense_element] == attack_element then
        multiplier = 0
    end

    local final_damage = base_damage * multiplier

    if is_critical then
        final_damage = final_damage * 1.5
    end

    return math.floor(final_damage)
end

>>>>>>> v0.1.0
return CombatMath