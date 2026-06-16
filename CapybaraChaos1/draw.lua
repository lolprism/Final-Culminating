---@diagnostic disable: undefined-global

function drawGameScreen()
    drawBackground()

    if gameState == "intro" then drawIntro()
    elseif gameState == "menu" then drawMenu()
    elseif gameState == "playing" then drawGameplay()
    elseif gameState == "gameover" then drawGameOver()
    end

    drawParticles()
end

function drawBackground()
    love.graphics.setColor(0.35, 0.72, 0.45)
    love.graphics.rectangle("fill", 0, 0, W, H)

    love.graphics.setColor(0.29, 0.64, 0.38)
    for x = 0, W, 90 do
        love.graphics.rectangle("fill", x, 0, 45, H)
    end

    love.graphics.setColor(1, 0.9, 0.2)
    love.graphics.circle("fill", 780, 100, 55)
    love.graphics.setColor(1, 0.95, 0.45, 0.35)
    love.graphics.circle("fill", 780, 100, 75)

    for i = 1, 15 do
        love.graphics.setColor(1, 1, 1, 0.20)
        love.graphics.circle("fill", (i * 120 + score * 8) % W, 100 + math.sin(i) * 50, 20)
        love.graphics.circle("fill", (i * 120 + score * 8 + 25) % W, 95 + math.sin(i) * 50, 15)
    end

    love.graphics.setColor(0.10, 0.45, 0.75)
    love.graphics.ellipse("fill", 220, 500, 150, 80)
    love.graphics.setColor(0.45, 0.80, 1, 0.45)
    love.graphics.ellipse("fill", 180, 470, 55, 22)

    love.graphics.setColor(0.12, 0.36, 0.18)
    love.graphics.rectangle("fill", 0, 585, W, 65)

    love.graphics.setColor(0.09, 0.30, 0.13)
    for x = 0, W, 35 do
        love.graphics.polygon("fill", x, 585, x + 15, 555, x + 30, 585)
    end
end

function drawIntro()
    love.graphics.setColor(0, 0, 0, 0.38)
    love.graphics.rectangle("fill", 0, 0, W, H)

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(fontBig)
    love.graphics.printf("CAPYBARA CHAOS", 0, 65, W, "center")
    love.graphics.setFont(fontMed)

    if introTimer < 6 then
        love.graphics.printf("Long before the chaos, Capy lived peacefully by the pond.", 70, 185, W - 140, "center")
        love.graphics.printf("No drama. No cameras. Just oranges and vibes.", 70, 230, W - 140, "center")
        drawCapybara(W / 2 - 45, 385, 90)
    elseif introTimer < 12 then
        love.graphics.printf("Then one random kid posted a video...", 70, 175, W - 140, "center")
        love.graphics.printf("\"MOST CHILL ANIMAL ON EARTH???\"", 70, 220, W - 140, "center")
        love.graphics.printf("The internet immediately lost its mind.", 70, 265, W - 140, "center")
        drawCapybara(W / 2 - 45, 390, 90)
        drawEnemy({name = "TikTok Kid", x = W / 2 + 190, y = 450})
    elseif introTimer < 20 then
        love.graphics.printf("Suddenly, everyone wanted to meet Capy.", 70, 180, W - 140, "center")
        love.graphics.printf("Fans arrived. Ducks joined. Paparazzi followed.", 70, 225, W - 140, "center")
        love.graphics.printf("Capy still only wanted one thing: peace.", 70, 270, W - 140, "center")
        drawEnemy({name = "Duck Army", x = W / 2 - 230, y = 455})
        drawCapybara(W / 2 - 45, 390, 90)
        drawEnemy({name = "Paparazzi", x = W / 2 + 230, y = 455})
    else
        love.graphics.printf("Now Capy must escape fame and collect oranges to stay calm.", 70, 180, W - 140, "center")
        love.graphics.printf("Run. Dodge. Survive. Stay chill.", 70, 235, W - 140, "center")
        love.graphics.printf("The chaos begins now.", 70, 290, W - 140, "center")
        drawCapybara(W / 2 - 45, 400, 90)
    end

    love.graphics.setFont(fontSmall)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Press SPACE to skip", 0, 605, W, "center")
end

function drawMenu()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(fontBig)
    love.graphics.printf("CAPYBARA CHAOS", 0, 90, W, "center")

    love.graphics.setFont(fontMed)
    love.graphics.printf("A chill capybara is trying to survive internet fame.", 100, 170, 700, "center")

    love.graphics.setFont(fontSmall)
    love.graphics.printf("WASD = Move   |   Collect oranges and golden oranges   |   Avoid chaos", 0, 260, W, "center")
    love.graphics.printf("Power-ups: Chill Aura, Zoomies, Mega Orange, Ice, Pull, Clear", 0, 292, W, "center")
    love.graphics.printf("PRESS SPACE TO ESCAPE FAME", 0, 360, W, "center")
    love.graphics.printf("Press ESC to Quit", 0, 392, W, "center")
    drawCapybara(W / 2 - 45, 505, 85)
end

function drawGameplay()
    drawUI()
    for _, orange in ipairs(oranges) do drawOrange(orange) end
    for _, p in ipairs(powerups) do drawPowerup(p) end
    for _, enemy in ipairs(enemies) do drawEnemy(enemy) end
    drawCapybara(player.x, player.y, player.size)
end

function drawGameOver()
    love.graphics.setColor(0, 0, 0, 0.58)
    love.graphics.rectangle("fill", 0, 0, W, H)
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(fontBig)
    love.graphics.printf("GAME OVER", 0, 145, W, "center")
    love.graphics.setFont(fontMed)
    love.graphics.printf(deathMessage, 100, 235, 700, "center")
    love.graphics.printf("Final Score: " .. math.floor(score), 0, 315, W, "center")
    love.graphics.printf("High Score: " .. highScore, 0, 355, W, "center")
    love.graphics.setFont(fontSmall)
    love.graphics.printf("Press R to Restart", 0, 445, W, "center")
    love.graphics.printf("Press M for Menu", 0, 475, W, "center")
end

function drawUI()
    love.graphics.setColor(0, 0, 0, 0.4)
    love.graphics.rectangle("fill", 15, 15, 290, 145, 14, 14)
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(fontSmall)
    love.graphics.print("Score: " .. math.floor(score), 35, 30)
    love.graphics.print("High Score: " .. highScore, 35, 55)
    love.graphics.print("Chaos Level: " .. level, 35, 80)

    if invincibleTimer > 0 then love.graphics.print("Power: CHILL AURA " .. math.ceil(invincibleTimer), 35, 105)
    elseif boostTimer > 0 then love.graphics.print("Power: ZOOMIES " .. math.ceil(boostTimer), 35, 105)
    elseif freezeTimer > 0 then love.graphics.print("Power: ICE " .. math.ceil(freezeTimer), 35, 105)
    elseif magnetTimer > 0 then love.graphics.print("Power: PULL " .. math.ceil(magnetTimer), 35, 105)
    else love.graphics.print("Power: None", 35, 105) end

    love.graphics.print("Golden Orange = +35 + boost", 35, 130)

    if levelMessageTimer > 0 then
        love.graphics.setFont(fontMed)
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf("CHAOS LEVEL " .. level, 0, 150, W, "center")
    end
end

function drawCapybara(x, y, size)
    if invincibleTimer > 0 then
        love.graphics.setColor(0.5, 0.9, 1, 0.45)
        love.graphics.circle("fill", x + size / 2, y + size / 2, size)
    end
    love.graphics.setColor(0.55, 0.32, 0.18)
    love.graphics.rectangle("fill", x, y + size * 0.25, size, size * 0.55, 15, 15)
    love.graphics.setColor(0.66, 0.42, 0.25)
    love.graphics.circle("fill", x + size * 0.83, y + size * 0.38, size * 0.30)
    love.graphics.setColor(0, 0, 0)
    love.graphics.circle("fill", x + size * 0.93, y + size * 0.33, 3)
    love.graphics.setColor(0.22, 0.12, 0.06)
    love.graphics.rectangle("fill", x + 8, y + size * 0.76, 8, 13)
    love.graphics.rectangle("fill", x + size - 16, y + size * 0.76, 8, 13)
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(fontSmall)
    love.graphics.print("CAPY", x - 2, y - 22)
end

function drawOrange(orange)
    if orange.kind == "golden" then
        love.graphics.setColor(1, 1, 0.5, 0.5)
        love.graphics.circle("fill", orange.x, orange.y, orange.size + 8)
        love.graphics.setColor(1, 0.85, 0.05)
    else
        love.graphics.setColor(1, 0.55, 0.05)
    end
    love.graphics.circle("fill", orange.x, orange.y, orange.size)
    love.graphics.setColor(0.1, 0.6, 0.1)
    love.graphics.circle("fill", orange.x + 5, orange.y - orange.size, 4)
end

function drawEnemy(enemy)
    if enemy.name == "Duck Army" then
        love.graphics.setColor(1, 0.9, 0.1)
        love.graphics.ellipse("fill", enemy.x, enemy.y, 28, 18)
        love.graphics.circle("fill", enemy.x + 22, enemy.y - 10, 14)
        love.graphics.setColor(1, 0.45, 0)
        love.graphics.polygon("fill", enemy.x + 34, enemy.y - 10, enemy.x + 50, enemy.y - 5, enemy.x + 34, enemy.y)
        love.graphics.setColor(0, 0, 0)
        love.graphics.circle("fill", enemy.x + 25, enemy.y - 14, 3)
    elseif enemy.name == "TikTok Kid" then
        love.graphics.setColor(1, 0.75, 0.55)
        love.graphics.circle("fill", enemy.x, enemy.y - 10, 17)
        love.graphics.setColor(1, 0.25, 0.75)
        love.graphics.rectangle("fill", enemy.x - 14, enemy.y + 5, 28, 35, 8, 8)
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", enemy.x + 18, enemy.y, 10, 18, 3, 3)
    elseif enemy.name == "Tiny Dog" then
        love.graphics.setColor(0.55, 0.30, 0.12)
        love.graphics.rectangle("fill", enemy.x - 25, enemy.y - 5, 45, 25, 8, 8)
        love.graphics.circle("fill", enemy.x + 22, enemy.y - 10, 16)
        love.graphics.setColor(0.30, 0.15, 0.05)
        love.graphics.circle("fill", enemy.x + 12, enemy.y - 22, 7)
        love.graphics.setColor(0, 0, 0)
        love.graphics.circle("fill", enemy.x + 27, enemy.y - 13, 3)
    elseif enemy.name == "Paparazzi" then
        love.graphics.setColor(0.1, 0.1, 0.1)
        love.graphics.rectangle("fill", enemy.x - 15, enemy.y, 30, 35, 6, 6)
        love.graphics.setColor(0.9, 0.7, 0.55)
        love.graphics.circle("fill", enemy.x, enemy.y - 15, 15)
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", enemy.x + 16, enemy.y - 12, 24, 16, 4, 4)
        love.graphics.setColor(1, 1, 0.4)
        love.graphics.circle("fill", enemy.x + 42, enemy.y - 4, 6)
    elseif enemy.name == "Drunk Driver" then
        love.graphics.setColor(0.18, 0.18, 0.18)
        love.graphics.rectangle("fill", enemy.x - 34, enemy.y - 17, 68, 34, 8, 8)

        love.graphics.setColor(0.75, 0.05, 0.05)
        love.graphics.rectangle("fill", enemy.x - 22, enemy.y - 30, 44, 18, 6, 6)

        love.graphics.setColor(0.8, 0.9, 1)
        love.graphics.rectangle("fill", enemy.x - 15, enemy.y - 27, 12, 10, 3, 3)
        love.graphics.rectangle("fill", enemy.x + 3, enemy.y - 27, 12, 10, 3, 3)

        love.graphics.setColor(0, 0, 0)
        love.graphics.circle("fill", enemy.x - 22, enemy.y + 20, 8)
        love.graphics.circle("fill", enemy.x + 22, enemy.y + 20, 8)

        love.graphics.setColor(1, 1, 0.35)
        love.graphics.circle("fill", enemy.x + 36, enemy.y - 3, 5)

    elseif enemy.name == "MEGA PAPARAZZI" then
        love.graphics.setColor(0.05, 0.05, 0.05)
        love.graphics.rectangle("fill", enemy.x - 35, enemy.y, 70, 80, 10, 10)
        love.graphics.setColor(0.9, 0.7, 0.55)
        love.graphics.circle("fill", enemy.x, enemy.y - 30, 32)
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", enemy.x + 30, enemy.y - 25, 55, 35, 6, 6)
        love.graphics.setColor(1, 1, 0.2)
        love.graphics.circle("fill", enemy.x + 90, enemy.y - 8, 14)
    end

    if freezeTimer > 0 then
        love.graphics.setColor(0.5, 0.9, 1, 0.25)
        love.graphics.circle("fill", enemy.x, enemy.y, enemy.size + 12)
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(fontSmall)
    love.graphics.printf(enemy.name, enemy.x - 70, enemy.y - 65, 140, "center")
end

function drawPowerup(p)
    if p.kind == "chill" then love.graphics.setColor(0.4, 0.9, 1)
    elseif p.kind == "zoom" then love.graphics.setColor(1, 1, 0.2)
    elseif p.kind == "freeze" then love.graphics.setColor(0.55, 0.95, 1)
    elseif p.kind == "magnet" then love.graphics.setColor(0.8, 0.3, 1)
    elseif p.kind == "clear" then love.graphics.setColor(1, 0.1, 0.1)
    else love.graphics.setColor(1, 0.4, 0) end

    love.graphics.circle("fill", p.x, p.y, p.size)
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(fontSmall)
    love.graphics.printf(p.label, p.x - 30, p.y - 8, 60, "center")
end

function drawParticles()
    for _, p in ipairs(particles) do
        love.graphics.setColor(p.r, p.g, p.b, p.life * 2)
        love.graphics.circle("fill", p.x, p.y, 4)
    end
    love.graphics.setColor(1, 1, 1)
end
