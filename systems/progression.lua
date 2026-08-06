local Player = require("entities.player")

local Progression = {}

function Progression.OnVictory(player)
    player.totalWins = (player.totalWins or 0) + 1
    
    if player.charm then
        player.completedCharms = player.completedCharms or {}
        player.completedCharms[player.charm] = true
    end

    player.unlockedCharms = player.unlockedCharms or {}
    local completed = player.completedCharms or {}
    local function unlock(id) table.insert(player.unlockedCharms, id) end
    local function has(id)
        for _, u in ipairs(player.unlockedCharms) do if u == id then return true end end
        return false
    end

    -- TIER 1: Unlocked after beating your very first run
    if player.totalWins == 1 and #player.unlockedCharms == 0 then
        unlock("lucky"); unlock("vampiric"); unlock("magic")
    end

    -- TIER 2: Unlocked by beating runs with Tier 1
    if completed["lucky"] and not has("exchange") then unlock("exchange") end
    if completed["vampiric"] and not has("challenge") then unlock("challenge") end
    if completed["magic"] and not has("pacifist") then unlock("pacifist") end
    if completed["vampiric"] and not has("violent") then unlock("violent") end -- Added Violent

    -- TIER 3: Unlocked by beating runs with Tier 2
    if completed["exchange"] and not has("rouge") then unlock("rouge") end
    if completed["exchange"] and not has("speed") then unlock("speed") end -- Added Speed
    if completed["challenge"] and not has("chaos") then unlock("chaos") end
    if completed["challenge"] and not has("greedy") then unlock("greedy") end -- Added Greedy
    if completed["pacifist"] and not has("natural") then unlock("natural") end
    if completed["pacifist"] and not has("calm") then unlock("calm") end

    -- TIER 4: Unlocked by beating runs with Tier 3
    if completed["rouge"] and not has("expert") then unlock("expert") end
    if completed["violent"] and not has("weaponmaster") then unlock("weaponmaster") end -- Mapped Weaponmaster
    if completed["natural"] and not has("guardian") then unlock("guardian") end
    if completed["calm"] and not has("master") then unlock("master") end

    -- TIER 5: Insanity (Requires 100 total wins + beating the game with the big T4s)
    if player.totalWins >= 100 and completed["expert"] and completed["weaponmaster"] and completed["guardian"] and completed["master"] and not has("insanity") then
        unlock("insanity")
    end
end

function Progression.OnLoss(player)
    local meta = {
        unlockedCharms = player.unlockedCharms or {},
        completedCharms = player.completedCharms or {},
        totalWins = player.totalWins or 0,
        run = { victories = 0 }
    }
    local freshState = Player.Create(player.name)
    for k, v in pairs(meta) do freshState[k] = v end
    for k, v in pairs(freshState) do player[k] = v end
end

return Progression