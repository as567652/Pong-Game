Print = Class{}

function Print:init()
    A = 0
end

function Print:Start_State()
    love.graphics.setFont(Titlefont)
        love.graphics.printf("PONG!!!", 0, VIRTUAL_HEIGHT / 2 - 50, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(Smallfont)
        love.graphics.printf("[ Press Enter To Continue.. ]", 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("[ Press Esc To Exit.. ]", 0, VIRTUAL_HEIGHT / 2 + 10, VIRTUAL_WIDTH, 'center')
end

function Print:Play_State()
    love.graphics.printf("Ready - Set - Pong!!!", 0, 10, VIRTUAL_WIDTH, 'center')
    love.graphics.printf(" Press [Space] To Pause The Game ", 0, VIRTUAL_HEIGHT - 20, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(Scorefont)
    love.graphics.printf(P1_score, VIRTUAL_WIDTH / 2 - 8 - 60, 15, VIRTUAL_WIDTH)
    love.graphics.printf(P2_score, VIRTUAL_WIDTH / 2 + 50, 15, VIRTUAL_WIDTH)
    MyBall:render()
    Paddle_L:render()
    Paddle_R:render()
end

function Print:Pause_State()
    love.graphics.printf("Ready - Pause - Pong!!!", 0, 10, VIRTUAL_WIDTH, 'center')
    love.graphics.printf(" Press [Space] To Resume The Game ", 0, VIRTUAL_HEIGHT - 20, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(Scorefont)
    love.graphics.printf('[ Game Paused ]', 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
end

function Print:Pause_timerr(n)
    love.graphics.setFont(Scorefont)
    love.graphics.printf(n, 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
end