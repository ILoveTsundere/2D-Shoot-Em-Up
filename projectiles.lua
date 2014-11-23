projectiles = {}

function projectiles.load()
  projectile_speed = 400
end

--spawns a new projectile infront of the caller
function projectiles.spawn(x,y,dir)
  table.insert(projectiles, {width = 15, height = 5, x = x, y = y, dir = dir, collider = Collider:addRectangle( x,y, 15,5)})
end

--once a collision has been detected, it removes the projectile, probably adding a custom animation eventually
function projectiles.hit(projectileIndex)
  Collider:remove(projectiles[projectileIndex].collider)
  table.remove(projectiles, projectileIndex)
end

function projectiles.clear()
  for i = table.getn(projectiles), 1, -1 do
    Collider:remove(projectiles[i].collider)
    table.remove(projectiles, i)
  end
end

--updates the projectile and collider positions
function projectiles.update(dt)
  for k,v in ipairs(projectiles) do
    if v.dir == "right" then
      v.x = v.x + projectile_speed * dt
      v.collider:move(projectile_speed * dt, 0)
    end
    if v.dir == "left" then
      v.x = v.x - projectile_speed * dt
      v.collider:move(-projectile_speed * dt, 0)
    end
  end
end

function projectiles.outOfBounds(projectileIndex)
  print "deleted projectile"
  Collider:remove(projectiles[projectileIndex].collider)
  table.remove(projectiles, projectileIndex)
end



--draws all the projectiles
function projectiles.draw()
  
  for i,v in ipairs(projectiles) do
    love.graphics.setColor(255,255,255)
    v.collider:draw('fill')
  end
end

