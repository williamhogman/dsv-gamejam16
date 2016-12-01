local lk = love.keyboard

local DIRECTIONS = {
    w = Vector.new(0, -1),
    s = Vector.new(0, 1),
    a = Vector.new(-1, 0),
    d = Vector.new(1, 0)
}

local function calcmovementdirection()
    local sum = Vector.new(0, 0)
    for k,v in pairs(DIRECTIONS) do
        if lk.isDown(k) then
            sum = sum + v
        end
    end
    return sum
end

local World = Class{
    init = function(self, tilemap_data)
        self.tilemap = TileMap(tilemap_data)
        self.player = Player(Vector.new(64, 64))
        local mrbot = Bot(Vector.new(128, 128), self.player)
        self.objects = {self.player, mrbot}
    end,
}

function World:draw(camera)
    self.tilemap:draw(camera)
    for k, v in ipairs(self.objects) do
        v:draw(camera)
    end
end

function World:update(dt)
    self.tilemap:update(dt)
    self.player:setMovement(calcmovementdirection())

    for _k, v in pairs(self.objects) do
        if v.collides then
            for _k, other in pairs(self.objects) do
                if other ~= v and are_colliding(v, other) then
                    v:did_collide(other)
                end
            end
        end
    end

    for k, v in pairs(self.objects) do
        v:update(dt, self.tilemap)
    end
end

--function World:registerObject(obj)
--table.insert(self.things, part)
--end
return World
