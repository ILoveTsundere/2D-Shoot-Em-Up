player_projectiles = {}
local  projectile_speed = 400

--spawns a new projectile infront of the caller
function player_projectiles.spawn(x, y, dir, onH, timer, col, w, h  )
  table.insert(player_projectiles, {width = w or 15, height = h or 5, x = x, y = y, dir = dir, 
      collider = col or Collider:addRectangle( x,y, 10,5), onHit = onH or false, bombed=false, timer = timer or 0})
  Collider.setPassive(player_projectiles[table.maxn(player_projectiles)].collider)
end

--once a collision has been detected, it removes the projectile, probably adding a custom animation eventually
function player_projectiles.hit(projectileIndex)
  if player_projectiles[projectileIndex].onHit then --creates the circle for the onhit effect (its a BOOOOMB)
    player_projectiles[projectileIndex].bombed = true
    local x,y = player_projectiles[projectileIndex].collider:center()
    Collider:remove(player_projectiles[projectileIndex].collider)
    player_projectiles[projectileIndex].collider = Collider:addCircle( x,y, 100)
    Collider.setPassive(player_projectiles[projectileIndex].collider)
  end
  if player_projectiles[projectileIndex].timer <= 0 then --gets ride of projectiles that have a timer equal or less than 0
      Collider:remove(player_projectiles[projectileIndex].collider)
      table.remove(player_projectiles, projectileIndex)
  end
end

--clears away all player projectiles
function player_projectiles.clear()
  for i = table.getn(player_projectiles), 1, -1 do
    Collider:remove(player_projectiles[i].collider)
    table.remove(player_projectiles, i)
  end
end

--updates the projectile and collider positions
function player_projectiles.update(dt)
  for k,v in ipairs(player_projectiles) do
    local timer = v.timer
    if v.bombed then
      v.timer = v.timer - dt
    end
    v.x = v.x + projectile_speed * dt
    v.collider:move(projectile_speed * dt, 0)
  end
end

function player_projectiles.outOfBounds(projectileIndex)
  Collider:remove(player_projectiles[projectileIndex].collider)
  table.remove(player_projectiles, projectileIndex)
end



--draws all the player_projectiles
function player_projectiles.draw()
  
  for i,v in ipairs(player_projectiles) do
    love.graphics.setColor(255,255,255)
    v.collider:draw('fill')
  end
end

return player_projectiles
