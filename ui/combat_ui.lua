local Spells = require("data.spells")
local Potions = require("systems.potion_system")

local CombatUI = {}

function CombatUI.Render(state)
    local player = state.player
    local enemy = state.enemy
    local y = 50
    local spacing = 25

    love.graphics.print("=== COMBAT ===", 50, y); y = y + (spacing * 2)
    
    local enemyStatus = ""
    if enemy.paralyzed then enemyStatus = enemyStatus .. " [PARALYZED]" end
    if enemy.status then enemyStatus = enemyStatus .. " [" .. string.upper(enemy.status.type) .. "]" end
    
    love.graphics.print(enemy.name .. " (HP: " .. enemy.hp .. " / " .. enemy.maxHp .. ")" .. enemyStatus, 50, y); y = y + (spacing * 2)
    love.graphics.print("   vs   ", 50, y); y = y + (spacing * 2)
    
    love.graphics.print(player.name .. " (Level " .. player.level .. ")", 50, y); y = y + spacing
    love.graphics.print("HP: " .. player.hp .. " / " .. player.maxHp, 50, y); y = y + spacing
    love.graphics.print("Mana: " .. player.mana .. " / " .. player.maxMana, 50, y); y = y + (spacing * 2)
    
    love.graphics.print("1. Attack   2. Defend   3. Spells   4. Potions   5. Flee", 50, y)

    -- Battle Log
    local eventY = y + 50
    love.graphics.print("--- BATTLE LOG ---", 50, eventY)
    eventY = eventY + 25
    
    local startIndex = math.max(1, #state.events - 4)
    
    for i = startIndex, #state.events do
        local ev = state.events[i]
        local text = ""
        
        if ev.type == "PLAYER_ATTACK" then
            text = "You dealt " .. ev.data.damage .. " DMG!"
            if ev.data.critical then text = text .. " (CRITICAL!)" end
        elseif ev.type == "ENEMY_ATTACK" then
            text = ev.data.attacker .. " hits you for " .. ev.data.damage .. " DMG!"
            
        -- THE FIX: Now shows the damage number AND the custom spell text on the same line
        elseif ev.type == "SPELL_CAST" then
            text = ev.data.spell .. " dealt " .. ev.data.damage .. " DMG! " .. (ev.data.text or "")
            
        elseif ev.type == "TEXT" then
            text = ev.data.text
        elseif ev.type == "PLAYER_DEFENDING" then
            text = "You brace yourself!"
        elseif ev.type == "ENEMY_DEFEATED" then
            text = ev.data.enemy .. " defeated! +" .. ev.data.gold .. "G"
        else
            text = "[" .. ev.type .. "]"
        end
        
        love.graphics.print(text, 50, eventY)
        eventY = eventY + 20
    end
end

function CombatUI.RenderSpells(player)
    local y = 350
    local spacing = 20
    love.graphics.print("--- SPELLBOOK ---", 50, y); y = y + spacing
    local index = 1
    for id, owned in pairs(player.inventory.spells or {}) do
        if owned then
            local spell = Spells.Get(id)
            if spell then
                love.graphics.print(index .. ". " .. spell.name .. " (" .. spell.manaCost .. " MP)", 50, y)
                y = y + spacing
                index = index + 1
            end
        end
    end
    love.graphics.print("0. Cancel", 50, y + spacing)
end

function CombatUI.RenderPotions(player)
    local y = 350
    local spacing = 20
    love.graphics.print("--- POTION POUCH ---", 50, y); y = y + spacing
    local index = 1
    for id, amount in pairs(player.inventory.potions or {}) do
        if amount > 0 then
            local potion = Potions.Get(id)
            if potion then
                love.graphics.print(index .. ". " .. potion.name .. " (x" .. amount .. ")", 50, y)
                y = y + spacing
                index = index + 1
            end
        end
    end
    love.graphics.print("0. Cancel", 50, y + spacing)
end

return CombatUI