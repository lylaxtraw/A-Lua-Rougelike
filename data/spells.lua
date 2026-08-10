local Spells = {}

local function CalculateDamage(player, enemy, baseDamage)
    -- Hook into 'atk' so your spell power grows as you level up!
    local magicPower = player.magic or player.atk or 1
    local enemyResist = enemy.def or 1 
    
    -- The spell's base damage now multiplies based on your power level
    -- (e.g., 15% stronger for every point of magicPower)
    local scaledDamage = baseDamage * (1 + (magicPower * 0.15))
    
    local damage = math.floor(scaledDamage - enemyResist)
    return math.max(1, damage) -- Guarantees at least 1 damage
end

Spells.List = {
    itchy_pollen = {
        id = "itchy_pollen", name = "Itchy Pollen", manaCost = 5, price = 0,
<<<<<<< HEAD
        flavour = "The air fills with irritating, magical dust.",
=======
        flavour = "The enemy is spored with irritating, magical dust.",
>>>>>>> v0.1.0
        cast = function(player, enemy, pushEvent)
            local damage = CalculateDamage(player, enemy, 5)
            enemy.hp = math.max(0, enemy.hp - damage)
            player.hp = math.min(player.maxHp, player.hp + 5)
            pushEvent("SPELL_CAST", { spell = "Itchy Pollen", damage = damage, text = "The magical pollen chokes your foe and heals you!" })
        end
    },
    fire_ball = {
        id = "fire_ball", name = "Fire Ball", manaCost = 30, price = 250,
        flavour = "A sphere of roaring flame erupts from your palm.",
        cast = function(player, enemy, pushEvent)
            local damage = CalculateDamage(player, enemy, 50)
            enemy.hp = math.max(0, enemy.hp - damage)
<<<<<<< HEAD
            enemy.status = { type = "burn", duration = 3, power = 0.10 }
=======
>>>>>>> v0.1.0
            pushEvent("SPELL_CAST", { spell = "Fire Ball", damage = damage, text = "The searing heat turns their skin to cinder." })
            pushEvent("BURN_APPLIED", { enemy = enemy.name })
        end
    },
    icicle_rush = {
        id = "icicle_rush", name = "Icicle Rush", manaCost = 10, price = 400,
        flavour = "Razor-sharp shards of ice materialize in the air.",
        cast = function(player, enemy, pushEvent)
            local hits = math.random(1, 10)
            local totalDamage = 0
            for i = 1, hits do totalDamage = totalDamage + CalculateDamage(player, enemy, 15) end
            enemy.hp = math.max(0, enemy.hp - totalDamage)
            pushEvent("SPELL_CAST", { spell = "Icicle Rush", damage = totalDamage, text = hits .. " ice shards puncture your enemy!" })
        end
    },
    rocky_punch = {
        id = "rocky_punch", name = "Rocky Punch", manaCost = 20, price = 450,
        flavour = "You conjure a massive fist of solid earth.",
        cast = function(player, enemy, pushEvent)
            local damage = CalculateDamage(player, enemy, 40)
            enemy.hp = math.max(0, enemy.hp - damage)
            pushEvent("SPELL_CAST", { spell = "Rocky Punch", damage = damage, text = "A massive earthen fist slams into the enemy!" })
        end
    },
    leafy_brew = {
        id = "leafy_brew", name = "Leafy Brew", manaCost = 25, price = 500,
        flavour = "A swirl of rejuvenating leaves envelops you.",
<<<<<<< HEAD
        cast = function(player, enemy, pushEvent)
=======
        cast = function(player, pushEvent)
>>>>>>> v0.1.0
            player.hp = math.min(player.maxHp, player.hp + 20)
            pushEvent("SPELL_CAST", { spell = "Leafy Brew", damage = 0, text = "The glowing leaves mend your wounds." })
        end
    },
    zappy_touch = {
        id = "zappy_touch", name = "Zappy Touch", manaCost = 5, price = 650,
        flavour = "Sparks dance across your fingertips before discharging.",
        cast = function(player, enemy, pushEvent)
            local damage = CalculateDamage(player, enemy, 10)
            enemy.hp = math.max(0, enemy.hp - damage)
<<<<<<< HEAD
            enemy.paralyzed = true
=======
>>>>>>> v0.1.0
            pushEvent("SPELL_CAST", { spell = "Zappy Touch", damage = damage, text = "A jolt of electricity locks their muscles!" })
            pushEvent("PARALYSIS_APPLIED", { enemy = enemy.name })
        end
    },
    lava_burst = {
        id = "lava_burst", name = "Lava Burst", manaCost = 50, price = 900,
        flavour = "The ground cracks open, spewing molten rock.",
        cast = function(player, enemy, pushEvent)
            local damage = CalculateDamage(player, enemy, 70)
            enemy.hp = math.max(0, enemy.hp - damage)
<<<<<<< HEAD
            enemy.status = { type = "burn", duration = 5, power = 0.15 }
=======
>>>>>>> v0.1.0
            pushEvent("SPELL_CAST", { spell = "Lava Burst", damage = damage, text = "Molten rock engulfs them in agonizing heat." })
            pushEvent("BURN_APPLIED", { enemy = enemy.name })
        end
    },
    iceberg_crush = {
        id = "iceberg_crush", name = "Iceberg Crush", manaCost = 20, price = 1200,
        flavour = "A colossal block of ice crashes down, shielding you.",
        cast = function(player, enemy, pushEvent)
            local damage = CalculateDamage(player, enemy, 30)
            enemy.hp = math.max(0, enemy.hp - damage)
            player.def = (player.def or 1) + 15
            pushEvent("SPELL_CAST", { spell = "Iceberg Crush", damage = damage, text = "The shattered ice forms a protective barrier around you." })
            pushEvent("BUFF_APPLIED", { buff = "Defense +15" })
        end
    },
    spiky_cannon = {
        id = "spiky_cannon", name = "Spiky Cannon", manaCost = 50, price = 1500,
        flavour = "Thick, thorny projectiles fire at blinding speed.",
        cast = function(player, enemy, pushEvent)
            local damage = CalculateDamage(player, enemy, 100)
            enemy.hp = math.max(0, enemy.hp - damage)
            pushEvent("SPELL_CAST", { spell = "Spiky Cannon", damage = damage, text = "Giant thorns shred through enemy defenses!" })
        end
    },
    rooted_beating = {
        id = "rooted_beating", name = "Rooted Beating", manaCost = 15, price = 1800,
        flavour = "Vines erupt from the earth, tightly binding your foe.",
<<<<<<< HEAD
        cast = function(player, enemy, pushEvent)
            enemy.status = { type = "rooted", duration = 5, power = 25 }
=======
        cast = function(enemy, pushEvent)
>>>>>>> v0.1.0
            pushEvent("SPELL_CAST", { spell = "Rooted Beating", damage = 0, text = "Living roots drag them into the dirt!" })
            pushEvent("STATUS_APPLIED", { enemy = enemy.name, status = "Rooted" })
        end
    },
    lightning_dodge = {
        id = "lightning_dodge", name = "Lightning Dodge", manaCost = 20, price = 2200,
        flavour = "You become a blur of static electricity.",
        cast = function(player, enemy, pushEvent)
            local damage = CalculateDamage(player, enemy, 40)
            enemy.hp = math.max(0, enemy.hp - damage)
<<<<<<< HEAD
            enemy.paralyzed = true
=======
>>>>>>> v0.1.0
            player.dodgeChance = (player.dodgeChance or 0) + 0.33
            pushEvent("SPELL_CAST", { spell = "Lightning Dodge", damage = damage, text = "You evade with the speed of a thunderbolt, stunning them!" })
            pushEvent("PARALYSIS_APPLIED", { enemy = enemy.name })
        end
    },
    magmatic_downpour = {
        id = "magmatic_downpour", name = "Magmatic Downpour", manaCost = 60, price = 3000,
        flavour = "The sky rains burning, liquid fire.",
        cast = function(player, enemy, pushEvent)
            local damage = CalculateDamage(player, enemy, 100)
            enemy.hp = math.max(0, enemy.hp - damage)
<<<<<<< HEAD
            enemy.status = { type = "scorch", duration = 2, power = 0.25 }
=======
>>>>>>> v0.1.0
            pushEvent("SPELL_CAST", { spell = "Magmatic Downpour", damage = damage, text = "A torrential rain of magma melts away their strength." })
            pushEvent("SCORCH_APPLIED", { enemy = enemy.name })
        end
    },
    frozen_barrage = {
        id = "frozen_barrage", name = "Frozen Barrage", manaCost = 60, price = 3500,
        flavour = "A relentless hailstorm turns the battlefield into a tundra.",
        cast = function(player, enemy, pushEvent)
            local damage = CalculateDamage(player, enemy, 70)
            enemy.hp = math.max(0, enemy.hp - damage)
<<<<<<< HEAD
            enemy.status = { type = "hail", duration = -1, power = 10 }
=======
>>>>>>> v0.1.0
            pushEvent("SPELL_CAST", { spell = "Frozen Barrage", damage = damage, text = "A violent blizzard engulfs the enemy." })
        end
    },
    meteor_impact = {
        id = "meteor_impact", name = "Meteor Impact", manaCost = 70, price = 5000,
        flavour = "You pull a flaming rock from the stratosphere.",
        cast = function(player, enemy, pushEvent)
            local damage = CalculateDamage(player, enemy, 300)
            enemy.hp = math.max(0, enemy.hp - damage)
            pushEvent("SPELL_CAST", { spell = "Meteor Impact", damage = damage, text = "The sheer force of the impact shatters the earth!" })
        end
    },
    sundowmer_bloom = {
        id = "sundowmer_bloom", name = "Sundowmer Bloom", manaCost = 150, price = 7500,
<<<<<<< HEAD
        flavour = "A terrifying, beautiful flower blooms, draining life.",
        cast = function(player, enemy, pushEvent)
            local damage = CalculateDamage(player, enemy, 60)
            enemy.hp = math.max(0, enemy.hp - damage)
            enemy.status = { type = "flower", duration = -1, power = 0.05 }
=======
        flavour = "A terrifying, beautiful flower blooms and roots itself to the enemy, draining its life.",
        cast = function(player, enemy, pushEvent)
            local damage = CalculateDamage(player, enemy, 60)
            enemy.hp = math.max(0, enemy.hp - damage)
>>>>>>> v0.1.0
            pushEvent("SPELL_CAST", { spell = "Sundowmer Bloom", damage = damage, text = "The parasitic blossom takes root in their soul." })
        end
    },
    thunderous_roaring = {
        id = "thunderous_roaring", name = "Thunderous Roaring", manaCost = 60, price = 8500,
        flavour = "You unleash a deafening shockwave fueled by your own vitality.",
        cast = function(player, enemy, pushEvent)
            local damage = CalculateDamage(player, enemy, math.floor(player.maxHp * 0.5))
            enemy.hp = math.max(0, enemy.hp - damage)
            pushEvent("SPELL_CAST", { spell = "Thunderous Roaring", damage = damage, text = "The massive soundwave crushes everything in its path!" })
        end
    },
    superior_mana_blast = {
        id = "superior_mana_blast", name = "Superior Mana Blast", manaCost = 0, price = 25000, legendary = true,
        flavour = "You channel every ounce of your magical essence into pure destruction.",
        cast = function(player, enemy, pushEvent)
            local drainedMana = player.mana
            player.mana = 0
            local damage = CalculateDamage(player, enemy, drainedMana * 5)
            enemy.hp = math.max(0, enemy.hp - damage)
            pushEvent("SPELL_CAST", { spell = "Superior Mana Blast", damage = damage, text = "A blinding beam of absolute magic obliterates reality itself!" })
        end
    }
}

function Spells.Get(id) return Spells.List[id] end

return Spells