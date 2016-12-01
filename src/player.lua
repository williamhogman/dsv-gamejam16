-- shorthands
local lg = love.graphics

local PLAYER_SIZE = 32
local TURN_SPEED = 25
local SPEED = 40
local OFFSET = Vector(PLAYER_SIZE / 2, PLAYER_SIZE / 2)
local DRAG = 50

local function getMouseVector()
    local x, y = love.mouse.getPosition()
    return Vector.new(x, y)
end

local function testColl(nextLoc, dir, tilemap)
    local corners = {-1/4, 1/4, 3/4, -3/4}
    for _k, v in pairs(corners) do
        local corner = nextLoc + OFFSET + ((dir:rotated(v * math.pi)) * (PLAYER_SIZE * 0.75))
        if tilemap:collidesWith(corner) then
            return true
        end
    end
    return false
end

local Creature = Class{
    init = function(self, loc, tex)
        self.loc = loc
        self.vel = Vector.new(0, 0)
        self.acc = Vector.new(0, 0)
        self.dir = Vector.new(0, 1)
        self.r = 0
        self.tex = tex
        self.collides = true
    end
}

function Creature:setMovement(vec)
    self.acc = vec * SPEED
end

function Creature:update(dt, tilemap, others)
    local new_dir = (self.loc + OFFSET) - self:getFacingPoint()
    local cpd = new_dir:normalized():cross(self.dir)

    local as = math.asin(cpd)
    local ca = clamp(as, -TURN_SPEED * dt, TURN_SPEED * dt)
    local nextDir = self.dir:rotated(ca)

    self.vel = (self.vel + (self.acc * dt)) * clamp(DRAG * dt, 0, 1)
    local nextLoc = self.loc + self.vel

    if not testColl(nextLoc, nextDir, tilemap) then
        self.loc = nextLoc
        self.dir = nextDir
        self.r = self.dir:angleTo()
    else
        local xcand = self.loc + Vector.new(self.vel.x, 0)
        local ycand = self.loc + Vector.new(0, self.vel.y)
        if not testColl(xcand, self.dir, tilemap) then
            self.loc = xcand
        elseif not testColl(ycand, self.dir, tilemap) then
            self.loc = ycand
        end
    end
end

function Creature:draw(camera)
    lg.draw(
        -- tex
        self.tex,
        -- draw positions
        self.loc.x + PLAYER_SIZE / 2, self.loc.y + PLAYER_SIZE / 2,
        self.r, 1, 1,
        -- origin offsets
        PLAYER_SIZE/2,
        PLAYER_SIZE/2)
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
