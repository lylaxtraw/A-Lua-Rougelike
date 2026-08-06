local GameOverScene = {}

function GameOverScene:draw()
    love.graphics.print("=== GAME OVER ===", 50, 50)
    love.graphics.print("The slime consumed you. Wanna try again?", 50, 80)
    
    love.graphics.print("1. Return to Saves Menu", 50, 150)
    love.graphics.print("2. Quit Game", 50, 180)
end

function GameOverScene:keypressed(key)
    if key == "1" then
        Game.sceneManager:Switch("save")
    elseif key == "2" then
        love.event.quit()
    end
end

return GameOverScene