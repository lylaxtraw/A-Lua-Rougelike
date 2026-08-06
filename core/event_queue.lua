local EventQueue = {}

function EventQueue.Create()
    return {}
end

function EventQueue.Push(queue, eventType, data)
    table.insert(queue, { type = eventType, data = data })
end

function EventQueue.All(queue)
    return queue
end

function EventQueue.Clear(queue)
    for index = #queue, 1, -1 do
        table.remove(queue, index)
    end
end

-- Note: EventQueue.Render() was removed. 
-- In LÖVE, fetching these events and printing them to the screen 
-- will be handled by combat_ui.lua inside the love.draw() cycle.

return EventQueue