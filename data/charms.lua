local Charms = {}

Charms.List = {
    lucky = {
        id = "lucky",
        name = "Lucky Charm",
        tier = 1,
        modifiers = { critBonus = 35, luckBonus = 35 }
    },
    vampiric = {
        id = "vampiric",
        name = "Vampiric Charm",
        tier = 1,
        modifiers = { lifesteal = 0.125 }
    },
    magic = {
        id = "magic",
        name = "Magic Charm",
        tier = 1,
        modifiers = { spellDamage = 1.20, spellCost = 1.35 }
    },
    exchange = {
        id = "exchange",
        name = "Exchange Charm",
        tier = 2,
        modifiers = { outgoingDamage = 2.0, incomingDamage = 2.0 }
    },
    challenge = {
        id = "challenge",
        name = "Challenge Charm",
        tier = 2,
        modifiers = { enemyScaling = 1.50, bonusXP = 2.0, bonusGold = 2.0 }
    },
    pacifist = {
        id = "pacifist",
        name = "Pacifist Charm",
        tier = 2,
        modifiers = {
            shieldPower = 3.0,
            maxHp = 1.50,
            maxMana = 1.50,
            disableAttacks = true,
            disableSpells = true,
            forcedShield = "spiky_back"
        }
    },
    violent = {
        id = "violent",
        name = "Violent Charm",
        tier = 2,
        modifiers = {
            attackDamage = 3.0,
            spellDamage = 3.0,
            maxMana = 2.0,
            disableDefense = true,
            disablePotions = true,
            forcedWeapon = "combat_knife"
        }
    },
    rouge = {
        id = "rouge",
        name = "Rouge Charm",
        tier = 2,
        modifiers = { levelBonus = 2.0, disableHealing = true, enemyScaling = 0.75 }
    },
    speed = {
        id = "speed",
        name = "Speed Charm",
        tier = 2,
        modifiers = { skipScaling = 0.10, enemyScaling = 1.50 }
    },
    greedy = {
        id = "greedy",
        name = "Greedy Charm",
        tier = 3,
        modifiers = { goldScaling = 0.001, bonusGold = 1.25, shopScaling = 1.50 }
    },
    chaos = {
        id = "chaos",
        name = "Chaos Charm",
        tier = 3,
        modifiers = { chaosMode = true, critChance = 75 }
    },
    natural = {
        id = "natural",
        name = "Natural Charm",
        tier = 3,
        modifiers = { naturalBoost = 2.0, disableShop = true, enemyScaling = 1.50, xpReduction = 0.90 }
    },
    calm = {
        id = "calm",
        name = "Calm Charm",
        tier = 3,
        modifiers = { shieldGold = 10, shieldMana = 10, priceGrowth = 0.01 }
    },
    expert = {
        id = "expert",
        name = "Expert Charm",
        tier = 4,
        modifiers = { composite = { "exchange", "challenge", "rouge" } }
    },
    champion = {
        id = "champion",
        name = "Champion Charm",
        tier = 4,
        modifiers = { composite = { "vampiric", "magic", "violent" } }
    },
    guardian = {
        id = "guardian",
        name = "Guardian Charm",
        tier = 4,
        modifiers = { composite = { "lucky", "pacifist", "greedy" } }
    },
    master = {
        id = "master",
        name = "Master Charm",
        tier = 4,
        modifiers = { outgoingDamage = 2.0, incomingDamage = 2.0, enemyScaling = 1.50, disableHealing = true }
    },
    insanity = {
        id = "insanity",
        name = "Insanity Charm",
        tier = 5,
        modifiers = { composite = { "master", "champion", "chaos" }, hardcore = true }
    }
}

function Charms.Get(id)
    return Charms.List[id]
end

return Charms