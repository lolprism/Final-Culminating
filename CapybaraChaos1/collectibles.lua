---@diagnostic disable: undefined-global

function spawnOrange()
    table.insert(oranges, {
        x = love.math.random(45, W - 45),
        y = love.math.random(45, H - 90),
        size = 15,
        kind = "orange"
    })
end

function spawnGoldenOrange()
    table.insert(oranges, {
        x = love.math.random(45, W - 45),
        y = love.math.random(45, H - 90),
        size = 21,
        kind = "golden"
    })
end

function spawnPowerup()
    local kinds = {
        {kind = "chill", label = "CHILL"},
        {kind = "zoom", label = "ZOOM"},
        {kind = "mega", label = "+25"},
        {kind = "freeze", label = "ICE"},
        {kind = "magnet", label = "PULL"},
        {kind = "clear", label = "CLEAR"}
    }

    local chosen = kinds[love.math.random(1, #kinds)]

    table.insert(powerups, {
        x = love.math.random(60, W - 60),
        y = love.math.random(60, H - 110),
        size = 24,
        kind = chosen.kind,
        label = chosen.label
    })
end

function checkCollectibles()
    for i = #oranges, 1, -1 do
        local orange = oranges[i]

        if magnetTimer > 0 then
            moveCollectibleTowardPlayer(orange, 180)
        end

        if checkCollision(player, orange) then
            if orange.kind == "golden" then
                score = score + 35
                boostTimer = 3
                playSound(goldenSound)
                burst(orange.x, orange.y, 1, 0.9, 0.1)
            else
                score = score + 10
                playSound(collectSound)
                burst(orange.x, orange.y, 1, 0.6, 0)
            end

            table.remove(oranges, i)
        end
    end

    for i = #powerups, 1, -1 do
        if checkCollision(player, powerups[i]) then
            applyPowerup(powerups[i])
            burst(powerups[i].x, powerups[i].y, 0.4, 0.9, 1)
            table.remove(powerups, i)
        end
    end
end

function applyPowerup(powerup)
    if powerup.kind == "chill" then
        invincibleTimer = 5
        playSound(powerSound)
    elseif powerup.kind == "zoom" then
        boostTimer = 5
        playSound(powerSound)
    elseif powerup.kind == "mega" then
        score = score + 25
        playSound(powerSound)
    elseif powerup.kind == "freeze" then
        freezeTimer = 4
        playSound(freezeSound)
    elseif powerup.kind == "magnet" then
        magnetTimer = 5
        playSound(powerSound)
    elseif powerup.kind == "clear" then
        enemies = {}
        score = score + 15
        playSound(clearSound)
    end
end

function moveCollectibleTowardPlayer(item, speed)
    local dx = player.x - item.x
    local dy = player.y - item.y
    local dist = math.sqrt(dx * dx + dy * dy)

    if dist > 0 and dist < 260 then
        item.x = item.x + (dx / dist) * speed * love.timer.getDelta()
        item.y = item.y + (dy / dist) * speed * love.timer.getDelta()
    end
end
