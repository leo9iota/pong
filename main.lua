--[[
    With the require() function we tell the game that these files exist, so we are able to
    call functions and access variables from outside of "main.lua" file.
]]
require("Player")
require("Ball")
require("Opponent")

function love.load()
    --[[
        Ensure randomness
    ]]
    math.randomseed(os.time())

    --[[
        Add filter to get a retro feel
    ]]
    love.graphics.setDefaultFilter("nearest", "nearest")
    
    --[[
        Load background
    ]]
    tennisCourt = love.graphics.newImage("assets/tennis-court.png")

    --[[
        Load pixel fonts
    ]]
    smallPixelFont = love.graphics.newFont("public-pixel-font.ttf", 16)
    mediumPixelFont = love.graphics.newFont("public-pixel-font.ttf", 32)
    largePixelFont = love.graphics.newFont("public-pixel-font.ttf", 64)

    --[[
        Load game sounds, the game sound can be either "static", which means they are
        preloaded into memory, or they can be "stream", which means they're streamed
        on demand, which has the advantage of not bloating the memory with large
        audio files.
    ]]
    SoundEffects = {
        paddleHitSound = love.audio.newSource("sounds/paddle-hit.wav", "static"),
        scoreSound = love.audio.newSource("sounds/score.wav", "static"),
        wallHitSound = love.audio.newSource("sounds/wall-hit.wav", "static")
    }

    --[[
        Track player and opponent score
    ]]
    Score = {
        playerScore = 0,   -- Initial score of the player
        opponentScore = 0  -- Initial score of the opponent (computer)
    }

    gameState = "none"

    Player:load()
    Ball:load()
    Opponent:load()
end

function love.update(dt)
    if gameState == "play" then
        Player:update(dt)
        Ball:update(dt)
        Opponent:update(dt)
    end
end

--[[
    This function is responsible for starting and quiting the game based on keyboard inputs
    made by the user.
]]
function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "enter" or key == "return" then
        if gameState == "none" then
            gameState = "play"
        else
            gameState = "none"
        end
    end
end

function love.draw()
    --[[
        Draw background
    ]]
    love.graphics.draw(tennisCourt, 0, 0)

    --[[
        Load medium font
    ]]
    love.graphics.setFont(mediumPixelFont)

    --[[
        Print player and opponent score
    ]]
    love.graphics.print("Player: " .. Score.playerScore, 40, 655)
    love.graphics.print("Computer: " .. Score.opponentScore, 850, 655)

    --[[
        In this conditional statement we render text based on the game state.
    ]]
    if gameState == "none" then
        love.graphics.printf("Press \"Enter\" to Start the Game", 0, 30, love.graphics.getWidth(), "center")
    else
        love.graphics.printf("The Game Starts...", 0, 30, love.graphics.getWidth(), "center")
    end

    drawScore()
    Player:draw()
    Ball:draw()
    Opponent:draw()
end

--[[
    This function is responsible for displaying the score of the player and opponent.
]]
function drawScore()
    love.graphics.setFont(mediumPixelFont)
    love.graphics.print("Player: " .. Score.playerScore, 40, 655)
    love.graphics.print("Computer: " .. Score.opponentScore, 850, 655)
end

--[[
    This function is responsible for the AABB collision detection. It returns true if the ball
    collides with a paddle. The "a" parameter is used for the ball and the "b" parameter is
    used for the paddle
]]
function isColliding(a, b)
	if  (a.x + a.width > b.x)
    and (a.x < b.x + b.width)
    and (a.y + a.height > b.y)
    and (a.y < b.y + b.height) then
		return true
	else
		return false
	end
end
