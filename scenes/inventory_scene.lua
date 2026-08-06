local InventoryUI = require("ui.inventory_ui")
local Inventory = require("systems.inventory")
local Potions = require("systems.potion_system")

local InventoryScene = {}

function InventoryScene:load()
    self.submode = "main"
end

function InventoryScene:draw()
    if self.submode == "main" then
        InventoryUI.RenderMain(Game.player)
    elseif self.submode == "weapons" then
        InventoryUI.RenderCategory("Weapons", Inventory.GetWeapons(Game.player))
    elseif self.submode == "shields" then
        InventoryUI.RenderCategory("Shields", Inventory.GetShields(Game.player))
    elseif self.submode == "potions" then
        local pots = {}
        for id, amount in pairs(Game.player.inventory.potions or {}) do
            if amount > 0 then
                local def = Potions.Get(id)
                if def then table.insert(pots, { name = def.name, amount = amount }) end
            end
        end
        InventoryUI.RenderPotions(pots)
    end
end

function InventoryScene:keypressed(key)
    if self.submode == "main" then
        if key == "escape" or key == "0" then 
            Game.sceneManager:Switch("menu")
        elseif key == "1" then self.submode = "weapons"
        elseif key == "2" then self.submode = "shields"
        elseif key == "3" then self.submode = "potions"
        end
    else
        if key == "escape" or key == "0" then
            self.submode = "main"
        else
            local choice = tonumber(key)
            if choice then
                if self.submode == "weapons" then
                    local weps = Inventory.GetWeapons(Game.player)
                    if weps[choice] then Inventory.EquipWeapon(Game.player, weps[choice].id) end
                elseif self.submode == "shields" then
                    local shs = Inventory.GetShields(Game.player)
                    if shs[choice] then Inventory.EquipShield(Game.player, shs[choice].id) end
                end
            end
        end
    end
end

return InventoryScene