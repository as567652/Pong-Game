Paddle = Class{}

function Paddle:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.dy = 0
end

function Paddle:update(dt) 
    if self.dy < 0 then
        self.y = math.max(self.y + self.dy * dt, 0)
    elseif self.dy > 0 then
        self.y = math.min(self.y + self.dy * dt, VIRTUAL_HEIGHT - 20)
    end
end

function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Paddle:AI(dt, pos)
    if pos < self.y then
        self.y = math.max(self.y - AI_Paddle_Speed * dt, 0)
    elseif pos + 5 > self.y + self.height then
        self.y = math.min(self.y + AI_Paddle_Speed * dt, VIRTUAL_HEIGHT - 20)
    end
end