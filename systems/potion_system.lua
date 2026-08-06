local PotionsData = require("data.potions")

local PotionSystem = {}

PotionSystem.List = PotionsData

function PotionSystem.Get(id)
    return PotionSystem.List[id]
end

function PotionSystem.Use(player, potionId)
    local potion = PotionSystem.Get(potionId)
    if not potion then return false, "Invalid Potion" end

    -- Safety check: Ensure inventory structure exists
    if not player.inventory then player.inventory = { potions = {} } end
    if not player.inventory.potions then player.inventory.potions = {} end

    local amount = player.inventory.potions[potionId] or 0
    if amount <= 0 then return false, "Out of potions" end

    -- Apply the potion effects
    local message = ""
    if potionId == "full_restore" then
        player.hp = player.maxHp
        player.mana = player.maxMana
        message = "Your entire body surges with energy."
        
    elseif potionId == "mana_restore" then
        player.mana = player.maxMana
        message = "Mana fully restored."
        
    elseif potionId == "minor_heal" then
        local healing = math.floor(player.maxHp * 0.25)
        player.hp = math.min(player.maxHp, player.hp + healing)
        message = "Restored " .. healing .. " HP."
        
    elseif potionId == "minor_mana" then
        local gain = math.floor(player.maxMana * 0.25)
        player.mana = math.min(player.maxMana, player.mana + gain)
        message = "Restored " .. gain .. " Mana."
        
    elseif potionId == "health_maxxer" then
        player.maxHp = player.maxHp + 25
        player.hp = player.hp + 25 -- Heal the new amount as a bonus
        message = "Your life force expands."
    end

    -- Deduct from inventory
    player.inventory.potions[potionId] = player.inventory.potions[potionId] - 1

    return true, message
end

return PotionSystem