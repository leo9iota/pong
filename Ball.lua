Ball = {}

function Ball:load()
    self.x = love.graphics.getWidth() / 2 - 10
    self.y = love.graphics.getHeight() / 2 - 10
    self.width = 20
    self.height = 20
    self.speed = 500
    self.xVelocity = -self.speed
    self.yVelocity = 0
end

function Ball:update(dt)
    self:move(dt)
    self:collide()
end

function Ball:collide()
    if isColliding(self, Player) then
        self.xVelocity = self.speed
        local centerOfBall = self.y + self.height / 2
        local centerOfPlayer = Player.y + Player.height / 2
        local collisionPosition = centerOfBall - centerOfPlayer
        self.yVelocity = collisionPosition * 5
    end

    if isColliding(self, Opponent) then
        self.xVelocity = -self.speed
        local centerOfBall = self.y + self.height / 2
        local centerOfOpponent = Opponent.y + Opponent.height / 2
        local collisionPosition = centerOfBall - centerOfOpponent
        self.yVelocity = collisionPosition * 5
    end

    if self.y < 0 then
        self.y = 0
        self.yVelocity = -self.yVelocity
    elseif self.y + self.height > love.graphics.getHeight() then
        self.y = love.graphics.getHeight() - self.height
        self.yVelocity = -self.yVelocity
    end

    if self.x < 0 then
        self.x = love.graphics.getWidth() / 2 - self.width / 2
        self.y = love.graphics.getHeight() / 2 - self.height / 2
        self.yVelocity = 0
        self.xVelocity = self.speed
    end

    if self.x + self.width > love.graphics.getWidth() then
        self.x = love.graphics.getWidth() / 2 - self.width / 2
        self.y = love.graphics.getHeight() / 2 - self.height / 2
        self.yVelocity = 0
        self.xVelocity = -self.speed
    end
end

function Ball:move(dt)
    self.x = self.x + self.xVelocity * dt
    self.y = self.y + self.yVelocity * dt
end

function Ball:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end