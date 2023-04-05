--[[ 
    Ball class: responsible for the ball behavior and movement.    
    We create a table Ball which contains all the variables and functions for the ball.
    We also create the 3 base function in LÖVE 2D, load(), update(dt) and draw(). We then
    call Ball:load(), Ball:update(dt) and Ball:draw() in main.lua
]]
Ball = {}

--[[
    The difference between the playe and the ball, is that player is controlled by input,
    while the ball will move in a direction depending on its last collision. In order for
    us to accomplish this we need to store the velocity of the ball. We do this by creating
    two variables, xVelocity and yVelocity.
]]
function Ball:load()
    self.x = love.graphics.getWidth() / 2 - 10  -- Initial x position for the ball
    self.y = love.graphics.getHeight() / 2 - 10 -- Initial y position for the ball
    self.width = 20                             -- Ball width in pixels
    self.height = 20                            -- Ball height in pixels
    self.speed = 500                            -- Initial speed of ball on game start
    self.xVelocity = -self.speed                -- Ball velocity on x achsis
    self.yVelocity = 0                          -- Ball velocity on y achsis
end

function Ball:update(dt)
    self:move(dt) -- Call move() function to move the ball
    self:collide() --  Call collide() function to have a collision detection in each update
end

--[[
    This function is responsible for changing the ball's x and y position on collision.
]]
function Ball:collide()
    -- isColliding function from Ball.lua (self is the ball, Player is the actual player)
    if isColliding(self, Player) then
        self.xVelocity = self.speed
        -- Calculate the center of the ball and the player
        local centerOfBall = self.y + self.height / 2
        local centerOfPlayer = Player.y + Player.height / 2
        local collisionPosition = centerOfBall - centerOfPlayer
        self.yVelocity = collisionPosition * 5
    end

    -- Collision detection for the ball
    if isColliding(self, Opponent) then
        self.xVelocity = -self.speed
        local centerOfBall = self.y + self.height / 2
        local centerOfOpponent = Opponent.y + Opponent.height / 2
        local collisionPosition = centerOfBall - centerOfOpponent
        self.yVelocity = collisionPosition * 5
    end

    -- Restrict playing field by creating invisible boundries on the top and bottom of the screen
    if self.y < 0 then
        self.y = 0
        self.yVelocity = -self.yVelocity
    elseif self.y + self.height > love.graphics.getHeight() then
        self.y = love.graphics.getHeight() - self.height
        self.yVelocity = -self.yVelocity
    end

    -- Reset ball position if it passed by the player (Opponent scored a point and gets the first ball)
    if self.x < 0 then
        self.x = love.graphics.getWidth() / 2 - self.width / 2
        self.y = love.graphics.getHeight() / 2 - self.height / 2
        self.yVelocity = 0
        self.xVelocity = self.speed
    end

    -- Reset ball position if it passed by the opponent (Player scored a point and gets the first ball)
    if self.x + self.width > love.graphics.getWidth() then
        self.x = love.graphics.getWidth() / 2 - self.width / 2
        self.y = love.graphics.getHeight() / 2 - self.height / 2
        self.yVelocity = 0
        self.xVelocity = -self.speed
    end
end

--[[
    This function is responsible for updating the ball's x and y position based on the velocity.
]]
function Ball:move(dt)
    self.x = self.x + self.xVelocity * dt
    self.y = self.y + self.yVelocity * dt
end

--[[ 
    This is one of the LÖVE 2D base function and responsible for drawing content to the window.
]]
function Ball:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end