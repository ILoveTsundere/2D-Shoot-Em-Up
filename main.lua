HC = require 'HardonCollider'
--COMMAND TO MAKE THE CONSOLE OUTPUT LIVE
io.stdout:setvbuf("no")
require "player"
require 'enemy'
require "projectiles"

function on_collide(dt, shape_a, shape_b)


end

function love.keypressed(key)
  if (key == ' ') then
    player.shoot()
  elseif (key == '1') then
    enemy.shoot()
  end
end

function love.load()
  love.window.setTitle("THE SPACESHIPS ARE BACK")
  print (love.window.getHeight(), love.window.getWidth())
  Collider = HC(100, on_collide)
  
  player.load()
  enemy.load()
  projectiles.load()

  borderTop    = Collider:addRectangle(0,-100, 800,100)
  borderBottom = Collider:addRectangle(0,600, 800,100)
  goalLeft     = Collider:addRectangle(-100,0, 100,600)
  goalRight    = Collider:addRectangle(800,0, 100,600)
  
end

function love.update(dt)
  player.update(dt)
  projectiles.update(dt)
  Collider:update(dt)
end


function love.draw()
  player.draw()
  enemy.draw()
  projectiles.draw()
  --borderTop:draw('line')
  --leftPaddle:draw('fill')
  
end
