push = require "push"

-- constants
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 640
VIRTUAL_HEIGHT = 360

PADDLE_SPEED = 200

function love.load()
    -- pixel aesthetic
    love.graphics.setDefaultFilter("nearest", "nearest")

    -- generate truly random number
    math.randomseed(os.time())

    -- define fonts
    pixelFontSmall = love.graphics.newFont("public-pixel-font.ttf", 8)
    pixelFontLarge = love.graphics.newFont("public-pixel-font.ttf", 32)
    love.graphics.setFont(pixelFontSmall)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    -- initial player score
    player1Score = 0
    player2Score = 0

    -- initial player position
    player1Y = 20
    player2Y = VIRTUAL_HEIGHT - 70

    -- initial ball position
    ballX = VIRTUAL_WIDTH / 2 - 4
    ballY = VIRTUAL_HEIGHT / 2 - 4

    ballDeltaX = math.random(2) == 1 and 100 or -100
    ballDeltaY = math.random(-50, 50)

    gameState = "start"
end

function love.update(dt)
    -- player 1 movement
    if love.keyboard.isDown("w") then
        player1Y = math.max(0, player1Y + (-PADDLE_SPEED) * dt)
        print("player1Y up: " .. math.floor(player1Y))
    elseif love.keyboard.isDown("s") then
        player1Y = math.min(VIRTUAL_HEIGHT - 50, player1Y + PADDLE_SPEED * dt)
        print("player1Y down: " .. math.floor(player1Y))
    end

    -- player 2 movement
    if love.keyboard.isDown("up") then
        player2Y = math.max(0, player2Y + (-PADDLE_SPEED) * dt)
        print("player2Y up: " .. math.floor(player2Y))
    elseif love.keyboard.isDown("down") then
        player2Y = math.min(VIRTUAL_HEIGHT - 50, player2Y + PADDLE_SPEED * dt)
        print("player2Y down: " .. math.floor(player2Y))
    end

    -- ball movement
    if gameState == "play" then
        ballX = ballX + ballDeltaX * dt
        ballY = ballY + ballDeltaY * dt
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "enter" or key == "return" then
        if gameState == "start" then
            gameState = "play"
        else
            gameState = "start"

            -- starting position of ball
            ballX = VIRTUAL_WIDTH / 2 - 4
            ballY = VIRTUAL_HEIGHT / 2 - 4

            -- randomize starting velocity of ball
            ballDeltaX = (math.random(2) == 1 and 100) or -100
            ballDeltaY = math.random(-50, 50) * 1.5
        end
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
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 160, VIRTUAL_HEIGHT / 5)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 132, VIRTUAL_HEIGHT / 5)

    -- player 1 paddle (left)
    love.graphics.rectangle("fill", 10, player1Y, 10, 50)

    -- player 2 paddle (right)
    love.graphics.rectangle("fill", VIRTUAL_WIDTH - 20, player2Y, 10, 50)

    -- ball
    love.graphics.rectangle("fill", ballX, ballY, 8, 8)

    push:apply("end")
end