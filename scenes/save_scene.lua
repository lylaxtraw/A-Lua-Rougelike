local Player = require("entities.player")
local Inventory = require("systems.inventory")
local SaveSystem = require("systems.save_system")
local GameState = require("core.game_state")

local SaveScene = {}

local function PreparePlayer(player)
    player.level = player.level or 1
    player.wave = player.wave or 1
    player.hp = player.hp or 50
    player.maxHp = player.maxHp or 50
    player.mana = player.mana or 25
    player.maxMana = player.maxMana or 25
    player.atk = player.atk or 1
    player.def = player.def or 1
    player.gold = player.gold or 100
    player.weapon = player.weapon or "fists"
    player.shield = player.shield or "none"
end

function SaveScene:load()
    self.submode = "select"
    self.currentName = ""
end

function SaveScene:draw()
    if self.submode == "select" then
        love.graphics.print("=== FIRST GAME: A ROGUELIKE ===", 50, 50)
        love.graphics.print("1. Load Save Slot 1", 50, 100)
        love.graphics.print("2. Load Save Slot 2", 50, 130)
        love.graphics.print("3. Load Save Slot 3", 50, 160)
        love.graphics.print("---", 50, 200)
        love.graphics.print("4. Erase Save 1", 50, 230)
        love.graphics.print("5. Erase Save 2", 50, 260)
        love.graphics.print("6. Erase Save 3", 50, 290)
    elseif self.submode == "name_input" then
        love.graphics.print("ENTER YOUR NAME:", 50, 50)
        love.graphics.print(self.currentName .. "_", 50, 100)
        love.graphics.print("Press ENTER to confirm. MAX 10 chars.", 50, 150)
        love.graphics.print("Press ESC to cancel.", 50, 180)
    end
end

function SaveScene:keypressed(key)
    if self.submode == "select" then
        if key == "1" or key == "2" or key == "3" then
            Game.currentSaveSlot = tonumber(key)
            if SaveSystem.Exists(Game.currentSaveSlot) then
                Game.player = SaveSystem.Load(Game.currentSaveSlot)
                PreparePlayer(Game.player)
                Game.state = GameState.Create(Game.player)
                Game.sceneManager:Switch("charm_select")
            else
                self.currentName = ""
                self.submode = "name_input"
            end
        elseif key == "4" then SaveSystem.Delete(1)
        elseif key == "5" then SaveSystem.Delete(2)
        elseif key == "6" then SaveSystem.Delete(3)
        end
    elseif self.submode == "name_input" then
        if key == "backspace" then
            self.currentName = string.sub(self.currentName, 1, -2)
        elseif key == "return" and string.len(self.currentName) > 0 then
            Game.player = Player.Create(self.currentName)
            Inventory.Initialize(Game.player)
            PreparePlayer(Game.player)
            SaveSystem.Save(Game.currentSaveSlot, Game.player)
            Game.state = GameState.Create(Game.player)
            Game.sceneManager:Switch("charm_select")
        elseif key == "escape" then
            self.submode = "select"
        end
    end
end

function SaveScene:textinput(t)
    if self.submode == "name_input" and string.len(self.currentName) < 10 then
        self.currentName = self.currentName .. t
    end
end

return SaveScene