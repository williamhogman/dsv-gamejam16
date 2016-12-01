local Engine = Class{
    init = function(self)
        self.things = {}
    end,
}

function Engine:draw()
    for i,v in ipairs(self.things) do
        v:draw(camera)
    end
end

function Engine:update(dt)
    for i,v in ipairs(self.things) do
        v:update(dt)
    end
end

function Engine:register(part)
    table.insert(self.things, part)
end

return Engine
