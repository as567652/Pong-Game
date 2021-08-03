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

    Target = 0
    N = 8

    Smallfont = love.graphics.newFont(Font_file, N)
    MidFont = love.graphics.newFont(Font_file, N * 2)
    Scorefont = love.graphics.newFont(Font_file, N * 3)
    Titlefont = love.graphics.newFont(Font_file, N * 4)
    
    Push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = false
    })

    Gamestate = 'START'
    Prev_Gamestate = ''

    Sounds = {
        ['wall_hit'] = love.audio.newSource('audio/hit.wav', 'static'),
        ['point_score'] = love.audio.newSource('audio/point.wav', 'static')
    }

    Player_Module.load()
    Menu_Module.load()
end

function love.update(dt)
    Player_Module.update(dt)
    Menu_Module.update(dt)
end

function love.keypressed(key)
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