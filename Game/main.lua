WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

Paddle_Speed = 190

Class = require 'class'
Push = require 'push'
require 'Paddle'
require 'Ball'

function love.load()
    love.window.setTitle('THE PONG GAME')
    love.graphics.setDefaultFilter('nearest', 'nearest')

    Smallfont = love.graphics.newFont('fonts/aa.TTF', 8)
    Scorefont = love.graphics.newFont('fonts/aa.TTF', 32)
    Titlefont = love.graphics.newFont('fonts/aa.TTF', 40)
    
    Push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = false
    })

    P1_score = 0
    P2_score = 0    

    Paddle_L = Paddle(5, 30, 5, 20)
    Paddle_R = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 40, 5, 20)

    MyBall = Ball()

    Gamestate = 'START'

    Sounds = {
        ['wall_hit'] = love.audio.newSource('audio/hit.wav', 'static'),
        ['point_score'] = love.audio.newSource('audio/point.wav', 'static')
    }
end

function love.update(dt)
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
    end

end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'return' then
        if Gamestate == 'START' then
            Gamestate = 'PLAY'
        elseif Gamestate == 'PLAY' then
            Gamestate = 'START'
            MyBall:reset()
        end
    end
end

function DisplayFPS()
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.setFont(Smallfont)
    love.graphics.print('FPS : '..tostring(love.timer.getFPS()), 10, 10)
    love.graphics.setColor(1, 1, 1, 1)
end

function love.draw()
    Push:apply('start')

    love.graphics.clear(40/255, 45/255, 52/255, 1)
    DisplayFPS()
    if Gamestate == 'START' then
        love.graphics.setFont(Titlefont)
        love.graphics.printf("PONG!!!", 0, VIRTUAL_HEIGHT / 2 - 50, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(Smallfont)
        love.graphics.printf("[ Press Enter To Continue.. ]", 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')
    elseif Gamestate == 'PLAY' then
        love.graphics.setFont(Scorefont)
        love.graphics.printf(P1_score, VIRTUAL_WIDTH / 2 - 8 - 60, 15, VIRTUAL_WIDTH)
        love.graphics.printf(P2_score, VIRTUAL_WIDTH / 2 + 50, 15, VIRTUAL_WIDTH)

        love.graphics.setFont(Smallfont)
        love.graphics.printf("Ready - Set - Pong!!!", 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("[ Press Enter To Return To Menu ]", 0, VIRTUAL_HEIGHT - 20, VIRTUAL_WIDTH, 'center')

        MyBall:render()
        Paddle_L:render()
        Paddle_R:render()
    end

    Push:apply('end')
end