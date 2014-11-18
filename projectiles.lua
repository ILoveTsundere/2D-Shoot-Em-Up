
projectiles = {}

function projectiles.load()
  projectile_speed = 100
end

function projectiles.spawn(x,y,dir)
  table.insert(projectiles, {width = 15, height = 5, x = x, y = y, dir = dir, collider = Collider:addRectangle( x,y, 15,5)})
end



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

function projectiles.draw()
  
  for i,v in ipairs(projectiles) do
    love.graphics.setColor(255,255,255)
    v.collider:draw('fill')
  end
end

