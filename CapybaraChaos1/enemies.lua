---@diagnostic disable: undefined-global

function spawnEnemy()
    -- Stops the screen from becoming impossible. Only Remove Comments if you think unlimited too much
   -- if #enemies >= maxEnemies then
   --     return
   -- end

    local types = {
        {name = "Duck Army", message = "The duck army got too powerful."},
        {name = "TikTok Kid", message = "You became too viral."},
        {name = "Tiny Dog", message = "A tiny angry dog ruined your chill."},
        {name = "Paparazzi", message = "The paparazzi exposed your location."},
        {name = "Drunk Driver", message = "A drunk driver crashed the chill zone."}
    }

    local chosen = types[love.math.random(1, #types)]
    local x, y = getSpawnPosition()

    local enemy = {
        x = x,
        y = y,
        size = 32,
        speed = math.min(95, 50 + level * 3),
        name = chosen.name,
        message = chosen.message
    }

    -- Drunk Driver moves randomly instead of chasing Capy
    if chosen.name == "Drunk Driver" then
        local angle = love.math.random() * math.pi * 2
        enemy.dx = math.cos(angle)
        enemy.dy = math.sin(angle)
        enemy.speed = 135
        enemy.size = 42
    end

    table.insert(enemies, enemy)
end

function spawnBoss()
    local x, y = getSpawnPosition()

    table.insert(enemies, {
        x = x,
        y = y,
        size = 70,
        speed = 75,
        name = "MEGA PAPARAZZI",
        message = "The MEGA PAPARAZZI ended your chill era."
    })
end

function updateEnemies(dt)
    for i = #enemies, 1, -1 do
        local enemy = enemies[i]
        local currentSpeed = enemy.speed

        if freezeTimer > 0 then
            currentSpeed = currentSpeed * 0.25
        end

        if enemy.name == "Drunk Driver" then
            enemy.x = enemy.x + enemy.dx * currentSpeed * dt
            enemy.y = enemy.y + enemy.dy * currentSpeed * dt

            if enemy.x < -120 or enemy.x > W + 120 or enemy.y < -120 or enemy.y > H + 120 then
                enemy.dead = true
            end
        else
            local dx = player.x - enemy.x
            local dy = player.y - enemy.y
            local dist = math.sqrt(dx * dx + dy * dy)

            if dist > 0 then
                enemy.x = enemy.x + (dx / dist) * currentSpeed * dt
                enemy.y = enemy.y + (dy / dist) * currentSpeed * dt
            end
        end

        if checkCollision(player, enemy) and invincibleTimer <= 0 then
            gameState = "gameover"
            deathMessage = enemy.message
            highScore = math.max(highScore, math.floor(score))
            playSound(gameOverSound)
        end

        if enemy.dead then
            table.remove(enemies, i)
        end
    end
end
