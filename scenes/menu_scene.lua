local MenuUI = require("ui.menu_ui")
local Enemy = require("entities.enemy")
local Combat = require("systems.combat")
local GameState = require("core.game_state")
local SaveSystem = require("systems.save_system")

local MenuScene = {}

function MenuScene:draw()
    MenuUI.Render(Game.player)
end

function MenuScene:keypressed(key)
    if key == "1" then
        -- Enter Combat
        local enemy = Enemy.Random(Game.player.wave)
        local combatState = Combat.CreateState(Game.player, enemy)
        GameState.StartCombat(Game.state, combatState)
        Game.sceneManager:Switch("combat")
        
    elseif key == "2" then
        -- Open Inventory
        Game.sceneManager:Switch("inventory")
        
    elseif key == "3" then
        -- Visit Shop
        Game.sceneManager:Switch("shop")
        
    elseif key == "4" then
        -- Save and Quit
        SaveSystem.Save(Game.currentSaveSlot, Game.player)
        love.event.quit()
    end
end

return MenuScene