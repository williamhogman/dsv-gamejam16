-- shorthands
local lg = love.graphics

local PLAYER_SIZE = 32
local MAX_SPEED = 80000000
local OFFSET = Vector(PLAYER_SIZE / 2, PLAYER_SIZE / 2)
local DRAG = 50

local Player = Class{
    init = function(self, loc)
       self.loc = loc
       self.vel = Vector.new(0, 0)
       self.acc = Vector.new(0, 0)
       self.r = 0
       self.tex = love.graphics.newImage("resources/player.png")
    end,
}

local function getMouseVector()
   local x, y = love.mouse.getPosition()
   return Vector.new(x, y)
end

function Player:setMovement(x, y)
   self.acc.x = x * 10
   self.acc.y = y * 10
end

function Player:update(dt)

   local dir = (self.loc + OFFSET) - getMouseVector()
   self.r = dir:angleTo(getMouseVector())

   self.vel = (self.vel + (self.acc * dt)):trimmed(MAX_SPEED) * clamp(DRAG * dt, 0, 1)
   self.loc = self.loc + self.vel

end

function Player:draw(camera)
    lg.draw(
        -- tex
        self.tex,
        -- draw positions
        self.loc.x + PLAYER_SIZE / 2, self.loc.y + PLAYER_SIZE / 2,
        self.r - math.pi / 4, 1, 1,
        -- origin offsets
        PLAYER_SIZE/2,
        PLAYER_SIZE/2)
end

return Player
