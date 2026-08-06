local Input = {}

-- This maps physical keys (like '1' or 'escape') to logical game actions.
Input.KeyMap = {
    ["1"] = "action_1",
    ["2"] = "action_2",
    ["3"] = "action_3",
    ["4"] = "action_4",
    ["5"] = "action_5",
    ["6"] = "action_6",
    ["escape"] = "cancel",
    ["0"] = "cancel",
    ["return"] = "confirm",
    ["backspace"] = "delete"
}

-- Returns the mapped action for a given key, or nil if unmapped
function Input.GetAction(key)
    return Input.KeyMap[key]
end

-- Allows you to dynamically rebind a key during gameplay
function Input.Bind(key, action)
    Input.KeyMap[key] = action
end

return Input