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
        self.player = Player(Vector.new(100, 100))
        --self.gameobjects = {self.player}
    end,
}

function World:draw(camera)
    self.tilemap:draw(camera)
    self.player:draw(camera)
end

function World:update(dt)
    self.tilemap:update(dt)
    self.player:setMovement(calcmovementdirection())
    self.player:update(dt, tilemap)
end

--function World:registerObject(obj)
--table.insert(self.things, part)
--end
return World
