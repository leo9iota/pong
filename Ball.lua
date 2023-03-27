Ball = Class{}

function Ball:constructor(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.deltaY = (math.random(2) == 1 and -100) or 100
    self.deltaX = math.random(-50, 50)
end

function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 4
    self.y = VIRTUAL_HEIGHT / 2 - 4

    self.deltaY = (math.random(2) == 1 and -100) or 100
    self.deltaX = math.random(-50, 50)
end

function Ball:update()
    self.x = self.x + self.deltaX * dt
    self.y = self.y + self.deltaY * dt
end

function Ball:render()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end