enemy = {}
laserSound = love.audio.newSource('Sounds/Laser_Shoot.wav')
picture = love.graphics.newImage('EnemyShip.png')

function enemy.load()
  table.insert(enemy, {pic = picture, x = 500, y = 300, width = picture:getWidth(), height = picture:getHeight(), collider = Collider:addRectangle(510,255,32,40), speed = 200})

end

function enemy.shoot()
    --love.audio.stop(laserSound)
    --projectiles.spawn(enemy.x, enemy.y - enemy.height/2, 'left')
    --love.audio.play(laserSound)

end

function enemy.draw()
  for k,v in ipairs(enemy) do
    love.graphics.draw(v.pic, v.x,v.y,math.rad(-90), 1,1)
    v.collider:draw('line')
  end
end
  
function addEnemy(x,y)
  --table.insert(enemy, {
end