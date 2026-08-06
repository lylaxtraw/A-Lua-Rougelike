local Potions = require("systems.potion_system")
local EventQueue = require("core.event_queue")

local LootSystem = {}

function LootSystem.GenerateDrop(player, enemy, combatState)
    -- Creates a +/- 20% variance pool for drops
    local baseGold = (enemy.gold or 20) * 1.5 
    local minGold = math.max(5, math.floor(baseGold * 0.7))
    local maxGold = math.floor(baseGold * 1.5)
    local goldDrop = math.random(minGold, maxGold)

    player.gold = player.gold + goldDrop
    
    EventQueue.Push(combatState.events, "TEXT", { text = "+" .. goldDrop .. " Gold" })

    local baseXp = enemy.xp or 30
    local minXp = math.max(1, math.floor(baseXp * 0.8))
    local maxXp = math.floor(baseXp * 1.2)
    local xpDrop = math.random(minXp, maxXp)
    
    player.gold = player.gold + goldDrop
    player.xp = player.xp + xpDrop
    
    EventQueue.Push(combatState.events, "TEXT", { text = "+" .. goldDrop .. " Gold" })
    EventQueue.Push(combatState.events, "TEXT", { text = "+" .. xpDrop .. " XP" })

    if math.random(1, 100) <= 25 then
        local potionId = math.random(1, 100) <= 50 and "minor_heal" or "minor_mana"
        if not player.inventory.potions then player.inventory.potions = {} end
        player.inventory.potions[potionId] = (player.inventory.potions[potionId] or 0) + 1
        
        local potionData = Potions.Get(potionId)
        local potionName = potionData and potionData.name or potionId
        
        EventQueue.Push(combatState.events, "TEXT", { text = "Found an item: " .. potionName })
    end
end

return LootSystem