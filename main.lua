--[[
    With the require() function we tell the game that these files exist, so we are able to
    call functions and access variables from outside of this file.
]]
require("Player")
require("Ball")
require("Opponent")

function love.load()
    Player:load()
    Ball:load()
    Opponent:load()
    print(Player.x)
end

function love.update(dt)
    Player:update(dt)
    Ball:update(dt)
    Opponent:update(dt)
end

function love.draw()
    Player:draw()
    Ball:draw()
    Opponent:draw()
end

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