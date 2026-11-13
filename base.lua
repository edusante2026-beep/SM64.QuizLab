
-- QuizLab - base.lua

local Questions = require("questions")
local Base = {}

local active, paused = false, false
local questionIndex, correctAnswer = 0, 0
local score, answerReceived = 0, false

-- =========================================
-- SINCRONIZACAO DA PONTUACAO
-- =========================================

local function set_score(value)
    score = math.max(0, tonumber(value) or 0)

    if gPlayerSyncTable ~= nil and gPlayerSyncTable[0] ~= nil then
        gPlayerSyncTable[0].quiz_score = score
    end
end

-- Retorna a pontuacao de qualquer jogador.
function Base.get_player_score(playerIndex)
    playerIndex = tonumber(playerIndex)

    if playerIndex == nil then
        return score
    end

    if gPlayerSyncTable ~= nil
    and gPlayerSyncTable[playerIndex] ~= nil then
        return math.max(
            0,
            tonumber(gPlayerSyncTable[playerIndex].quiz_score) or 0
        )
    end

    return 0
end

-- Retorna a pontuacao do jogador local.
function Base.get_score()
    return Base.get_player_score(0)
end

-- Inicializa a pontuacao sincronizada do jogador local.
if gPlayerSyncTable ~= nil and gPlayerSyncTable[0] ~= nil then
    if gPlayerSyncTable[0].quiz_score == nil then
        set_score(0)
    else
        score = tonumber(gPlayerSyncTable[0].quiz_score) or 0
    end
end

-- =========================================
-- PERGUNTAS
-- =========================================

local function current_question()
    if questionIndex < 1 then return nil end
    return Questions[questionIndex]
end

function Base.get_current_question()
    return current_question()
end

function Base.get_question_index()
    return questionIndex
end

function Base.get_question_count()
    return #Questions
end

function Base.get_correct_answer()
    return correctAnswer
end

function Base.has_answer()
    return answerReceived
end

function Base.is_active()
    return active
end

function Base.is_paused()
    return paused
end

local function load_question(index)
    if #Questions == 0 then return false end

    index = math.max(1, math.min(#Questions, tonumber(index) or 0))

    local question = Questions[index]
    local answers = question and question.answers or nil
    local correct = question and tonumber(question.correct) or 0

    if type(answers) ~= "table"
    or #answers < 2
    or correct < 1
    or correct > #answers then
        return false
    end

    questionIndex, correctAnswer = index, correct
    answerReceived = false

    return true
end

-- Seleciona uma pergunta aleatória.
function Base.select_question()
    if #Questions == 0 then return false end
    return load_question(math.random(1, #Questions))
end

-- Alias explícito para a opção "Pergunta Aleatória".
function Base.random()
    if not active then return false end
    return Base.select_question()
end

-- =========================================
-- CONTROLE DO QUIZ
-- =========================================

function Base.start()
    set_score(0)

    paused = false
    answerReceived = false

    if not Base.select_question() then
        active, questionIndex, correctAnswer = false, 0, 0
        return false
    end

    active = true
    return true
end

-- Avança em sequência e retorna à primeira pergunta depois da última.
function Base.next()
    if not active or #Questions == 0 then return false end

    local nextIndex = questionIndex + 1

    if nextIndex > #Questions then
        nextIndex = 1
    end

    return load_question(nextIndex)
end

function Base.stop()
    active, paused = false, false
    questionIndex, correctAnswer = 0, 0

    set_score(0)
    answerReceived = false
end

function Base.set_paused(value)
    paused = active and value == true
end

-- =========================================
-- RESPOSTAS
-- =========================================

function Base.check_answer(message)
    if not active or answerReceived or type(message) ~= "string" then
        return nil
    end

    local answer = message:lower():match("^%s*(.-)%s*$")
    local selected = ({ a = 1, b = 2, c = 3, d = 4 })[answer]

    if not selected then return nil end

    local q = current_question()

    if not q or not q.answers or selected > #q.answers then
        return nil
    end

    answerReceived = true

    if selected == correctAnswer then
        set_score(score + 1)
        return true
    end

    return false
end

_G.QuizLabBase = Base

return Base

