local CombatUI = require("ui.combat_ui")
local Combat = require("systems.combat")
local SaveSystem = require("systems.save_system")
local Progression = require("systems.progression")
local Scaling = require("systems.scaling")
local GameState = require("core.game_state")

local CombatScene = {}

local function HandleVictory(player)
    if not player.run then player.run = { victories = 0 } end
    player.run.victories = player.run.victories + 1
    player.wave = player.wave + 1
    player.mana = player.maxMana

    if player.wave == 21 then
        Progression.OnVictory(player)
    end

    local requiredXP = Scaling.RequiredXP(player.level)
    while player.xp >= requiredXP do
        player.xp = player.xp - requiredXP
        Scaling.LevelUp(player)
        requiredXP = Scaling.RequiredXP(player.level)
    end
end

local function CheckCombatEnd()
    local combatState = Game.state.combat.state
    if not combatState.finished then return end

    local result = combatState.result
    GameState.EndCombat(Game.state, result)

    if result == "victory" then
        HandleVictory(Game.player)
        SaveSystem.Save(Game.currentSaveSlot, Game.player)
        Game.sceneManager:Switch("menu")
        
    -- Fleeing now triggers the exact same run-wipe penalty as dying!
    elseif result == "defeat" or result == "flee" then
        Progression.OnLoss(Game.player)
        SaveSystem.Save(Game.currentSaveSlot, Game.player)
        Game.sceneManager:Switch("gameover")
    end
end

function CombatScene:load() self.submode = "main" end

function CombatScene:draw()
    if self.submode == "main" then CombatUI.Render(Game.state.combat.state)
    elseif self.submode == "spells" then CombatUI.RenderSpells(Game.player)
    elseif self.submode == "potions" then CombatUI.RenderPotions(Game.player) end
end

function CombatScene:keypressed(key)
    if self.submode == "main" then
        local action = nil
        if key == "1" then action = "attack"
        elseif key == "2" then action = "defend"
        elseif key == "3" then self.submode = "spells"; return
        elseif key == "4" then self.submode = "potions"; return
        elseif key == "5" then action = "flee" end

        if action then Combat.ProcessAction(Game.state.combat.state, action); CheckCombatEnd() end
    elseif self.submode == "spells" then
        if key == "0" or key == "escape" then self.submode = "main" else
            local choice = tonumber(key)
            if choice then
                local idx = 1
                for id, owned in pairs(Game.player.inventory.spells or {}) do
                    if owned then
                        if idx == choice then Combat.ProcessAction(Game.state.combat.state, "spell", id); CheckCombatEnd(); self.submode = "main"; break end
                        idx = idx + 1
                    end
                end
            end
        end
    elseif self.submode == "potions" then
        if key == "0" or key == "escape" then self.submode = "main" else
            local choice = tonumber(key)
            if choice then
                local idx = 1
                for id, amt in pairs(Game.player.inventory.potions or {}) do
                    if amt > 0 then
                        if idx == choice then Combat.ProcessAction(Game.state.combat.state, "potion", id); CheckCombatEnd(); self.submode = "main"; break end
                        idx = idx + 1
                    end
                end
            end
        end
    end
end

return CombatScene