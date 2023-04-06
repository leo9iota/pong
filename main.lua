--[[
    With the require() function we tell the game that these files exist, so we are able to
    call functions and access variables from outside of "main.lua" file.
]]
require("Player")
require("Ball")
require("Opponent")

function love.load()
    --[[
        Load pixel fonts
    ]]
    smallPixelFont = love.graphics.newFont("public-pixel-font.ttf", 16)
    mediumPixelFont = love.graphics.newFont("public-pixel-font.ttf", 32)
    largePixelFont = love.graphics.newFont("public-pixel-font.ttf", 64)

    playerScore = 0     -- Initial score of the player
    opponentScore = 0   -- Initial score of the opponent (computer)

    gameState = "none"

    Player:load()
    Ball:load()
    Opponent:load()
end

function love.update(dt)
    Player:update(dt)
    Ball:update(dt)
    Opponent:update(dt)
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
    love.graphics.setFont(mediumPixelFont)

    --[[
        In this conditional statement we render text based on the game state.
    ]]
    if gameState == "none" then
        love.graphics.printf("Press \"Enter\" to Start the Game", 0, 50, love.graphics.getWidth(), "center")
    else
        love.graphics.printf("The Game Starts...", 0, 20, love.graphics.getWidth(), "center")
    end

    Player:draw()
    Ball:draw()
    Opponent:draw()
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
