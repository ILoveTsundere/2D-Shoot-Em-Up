enemy = {}
laserSound = love.audio.newSource('Sounds/Laser_Shoot.wav')
picture = love.graphics.newImage('Images/EnemyShip.png')
enemyExplosion = love.audio.newSource('Sounds/Enemy_Explosion1.wav')

--loads the first enemy, eventually this won't exist...
function enemy.load()
  table.insert(enemy, {pic = picture, x = 500, y = 300, width = picture:getWidth(), height = picture:getHeight(), collider = Collider:addRectangle(510,255,32,40), speed = 200, outOfBounds = -picture:getWidth()/2})

end

--enemy shooting
function enemy.shoot()
  if table.getn(enemy) > 0 then
    enemyShooter = enemy[math.random(1, table.getn(enemy))]
    love.audio.stop(laserSound)
    enemy_projectiles.spawn(enemyShooter.x - 20, enemyShooter.y - enemyShooter.height/2, 'left')
    love.audio.play(laserSound)
  end

end
--checks if the enemy is out of bounds
function enemy.outOfBounds(i)
  Collider:remove(enemy[i].collider)
  table.remove(enemy, i)

end

--updates enemy positions using delta time
function enemy.update(dt)
  for k,v in ipairs(enemy) do
    v.x = v.x - 100*dt
    v.collider:moveTo(v.x+25, v.y-25)
  end
end


function enemy.clear()
  for i = table.getn(enemy), 1, -1 do
    Collider:remove(enemy[i].collider)
    table.remove(enemy, i)
  end
end

--draws the enemy 
function enemy.draw()
  for k,v in ipairs(enemy) do
    love.graphics.draw(v.pic, v.x,v.y,math.rad(-90), 1,1)
    --v.collider:draw('line')
  end
end

--does the enemy death animation and removes him from the table
function enemy.hit(enemyIndex)
  love.audio.stop(enemyExplosion)
  Collider:remove(enemy[enemyIndex].collider)
  table.remove(enemy, enemyIndex)
  love.audio.play(enemyExplosion)

end

function enemy.addEnemy(x, y)
  table.insert(enemy, {pic = picture, x = x, y = y, width = picture:getWidth(), height = picture:getHeight(), collider = Collider:addRectangle(x+10,y-45,32,40), speed = 200, outOfBounds = -picture:getWidth()/2})
end

return enemy