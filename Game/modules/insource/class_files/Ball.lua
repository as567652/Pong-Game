Ball = Class{}

function Ball:init()
    self.x = VIRTUAL_WIDTH / 2
    self.y = VIRTUAL_HEIGHT / 2 - 2.5
    self.width = 5
    self.height = 5 
    
    math.randomseed(os.time())

    self.speed = 185

    self.dx = math.random(2) == 1 and -self.speed or self.speed
    self.dy = math.random(-150, -180)
end

function Ball:update(dt)
    if Gamestate ~= 'PAUSE_TO_PLAY' then
        self.x = self.x + self.dx * dt
        self.y = self.y + self.dy * dt
    end
end

function  Ball:Lcollides(Box)
    --0 for success collision
    --1 for failed collision
    if self.x < Box.x + Box.width then
        if self.y > Box.y - 8 and self.y < Box.y + Box.height + 8 then
            return 0
        else
            return 1
        end
    else
        return -1
    end
end

function  Ball:Rcollides(Box)
    --0 for success collision
    --1 for failed collision
    if self.x + self.width > Box.x then
        if self.y > Box.y - 8 and self.y < Box.y + Box.height + 8 then
            return 0
        else
            return 1
        end
    else
        return -1
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