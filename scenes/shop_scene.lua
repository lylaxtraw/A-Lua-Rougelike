local ShopUI = require("ui.shop_ui")
local Shop = require("systems.shop")

local ShopScene = {}

function ShopScene:load()
    self.submode = "main"
    self.message = nil
    self.items = {}
end

function ShopScene:draw()
    if self.submode == "main" then
        ShopUI.RenderMain(Game.player)
    else
        ShopUI.RenderCategory(Game.player, self.submode, self.items)
    end

    if self.message then
        love.graphics.setColor(0, 0, 0, 0.9)
        love.graphics.rectangle("fill", 350, 40, 300, 60)
        love.graphics.setColor(1, 1, 1, 1)
        ShopUI.RenderMessage(self.message)
    end
end

function ShopScene:keypressed(key)
    if self.message then
        self.message = nil
        return
    end

    if self.submode == "main" then
        if key == "escape" or key == "0" or key == "5" then
            Game.sceneManager:Switch("menu")
        elseif key == "1" then
            self.submode = "weapon"
            self.items = Shop.GetCategory(Game.player, "weapon")
        elseif key == "2" then
            self.submode = "shield"
            self.items = Shop.GetCategory(Game.player, "shield")
        elseif key == "3" then
            self.submode = "spell"
            self.items = Shop.GetCategory(Game.player, "spell")
        elseif key == "4" then
            self.submode = "potion"
            self.items = Shop.GetCategory(Game.player, "potion")
        end
    else
        if key == "escape" or key == "0" then
            self.submode = "main"
        else
            local choice = tonumber(key)
            if choice and self.items[choice] then
                local item = self.items[choice]
                local success, msg = Shop.ProcessPurchase(Game.player, self.submode, item.id, item.price)
                self.message = msg
            end
        end
    end
end

return ShopScene