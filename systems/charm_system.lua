local Charms = {}

Charms.List = {
    -- TIER 1
    lucky = { id = "lucky", name = "Lucky Charm", tier = 1, description = "Bumps all chances up to 35% more likely." },
    vampiric = { id = "vampiric", name = "Vampiric Charm", tier = 1, description = "Gain 1/8 of damage dealt as health." },
    magic = { id = "magic", name = "Magic Charm", tier = 1, description = "All spells deal 20% more damage and cost 35% more mana." },
    
    -- TIER 2
    exchange = { id = "exchange", name = "Exchange Charm", tier = 2, description = "Deal and suffer 100% more damage." },
    challenge = { id = "challenge", name = "Challenge Charm", tier = 2, description = "Slime grows 50% more, but gives 100% more xp & gold." },
    pacifist = { id = "pacifist", name = "Pacifist Charm", tier = 2, description = "+200% to all shields, +50% health & mana, but you can't attack or use spells. Start with Spiky Back." },
    violent = { id = "violent", name = "Violent Charm", tier = 2, description = "+200% to all attacks and spells, +100% mana, but you can't shield or use potions. Start with Combat Knife." },
    
    -- TIER 3
    rouge = { id = "rouge", name = "Rouge Charm", tier = 3, description = "+100% stat boost when leveling up, but you can't heal. Slime grows 25% less." },
    speed = { id = "speed", name = "Speed Charm", tier = 3, description = "Gives all stats and stuff a 10% boost for each shop skipped, stacks. Slime grows 50% more." },
    greedy = { id = "greedy", name = "Greedy Charm", tier = 3, description = "Each held gold gives a 0.1% boost to DMG and DEF, stacks. Slime gives 25% more gold, shops gain a 50% price scale per purchase." },
    chaos = { id = "chaos", name = "Chaos Charm", tier = 3, description = "Randomizes all your (unlocked) stuff every round. Crit chance is 75%." },
    natural = { id = "natural", name = "Natural Charm", tier = 3, description = "Doubles your stats at the beginning of each battle, disables shop. Slime grows 50% more, and gives 10% less xp." },
    calm = { id = "calm", name = "Calm Charm", tier = 3, description = "Gives 10 gold & mana per each consecutive shielding, stacks. Price increases 1% per turn." },
    
    -- TIER 4
    expert = { id = "expert", name = "Expert Charm", tier = 4, description = "Applies Exchange, Challenge, & Rouge Charms." },
    weaponmaster = { id = "weaponmaster", name = "Weaponmaster Charm", tier = 4, description = "Applies Vampiric, Magic, & Violent Charms." },
    guardian = { id = "guardian", name = "Guardian Charm", tier = 4, description = "Applies Lucky, Pacifist, & Greedy Charms." },
    master = { id = "master", name = "Master Charm", tier = 4, description = "Applies only the downsides of Expert Charm." },
    
    -- TIER 5
    insanity = { id = "insanity", name = "Insanity Charm", tier = 5, description = "Applies Master, Weaponmaster, & Chaos Charms. Losing once resets you back (Basically, a Hardcore run)." }
}

function Charms.Get(id)
    return Charms.List[id]
end

function Charms.Apply(player)
    -- This is where we will eventually hook all the mechanical stat boosts
    -- based on player.charm when a run starts!
    local activeCharm = Charms.Get(player.charm)
    if not activeCharm then return end
    
    -- Example hook (You can expand this later to apply the actual modifiers!)
    if player.charm == "pacifist" then
        player.inventory.shields["spiky_back"] = true
        player.shield = "spiky_back"
    elseif player.charm == "violent" then
        player.inventory.weapons["combat_knife"] = true
        player.weapon = "combat_knife"
    end
end

return Charms