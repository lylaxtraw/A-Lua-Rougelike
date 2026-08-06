local EventQueue = require("core.event_queue")

local GameState = {}

local function CombatState()
    return {
        active = false,
        result = nil,
        turn = 1,
        state = nil
    }
end

local function MenuState()
    return { selected = 1 }
end

function GameState.Create(player)
    return {
        running = true,
        mode = "menu",
        player = player,
        enemy = nil,
        combat = CombatState(),
        menu = MenuState(),
        events = EventQueue.Create()
    }
end

function GameState.SetMode(state, mode)
    state.mode = mode
end

function GameState.StartCombat(state, combatState)
    state.mode = "combat"
    state.combat.active = true
    state.combat.result = nil
    state.combat.turn = 1
    state.combat.state = combatState
    state.enemy = combatState.enemy
end

function GameState.EndCombat(state, result)
    state.mode = "menu"
    state.combat.active = false
    state.combat.result = result
    state.combat.state = nil
    state.enemy = nil
end

return GameState