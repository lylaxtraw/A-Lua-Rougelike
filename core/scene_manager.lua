local SceneManager = {}
SceneManager.__index = SceneManager

function SceneManager.Create()
    local self = setmetatable({}, SceneManager)
    self.scenes = {}
    self.currentSceneName = nil
    self.currentScene = nil
    return self
end

-- Registers a scene module to a string name
function SceneManager:Register(name, scene)
    self.scenes[name] = scene
end

-- Safely unloads the old scene and loads the new one
function SceneManager:Switch(name, ...)
    if self.scenes[name] then
        if self.currentScene and self.currentScene.unload then
            self.currentScene:unload()
        end
        
        self.currentSceneName = name
        self.currentScene = self.scenes[name]
        
        if self.currentScene.load then
            self.currentScene:load(...)
        end
    else
        print("Error: Scene '" .. tostring(name) .. "' not found!")
    end
end

-- LÖVE Callbacks Delegators
function SceneManager:Update(dt)
    if self.currentScene and self.currentScene.update then
        self.currentScene:update(dt)
    end
end

function SceneManager:Draw()
    if self.currentScene and self.currentScene.draw then
        self.currentScene:draw()
    end
end

function SceneManager:KeyPressed(key)
    if self.currentScene and self.currentScene.keypressed then
        self.currentScene:keypressed(key)
    end
end

function SceneManager:TextInput(t)
    if self.currentScene and self.currentScene.textinput then
        self.currentScene:textinput(t)
    end
end

return SceneManager