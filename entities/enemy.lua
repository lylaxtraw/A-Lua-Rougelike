local EnemiesData = require("data.enemies")
local Scaling = require("systems.scaling")

local Enemy = {}

-- Element definitions for post-wave 10
local Elements = {"earth", "thunder", "fire", "ice", "grass"}

local function DeepCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do copy[DeepCopy(orig_key)] = DeepCopy(orig_value) end
        setmetatable(copy, DeepCopy(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end

function Enemy.Create(id, wave)
    local baseData = EnemiesData[id]
    if not baseData then return nil end

    local enemy = DeepCopy(baseData)

    if wave then
        Scaling.Enemy(enemy, wave)
        
        -- MASTER (Wave 100, 200...)
        if wave % 100 == 0 then
<<<<<<< HEAD
            enemy.name = "Slime Master"
=======
            enemy.name = enemy.name .. " Master"
>>>>>>> v0.1.0
            enemy.isMaster = true
            enemy.maxHp = enemy.maxHp * 5
            enemy.atk = enemy.atk * 2
            enemy.def = enemy.def * 2

        -- RULER (Wave 20, 40, 60, 80...)
        elseif wave % 20 == 0 then
            enemy.isRuler = true
            enemy.element = Elements[math.random(#Elements)]
<<<<<<< HEAD
            enemy.name = string.upper(enemy.element:sub(1,1)) .. enemy.element:sub(2) .. " Ruler"
=======
            enemy.name = enemy.name .. " " .. string.upper(enemy.element:sub(1,1)) .. enemy.element:sub(2) .. " Ruler"
>>>>>>> v0.1.0
            enemy.maxHp = enemy.maxHp * 3

        -- ELITE (Wave 5, 10, 15...)
        elseif wave % 5 == 0 then
            enemy.isElite = true
            enemy.name = "Elite " .. enemy.name
            
            -- Balanced stacking: 10% increase per Elite level
            local eliteLevel = math.floor(wave / 5)
            local boost = 1 + (0.10 * eliteLevel) 
            
            enemy.maxHp = math.floor(enemy.maxHp * boost)
            enemy.atk = math.floor(enemy.atk * boost)
            enemy.def = math.floor(enemy.def * boost)

        -- NORMAL SLIMES (Post Wave 10 gets types)
        elseif wave > 10 and enemy.id ~= "slime" then
            if math.random(1, 100) <= 50 then -- 50% chance to be elemental
                enemy.element = Elements[math.random(#Elements)]
                enemy.name = string.upper(enemy.element:sub(1,1)) .. enemy.element:sub(2) .. " " .. enemy.name
            end
        end
    end

    -- THE FIX: Set active HP *after* all scaling and boss multipliers are applied!
    enemy.hp = enemy.maxHp

    return enemy
end

function Enemy.Random(wave)
    if wave and wave <= 3 then
        return Enemy.Create("slime", wave)
    end
    local keys = {}
    for key, _ in pairs(EnemiesData) do table.insert(keys, key) end
    local randomKey = keys[math.random(#keys)]
    return Enemy.Create(randomKey, wave)
end

return Enemy