local Weapons = require("data.weapons")
local Shields = require("data.shields")
local Spells = require("data.spells")
local Potions = require("systems.potion_system")

local Shop = {}

Shop.currentWave = -1
Shop.stock = { weapon = {}, shield = {}, spell = {}, potion = {} }

local function ShuffleAndPick(dataDict, count, ownedDict)
    local list = {}
    for id, v in pairs(dataDict) do 
        -- FILTER: Only insert if not already owned
        if not ownedDict or not ownedDict[id] then
            table.insert(list, v) 
        end
    end
    
    for i = #list, 2, -1 do
        local j = math.random(i)
        list[i], list[j] = list[j], list[i]
    end
    
    local result = {}
    for i = 1, math.min(count, #list) do table.insert(result, list[i]) end
    table.sort(result, function(a, b) return (a.price or 0) < (b.price or 0) end)
    return result
end

function Shop.RefreshStock(player)
    Shop.currentWave = player.wave
    
    -- Pass the player's inventory sub-tables to filter out owned items
    Shop.stock.weapon = ShuffleAndPick(Weapons.Data, 3, player.inventory.weapons)
    Shop.stock.shield = ShuffleAndPick(Shields.Data, 3, player.inventory.shields)
    Shop.stock.spell = ShuffleAndPick(Spells.List, 3, player.inventory.spells)

    local pots = {}
    for _, p in pairs(Potions.List) do table.insert(pots, p) end
    table.sort(pots, function(a, b) return (a.price or 0) < (b.price or 0) end)
    Shop.stock.potion = pots
end

function Shop.ProcessPurchase(player, itemType, itemId, price)
    price = price or 0 
    if player.gold < price then return false, "Not enough gold." end

    if itemType == "weapon" then
        player.gold = player.gold - price
        player.inventory.weapons[itemId] = true
        Shop.RefreshStock(player) -- Refresh to remove it from screen
        return true, "Weapon purchased!"
    elseif itemType == "shield" then
        player.gold = player.gold - price
        player.inventory.shields[itemId] = true
        Shop.RefreshStock(player)
        return true, "Shield purchased!"
    elseif itemType == "spell" then
        player.gold = player.gold - price
        player.inventory.spells[itemId] = true
        Shop.RefreshStock(player)
        return true, "Spell learned!"
    elseif itemType == "potion" then
        player.gold = player.gold - price
        player.inventory.potions[itemId] = (player.inventory.potions[itemId] or 0) + 1
        return true, "Potion purchased!"
    end
    return false, "Invalid item."
end

function Shop.GetCategory(player, category)
    if Shop.currentWave ~= player.wave then Shop.RefreshStock(player) end
    return Shop.stock[category]
end

return Shop