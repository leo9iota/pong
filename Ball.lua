--[[ 
    Ball class: responsible for the ball behavior and movement.    
    We create a table Ball which contains all the variables and functions for the ball.
    We also create the 3 base function in LÖVE 2D, load(), update(dt) and draw(). We then
    call Ball:load(), Ball:update(dt) and Ball:draw() in main.lua
]]
Ball = {}

--[[
    The difference between the player and the ball, is that player is controlled by input,
    while the ball will move in a direction depending on its last collision. In order for
    us to accomplish this we need to store the velocity of the ball. We do this by creating
    two variables, xVelocity and yVelocity.
]]
function Ball:load()
    self.tennisBall = love.graphics.newImage("assets/tennis-ball.png")
    self.width = self.tennisBall:getWidth()
    self.height = self.tennisBall:getHeight()
    self.x = love.graphics.getWidth() / 2 - 10
    self.y = love.graphics.getHeight() / 2 - 10
    self.speed = 500
    self.xVelocity = -self.speed
    self.yVelocity = 0
end

function Ball:update(dt)
    self:move(dt)   -- Call move() function to move the ball
    self:collide()  -- Call collide() function to have a collision detection in each update
end

function Ball:collide()
    self:collideBoundries()
    self:collidePlayer()
    self:collideOpponent()
    self:score()
end

function Ball:collideBoundries()
    --[[
        Restrict playing field by creating invisible boundries on the top and bottom of
        the screen.
    ]]
    if self.y < 0 then
        self.y = 0
        self.yVelocity = -self.yVelocity
    elseif self.y + self.height > love.graphics.getHeight() then
        self.y = love.graphics.getHeight() - self.height
        self.yVelocity = -self.yVelocity
    end
end

function Ball:collidePlayer()
    --[[
        The "isColliding()" function comes from the "main.lua" file and is responsible for
        checking if the ball collides with the paddles. The collision method that is being
        used is AABB, which stands for axis-aligned bouding boxes. The arguments that are
        being passed, are "self", which is the ball and "Player", which is the actual player.

        We also calculate the center of the ball aswell as the center of the player to
        determine the trajectory of the ball after the collision
    ]]
    if isColliding(self, Player) then
        self.xVelocity = self.speed
        local centerOfBall = self.y + self.height / 2
        local centerOfPlayer = Player.y + Player.height / 2
        local collisionPosition = centerOfBall - centerOfPlayer
        self.yVelocity = collisionPosition * 5
    end
end

function Ball:collideOpponent()
    --[[
        This is the collision detection for the opponent (computer).
    ]]
    if isColliding(self, Opponent) then
        self.xVelocity = -self.speed
        local centerOfBall = self.y + self.height / 2
        local centerOfOpponent = Opponent.y + Opponent.height / 2
        local collisionPosition = centerOfBall - centerOfOpponent
        self.yVelocity = collisionPosition * 5
    end
end

function Ball:score()
    --[[
        Reset ball position if it passed by the player.
        (Opponent scored a point and gets the first ball)
    ]]
    if self.x < 0 then
        self:resetBallPosition(1)
        Score.opponentScore = Score.opponentScore + 1
    end

    --[[
        Reset ball position if it passed by the opponent.
        (Player scored a point and gets the first ball)
    ]]
    if self.x + self.width > love.graphics.getWidth() then
        self:resetBallPosition(-1)
        Score.playerScore = Score.playerScore + 1
    end
end

--[[
    This function is responsible for resetting the balls position back to its starting
    position. The "trajectory" parameter determines in which direction the ball will move
    based on a value which can be either positive or negative. If the value is positive,
    the ball will move towards the opponent (computer), if it's negative, it will move
    towards the player.
]]
function Ball:resetBallPosition(trajectory)
    self.x = love.graphics.getWidth() / 2 - self.width / 2
    self.y = love.graphics.getHeight() / 2 - self.height / 2
    self.yVelocity = 0
    self.xVelocity = self.speed * trajectory
end

--[[
    This function is responsible for updating the ball's x and y position based on the
    velocity.
]]
function Ball:move(dt)
    self.x = self.x + self.xVelocity * dt
    self.y = self.y + self.yVelocity * dt
end

--[[ 
    This is one of the LÖVE 2D base function and responsible for drawing content to the
    window.
]]
function Ball:draw()
    love.graphics.draw(self.tennisBall, self.x, self.y)
end