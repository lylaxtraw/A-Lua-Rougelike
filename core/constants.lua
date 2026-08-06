local Constants = {}

Constants.Combat = {
    PLAYER_CRIT_CHANCE = 10,
    ENEMY_CRIT_CHANCE = 5,
    CRIT_MULTIPLIER = 2,
    DEFEND_MULTIPLIER = 0.5,
    MIN_DAMAGE = 1
}

Constants.Progression = {
    XP_BASE = 100,
    XP_SCALE = 1.35,
    HP_SCALE = 1.12,
    MANA_SCALE = 1.10,
    ATK_SCALE = 1.15,
    DEF_SCALE = 1.10
}

Constants.EnemyScaling = {
    HP_PER_WAVE = 0.12,
    ATK_PER_WAVE = 0.08,
    DEF_PER_WAVE = 0.05,
    REWARD_PER_WAVE = 0.10
}

Constants.Player = {
    BASE_HP = 50,
    BASE_MANA = 25,
    BASE_ATK = 1,
    BASE_DEF = 1,
    BASE_GOLD = 100
}

return Constants