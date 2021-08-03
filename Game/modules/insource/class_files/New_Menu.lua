New_Menu = Class{}

function New_Menu:init()
    self.UD = 0
    self.first = {}
    self.second = {}
    self.current_counter_UD = 1
    self.current_counter_RL = 0

    self.tmp = 0

    self.L = 40
    self.Gap = 72
end

function New_Menu:render()
    love.graphics.setFont(Titlefont)
    love.graphics.printf(" [ PONG GAME ] ", 0, self.L - 16, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(MidFont)
    X = 0
    LL = 180
    for i = 1, self.UD do
        Curr_Str = self.first[i][1]
        love.graphics.printf(Curr_Str, 0, self.L + self.Gap + X, VIRTUAL_WIDTH -LL, 'center')
        love.graphics.printf(self.second[Curr_Str][self.first[i][3]], 0, self.L + self.Gap + X, VIRTUAL_WIDTH + LL, 'center')
        if self.current_counter_UD == i then
            love.graphics.printf('<', 0, self.L + self.Gap + X, VIRTUAL_WIDTH + LL - 120, 'center')
            love.graphics.printf('>', 0, self.L + self.Gap + X, VIRTUAL_WIDTH + LL + 120, 'center')
            self.tmp = i
        end
        X = X + 20 
    end
    love.graphics.setFont(Smallfont)
    love.graphics.printf("Press [ ENTER ] To Continue", 0, VIRTUAL_HEIGHT - 30, VIRTUAL_WIDTH, 'center')
end

function New_Menu:update(dt)
    if self.current_counter_UD <= 0 then
        self.current_counter_UD = self.UD
    elseif self.current_counter_UD >= self.UD + 1 then
        self.current_counter_UD = 1
    end
end

function  New_Menu:State_Reset()
    self.current_counter_UD = 1
end

function New_Menu:get_value(str)
    for i = 1, self.UD do
        if self.first[i][1] == str then
            return self.second[str][self.first[i][3]]
        end
    end
end

function New_Menu:KeyPressFunc(key)
    if key == 'up' then
        self.current_counter_UD = self.current_counter_UD - 1
    elseif key == 'down' then
        self.current_counter_UD = self.current_counter_UD + 1
    elseif key == 'right' then
        if self.first[self.tmp][3] > self.first[self.tmp][2] - 1 then
            self.first[self.tmp][3] = 1
        else
            self.first[self.tmp][3] = self.first[self.tmp][3] + 1
        end
    elseif key == 'left' then
        if self.first[self.tmp][3] == 1 then
            self.first[self.tmp][3] = self.first[self.tmp][2]
        else
            self.first[self.tmp][3] = self.first[self.tmp][3] - 1
        end
    end
end

function New_Menu:msg_print(msg)
    love.graphics.setFont(Smallfont)
    love.graphics.printf(msg, 0, self.L + self.Gap / 2 + 10 , VIRTUAL_WIDTH, 'center')
end