local Shields = {}

Shields.Data = {
    none = {
        id = "none",
        name = "None",
        description = "Trusting your body alone is a dangerous lifestyle.",
        stats = "+0% DEF",
        defenseMultiplier = 1,
        price = 0
    },
    basic_shield = {
        id = "basic_shield",
        name = "Basic Shield",
        description = "Wood. Metal. Reliability. Sometimes that's enough.",
        stats = "+50% DEF",
        defenseMultiplier = 1.5,
        price = 100
    },
    rounded_shield = {
        id = "rounded_shield",
        name = "Rounded Shield",
        description = "Its curved frame redirects force surprisingly well.",
        stats = "+100% DEF",
        defenseMultiplier = 2,
        price = 250
    },
    wide_block = {
        id = "wide_block",
        name = "Wide Block",
        description = "Less elegant than hiding behind a wall, but close enough.",
        stats = "+150% DEF",
        defenseMultiplier = 2.5,
        price = 600
    },
    magical_barrier = {
        id = "magical_barrier",
        name = "Magical Barrier",
        description = "A floating shield sustained entirely by magical energy.",
        stats = "+400% DEF | Mana Drain",
        defenseMultiplier = 5,
        manaDrain = 15,
        price = 1500
    },
    spiky_back = {
        id = "spiky_back",
        name = "Spiky Back",
        description = "Attackers regret touching it almost immediately.",
        stats = "+200% DEF | Thorn Damage",
        defenseMultiplier = 3,
        thornDamage = 5,
        price = 3000
    },
    paladin_shield = {
        id = "paladin_shield",
        name = "Paladin's Shield",
        description = "Blessed steel crafted for frontline guardians.",
        stats = "+700% DEF | +10 Mana",
        defenseMultiplier = 8,
        manaBonus = 10,
        price = 5500
    },
    obsidian_cover = {
        id = "obsidian_cover",
        name = "Obsidian Cover Up",
        description = "Heavy volcanic plating capable of stopping devastating blows.",
        stats = "+900% DEF",
        defenseMultiplier = 10,
        price = 10000
    },
    mystical_power_palm = {
        id = "mystical_power_palm",
        name = "Mystical Power Palm",
        description = "A defensive martial stance refined through spiritual discipline.",
        stats = "+250% DEF | +15 HP",
        defenseMultiplier = 3.5,
        hpBonus = 15,
        price = 25000
    },
    monk_counter_stance = {
        id = "monk_counter_stance",
        name = "Monk's Counter Stance",
        description = "True masters turn enemy force into their own strength.",
        stats = "+300% DEF | Counter | Mana Gain",
        defenseMultiplier = 4,
        counter = true,
        price = 60000
    },
    glorious_spiritual_field = {
        id = "glorious_spiritual_field",
        name = "Glorious Spiritual Field",
        description = "A radiant barrier that bends attacks back toward their source.",
        stats = "+1900% DEF | 50% Reflect",
        defenseMultiplier = 20,
        reflectPercent = 0.5,
        price = 250000
    }
}

function Shields.Get(id)
    return Shields.Data[id]
end

return Shields