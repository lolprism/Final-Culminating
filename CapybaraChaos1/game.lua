---@diagnostic disable: undefined-global

W, H = 900, 650

function setupGame()
    love.window.setTitle("Capybara Chaos")
    love.window.setMode(W, H)

    fontBig = love.graphics.newFont(52)
    fontMed = love.graphics.newFont(25)
    fontSmall = love.graphics.newFont(16)

    loadAudio()

    highScore = 0
    gameState = "intro"
    introTimer = 0
    resetGame()
end

function resetGame()
    player = {x = W / 2, y = H / 2, size = 42, speed = 270}
    enemies = {}
    oranges = {}
    powerups = {}
    particles = {}

    score = 0
    spawnTimer = 0
    orangeTimer = 0
    goldenOrangeTimer = 0
    powerTimer = 0

    invincibleTimer = 0
    boostTimer = 0
    freezeTimer = 0
    magnetTimer = 0

    deathMessage = ""
    level = 1
    levelMessageTimer = 2
    bossSpawned = false
    maxEnemies = 18
end

function updateGame(dt)
    updateParticles(dt)

    if gameState == "intro" then
        introTimer = introTimer + dt
        if introTimer > 30 then
            gameState = "menu"
        end
        return
    end

    if gameState ~= "playing" then return end

    updateTimers(dt)
    movePlayer(dt)
    score = score + dt
    updateLevel(dt)

    if score > 100 and bossSpawned == false then
        spawnBoss()
        bossSpawned = true
        playSound(bossSound)
    end

    spawnThings(dt)
    updateEnemies(dt)
    checkCollectibles()
end

function updateTimers(dt)
    if invincibleTimer > 0 then invincibleTimer = invincibleTimer - dt end
    if boostTimer > 0 then boostTimer = boostTimer - dt end
    if freezeTimer > 0 then freezeTimer = freezeTimer - dt end
    if magnetTimer > 0 then magnetTimer = magnetTimer - dt end
end

function updateLevel(dt)
    local newLevel = math.floor(score / 25) + 1

    if newLevel > level then
        level = newLevel
        levelMessageTimer = 2
        playSound(levelSound)
    end

    if levelMessageTimer > 0 then
        levelMessageTimer = levelMessageTimer - dt
    end
end

function spawnThings(dt)
    spawnTimer = spawnTimer + dt
    if spawnTimer > math.max(0.8, 2.25 - score / 95) then
        spawnEnemy()
        spawnTimer = 0
    end

    orangeTimer = orangeTimer + dt
    if orangeTimer > 1.6 then
        spawnOrange()
        orangeTimer = 0
    end

    goldenOrangeTimer = goldenOrangeTimer + dt
    if goldenOrangeTimer > 10 then
        spawnGoldenOrange()
        goldenOrangeTimer = 0
    end

    powerTimer = powerTimer + dt
    if powerTimer > 7 then
        spawnPowerup()
        powerTimer = 0
    end
end

function handleKeyPress(key)
    if key == "space" and gameState == "intro" then
        gameState = "menu"
    elseif key == "space" and gameState == "menu" then
        resetGame()
        gameState = "playing"
    elseif key == "r" and gameState == "gameover" then
        resetGame()
        gameState = "playing"
    elseif key == "m" and gameState == "gameover" then
        resetGame()
        gameState = "menu"
    elseif key == "escape" then
        love.event.quit()
    end
end
