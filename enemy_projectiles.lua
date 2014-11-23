enemy_projectiles = {}
local projectile_speed = 400


--spawns a new projectile infront of the caller
function enemy_projectiles.spawn(x,y,dir)
  table.insert(enemy_projectiles, {width = 15, height = 5, x = x, y = y, dir = dir, collider = Collider:addRectangle( x,y, 15,5)})
  Collider.setPassive(enemy_projectiles[table.maxn(enemy_projectiles)].collider)
end

--once a collision has been detected, it removes the projectile, probably adding a custom animation eventually
function enemy_projectiles.hit(projectileIndex)
  Collider:remove(enemy_projectiles[projectileIndex].collider)
  table.remove(enemy_projectiles, projectileIndex)
end

function enemy_projectiles.clear()
  for i = table.getn(enemy_projectiles), 1, -1 do
    Collider:remove(enemy_projectiles[i].collider)
    table.remove(enemy_projectiles, i)
  end
end

--updates the projectile and collider positions
function enemy_projectiles.update(dt)
  for k,v in ipairs(enemy_projectiles) do
    if v.dir == "left" then
      v.x = v.x - projectile_speed * dt
      v.collider:move(-projectile_speed * dt, 0)
    end
  end
end

function enemy_projectiles.outOfBounds(projectileIndex)
  Collider:remove(enemy_projectiles[projectileIndex].collider)
  table.remove(enemy_projectiles, projectileIndex)
end



--draws all the enemy_projectiles
function enemy_projectiles.draw()
  
  for i,v in ipairs(enemy_projectiles) do
    love.graphics.setColor(255,255,255)
    v.collider:draw('fill')
  end
end

return enemy_projectiles