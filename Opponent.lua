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
    self.width = 20     -- Paddle width
    self.height = 100   -- Paddle height
    self.x = love.graphics.getWidth() - self.width - 50
    self.y = love.graphics.getHeight() / 2
    self.yVelocity = 0
    self.speed = 500

    self.timer = 0      -- Opponent decision delay
    self.rate = 0.275   -- Rate on which the opponent can call the aquireTarget() function
end

--[[
    Opponent is only able to call the aquireTarget() function every half a second, defined in
    the self.rate variable.
]]
function Opponent:update(dt)
    self:move(dt)
    self.timer = self.timer + dt -- Counts upwards until it reaches the half second threshold to then call the aquireTarget() function
    
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
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
