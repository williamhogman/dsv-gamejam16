-------------------------------
-- External Includes ----------
-------------------------------

require("cupid.debug")

-------------------------------
-- Includes -------------------
-------------------------------

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
      v:draw()
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


function load_resources()
<<<<<<< 6ebaafd2cd2ae4c4928b2ad32d7ad52f7818246f
    player = Player(Vector.new(100, 100))
end

function setup_game()
    -- load images and such
    load_resources()

=======

end

function setup_game()
   engine = Engine()
   engine:register(Player(Vector.new(100, 100)))
   -- load images and such
   load_resources()
>>>>>>> use engine system for rendering player
end

function draw_debug()
    function print_thing(thing, y)
        lg.print(thing, 0, y)
        return y + 16
    end

    local y = 16

    local mx, my = love.mouse.getPosition()

    lg.push()
    lg.translate(lg.getWidth() - 196, y)
    y = print_thing(string.format("FPS: %d", lt.getFPS()), y)
    y = print_thing(string.format("Frametime: %.3f ms", 1000 * lt.getAverageDelta()), y)
    y = print_thing(string.format("Camera X: %d, Y: %d", camera.x, camera.y), y)
    y = print_thing(string.format("Mouse X: %d Y: %d", mx, my), y)
    lg.pop()

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
    end
end

function love.mousepressed(x, y, button, istouch)

end
