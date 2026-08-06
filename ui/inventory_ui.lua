local InventoryUI = {}

function InventoryUI.RenderMain(player)
    local y = 50
    local spacing = 25
    love.graphics.print("=== INVENTORY ===", 50, y); y = y + spacing * 2
    love.graphics.print("1. Weapons", 50, y); y = y + spacing
    love.graphics.print("2. Shields", 50, y); y = y + spacing
    love.graphics.print("3. Potions", 50, y); y = y + spacing * 2
    love.graphics.print("Press 1-3 to select category. 0 to return to Campfire.", 50, y)
end

function InventoryUI.RenderCategory(title, items)
    local y = 50
    local spacing = 20
    love.graphics.print("--- " .. string.upper(title) .. " ---", 50, y); y = y + spacing * 2
    
    if #items == 0 then
        love.graphics.print("Empty.", 50, y); y = y + spacing
    else
        for i, item in ipairs(items) do
            local equipped = item.equipped and " [EQUIPPED]" or ""
            love.graphics.print(i .. ". " .. item.name .. equipped, 50, y); y = y + spacing
            if item.damageMultiplier then
                love.graphics.print("   Multiplier: x" .. item.damageMultiplier, 50, y); y = y + spacing
            elseif item.defenseMultiplier then
                love.graphics.print("   Multiplier: x" .. item.defenseMultiplier, 50, y); y = y + spacing
            end
        end
    end
    y = y + spacing
    love.graphics.print("Press number to EQUIP. 0 to go back.", 50, y)
end

function InventoryUI.RenderPotions(potionsList)
    local y = 50
    local spacing = 20
    love.graphics.print("--- POTIONS ---", 50, y); y = y + spacing * 2
    
    if #potionsList == 0 then
        love.graphics.print("None.", 50, y); y = y + spacing
    else
        for i, pot in ipairs(potionsList) do
            love.graphics.print(i .. ". " .. pot.name .. " (x" .. pot.amount .. ")", 50, y); y = y + spacing
        end
    end
    y = y + spacing
    love.graphics.print("0 to go back.", 50, y)
end

return InventoryUI