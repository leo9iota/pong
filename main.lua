push = require "push"

-- constants
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 640
VIRTUAL_HEIGHT = 360

PADDLE_SPEED = 200

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    -- define fonts
    pixelFontSmall = love.graphics.newFont("public-pixel-font.ttf", 8)
    pixelFontLarge = love.graphics.newFont("public-pixel-font.ttf", 32)
    love.graphics.setFont(pixelFontSmall)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    playerOneScore = 0
    playerTwoScore = 0

    playerOneY = 20
    playerTwoY = VIRTUAL_HEIGHT - 70

    gameState = "start"
end

function love.update(dt)
    -- player 1 movement
    if love.keyboard.isDown("w") then
        playerOneY = playerOneY + (-PADDLE_SPEED) * dt
    elseif love.keyboard.isDown("s") then
        playerOneY = playerOneY + PADDLE_SPEED * dt
    end

    -- player 2 movement
    if love.keyboard.isDown("up") then
        playerTwoY = playerTwoY + (-PADDLE_SPEED) * dt
    elseif love.keyboard.isDown("down") then
        playerTwoY = playerTwoY + PADDLE_SPEED * dt
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function love.draw()
    push:apply("start")

    -- background
    love.graphics.clear(0 / 255, 0 / 255, 0 / 255, 255 / 255)
    love.graphics.setFont(pixelFontSmall)

    -- greeting text
    if gameState == "start" then
        love.graphics.printf("Press \"Enter\" to Start the Game", 0, 20, VIRTUAL_WIDTH, "center")
    else
        love.graphics.printf("The Game Starts...", 0, 20, VIRTUAL_WIDTH, "center")
    end

    -- player score
    love.graphics.setFont(pixelFontLarge)
    love.graphics.print(tostring(playerOneScore), VIRTUAL_WIDTH / 2 - 160, VIRTUAL_HEIGHT / 5)
    love.graphics.print(tostring(playerTwoScore), VIRTUAL_WIDTH / 2 + 132, VIRTUAL_HEIGHT / 5)

    -- player 1 paddle (left)
    love.graphics.rectangle("fill", 10, playerOneY, 10, 50)

    -- player 2 paddle (right)
    love.graphics.rectangle("fill", VIRTUAL_WIDTH - 20, playerTwoY, 10, 50)

    -- ball
    love.graphics.rectangle("fill", VIRTUAL_WIDTH / 2 - 4, VIRTUAL_HEIGHT / 2 - 4, 8, 8)

    push:apply("end")
end