Ball = Class{}

function Ball:init()
    self.x = VIRTUAL_WIDTH / 2
    self.y = VIRTUAL_HEIGHT / 2 - 2.5
    self.width = 5
    self.height = 5 
    
    math.randomseed(os.time())

    self.speed = 185

    self.dx = math.random(2) == 1 and -self.speed or self.speed
    self.dy = math.random(-self.speed, self.speed)
end

function Ball:update(dt)
    if Gamestate ~= 'PAUSE_TO_PLAY' then
        self.x = self.x + self.dx * dt
        self.y = self.y + self.dy * dt    
    end
end

function  Ball:collides(Box)
    if self.x > Box.x + Box.width or self.x + self.width < Box.x then
        return false
    end
    if self.y > Box.y + Box.height or self.y + self.height < Box.y then
        return false
    end
    return true
end

function Ball:LRBoundary_Collide()
    if self.x + self.width >= VIRTUAL_WIDTH then
        return 1
    elseif self.x <= 0 then
        return 2
    end
end

function Ball:UDBoundary_Collide()
    if self.y <= 0 or self.y + self.height >= VIRTUAL_HEIGHT then
        return true
    else
        return false
    end
end

function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2
    self.y = VIRTUAL_HEIGHT / 2 - 2.5
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)  
end