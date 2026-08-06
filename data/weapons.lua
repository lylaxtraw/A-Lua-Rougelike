local Weapons = {}

Weapons.Data = {
    fists = {
        id = "fists",
        name = "Fists",
        description = "When steel fails, these still work.",
        stats = "+0% DMG",
        damageMultiplier = 1,
        price = 0
    },
    basic_sword = {
        id = "basic_sword",
        name = "Basic Sword",
        description = "You know it, you love it. Good ol' classic that never dies.",
        stats = "+50% DMG",
        damageMultiplier = 1.5,
        price = 100
    },
    challenge_dagger = {
        id = "challenge_dagger",
        name = "Challenge Dagger",
        description = "A weapon made for reckless fighters who think speed solves everything.",
        stats = "+100% DMG",
        damageMultiplier = 2,
        price = 250
    },
    combat_knife = {
        id = "combat_knife",
        name = "Combat Knife",
        description = "Military-grade brutality compacted into sharpened steel.",
        stats = "+150% DMG",
        damageMultiplier = 2.5,
        price = 600
    },
    thunder_gloves = {
        id = "thunder_gloves",
        name = "Thunder Gloves",
        description = "Every punch crackles with unstable electricity.",
        stats = "+100% DMG | Paralysis",
        damageMultiplier = 2,
        paralysisChance = 0.25,
        manaPenalty = 5,
        price = 1400
    },
    vengeful_katana = {
        id = "vengeful_katana",
        name = "Vengeful Katana",
        description = "Forged for warriors too angry to fall in battle.",
        stats = "+200% DMG | +10 HP",
        damageMultiplier = 3,
        hpBonus = 10,
        price = 3000
    },
    greatsword = {
        id = "greatsword",
        name = "Greatsword",
        description = "Heavy. Slow. Catastrophically effective.",
        stats = "+400% DMG | +15 DEF",
        damageMultiplier = 5,
        defenseBonus = 15,
        price = 6000
    },
    mythical_crimson_blade = {
        id = "mythical_crimson_blade",
        name = "Mythical Crimson Blade",
        description = "Its edge burns hotter than a supernova.",
        stats = "+700% DMG | Burn",
        damageMultiplier = 8,
        burn = true,
        price = 12000
    },
    black_thorn_crash = {
        id = "black_thorn_crash",
        name = "Black Thorn Crash",
        description = "Alive. Hungry. Violently opposed to safe combat.",
        stats = "+400% DMG | +5 Mana | -5 HP",
        damageMultiplier = 5,
        manaBonus = 5,
        hpPenalty = 5,
        price = 25000
    },
    bloodlust_chained_claws = {
        id = "bloodlust_chained_claws",
        name = "Bloodlust Chained Claws",
        description = "Every wound inflicted feeds their owner.",
        stats = "+250% DMG | Lifesteal",
        damageMultiplier = 3.5,
        lifesteal = 0.2,
        price = 60000
    },
    prismatic_slime_slasher = {
        id = "prismatic_slime_slasher",
        name = "Prismatic Slime Slasher",
        description = "An absurd weapon built from condensed monster remains and bad decisions.",
        stats = "+2900% DMG | Scorch | Paralysis",
        damageMultiplier = 30,
        scorch = true,
        paralysisChance = 0.5,
        price = 250000
    }
}

function Weapons.Get(id)
    return Weapons.Data[id]
end

return Weapons