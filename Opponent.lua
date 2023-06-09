--[[
    Opponent Class: responsible for the movement of the opponent paddle.
    Contains the 3 base functions of LÖVE 2D: load(), update(dt) and draw().
    These function also need to be called in main.lua. The opponent is very
    similar to the player, they both have to keep track of their own x and y
    positions. We have a width and height, aswell as a speed variable.
]]
Opponent = {}

--[[ 
    Initial position of the opponent paddle. Acts sort of as a "constructor".
]]
function Opponent:load()
    self.paddle = love.graphics.newImage("assets/paddle.png")
    self.width = self.paddle:getWidth()
    self.height = self.paddle:getHeight()
    self.x = love.graphics.getWidth() - self.width - 50
    self.y = love.graphics.getHeight() / 2 + 65
    self.yVelocity = 0
    self.speed = 500

    --[[ 
        The "timer" variable creates a delay before the computer can call the "aquireTarget()"
        function again, this ensures human-like delay. The "rate" is a random number between
        0.1 and 0.5 seconds.
    ]]
    self.timer = 0
    self.rate = 0.3
end

--[[
    Opponent is only able to call the aquireTarget() function every half a second, defined in
    the self.rate variable.
]]
function Opponent:update(dt)
    self:move(dt)
    --[[
        Counts upwards until it reaches the threshold to then call the "aquireTarget()"
        function
    ]]
    self.timer = self.timer + dt
    
    if self.timer > self.rate then
        self.timer = 0
        self:acquireTarget()
    end
end

--[[
    Responsible for the movement speed of the opponent paddle
]]
function Opponent:move(dt)
    self.y = self.y + self.yVelocity * dt
end

--[[

]]
function Opponent:acquireTarget()
    if Ball.y + Ball.height < self.y then
        self.yVelocity = -self.speed
    elseif Ball.y > self.y + self.height then
        self.yVelocity = self.speed
    else
        self.yVelocity = 0
    end
end

--[[
    This function is responsible for drawing the opponent paddle
]]
function Opponent:draw()
    love.graphics.draw(self.paddle, self.x, self.y)
end
