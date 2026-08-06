local CharmSystem = require("systems.charm_system")

local CharmSelectScene = {}

function CharmSelectScene:load()
    self.unlocked = Game.player.unlockedCharms or {}
    self.submode = "list"
    self.selectedCharmId = nil
    
    -- THE ANTI-EXPLOIT FIX: 
    -- Skip this screen if they have no charms, are past Wave 1, or already locked a choice in!
    if #self.unlocked == 0 or Game.player.wave > 1 or Game.player.charmSelected then
        Game.sceneManager:Switch("menu")
    end
end

function CharmSelectScene:draw()
    if self.submode == "list" then
        love.graphics.print("=== EQUIP A CHARM ===", 50, 50)
        love.graphics.print("Choose a charm for this run:", 50, 80)
        
        local y = 120
        for i, charmId in ipairs(self.unlocked) do
            local charmData = CharmSystem.Get(charmId)
            if charmData then
                love.graphics.print(i .. ". " .. charmData.name .. " (Tier " .. charmData.tier .. ")", 50, y)
                y = y + 30
            end
        end
        
        love.graphics.print("0. Unequip / No Charm", 50, y + 20)
        
    elseif self.submode == "confirm" then
        love.graphics.print("=== CONFIRM CHARM ===", 50, 50)
        
        if self.selectedCharmId == "none" then
            love.graphics.print("You are about to start the run with NO CHARM.", 50, 100)
            love.graphics.print("Are you sure?", 50, 130)
        else
            local charmData = CharmSystem.Get(self.selectedCharmId)
            if charmData then
                love.graphics.print("Name: " .. charmData.name, 50, 100)
                love.graphics.print("Tier: " .. charmData.tier, 50, 130)
                
                -- Safely pull the description, wrapping it just in case it's missing
                local desc = charmData.description or "A mysterious artifact with unknown powers."
                love.graphics.print("Effect: " .. desc, 50, 170)
            end
        end
        
        love.graphics.print("1. Confirm and Begin Run", 50, 250)
        love.graphics.print("0. Go Back", 50, 280)
    end
end

function CharmSelectScene:keypressed(key)
    if self.submode == "list" then
        if key == "0" then
            self.selectedCharmId = "none"
            self.submode = "confirm"
        else
            local choice = tonumber(key)
            if choice and self.unlocked[choice] then
                self.selectedCharmId = self.unlocked[choice]
                self.submode = "confirm"
            end
        end
        
    elseif self.submode == "confirm" then
        if key == "1" then
            if self.selectedCharmId == "none" then
                Game.player.charm = nil
            else
                Game.player.charm = self.selectedCharmId
                CharmSystem.Apply(Game.player)
            end
            
            -- THE LOCK-IN: Flags the player so they can't re-pick until they die!
            Game.player.charmSelected = true 
            
            Game.sceneManager:Switch("menu")
            
        elseif key == "0" or key == "escape" then
            self.submode = "list"
            self.selectedCharmId = nil
        end
    end
end

return CharmSelectScene