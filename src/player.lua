-- shorthands
local function getMouseVector()
    local x, y = love.mouse.getPosition()
    return Vector.new(x, y)
end

local Player = Class{
    init = function(self, loc)
        local tex = love.graphics.newImage("resources/player.png")
        Creature.init(self, loc, tex)
    end,
}

Player:include(Creature)

function Player:getFacingPoint()
    return getMouseVector()
end

return Player
