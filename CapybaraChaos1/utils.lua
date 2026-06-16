---@diagnostic disable: undefined-global

function checkCollision(a, b)
    return a.x < b.x + b.size and
           b.x < a.x + a.size and
           a.y < b.y + b.size and
           b.y < a.y + a.size
end

function getSpawnPosition()
    local side = love.math.random(1, 4)
    local x, y

    if side == 1 then
        x, y = -60, love.math.random(0, H)
    elseif side == 2 then
        x, y = W + 60, love.math.random(0, H)
    elseif side == 3 then
        x, y = love.math.random(0, W), -60
    else
        x, y = love.math.random(0, W), H + 60
    end

    return x, y
end

function burst(x, y, r, g, b)
    for i = 1, 12 do
        table.insert(particles, {
            x = x,
            y = y,
            dx = love.math.random(-120, 120),
            dy = love.math.random(-120, 120),
            life = 0.5,
            r = r,
            g = g,
            b = b
        })
    end
end

function updateParticles(dt)
    for i = #particles, 1, -1 do
        local p = particles[i]
        p.x = p.x + p.dx * dt
        p.y = p.y + p.dy * dt
        p.life = p.life - dt

        if p.life <= 0 then
            table.remove(particles, i)
        end
    end
end
