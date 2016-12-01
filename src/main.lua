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

function load_resources()
    player = Player(Vector.new(100, 100))
end

function setup_game()
    -- load images and such
    load_resources()

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
    player:draw()
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
    player:update()
end

function love.draw()

    -- camera:attach()
    draw_game()
    -- camera:detach()

    draw_ui()
    draw_debug()

end

function love.keypressed(key, scancode, isrepeat)

    if scancode == "escape" then
        le.quit()
    end

end

function love.mousepressed(x, y, button, istouch)

end
