-- shorthands
local lg = love.graphics

local PLAYER_SIZE = 32

local Player = Class{
    init = function(self, loc)
        self.loc = loc
        self.r = 0
        self.tex = love.graphics.newImage("resources/player.png")
    end,
}

local function getMouseVector()
   local x, y = love.mouse.getPosition()
   return Vector.new(x, y)
end


function Player:update(dt)
   self.r = self.loc:angleTo(getMouseVector())
end

function Player:draw()
    lg.draw(self.tex, self.loc.x + 16, self.loc.y + 16, self.r)
end

return Player
