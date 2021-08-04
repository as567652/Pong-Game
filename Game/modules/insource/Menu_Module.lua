local Menu_Module = {}

function Menu_Module.load()
    Menu_Options_Var = Menu()
    Menu_Options_Var.Options = {"Play", "", "Settings", "Credits", "Exit"}
    Menu_Options_Var.n = 5

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

    VS_COMP_Menu = New_Menu()
    VS_COMP_Menu.UD = 2
    VS_COMP_Menu.first = {{"Target", 10, 1}, {"Difficulty", 3, 1}}
    VS_COMP_Menu.second["Target"] = {1, 3, 5, 7, 9, 11, 13, 15, 17, 19}
    VS_COMP_Menu.second["Difficulty"] = {"Easy", "Medium", "Hard"}

    VS_PLAYER_Menu = New_Menu()
    VS_PLAYER_Menu.UD = 1
    VS_PLAYER_Menu.first = {{"Target", 8, 1}}
    VS_PLAYER_Menu.second["Target"] = {5, 7, 9, 11, 13, 15, 17, 19}

    Settings_Options_Var = New_Menu()
    Settings_Options_Var.UD = 2
    Settings_Options_Var.first = {{"Volume", 5, 5}, {"Music", 2, 1}}
    Settings_Options_Var.second["Volume"] = {1, 2, 3, 4, 5}
    Settings_Options_Var.second["Music"] = {"On", "Off"}
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
    elseif Gamestate == 'VS_COMP_Menu' then
        VS_COMP_Menu:update(dt)
    elseif Gamestate == 'VS_PLAYER_Menu' then
        VS_PLAYER_Menu:update(dt)
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
            elseif Menu_Options_Var:Option_Selected() == 'Credits' then
                Gamestate = 'CREDITS'
            end
        end
        Menu_Options_Var:KeyPressFunc(key)
    elseif Gamestate == 'SETTINGS_MENU' then
        if key == 'return' then
            Gamestate = 'MAIN_MENU'
            Menu_Options_Var.current_counter = 1
            Settings_Options_Var.current_counter_UD = 1
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
                Gamestate = 'VS_COMP_Menu'
            elseif Mode_Selection:Option_Selected() == 'VS Player' then
                Gamestate = 'VS_PLAYER_Menu'
            else
                Gamestate = 'MAIN_MENU'
            end 
        end
        Mode_Selection:KeyPressFunc(key)
    elseif Gamestate == 'VS_COMP_Menu' then
        if key == 'return' then
            Gamestate = 'COMPUTER_MODE'
            Prev_Gamestate = 'COMPUTER_MODE'
            Target = VS_COMP_Menu:get_value("Target")
            VS_COMP_Menu.current_counter_UD = 1
        end
        VS_COMP_Menu:KeyPressFunc(key)
    elseif Gamestate == 'VS_PLAYER_Menu' then
        if key == 'return' then
            Gamestate = 'PLAY'
            Prev_Gamestate = 'PLAY'
            Target = VS_PLAYER_Menu:get_value("Target")
            VS_PLAYER_Menu.current_counter_UD = 1
        end
        VS_PLAYER_Menu:KeyPressFunc(key)
    elseif Gamestate == 'PAUSE' then
        if key == 'return' then
            if Pause_Menu:Option_Selected() == 'Resume' then
                Gamestate = 'PAUSE_TO_PLAY'
            else
                Gamestate = 'QUIT_CONF_1'
                QUIT_CONF_1.current_counter = 1
                Pause_Menu.current_counter = 1
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
    elseif Gamestate == 'CREDITS' then
        if key == 'return' then
            Gamestate = 'MAIN_MENU'
        end
    end
end

function Menu_Module.draw()
    if Gamestate == 'MAIN_MENU' then
        love.graphics.printf("New Play Mode (Coming Soon)", 0, 40 + 72 + 25, VIRTUAL_WIDTH, 'center')
        Menu_Options_Var:render()
        Menu_Options_Var:msg_print(". . M E N U . .")
    elseif Gamestate == 'SETTINGS_MENU' then
        Settings_Options_Var:render()
        Settings_Options_Var:msg_print(". . S E T T I N G S . . ")
    elseif Gamestate == 'QUIT_CONF_0' then
        QUIT_CONF_0:render()
        QUIT_CONF_0:msg_print(". . Are You Sure You Want To Quit ?? . . ")
    elseif Gamestate == 'MODE_MENU' then
        Mode_Selection:render()
        Mode_Selection:msg_print(". . Opponent Selection . .")
    elseif Gamestate == 'VS_COMP_Menu' then
        VS_COMP_Menu:render()
        VS_COMP_Menu:msg_print(' . . Game Settings . .')
    elseif Gamestate == 'VS_PLAYER_Menu' then
        VS_PLAYER_Menu:render()
        VS_PLAYER_Menu:msg_print(' . . Game Settings . .')
    elseif Gamestate == 'PAUSE' then
        Pause_Menu:render()
        Pause_Menu:msg_print(". . P A U S E D . . ")
    elseif Gamestate == 'QUIT_CONF_1' then
        QUIT_CONF_1:render()
        QUIT_CONF_1:msg_print(". . Progress Won't Be Saved, Continue ?? . . ")
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
    elseif Gamestate == 'CREDITS' then
        love.graphics.setFont(Titlefont)
        love.graphics.printf(" [ PONG GAME ] ", 0, 40 - 16, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(MidFont)
        love.graphics.printf("..Created by..", 0, 40 - 16 + 80, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("[ Abhinav Sharma ]", 0, 40 - 16 + 110, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(Smallfont)
        love.graphics.printf("GitHub - as567652", 0, 40 - 16 + 140, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("Press [ Enter ] to return to Main Menu", 0, VIRTUAL_HEIGHT - 30, VIRTUAL_WIDTH, 'center')
    end
end

return Menu_Module