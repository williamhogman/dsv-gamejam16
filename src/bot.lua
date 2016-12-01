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
    local accel = toaccelinplace(self.target.loc - self.loc) * 10

    local leftfeeler = self.loc + accel:rotated(1/4 * math.pi)
    local rightfeeler = self.loc + accel:rotated(-1/4 * math.pi)

    if tilemap:collidesWith(leftfeeler) then
        self.acc = accel:rotated(1/8 * math.pi)
    elseif tilemap:collidesWith(rightfeeler) then
        self.acc = accel:rotated(-1/8 * math.pi)
    else
        self.acc = accel
    end
    Creature.update(self, dt, tilemap, others)
end

function Bot:getFacingPoint()
    return self.target.loc
end

return Bot
