local EventHandler = Class {}

function EventHandler:init()

    self.subscribers = {}
    self.events = {}

end

function EventHandler:verifyData()

  if not self.subscribers[key] or not self.events[key] then
        self.subscribers[key] = {}
        self.events[key] = {}
    end

end

function EventHandler:subscribe(key, fnc)

    self:verifyData()
    table.insert(self.subscribers[key], fnc)

end

function EventHandler:push(key, event)

    self:verifyData()
    table.insert(self.events[key], event)

end

function EventHandler:tick()

    for key, events in pairs(self.events) do
        for _, event in ipairs(self.events[key]) do
            for _, receiver in ipairs(self.subscribers[key]) do
                self.subscribers[key](event)
            end
        end
    end

end

return EventHandler
