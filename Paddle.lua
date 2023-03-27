Paddle = Class{}

function Paddle:constructor(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.width = width
    self.deltaY = 0
end

function Paddle:update(dt)
    if self.deltaY < 0 then
        self.y = math.max(0, self.y + self.deltaY * dt)
    else
        self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.deltaY * dt)
    end
end