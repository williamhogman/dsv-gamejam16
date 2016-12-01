local OFFSET = Vector.new(16, 16)

local Bot = Class{
    init = function(self, loc, target)
        local tex = love.graphics.newImage("resources/goblin.png")
        Creature.init(self, loc, tex)
        self.target = target
    end,
}

Bot:include(Creature)

function toaccelinplace(v)
    if v.x > 0 then
        v.x = 1
    elseif v.x < 0 then
        v.x = -1
    end

    if v.y > 0 then
        v.y = 1
    elseif v.y < 0 then
        v.y = -1
    end

    return v
end

function Bot:update(dt, tilemap, others)
    local accel = toaccelinplace(self.target.loc - (self.loc + OFFSET)) * 10

    local leftfeeler = self.loc + OFFSET + accel:rotated(1/4 * math.pi) * 2
    local rightfeeler = self.loc + OFFSET + accel:rotated(-1/4 * math.pi) * 2
    local midfeeler = self.loc + OFFSET + accel * 2

    if tilemap:collidesWith(leftfeeler) then
        self.acc = accel:rotated(-1/4 * math.pi)
    elseif tilemap:collidesWith(rightfeeler) then
        self.acc = accel:rotated(1/4 * math.pi)
    elseif tilemap:collidesWith(midfeeler) then
        self.acc = -accel
    else
        self.acc = accel
    end
    Creature.update(self, dt, tilemap, others)
end

function Bot:draw(camera)
    local accel = toaccelinplace(self.target.loc - self.loc) * 10
    local leftfeeler = self.loc + OFFSET + accel:rotated(1/4 * math.pi) * 2
    local rightfeeler = self.loc + OFFSET + accel:rotated(-1/4 * math.pi) * 2

    love.graphics.circle("fill", leftfeeler.x, leftfeeler.y, 10)
    love.graphics.circle("fill", rightfeeler.x, rightfeeler.y, 10)

    local feck = self.loc + OFFSET
    local comb = feck + self.acc
    love.graphics.line(feck.x, feck.y, comb.x + 25, comb.y + 25)
    Creature.draw(self, camera)
end

function Bot:getFacingPoint()
    return self.target.loc
end

return Bot
