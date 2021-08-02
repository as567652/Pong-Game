Menu = Class{}

function Menu:init()
    self.L = 40
    self.Gap = 72
    self.Options = {}
    self.current_counter = 1
    self.n = 0
end

function Menu:render()
    love.graphics.setFont(Titlefont)
    love.graphics.printf(" [ PONG GAME ] ", 0, self.L - 16, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(MidFont)
    X = 0
    --love.graphics.printf(self.current_counter, 0, 10, VIRTUAL_WIDTH, 'center')
    for y = 1, self.n do
        if self.current_counter == y then
            if self.Options[y] == '[ Back To Menu ]' then
                love.graphics.setFont(Smallfont)
                love.graphics.printf('-'..self.Options[y]..'-', 0, VIRTUAL_HEIGHT - 30, VIRTUAL_WIDTH, 'center')
                love.graphics.setFont(MidFont)
            else
                love.graphics.printf('-'..self.Options[y]..'-', 0, self.L + self.Gap + X, VIRTUAL_WIDTH, 'center')
            end
        else
            if self.Options[y] == '[ Back To Menu ]' then
                love.graphics.setFont(Smallfont)
                love.graphics.printf(self.Options[y], 0, VIRTUAL_HEIGHT - 30, VIRTUAL_WIDTH, 'center')
                love.graphics.setFont(MidFont)
            else
                love.graphics.printf(self.Options[y], 0, self.L + self.Gap + X, VIRTUAL_WIDTH, 'center')
            end       
        end
        X = X + 20
    end
end

function Menu:update(dt)
    if self.current_counter == 0 then
        self.current_counter = self.n
    elseif self.current_counter == self.n + 1 then
        self.current_counter = 1
    end
end

function Menu:Option_Selected()
    return self.Options[self.current_counter]
end

function  Menu:State_Reset()
    self.current_counter = 1
end

function Menu:KeyPressFunc(key)
    if key == 'up' then
        self.current_counter = self.current_counter - 1
    elseif key == 'down' then
        self.current_counter = self.current_counter + 1
    end
end

function Menu:msg_print(msg)
    love.graphics.setFont(Smallfont)
    love.graphics.printf(msg, 0, self.L + self.Gap / 2 + 10 , VIRTUAL_WIDTH, 'center')
end

function Menu:msg_print_winner(msg)
    love.graphics.setFont(MidFont)
    love.graphics.printf(msg, 0, VIRTUAL_HEIGHT / 2 , VIRTUAL_WIDTH, 'center')
end