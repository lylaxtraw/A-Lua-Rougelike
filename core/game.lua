local SceneManager = require("core.scene_manager")

local Game = {
    sceneManager = SceneManager.Create(),
    player = nil,
    state = nil,
    currentSaveSlot = 1
}

function Game.Init()
    love.graphics.setBackgroundColor(0.05, 0.05, 0.08)

    Game.sceneManager:Register("save", require("scenes.save_scene"))
    Game.sceneManager:Register("charm_select", require("scenes.charm_select_scene"))
    Game.sceneManager:Register("menu", require("scenes.menu_scene"))
    Game.sceneManager:Register("inventory", require("scenes.inventory_scene"))
    Game.sceneManager:Register("shop", require("scenes.shop_scene"))
    Game.sceneManager:Register("combat", require("scenes.combat_scene"))
    Game.sceneManager:Register("gameover", require("scenes.gameover_scene"))

    Game.sceneManager:Switch("save")
end

return Game