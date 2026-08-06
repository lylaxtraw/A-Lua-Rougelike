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

return CombatMath