-- name: \\#00FF75\\QuizLab \\#9AFF27\\(v1.0)
-- description: Quiz de ciencias local
local Base = require("base")
local menuOpen, menuSelection, menuScreen = false, 1, "main"
local menuItems, inputsDown, stickCooldown = {}, 0, 0

local function update_items()
    if Base.is_active() then
        menuItems = {"PROXIMA PERGUNTA","PARAR QUIZ","PLACAR","CONFIGURACOES","SAIR"}
    else
        menuItems = {"NOVO QUIZ","PLACAR","CONFIGURACOES","SAIR"}
    end
    if menuSelection > #menuItems then menuSelection = 1 end
end

local function open_menu(screen)
    if menuOpen then
        if screen then menuScreen = screen end
        return
    end
    menuOpen, menuSelection, menuScreen = true, 1, screen or "main"
    update_items()
    inputsDown = gMarioStates[0].controller.buttonDown
    play_sound(SOUND_MENU_PAUSE, gGlobalSoundSource)
end

local function close_menu()
    menuOpen, menuSelection, menuScreen = false, 1, "main"
    inputsDown = 0
    play_sound(SOUND_MENU_CLICK_FILE_SELECT, gGlobalSoundSource)
end

local function move_selection(dir)
    update_items()
    menuSelection = ((menuSelection - 1 + dir) % #menuItems) + 1
    play_sound(SOUND_MENU_CHANGE_SELECT, gGlobalSoundSource)
end

local function select_item()
    update_items()
    local item = menuItems[menuSelection]
    if item == "NOVO QUIZ" then
        if Base.start() then
            close_menu()
            djui_chat_message_create("\\#00FF75\\QuizLab: novo quiz iniciado!")
        end
    elseif item == "PROXIMA PERGUNTA" then
        if Base.next() then close_menu() end
    elseif item == "PARAR QUIZ" then
        Base.stop()
        update_items()
        close_menu()
        djui_chat_message_create("\\#FF4D5A\\QuizLab: quiz encerrado!")
    elseif item == "PLACAR" then
        menuScreen, menuSelection = "score", 1
        play_sound(SOUND_MENU_CLICK_FILE_SELECT, gGlobalSoundSource)
    elseif item == "CONFIGURACOES" then
        menuScreen, menuSelection = "settings", 1
        play_sound(SOUND_MENU_CLICK_FILE_SELECT, gGlobalSoundSource)
    elseif item == "SAIR" then
        close_menu()
    end
end

local function handle_input(m)
    if m.playerIndex ~= 0 then return end
    if not menuOpen then
        if (m.controller.buttonPressed & START_BUTTON) == 0 then return end
        m.controller.buttonPressed = m.controller.buttonPressed & ~START_BUTTON
        open_menu()
    end
    if m.freeze < 3 then m.freeze = 3 end
    local pressed = m.controller.buttonDown & (m.controller.buttonDown ~ inputsDown)
    inputsDown = m.controller.buttonDown
    m.controller.buttonDown, m.controller.buttonPressed = 0, 0
    m.controller.stickX, m.controller.stickY = 0, 0
    if djui_hud_is_pause_menu_created() then
        inputsDown = B_BUTTON
        return
    end
    if (pressed & R_TRIG) ~= 0 then
        djui_open_pause_menu()
        return
    end
    if menuScreen ~= "main" then
        if (pressed & B_BUTTON) ~= 0 then
            menuScreen, menuSelection = "main", 1
        end
        return
    end
    local y = m.controller.rawStickY
    if (inputsDown & D_JPAD) ~= 0 then y = y - 65 end
    if (inputsDown & U_JPAD) ~= 0 then y = y + 65 end
    if stickCooldown > 0 then stickCooldown = stickCooldown - 1 end
    if stickCooldown == 0 then
        if y > 64 then
            move_selection(-1)
            stickCooldown = 5
        elseif y < -64 then
            move_selection(1)
            stickCooldown = 5
        end
    end
    if (pressed & A_BUTTON) ~= 0 then
        select_item()
    elseif (pressed & B_BUTTON) ~= 0 or (pressed & START_BUTTON) ~= 0 then
        close_menu()
    end
end

hook_event(HOOK_BEFORE_MARIO_UPDATE, handle_input)

hook_chat_command("quiz", "start, stop, next ou score", function(msg)
    local cmd = (msg or ""):lower():match("^%s*(.-)%s*$")
    if cmd == "" or cmd == "start" then
        if Base.start() then djui_chat_message_create("\\#00FF75\\QuizLab: novo quiz iniciado!") end
    elseif cmd == "stop" then
        Base.stop()
        update_items()
        djui_chat_message_create("\\#FF4D5A\\QuizLab: quiz encerrado.")
    elseif cmd == "next" then
        if Base.next() then djui_chat_message_create("\\#168CFF\\QuizLab: proxima pergunta!") end
    elseif cmd == "score" then
        open_menu("score")
    end
    return true
end)

hook_event(HOOK_ON_CHAT_MESSAGE, function(m, msg)
    if not m or not Base.is_active() then return true end
    local result = Base.check_answer(m.playerIndex, msg)
    if result == nil then return true end
    djui_chat_message_create(result and "\\#00FF75\\QuizLab: CORRETO!" or "\\#FF4D5A\\QuizLab: ERRADO!")
    return false
end)

_G.QuizLab = {
    is_active = Base.is_active,
    is_paused = function() return menuOpen and Base.is_active() end,
    is_pause_menu_open = function() return menuOpen end,
    get_pause_menu_screen = function() return menuScreen end,
    get_pause_menu_items = function() update_items(); return menuItems end,
    get_pause_menu_selection = function() return menuSelection end,
    get_current_question = Base.get_current_question,
    get_question_index = Base.get_question_index,
    get_question_count = Base.get_question_count,
    get_correct_answer = Base.get_correct_answer,
    get_score = Base.get_score,
    has_answer = Base.has_answer,
    get_player_score = Base.get_player_score,
    get_player_answer = Base.get_player_answer,
    start = Base.start,
    stop = Base.stop,
    next = Base.next
}

require("hud")
