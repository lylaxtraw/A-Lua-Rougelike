local Constants = require("core.constants")

local Player = {}

function Player.Create(name)
    return {
        name = name,
        level = 1,
        xp = 0,
        wave = 1,

        -- Base stats: Permanent, saved, and scaled by level-ups
        baseHp = Constants.Player.BASE_HP,
        baseMana = Constants.Player.BASE_MANA,
        baseAtk = Constants.Player.BASE_ATK,
        baseDef = Constants.Player.BASE_DEF,

        -- Active stats: Modified by charms/gear dynamically
        maxHp = Constants.Player.BASE_HP,
        hp = Constants.Player.BASE_HP,
        maxMana = Constants.Player.BASE_MANA,
        mana = Constants.Player.BASE_MANA,
        atk = Constants.Player.BASE_ATK,
        def = Constants.Player.BASE_DEF,

        gold = Constants.Player.BASE_GOLD,
        weapon = "fists",
        shield = "none",
        charm = nil,

        inventory = {
            weapons = { fists = true },
            shields = { none = true },
            potions = { full_restore = 1, mana_restore = 1 },
            spells = { itchy_pollen = true }
        },

        run = { victories = 0, completed = false }
    }
end

function Player.Recalculate(player)
    -- 1. Reset active stats back to the safe base level
    player.maxHp = player.baseHp
    player.maxMana = player.baseMana
    player.atk = player.baseAtk
    player.def = player.baseDef

    -- 2. Ensure current HP/Mana don't magically exceed the new maxes
    player.hp = math.min(player.hp, player.maxHp)
    player.mana = math.min(player.mana, player.maxMana)
end

return Player