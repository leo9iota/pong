push = require "push"

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 640
VIRTUAL_HEIGHT = 360

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    pixelFontSmall = love.graphics.newFont("public-pixel-font.ttf", 8)
    love.graphics.setFont(pixelFontSmall)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

function love.update(dt)
    -- player 1 movement
    if love.keyboard.isDown("w") then
        print("key w")
    elseif love.keyboard.isDown("s") then
        print("key s")
    end

    -- player 2 movement
    if love.keyboard.isDown("up") then
        print("key up")
    elseif love.keyboard.isDown("down") then
        print("key down")
            
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "enter" or key == "return" then
        print("start game")
    end
end

function love.draw()
    push:apply("start")

    love.graphics.clear(0 / 255, 0 / 255, 0 / 255, 255 / 255)

    push:apply("end")
end