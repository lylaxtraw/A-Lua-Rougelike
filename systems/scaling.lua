local Constants = require("core.constants")

local Scaling = {}

-- Safely scales numbers and prevents the "math.floor trap" on tiny integers
local function Grow(current, scale)
    local newVal = math.floor(current * scale)
    if newVal <= current and scale > 1.0 then
        return current + 1
    end
    return newVal
end

function Scaling.RequiredXP(level)
    return math.floor(Constants.Progression.XP_BASE * (Constants.Progression.XP_SCALE ^ (level - 1)))
end

function Scaling.LevelUp(player)
    player.level = player.level + 1

    player.baseHp = Grow(player.baseHp or player.maxHp, Constants.Progression.HP_SCALE)
    player.baseMana = Grow(player.baseMana or player.maxMana, Constants.Progression.MANA_SCALE)
    player.baseAtk = Grow(player.baseAtk or player.atk, Constants.Progression.ATK_SCALE)
    player.baseDef = Grow(player.baseDef or player.def, Constants.Progression.DEF_SCALE)

    -- Push new base to active stats
    player.maxHp = player.baseHp
    player.maxMana = player.baseMana
    player.atk = player.baseAtk
    player.def = player.baseDef
    
    -- Heal
    player.hp = player.maxHp
    player.mana = player.maxMana
end

function Scaling.Enemy(enemy, wave)
    local hpScale = 1 + ((wave - 1) * Constants.EnemyScaling.HP_PER_WAVE)
    local atkScale = 1 + ((wave - 1) * Constants.EnemyScaling.ATK_PER_WAVE)
    local defScale = 1 + ((wave - 1) * Constants.EnemyScaling.DEF_PER_WAVE)
    local rewardScale = 1 + ((wave - 1) * Constants.EnemyScaling.REWARD_PER_WAVE)

    enemy.maxHp = Grow(enemy.maxHp, hpScale)
    enemy.atk = Grow(enemy.atk, atkScale)
    enemy.def = Grow(enemy.def, defScale)
    
    enemy.gold = math.floor((enemy.gold or 0) * rewardScale)
    enemy.xp = math.floor((enemy.xp or 0) * rewardScale)
end

return Scaling