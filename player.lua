
player = {}
laserSound = love.audio.newSource('Sounds/Laser_Shoot.wav')

function player.load()
  player.pic = love.graphics.newImage('PlayerShip.png')
  player.x = 100
  player.y = 95
  player.width = player.pic:getWidth()
  player.height = player.pic:getHeight()
  player.collider = Collider:addRectangle(50,100, 50,40)
  player.speed = 200
end

function player.shoot()
  love.audio.stop(laserSound)
  projectiles.spawn(player.x, player.y + player.height/2, 'right')
  love.audio.play(laserSound)
end


function player.update(dt)
  
  -- right player movement
  if love.keyboard.isDown('up') or love.keyboard.isDown('w') then
      player.collider:move(0, -player.speed * dt)
      player.y = player.y - player.speed * dt
  elseif love.keyboard.isDown('down') or love.keyboard.isDown('s') then
      player.collider:move(0,  player.speed * dt)
      player.y = player.y + player.speed * dt
end

function player.keypressed(key)


    end
end
function player.draw()
  love.graphics.draw(player.pic, player.x,player.y,math.rad(90), 1,1)
  player.collider:draw('line')
end