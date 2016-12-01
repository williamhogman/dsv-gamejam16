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


local tilemap_data = require "level/first"

function love.load()
    engine = Engine()
    engine:register(World(tilemap_data))
    engine:register(DebugOverlay())
end

function love.update(dt)
    engine:update(dt)
end

function love.draw()
    engine:draw()
end

function love.keypressed(key, scancode, isrepeat)
    if scancode == "escape" then
        le.quit()
    end
end
