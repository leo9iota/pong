--[[
    Player class: responsible for the movement of the player paddle.
]]
Player = {}

function Player:load()
    self.paddle = love.graphics.newImage("assets/paddle.png")
    self.width = self.paddle:getWidth()
    self.height = self.paddle:getHeight()
    self.x = 50
    self.y = love.graphics.getHeight() / 2
    self.speed = 500
end

function Player:update(dt)
    self:move(dt)
    self:checkBoundries()
end

--[[
    This function is responsible for getting the keyboard input from the user and controlling
    the player paddle on the right side.
]]
function Player:move(dt)
    if love.keyboard.isDown("w") then
        self.y = self.y - self.speed * dt
    elseif love.keyboard.isDown("s") then
        self.y = self.y + self.speed * dt
    end
end

--[[
    This function is responsible for limiting the space where the ball can go. To upper and
    lower side of the screen acts as invisible boundries.
]]
function Player:checkBoundries()
    if self.y < 0 then
        self.y = 0
    elseif self.y + self.height > love.graphics.getHeight() then
        self.y = love.graphics.getHeight() - self.height
    end
end

--[[
    This function is responsible for drawing the player paddle.
]]
function Player:draw()
    love.graphics.draw(self.paddle, self.x, self.y)
end