
player = {}
laserSound = love.audio.newSource('Sounds/Laser_Shoot.wav')
local sprites = love.graphics.newImage('Images/PlayerShip.png')
--loads the player values
function player.load()
  player.x = 100
  player.y = 95
  player.width = sprites:getWidth()
  player.height = sprites:getHeight()
  player.collider = Collider:addRectangle(50,100, 50,40)
  player.speed = 200
  player.anim = newAnimation(sprites, 50, 50, 0.1, 4)
  player.powerUp = 0
  player.specialCharges = 5
end

--creates a projectile
function player.shoot()
  love.audio.stop(laserSound)
  local x,y = player.collider:center()
  --for x = 1,  player.powerUp do
    player_projectiles.spawn(x + sprites:getWidth()/4,y, 'right')
  --end
end 

function love.keypressed(key)
  local x,y = player.collider:center()
  if (key == ' ') then
    player.shoot(' ')
  elseif (key == '1') then
    if player.specialCharges > 0 then
      player_projectiles.spawn(x + sprites:getWidth()/4, y, 'right', true,.5)  
      player.specialCharges = player.specialCharges - 1
    end
  elseif (key == '2') then
    player.powerUp = player.powerUp + 1
  elseif (key == '3') then
    player.powerUp = player.powerUp-1
  end
love.audio.play(laserSound)  
end

--when the player is hit by a projectile, the projectile index is sent incase i decide to add special ones
function player.hit(projectile)
  
end

--when the player crashes with another ship
function player.crash()
  
end
function player.clear()
  
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
  player.anim:update(dt)   
end

  
  
function player.draw()
  player.anim:draw(player.x,player.y,math.rad(90), 1,1)
  --player.collider:draw('line')
end

return player