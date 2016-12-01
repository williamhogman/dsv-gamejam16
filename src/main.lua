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

function love.keypressed(key, scancode, isrepeat)
    if scancode == "escape" then
       le.quit()
    elseif scancode == "w" then
       player:setMovement(0, -1)
    elseif scancode == "s" then
       player:setMovement(0, 1)
    elseif scancode == "a" then
       player:setMovement(-1, 0)
    elseif scancode == "d" then
       player:setMovement(1, 0)
    end

end

function love.mousepressed(x, y, button, istouch)

end
