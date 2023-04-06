require("Player")
require("Ball")
require("Opponent")

function love.load()
    smallPixelFont = love.graphics.newFont("public-pixel-font.ttf", 16)
    mediumPixelFont = love.graphics.newFont("public-pixel-font.ttf", 32)
    largePixelFont = love.graphics.newFont("public-pixel-font.ttf", 64)

    playerScore = 0
    opponentScore = 0

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

    if gameState == "none" then
        love.graphics.printf("Press \"Enter\" to Start the Game", 0, 50, love.graphics.getWidth(), "center")
    else
        love.graphics.printf("The Game Starts...", 0, 20, love.graphics.getWidth(), "center")
        Player:draw()
        Ball:draw()
        Opponent:draw()
    end
end

function isColliding(a, b)
	if (a.x + a.width > b.x)
    and (a.x < b.x + b.width)
    and (a.y + a.height > b.y)
    and (a.y < b.y + b.height) then
		return true
	else
		return false
	end
end