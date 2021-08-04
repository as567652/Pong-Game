WINDOW_WIDTH = 1085
WINDOW_HEIGHT = 610
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

Paddle_Speed = 200

Class = require 'modules/outsource/class'
Push = require 'modules/outsource/push'

require 'modules/insource/class_files/Ball'
require 'modules/insource/class_files/Paddle'
require 'modules/insource/class_files/Menu'
require 'modules/insource/class_files/New_Menu'

local Player_Module = require 'modules/insource/Player_Module'
local Menu_Module = require 'modules/insource/Menu_Module'

Font_file = 'fonts/bb.ttf'

function love.load()
    love.window.setTitle('THE PONG GAME')
    love.graphics.setDefaultFilter('nearest', 'nearest')

    Music = love.audio.newSource("audio/music.mp3", "stream")

    Target = 0
    Music_stat = 'On'
    SFX_stat = 'On'
    Volume_Var = 5
    Count_Down_ULTRA = 3
    N = 8

    Smallfont = love.graphics.newFont(Font_file, N)
    MidFont = love.graphics.newFont(Font_file, N * 2)
    Scorefont = love.graphics.newFont(Font_file, N * 3)
    Titlefont = love.graphics.newFont(Font_file, N * 4)
    Countfont = love.graphics.newFont(Font_file, N * 5)
    
    Push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = false
    })

    Gamestate = 'START'
    Prev_Gamestate = ''

    Sounds = {
        ['wall_hit'] = love.audio.newSource('audio/hit.wav', 'static'),
        ['point_score'] = love.audio.newSource('audio/point.wav', 'static'),
        ['up_down'] = love.audio.newSource('audio/enter.wav', 'static'),
        ['enter'] = love.audio.newSource('audio/enter.wav', 'static'),
    }

    Player_Module.load()
    Menu_Module.load()
end

function love.update(dt)
    Player_Module.update(dt)
    Menu_Module.update(dt)
    if Music_stat == 'On' then
        Music:play()
        if Gamestate == 'PLAY' or Gamestate == 'COMPUTER_MODE' then
            Music:setVolume(Volume_Var / 10)
        else
            Music:setVolume(0.2 * Volume_Var)
        end 
    else
        Music:stop()
    end
end

function love.keypressed(key)
    if SFX_stat == 'On' then
        if Gamestate == 'PLAY' or Gamestate == 'COMPUTER_MODE' then
            if key == 'up' or key == 'down' then
                Sounds['up_down']:stop() 
            end
        else
            if key == 'up' or key == 'down' then
                Sounds['up_down']:play() 
            end
        end
        if key == 'return' then
            Sounds['enter']:play()
        end
    else
        Sounds['up_down']:stop() 
        Sounds['enter']:stop()
    end
    Menu_Module.keypressed(key)
    Player_Module.keypressed(key)
end

function love.draw()
    Push:apply('start')

    love.graphics.clear(40/255, 45/255, 52/255, 1)

    DisplayFPS()
    
    Menu_Module.draw()
    Player_Module.draw()

    Push:apply('end')
end

function DisplayFPS()
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.setFont(Smallfont)
    love.graphics.printf('FPS : '..tostring(love.timer.getFPS()), 0, VIRTUAL_HEIGHT - 15, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)
end