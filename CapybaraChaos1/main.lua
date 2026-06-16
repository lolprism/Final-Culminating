---@diagnostic disable: undefined-global

require("game")
require("audio")
require("utils")
require("player")
require("enemies")
require("collectibles")
require("draw")

function love.load()
    setupGame()
end

function love.update(dt)
    updateGame(dt)
end

function love.draw()
    drawGameScreen()
end

function love.keypressed(key)
    handleKeyPress(key)
end
