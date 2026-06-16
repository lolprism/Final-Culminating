---@diagnostic disable: undefined-global

function loadAudio()
    music = loadSound("assets/music.wav", "stream")
    collectSound = loadSound("assets/collect.wav", "static")
    goldenSound = loadSound("assets/golden.wav", "static")
    powerSound = loadSound("assets/power.wav", "static")
    freezeSound = loadSound("assets/freeze.wav", "static")
    levelSound = loadSound("assets/level.wav", "static")
    bossSound = loadSound("assets/boss.wav", "static")
    gameOverSound = loadSound("assets/gameover.wav", "static")
    clearSound = loadSound("assets/clear.wav", "static")

    if music then
        music:setLooping(true)
        music:setVolume(0.32)
        music:play()
    end
end

function loadSound(path, soundType)
    if love.filesystem.getInfo(path) then
        return love.audio.newSource(path, soundType)
    end
    return nil
end

function playSound(sound)
    if sound then
        sound:stop()
        sound:play()
    end
end
