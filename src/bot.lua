local Bot = Class{
    init = function(self, loc, target)
        local tex = love.graphics.newImage("resources/goblin.png")
        Creature.init(self, loc, tex)
        self.target = target
    end,
}

Bot:include(Creature)

function Bot:getFacingPoint()
    return self.target.loc
end

return Bot
