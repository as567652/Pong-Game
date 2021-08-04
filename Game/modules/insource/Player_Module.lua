local Player_Module = {}

function Player_Module.load()
    P1_score = 0
    P2_score = 0

    Paddle_L = Paddle(5, 30, 5, 20)
    Paddle_R = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 40, 5, 20)

    MyBall = Ball()

    Count_Down = (Count_Down_ULTRA + 1) * 60
end

function Player_Module.update(dt)
    if Gamestate == 'PLAY' or Gamestate == 'COMPUTER_MODE' then
        Paddle_L:update(dt)
        Paddle_R:update(dt)

        MyBall:update(dt)

        if Gamestate == 'PLAY' then
            if love.keyboard.isDown('w') then
                Paddle_L.dy = -Paddle_Speed
            elseif love.keyboard.isDown('s') then
                Paddle_L.dy = Paddle_Speed
            else 
                Paddle_L.dy = 0
            end
        else
            Paddle_L:AI(dt, MyBall.y)
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
            if SFX_stat == "On" then
                Sounds['wall_hit']:play()
            else
                Sounds['wall_hit']:stop()
            end
        end
        if MyBall:collides(Paddle_R) and MyBall.x + MyBall.width > VIRTUAL_WIDTH - 35 then
            MyBall.dx = -MyBall.dx
            if SFX_stat == "On" then
                Sounds['wall_hit']:play()
            else
                Sounds['wall_hit']:stop()
            end
        end

        if MyBall:UDBoundary_Collide() and (MyBall.y < 10 or MyBall.y + MyBall.height > VIRTUAL_HEIGHT - 10) then
            MyBall.dy = - MyBall.dy
            if SFX_stat == "On" then
                Sounds['wall_hit']:play()
            else
                Sounds['wall_hit']:stop()
            end
        end

        if MyBall:LRBoundary_Collide() == 1 then
            P1_score = P1_score + 1
            if SFX_stat == "On" then
                Sounds['point_score']:play()
            else
                Sounds['point_score']:stop()
            end
            MyBall:reset()
        elseif MyBall:LRBoundary_Collide() == 2 then
            P2_score = P2_score + 1
            if SFX_stat == "On" then
                Sounds['point_score']:play()
            else
                Sounds['point_score']:stop()
            end
            MyBall:reset()
        end

        if P1_score == Target then
            Gamestate = 'P1_WINNER'
        elseif P2_score == Target then
            Gamestate = 'P2_WINNER'
        end

    elseif Gamestate == 'PAUSE_TO_PLAY' then
        if Count_Down > 0 then
            Count_Down = Count_Down - 1
        elseif Count_Down == 0 then
            Gamestate = 'PLAY'
            Count_Down = (Count_Down_ULTRA + 1) * 60
        end
    end
end

function Score_Reset()
    P1_score = 0
    P2_score = 0
end

function Player_Module.keypressed(key)
    if Gamestate == 'START' then
        if key == 'return' then
            Gamestate = 'MAIN_MENU'
        end
    elseif Gamestate == 'PLAY' or Gamestate == 'COMPUTER_MODE' then
        if key == 'space' then
            Gamestate = 'PAUSE'
        end
    end
end

function Player_Module.draw()
    if Gamestate == 'START' then
        love.graphics.setFont(Titlefont)
        love.graphics.printf(". . P O N G . .", 0, VIRTUAL_HEIGHT / 2 - 50, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(Smallfont)
        love.graphics.printf("[ Press Enter To Continue.. ]", 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')
    elseif Gamestate == 'PLAY' or Gamestate == 'COMPUTER_MODE' or Gamestate == 'PAUSE_TO_PLAY' then
        love.graphics.setFont(Smallfont) 
        love.graphics.printf("Ready - Set - Pong!!!", 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("[ Target - "..tostring(Target).." ]", 0, 50, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(Titlefont)
        love.graphics.printf(P1_score, VIRTUAL_WIDTH / 2 - 108, 15, VIRTUAL_WIDTH)
        love.graphics.printf(P2_score, VIRTUAL_WIDTH / 2 + 80, 15, VIRTUAL_WIDTH)
        love.graphics.setFont(Smallfont) 
        Paddle_L:render()
        MyBall:render()
        Paddle_R:render() 
        if Gamestate == 'PLAY' then
            love.graphics.printf("Press [ SPACE ] To Pause The PONG", 0, VIRTUAL_HEIGHT - 30, VIRTUAL_WIDTH, 'center')
        elseif Gamestate == 'COMPUTER_MODE' then
            love.graphics.printf("Press [ SPACE ] To Pause The PONG", 0, VIRTUAL_HEIGHT - 30, VIRTUAL_WIDTH, 'center')
        elseif Gamestate == 'PAUSE_TO_PLAY' then
            love.graphics.setFont(Countfont)
            K = math.floor(Count_Down / 60)
            if K == 0 then
                love.graphics.printf('GO!!!', 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
            else
                love.graphics.printf(K, 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
            end
        end
    end
end

return Player_Module