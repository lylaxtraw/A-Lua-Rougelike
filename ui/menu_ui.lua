local Weapons = require("data.weapons")
local Shields = require("data.shields")

local MenuUI = {}

function MenuUI.Render(player)
    local y = 50
    local spacing = 25

    love.graphics.print("CAMPFIRE - WAVE " .. player.wave, 50, y)
    y = y + (spacing * 2)
    
    love.graphics.print("Name:   " .. player.name .. " (Level " .. player.level .. ")", 50, y); y = y + spacing
    love.graphics.print("HP:     " .. player.hp .. " / " .. player.maxHp, 50, y); y = y + spacing
    love.graphics.print("Mana:   " .. player.mana .. " / " .. player.maxMana, 50, y); y = y + spacing
    love.graphics.print("Gold:   " .. player.gold, 50, y); y = y + (spacing * 2)
    
    local currentWeapon = Weapons.Get(player.weapon)
    local currentShield = Shields.Get(player.shield)
    
    love.graphics.print("Weapon: " .. (currentWeapon and currentWeapon.name or "None"), 50, y); y = y + spacing
    love.graphics.print("Shield: " .. (currentShield and currentShield.name or "None"), 50, y); y = y + (spacing * 2)
    
    love.graphics.print("1. Enter Next Wave", 50, y); y = y + spacing
    love.graphics.print("2. Open Inventory", 50, y); y = y + spacing
    love.graphics.print("3. Visit Shop", 50, y); y = y + spacing
    love.graphics.print("4. Save & Quit", 50, y); y = y + (spacing * 2)

    love.graphics.print("Press 1-4 to choose an action.", 50, y)
end

return MenuUI