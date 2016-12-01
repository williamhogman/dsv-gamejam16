-- shorthands
local lg = love.graphics

local PLAYER_SIZE = 32
local TURN_SPEED = 25
local SPEED = 40
local OFFSET = Vector(PLAYER_SIZE / 2, PLAYER_SIZE / 2)
local DRAG = 50

local Player = Class{
    init = function(self, loc)
       self.loc = loc
       self.vel = Vector.new(0, 0)
       self.acc = Vector.new(0, 0)
       self.dir = Vector.new(0, 1)
       self.r = 0
       self.tex = love.graphics.newImage("resources/player.png")
    end,
}

local function getMouseVector()
   local x, y = love.mouse.getPosition()
   return Vector.new(x, y)
end

function Player:setMovement(vec)
   self.acc = vec * SPEED
end

function Player:update(dt)
   local new_dir = (self.loc + OFFSET) - getMouseVector()
   local cpd = new_dir:normalized():cross(self.dir)

   local as = math.asin(cpd)
   local ca = clamp(as, -TURN_SPEED * dt, TURN_SPEED * dt)
   self.dir:rotateInplace(ca)

   self.r = self.dir:angleTo(getMouseVector())
   self.vel = (self.vel + (self.acc * dt)) * clamp(DRAG * dt, 0, 1)
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
