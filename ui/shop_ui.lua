local ShopUI = {}

function ShopUI.RenderMain(player)
    local y = 50
    local spacing = 25

    love.graphics.print("MERCHANT'S SHOP - Gold: " .. player.gold, 50, y); y = y + (spacing * 2)
    
    love.graphics.print("1. Weapons", 50, y); y = y + spacing
    love.graphics.print("2. Shields", 50, y); y = y + spacing
    love.graphics.print("3. Spells", 50, y); y = y + spacing
    love.graphics.print("4. Potions", 50, y); y = y + spacing
    love.graphics.print("5. Exit Shop", 50, y); y = y + (spacing * 2)
    
    love.graphics.print("Press 1-5 to select a category.", 50, y)
end

function ShopUI.RenderCategory(player, categoryName, items)
    local y = 50
    local spacing = 20

    love.graphics.print(string.upper(categoryName) .. " SHOP - Gold: " .. player.gold, 50, y)
    y = y + (spacing * 2)

    for i, item in ipairs(items) do
        -- Safety: Default to 0 if price is nil
        local price = item.price or 0
        love.graphics.print(i .. ". " .. item.name .. " (" .. price .. " Gold)", 50, y); y = y + spacing
        
        if item.description then
            love.graphics.print("   " .. item.description, 50, y); y = y + spacing
        end
        if item.stats then
            love.graphics.print("   Stats: " .. item.stats, 50, y); y = y + spacing
        end
        y = y + 10 
    end

    love.graphics.print("0. Back", 50, y + spacing)
end

function ShopUI.RenderMessage(msg)
    -- Displays text cleanly without pausing the game!
    love.graphics.print("[SHOP]: " .. msg, 370, 60)
end

return ShopUI