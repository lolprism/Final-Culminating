---@diagnostic disable: undefined-global

function movePlayer(dt)
    local speed = player.speed

    if boostTimer > 0 then
        speed = speed * 1.7
    end

    if love.keyboard.isDown("w") then player.y = player.y - speed * dt end
    if love.keyboard.isDown("s") then player.y = player.y + speed * dt end
    if love.keyboard.isDown("a") then player.x = player.x - speed * dt end
    if love.keyboard.isDown("d") then player.x = player.x + speed * dt end

    player.x = math.max(20, math.min(W - 60, player.x))
    player.y = math.max(20, math.min(H - 70, player.y))
end
