-- name: \\#00FF75\\QuizLab \\#9AFF27\\(v2.0)
-- description: \\#00FF75\\QuizLab \\#FFFFFF\\ - Test your knowledge in SM64CoopDX!\n\n\\#00FF99\\Random Questions\\#FFFFFF\\ and \\#FFD447\\Next Question\\#FFFFFF\\!\n\\#FF66CC\\Track your score\\#FFFFFF\\ and enjoy animated menus!\n\n\\#22AAFF\\Available in English and Portuguese.\n\\#AAAAAA\\Made for SM64CoopDX 1.5.1.\n\\#FFAA33\\Play and learn!

local Base = require("base")
local Language = require("language")
Language.set("en") -- idioma inicial; a aba Configuracoes permite alternar para pt.

local pauseMenuOpen, pauseMenuSelection, pauseMenuScreen = false, 1, "main"
local settingsSelection = 1
local hudSizeLevel = 1
local pauseMenuItems = {}
local pauseMenuInputsDown, pauseMenuStickCooldownY, pauseMenuStickCooldownX = 0, 0, 0
local pauseStartBlocked = false

-- A lista só é reconstruída depois que a animação de fechamento termina.
local pendingMenuRefresh = false
local menuCloseRenderFrames = 0
local MENU_CLOSE_ANIMATION_FRAMES = 26

local function is_host()
    return type(network_is_server) == "function" and network_is_server() == true
end

local function get_tabs()
    local tabs = { "main", "score", "settings" }
    if is_host() then tabs[#tabs + 1] = "info" end
    return tabs
end

local function update_pause_menu_items()
    if Base.is_active() then
        pauseMenuItems = {
            Language.get("RANDOM_QUESTION"),
            Language.get("NEXT_QUESTION"),
            Language.get("STOP_QUIZ")
        }
    else
        pauseMenuItems = { Language.get("NEW_QUIZ") }
    end
end

local function start_quiz()
    if not Base.start() then
        djui_chat_message_create("\\#FF4D5A\\" .. Language.get("ERR_LOAD"))
        return false
    end
    return true
end

local function stop_quiz() Base.stop() end
local function next_question() return Base.next() end
local function random_question() return Base.random() end

local function open_pause_menu()
    if pauseMenuOpen then return end
    pauseMenuOpen = true
    update_pause_menu_items()
    pauseMenuSelection, pauseMenuScreen = 1, "main"
    Base.set_paused(true)
    pauseMenuInputsDown = gMarioStates[0].controller.buttonDown
    play_sound(SOUND_MENU_PAUSE, gGlobalSoundSource)
end

local function close_pause_menu(closedWithStart, refreshAfterClose)
    if not pauseMenuOpen then return end
    pauseMenuOpen = false
    pauseMenuSelection, pauseMenuScreen = 1, "main"
    Base.set_paused(false)
    pauseMenuInputsDown = 0
    if closedWithStart then pauseStartBlocked = true end
    if refreshAfterClose then
        pendingMenuRefresh = true
        menuCloseRenderFrames = 0
    end
    play_sound(SOUND_MENU_CLICK_FILE_SELECT, gGlobalSoundSource)
end

local function change_pause_selection(direction)
    local count = #pauseMenuItems
    if count == 0 then return end
    pauseMenuSelection = ((pauseMenuSelection - 1 + direction) % count) + 1
    play_sound(SOUND_MENU_CHANGE_SELECT, gGlobalSoundSource)
end

local function change_pause_tab(direction)
    local tabs, current = get_tabs(), 1
    for i, tab in ipairs(tabs) do if tab == pauseMenuScreen then current = i; break end end
    pauseMenuScreen = tabs[((current - 1 + direction) % #tabs) + 1]
    pauseMenuSelection = 1
    play_sound(SOUND_MENU_CHANGE_SELECT, gGlobalSoundSource)
end

local function select_pause_item()
    local selected = pauseMenuItems[pauseMenuSelection]

    if selected == Language.get("NEW_QUIZ") then
        if start_quiz() then
            close_pause_menu(false, true)
            djui_chat_message_create("\\#00FF75\\" .. Language.get("NEW_STARTED"))
        end

    elseif selected == Language.get("RANDOM_QUESTION") then
        if random_question() then close_pause_menu(false, false) end

    elseif selected == Language.get("NEXT_QUESTION") then
        if next_question() then close_pause_menu(false, false) end

    elseif selected == Language.get("STOP_QUIZ") then
        stop_quiz()
        close_pause_menu(false, true)
        djui_chat_message_create("\\#FF4D5A\\" .. Language.get("STOPPED"))
    end
end

local function handle_pause_menu_input(m)
    if m.playerIndex ~= 0 then return end
    if not pauseMenuOpen then
        if (m.controller.buttonDown & START_BUTTON) == 0 then pauseStartBlocked = false end
        if not pauseStartBlocked and (m.controller.buttonPressed & START_BUTTON) ~= 0 then
            m.controller.buttonPressed = m.controller.buttonPressed & ~START_BUTTON
            open_pause_menu()
        else return end
    end

    if m.freeze < 3 then m.freeze = 3 end
    local inputsPressed = m.controller.buttonDown & (m.controller.buttonDown ~ pauseMenuInputsDown)
    pauseMenuInputsDown = m.controller.buttonDown
    m.controller.buttonDown, m.controller.buttonPressed = 0, 0
    m.controller.stickX, m.controller.stickY = 0, 0

    if djui_hud_is_pause_menu_created() then pauseMenuInputsDown = B_BUTTON; return end
    if (inputsPressed & R_TRIG) ~= 0 then djui_open_pause_menu(); return end
    if (inputsPressed & START_BUTTON) ~= 0 then close_pause_menu(true, false); return end

    if pauseMenuScreen ~= "main" then
        if pauseMenuScreen == "settings" then
            local stickY = m.controller.rawStickY
            if (pauseMenuInputsDown & D_JPAD) ~= 0 then stickY = stickY - 65 end
            if (pauseMenuInputsDown & U_JPAD) ~= 0 then stickY = stickY + 65 end
            if pauseMenuStickCooldownY > 0 then pauseMenuStickCooldownY = pauseMenuStickCooldownY - 1 end
            if pauseMenuStickCooldownY == 0 then
                if stickY > 64 then
                    settingsSelection = settingsSelection - 1
                    if settingsSelection < 1 then settingsSelection = 2 end
                    pauseMenuStickCooldownY = 6
                    play_sound(SOUND_MENU_CHANGE_SELECT, gGlobalSoundSource)
                elseif stickY < -64 then
                    settingsSelection = settingsSelection + 1
                    if settingsSelection > 2 then settingsSelection = 1 end
                    pauseMenuStickCooldownY = 6
                    play_sound(SOUND_MENU_CHANGE_SELECT, gGlobalSoundSource)
                end
            end
            if (inputsPressed & A_BUTTON) ~= 0 then
                if settingsSelection == 1 then
                    Language.toggle()
                    update_pause_menu_items()
                else
                    hudSizeLevel = hudSizeLevel + 1
                    if hudSizeLevel > 5 then hudSizeLevel = 1 end
                end
                play_sound(SOUND_MENU_CHANGE_SELECT, gGlobalSoundSource)
            end
        end
        if (inputsPressed & B_BUTTON) ~= 0 then
            pauseMenuScreen, pauseMenuSelection = "main", 1
            play_sound(SOUND_MENU_CLICK_FILE_SELECT, gGlobalSoundSource)
        end
    else
        local stickY = m.controller.rawStickY
        if (pauseMenuInputsDown & D_JPAD) ~= 0 then stickY = stickY - 65 end
        if (pauseMenuInputsDown & U_JPAD) ~= 0 then stickY = stickY + 65 end
        if pauseMenuStickCooldownY > 0 then pauseMenuStickCooldownY = pauseMenuStickCooldownY - 1 end
        if pauseMenuStickCooldownY == 0 then
            if stickY > 64 then change_pause_selection(-1); pauseMenuStickCooldownY = 5
            elseif stickY < -64 then change_pause_selection(1); pauseMenuStickCooldownY = 5 end
        end
        if (inputsPressed & A_BUTTON) ~= 0 then select_pause_item() end
        if (inputsPressed & B_BUTTON) ~= 0 then close_pause_menu() end
    end

    local stickX = m.controller.rawStickX
    if (pauseMenuInputsDown & L_JPAD) ~= 0 then stickX = stickX - 65 end
    if (pauseMenuInputsDown & R_JPAD) ~= 0 then stickX = stickX + 65 end
    if pauseMenuStickCooldownX > 0 then pauseMenuStickCooldownX = pauseMenuStickCooldownX - 1 end
    if pauseMenuStickCooldownX == 0 then
        if stickX > 64 then change_pause_tab(1); pauseMenuStickCooldownX = 7
        elseif stickX < -64 then change_pause_tab(-1); pauseMenuStickCooldownX = 7 end
    end
end

local function before_mario_update(m)
    if m.playerIndex == 0 then handle_pause_menu_input(m) end
end

-- O HUD anima o fechamento por 24 frames. A margem extra evita atualizar a
-- lista no mesmo frame em que o painel ainda está sendo desenhado.
local function after_pause_close_render()
    if not pendingMenuRefresh or pauseMenuOpen then return end
    menuCloseRenderFrames = menuCloseRenderFrames + 1
    if menuCloseRenderFrames >= MENU_CLOSE_ANIMATION_FRAMES then
        update_pause_menu_items()
        pendingMenuRefresh = false
        menuCloseRenderFrames = 0
    end
end

local function quiz_command(message)
    local command = (message or ""):lower():match("^%s*(.-)%s*$")
    if command == "" or command == "start" then
        if start_quiz() then
            update_pause_menu_items()
            djui_chat_message_create("\\#00FF75\\" .. Language.get("STARTED"))
        end
    elseif command == "stop" then
        stop_quiz()
        update_pause_menu_items()
        djui_chat_message_create("\\#FF4D5A\\" .. Language.get("STOPPED"))
    elseif command == "next" then
        if next_question() then djui_chat_message_create("\\#168CFF\\" .. Language.get("NEXT")) end
    elseif command == "random" then
        if random_question() then djui_chat_message_create("\\#168CFF\\" .. Language.get("NEXT")) end
    elseif command == "score" then
        if not pauseMenuOpen then open_pause_menu() end
        pauseMenuScreen = "score"
    end
    return true
end

local function on_chat_message(m, message)
    -- Cada cliente só processa as respostas do próprio jogador.
    if not m or m.playerIndex ~= 0 then return true end
    if not Base.is_active() then return true end

    local result = Base.check_answer(message)

    if result == true then
        djui_chat_message_create("\\#00FF75\\" .. Language.get("CORRECT"))
        return false
    elseif result == false then
        djui_chat_message_create("\\#FF4D5A\\" .. Language.get("WRONG"))
        return false
    end

    return true
end

hook_chat_command("quiz", Language.get("CHAT_HELP"), quiz_command)
hook_event(HOOK_ON_CHAT_MESSAGE, on_chat_message)
hook_event(HOOK_BEFORE_MARIO_UPDATE, before_mario_update)
hook_event(HOOK_ON_HUD_RENDER, after_pause_close_render)

_G.QuizLab = {
    is_active=Base.is_active, is_paused=Base.is_paused,
    is_pause_menu_open=function() return pauseMenuOpen end,
    get_pause_menu_screen=function() return pauseMenuScreen end,
    get_pause_menu_items=function() return pauseMenuItems end,
    get_pause_menu_selection=function() return pauseMenuSelection end,
    get_current_question=Base.get_current_question, get_question_index=Base.get_question_index,
    get_question_count=Base.get_question_count, get_correct_answer=Base.get_correct_answer,
    get_score=Base.get_score, get_player_score=Base.get_player_score, has_answer=Base.has_answer,
    get_language=Language.get_current, set_language=Language.set, toggle_language=Language.toggle,
    get_hud_size=function() return hudSizeLevel end,
    get_settings_selection=function() return settingsSelection end,
    is_host=is_host, start=start_quiz, stop=stop_quiz, next=next_question,
    random=random_question,
    get_text=Language.get
}
update_pause_menu_items()
require("hud")
