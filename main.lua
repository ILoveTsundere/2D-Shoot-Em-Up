local HC = require 'HardonCollider'
io.stdout:setvbuf("no") --COMMAND TO MAKE THE CONSOLE OUTPUT LIVE
require "enemy_projectiles"
require "player_projectiles"
require "player"
require 'enemy'
require("AnAL")
love.graphics.setDefaultFilter("nearest", "nearest")
shootTime = 0 -- for testing

--proceeds to call the appropiate function depending on which shapes collided
--@param dt The delta time
--@param shape_a, shape b The colliding shapes
function on_collide(dt, shape_a, shape_b)
  if shape_a == borderLeft or shape_b == borderLeft then -- if its the borderLeft, I have to check Enemy and Projectile.
    for i = table.getn(enemy_projectiles), 1, -1 do
      if enemy_projectiles[i].collider == shape_b or enemy_projectiles[i].collider == shape_a then --if the other shape is a projectile, then OUTOFBOUNDS
        enemy_projectiles.outOfBounds(i)
        return
      end
    end
    for i = table.getn(enemy), 1, -1 do
      if enemy[i].collider == shape_b or enemy[i].collider == shape_a then --if the other shape is a ship, then OUTOFBOUNDS
        enemy.outOfBounds(i)
        return
      end
    end
  elseif shape_a == borderRight or shape_b == borderRight then -- if its the borderRIght, I have to check projectiles only (enemies exit out the left side)
    for i = table.getn(player_projectiles), 1, -1 do
      if player_projectiles[i].collider == shape_b or player_projectiles[i].collider == shape_a then --if the other shape is a projectile, then OUTOFBOUNDS
        player_projectiles.outOfBounds(i)
        return
      end
    end
  --check if either shape belongs to the player
  elseif shape_a == player.collider or shape_b == player.collider then
    for i = table.getn(enemy), 1, -1 do
      if enemy[i].collider == shape_b or enemy[i].collider == shape_a then --if the other shape is a ship, then CRASH
        player.crash()
        enemy.hit(i)
        return
      end
    end
    for i = table.getn(enemy_projectiles), 1, -1 do
      if enemy_projectiles[i].collider == shape_b or enemy_projectiles[i].collider == shape_a then --if the other shape is a projectile, then HIT
        player.hit(i)
        enemy_projectiles.hit(i)
        return
      end
    end
  else --check if either shape belongs to an enemy, then check if the 2nd shape belongs to a player_projectile (don't have to check if it's the player)
  for i = table.getn(enemy), 1, -1 do
    if enemy[i].collider == shape_b or enemy[i].collider == shape_a then
      for j = table.getn(player_projectiles), 1, -1 do
        if player_projectiles[j].collider == shape_b or player_projectiles[j].collider == shape_a then --if the other shape is a projectile, then HIT
          enemy.hit(i)
          player_projectiles.hit(j)
          return
        end
      end
    end
  end
  end
end


--checks for keypressed events


--clears the game of the game objects
function clearGame()
  enemy.clear()
  projectiles.clear()
  player.clear()
end

--loads the game
function love.load()
  love.window.setTitle("THE SPACESHIPS ARE BACK")
  love.window.setMode(900, 600, { vsync = false})
  
  Collider = HC(1000, on_collide)

  player.load()
  enemy.load()

  --borderTop      = Collider:addRectangle(0,-100, 800,100)
  --borderBottom   = Collider:addRectangle(0,600, 800,100)
  borderLeft     = Collider:addRectangle(0,0, 2,600)
  borderRight    = Collider:addRectangle(900,0, 2,600)


end

--update function
function love.update(dt)
  shootTime = shootTime + dt
  if shootTime > .1 then
    shootTime = 0
    enemy.addEnemy(math.random(500,800), math.random(0,600))
    enemy.shoot()
  end
  player.update(dt)
  enemy.update(dt)
  player_projectiles.update(dt)
  enemy_projectiles.update(dt)
  Collider:update(dt)
end

--draws
function love.draw()
  love.graphics.print("Number of Enemyships = " ..  table.maxn(enemy) )
  love.graphics.print("\nNumber of Player Projectiles = " ..  table.maxn(player_projectiles) )
  love.graphics.print("\n\nNumber of Enemy Projectiles = " ..  table.maxn(enemy_projectiles) )
  player.draw()
  enemy.draw()
  enemy_projectiles.draw()
  player_projectiles.draw()
  borderRight:draw('line')
  borderLeft:draw('line')

end
