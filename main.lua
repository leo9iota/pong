-- imports
push = require "push"
Class = require "class"
require "Paddle"
require "Ball"

-- constants
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 640
VIRTUAL_HEIGHT = 360

PADDLE_SPEED = 200

--[[
Runs when the game first starts up, only once; used to initialize the game.
--]]
function love.load()
    -- pixel aesthetic
    love.graphics.setDefaultFilter("nearest", "nearest")

    -- "seed" the RNG so that calls to random are always random
    -- use the current time, since that will vary on startup every time
    math.randomseed(os.time())

    -- more "retro-looking" font object we can use for any text
    pixelFontSmall = love.graphics.newFont("public-pixel-font.ttf", 8)
    pixelFontLarge = love.graphics.newFont("public-pixel-font.ttf", 32)

    -- set LÖVE2D's active font to the smallFont object
    love.graphics.setFont(pixelFontSmall)

    -- initialize window with virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    -- initial player score
    player1Score = 0
    player2Score = 0

    -- initialize our player paddles; make them global so that they can be
    -- detected by other functions and modules
    player1 = Paddle(10, 20, 10, 50)
    player2 = Paddle(VIRTUAL_WIDTH - 20, VIRTUAL_HEIGHT - 70, 10, 50)

    -- place a ball in the middle of the screen
    ball = Ball(VIRTUAL_WIDTH / 2 - 4, VIRTUAL_HEIGHT / 2 - 4, 8, 8)

    -- game state variable used to transition between different parts of the game
    -- (used for beginning, menus, main game, high score list, etc.)
    -- we will use this to determine behavior during render and update
    gameState = "start"
end

--[[
Runs every frame, with "dt" (delta time) passed in, our delta in seconds 
since the last frame, which LÖVE2D supplies us.
--]]
function love.update(dt)
    -- player 1 movement
    if love.keyboard.isDown("w") then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown("s") then
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    -- player 2 movement
    if love.keyboard.isDown("up") then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown("down") then
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end

    -- update our ball based on its deltaX and deltaY only if we're in play state;
    -- scale the velocity by dt so movement is framerate-independent
    if gameState == "play" then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)
end

--[[
Keyboard handling, called by LÖVE2D each frame; 
passes in the key we pressed so we can access.
--]]
function love.keypressed(key)
    -- keys can be accessed by string name
    if key == "escape" then
        -- function LÖVE2D gives us to terminate application
        love.event.quit()
    -- if we press enter during the start state of the game, we'll go into play mode
    -- during play mode, the ball will move in a random direction
    elseif key == "enter" or key == "return" then
        if gameState == "start" then
            gameState = "play"
        else
            gameState = "start"

            -- ball's new reset method
            ball:reset()
        end
    end
end

--[[
Called after update by LÖVE2D, used to draw anything to the screen, 
updated or otherwise.
--]]
function love.draw()
    -- begin rendering at virtual resolution
    push:apply("start")

    -- clear the screen with a specific color; in this case, a color similar
    -- to some versions of the original Pong
    love.graphics.clear(0 / 255, 0 / 255, 0 / 255, 255 / 255)

    -- draw different things based on the state of the game
    love.graphics.setFont(pixelFontSmall)

    if gameState == "start" then
        love.graphics.printf("Press \"Enter\" to Start the Game", 0, 20, VIRTUAL_WIDTH, "center")
    else
        love.graphics.printf("The Game Starts...", 0, 20, VIRTUAL_WIDTH, "center")
    end

    -- render player score
    love.graphics.setFont(pixelFontLarge)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 160, VIRTUAL_HEIGHT / 5)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 132, VIRTUAL_HEIGHT / 5)

    -- render paddles, now using their class' render method
    player1:render()
    player2:render()

    -- render ball using its class' render method
    ball:render()

    -- end rendering at virtual resolution
    push:apply("end")
end
