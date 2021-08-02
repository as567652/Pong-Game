local Menu_Module = {}

function Menu_Module.load()
    Menu_Options_Var = Menu()
    Menu_Options_Var.Options = {"Play", "Leaderboard", "Settings", "Credits", "Exit"}
    Menu_Options_Var.n = 5

    Settings_Options_Var = Menu()
    Settings_Options_Var.Options = {"Adjust Volume", "[ Back To Menu ]"}
    Settings_Options_Var.n = 2

    QUIT_CONF_0 = Menu()
    QUIT_CONF_0.Options = {"Yes", "No"}
    QUIT_CONF_0.n = 2

    Mode_Selection = Menu()
    Mode_Selection.Options = {"VS Computer", "VS Player", "[ Back To Menu ]"}
    Mode_Selection.n = 3

    Pause_Menu = Menu()
    Pause_Menu.Options = {"Resume", "Quit"}
    Pause_Menu.n = 2 

    QUIT_CONF_1 = Menu()
    QUIT_CONF_1.Options = {"Yes", "No"}
    QUIT_CONF_1.n = 2

    WINNER = Menu()
    WINNER.Options = {"[ Back To Menu ]"}
    WINNER.n = 1
end

function Menu_Module.update(dt)
    if Gamestate == 'MAIN_MENU' then
        Menu_Options_Var:update(dt)
    elseif Gamestate == 'SETTINGS_MENU' then
        Settings_Options_Var:update(dt)
    elseif Gamestate == 'QUIT_CONF_0' then
        QUIT_CONF_0:update(dt)
    elseif Gamestate == 'MODE_MENU' then
        Mode_Selection:update(dt)
    elseif Gamestate == 'PAUSE' then
        Pause_Menu:update(dt)
    elseif Gamestate == 'QUIT_CONF_1' then
        QUIT_CONF_1:update(dt)
    elseif Gamestate == 'P1_WINNER' or Gamestate == 'P2_WINNER' then
        WINNER:update(dt)
        Score_Reset()
    end
end

function Menu_Module.keypressed(key)
    if Gamestate == 'MAIN_MENU' then
        if key == 'return' then
            if Menu_Options_Var:Option_Selected() == 'Play' then
                Gamestate = 'MODE_MENU'
                Mode_Selection.current_counter = 1
            elseif Menu_Options_Var:Option_Selected() == 'Settings' then
                Gamestate = 'SETTINGS_MENU'
                Settings_Options_Var.current_counter = 1
            elseif Menu_Options_Var:Option_Selected() == 'Exit' then
                Gamestate = 'QUIT_CONF_0'
                QUIT_CONF_0.current_counter = 1
            end
        end
        Menu_Options_Var:KeyPressFunc(key)
    elseif Gamestate == 'SETTINGS_MENU' then
        if key == 'return' then
            if Settings_Options_Var:Option_Selected() == '[ Back To Menu ]' then
                Gamestate = 'MAIN_MENU'
                Menu_Options_Var.current_counter = 1
            end
        end
        Settings_Options_Var:KeyPressFunc(key)
    elseif Gamestate == 'QUIT_CONF_0' then
        if key == 'return' then
            if QUIT_CONF_0:Option_Selected() == 'Yes' then
                love.event.quit()
            elseif QUIT_CONF_0:Option_Selected() == 'No' then
                Gamestate = 'MAIN_MENU'
                Menu_Options_Var.current_counter = 1
            end 
        end
        QUIT_CONF_0:KeyPressFunc(key)
    elseif Gamestate == 'MODE_MENU' then
        if key == 'return' then
            if Mode_Selection:Option_Selected() == 'VS Computer' then
                Gamestate = 'COMPUTER_MODE'
                Prev_Gamestate = 'COMPUTER_MODE'
            elseif Mode_Selection:Option_Selected() == 'VS Player' then
                Gamestate = 'PLAY'
                Prev_Gamestate = 'PLAY'
            else
                Gamestate = 'MAIN_MENU'
            end 
        end
        Mode_Selection:KeyPressFunc(key)
    elseif Gamestate == 'PAUSE' then
        if key == 'return' then
            if Pause_Menu:Option_Selected() == 'Resume' then
                Gamestate = 'PAUSE_TO_PLAY'
            else
                Gamestate = 'QUIT_CONF_1'
                QUIT_CONF_1.current_counter = 1
            end
        end
        Pause_Menu:KeyPressFunc(key)
    elseif Gamestate == 'QUIT_CONF_1' then
        if key == 'return' then
            if QUIT_CONF_1:Option_Selected() == 'Yes' then
                Gamestate = 'MAIN_MENU'
                MyBall:reset()
                Score_Reset()
            else
                Gamestate = 'PAUSE'
                Pause_Menu.current_counter = 1
            end
        end
        QUIT_CONF_1:KeyPressFunc(key)
    elseif Gamestate == 'P1_WINNER' then
        if key == 'return' then
            Gamestate = 'MAIN_MENU'
        end
        WINNER:KeyPressFunc(key)
    elseif Gamestate == 'P2_WINNER' then
        if key == 'return' then
            Gamestate = 'MAIN_MENU'
        end
        WINNER:KeyPressFunc(key)
    end
end

function Menu_Module.draw()
    if Gamestate == 'MAIN_MENU' then
        Menu_Options_Var:render()
    elseif Gamestate == 'SETTINGS_MENU' then
        Settings_Options_Var:render()
    elseif Gamestate == 'QUIT_CONF_0' then
        QUIT_CONF_0:render()
        QUIT_CONF_0:msg_print("Are You Sure You Want To Quit ??")
    elseif Gamestate == 'MODE_MENU' then
        Mode_Selection:render()
    elseif Gamestate == 'PAUSE' then
        Pause_Menu:render()
        Pause_Menu:msg_print("...Game Paused...")
    elseif Gamestate == 'QUIT_CONF_1' then
        QUIT_CONF_1:render()
        QUIT_CONF_1:msg_print("Progress Won't Be Saved, Continue ??")
    elseif Gamestate == 'P1_WINNER' then
        WINNER:render()
        if Prev_Gamestate == 'PLAY' then
            WINNER:msg_print_winner("Congrats Player 1\nYou Won !!!!")
        else
            WINNER:msg_print_winner("Computer Won :(")
        end
    elseif Gamestate == 'P2_WINNER' then
        WINNER:render()
        if Prev_Gamestate == 'PLAY' then
            WINNER:msg_print_winner("Congrats Player 2\nYou Won !!!!")
        else
            WINNER:msg_print_winner("Congratulations\n You Won !!!!")
        end
    end
end

return Menu_Module