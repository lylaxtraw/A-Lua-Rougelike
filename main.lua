love.filesystem.setIdentity("A Lua Rougelike", true)
math.randomseed(os.time())

-- Declare Game globally so all scenes can access the active player state
Game = require("core.game")

function love.load()
    Game.Init()
end

function love.update(dt)
    Game.sceneManager:Update(dt)
end

function love.draw()
    Game.sceneManager:Draw()
end

function love.keypressed(key)
    Game.sceneManager:KeyPressed(key)
end

function love.textinput(t)
    Game.sceneManager:TextInput(t)
end