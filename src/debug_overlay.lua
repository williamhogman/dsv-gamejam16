local lg = love.graphics
local lm = love.mouse
local lt = love.timer

local DebugOverlay = Class{
   init = function(self)
   end,
}

function DebugOverlay:draw(camera)
   function print_thing(thing, y)
      lg.print(thing, 0, y)
      return y + 16
   end

   local y = 16

   local mx, my = lm.getPosition()

   lg.push()
   lg.translate(lg.getWidth() - 196, y)
   y = print_thing(string.format("FPS: %d", lt.getFPS()), y)
   y = print_thing(string.format("Memory Usage (kB): %d", collectgarbage('count')), y)
   y = print_thing(string.format("Frametime: %.3f ms", 1000 * lt.getAverageDelta()), y)
   y = print_thing(string.format("Camera X: %d, Y: %d", camera.x, camera.y), y)
   y = print_thing(string.format("Mouse X: %d Y: %d", mx, my), y)
   lg.pop()
end

function DebugOverlay:update(dt)

end

return DebugOverlay
