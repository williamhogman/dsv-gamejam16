-------------------------------
-- External Includes ----------
-------------------------------

require("cupid.debug")

-------------------------------
-- Includes -------------------
-------------------------------

require "derp_math"

-- these are global, careful?
require "defines"

-------------------------------
-- Short Forms ----------------
-------------------------------

local lg = love.graphics
local lw = love.window
local lt = love.timer
local lm = love.mouse
local le = love.event
local li = love.image
local lk = love.keyboard
-------------------------------
-- Resources ------------------
-------------------------------

local tilemap_data = require "level/first"

-------------------------------
-- Global game variables! -----
-------------------------------

local camera = Camera(0, 0, 1)

-------------------------------
-- Game object definitions ----
-------------------------------

-------------------------------
-- Game functions here! -------
-------------------------------

local Engine = Class{
   init = function(self)
      self.things = {}
   end,
}

function Engine:draw()
   for i,v in ipairs(self.things) do
      v:draw(camera)
   end
end

function Engine:update(dt)
   for i,v in ipairs(self.things) do
      v:update(dt)
   end
end

function Engine:register(part)
   table.insert(self.things, part)
end


function setup_game()
   engine = Engine()
   engine:register(TileMap(tilemap_data))
   player = Player(Vector.new(100, 100))
   engine:register(player)
   engine:register(DebugOverlay())
end

function draw_map()

end

-- DRAW ALL THE THINGS
function draw_game()
   engine:draw()
end

function draw_ui()

end

-------------------------------
-- Love functions go here! ----
-------------------------------

function love.load()
   -- load resources
   setup_game()
end

function love.update(dt)
   engine:update(dt)
end

function love.draw()
   -- camera:attach()
   draw_game()
   -- camera:detach()
   draw_ui()
end

DIRECTIONS = {w = Vector.new(0, -1), s = Vector.new(0, 1), a = Vector.new(-1, 0), d = Vector.new(1, 0)}

function calcmovementdirection()
   local sum = Vector.new(0, 0)
   for k,v in pairs(DIRECTIONS) do
      if lk.isDown(k) then
         sum = sum + v
      end
   end
   return sum
end

function love.keypressed(key, scancode, isrepeat)
   player:setMovement(calcmovementdirection())
end

function love.keyreleased(key, scancode)
   player:setMovement(calcmovementdirection())
end

function love.mousepressed(x, y, button, istouch)

end
