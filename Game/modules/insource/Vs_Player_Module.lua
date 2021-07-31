local Vs_Player_Module = {}

function Vs_Player_Module.load()
    P1_score = 0
    P2_score = 0    

    Paddle_L = Paddle(5, 30, 5, 20)
    Paddle_R = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 40, 5, 20)

    MyBall = Ball()

    Pause_timer = 80
end

function Vs_Player_Module.update(dt)
    if Gamestate == 'PLAY' then

        Paddle_L:update(dt)
        Paddle_R:update(dt)

        MyBall:update(dt)

        if love.keyboard.isDown('w') then
            Paddle_L.dy = -Paddle_Speed
        elseif love.keyboard.isDown('s') then
            Paddle_L.dy = Paddle_Speed
        else
            Paddle_L.dy = 0
        end
        
        if love.keyboard.isDown('up') then
            Paddle_R.dy = -Paddle_Speed
        elseif love.keyboard.isDown('down') then
            Paddle_R.dy = Paddle_Speed
        else
            Paddle_R.dy = 0
        end

        if MyBall:collides(Paddle_L) and MyBall.x < 35 then
            MyBall.dx = -MyBall.dx  
            Sounds['wall_hit']:play()
        end
        if MyBall:collides(Paddle_R) and MyBall.x + MyBall.width > VIRTUAL_WIDTH - 35 then
            MyBall.dx = -MyBall.dx
            Sounds['wall_hit']:play()
        end

        if MyBall:UDBoundary_Collide() and (MyBall.y < 10 or MyBall.y + MyBall.height > VIRTUAL_HEIGHT - 10) then
            MyBall.dy = - MyBall.dy
            Sounds['wall_hit']:play()
        end

        if MyBall:LRBoundary_Collide() == 1 then
            P1_score = P1_score + 1
            Sounds['point_score']:play()
            MyBall:reset()
        elseif MyBall:LRBoundary_Collide() == 2 then
            P2_score = P2_score + 1
            Sounds['point_score']:play()
            MyBall:reset()
        end
    elseif Gamestate == 'PAUSE_TO_PLAY' then
        Pause_timerr(Pause_timer)
        Pause_timer = Pause_timer - 1
        if Pause_timer == 0 then
            Gamestate = 'PLAY'
            Pause_timer = 80
        end
    end
end

function Pause_timerr(n)
    love.graphics.setFont(Scorefont)
    love.graphics.printf(n, 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
end

function Score_Reset()
    P1_score = 0
    P2_score = 0  
end

function Vs_Player_Module.keypressed(key)
    if Gamestate == 'START' then
        if key == 'return' then
            Gamestate = 'MAIN_MENU'
        end
    elseif Gamestate == 'PLAY' then
        if key == 'space' then
            Gamestate = 'PAUSE'
        end
    end
end

function Vs_Player_Module.draw()
    if Gamestate == 'START' then
        love.graphics.setFont(Titlefont)
        love.graphics.printf(". . P O N G . .", 0, VIRTUAL_HEIGHT / 2 - 50, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(Smallfont)
        love.graphics.printf("[ Press Enter To Continue.. ]", 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.setFont(Smallfont)
        if Gamestate == 'PLAY' then
            love.graphics.printf("Ready - Set - Pong!!!", 0, 10, VIRTUAL_WIDTH, 'center')
            love.graphics.setFont(Titlefont)
            love.graphics.printf(P1_score, VIRTUAL_WIDTH / 2 - 108, 15, VIRTUAL_WIDTH)
            love.graphics.printf(P2_score, VIRTUAL_WIDTH / 2 + 80, 15, VIRTUAL_WIDTH)
            love.graphics.setFont(Smallfont)
            love.graphics.printf("Press [ SPACE ] To Pause The PONG", 0, VIRTUAL_HEIGHT - 30, VIRTUAL_WIDTH, 'center')
            MyBall:render()
            Paddle_L:render()
            Paddle_R:render()
        elseif Gamestate == 'PAUSE_TO_PLAY' then
            love.graphics.printf("Ready - Set - Pong!!!", 0, 10, VIRTUAL_WIDTH, 'center')
            love.graphics.setFont(Titlefont)
            love.graphics.printf(P1_score, VIRTUAL_WIDTH / 2 - 108, 15, VIRTUAL_WIDTH)
            love.graphics.printf(P2_score, VIRTUAL_WIDTH / 2 + 80, 15, VIRTUAL_WIDTH)
            MyBall:render()
            Paddle_L:render()
            Paddle_R:render()  
        end
    end
end

return Vs_Player_Module