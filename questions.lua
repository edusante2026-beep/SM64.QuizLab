-- QuizLab
-- questions.lua
-- Mantem a lista de questoes dinamica: os textos sao consultados no idioma
-- ativo no momento em que cada campo e acessado, nao quando o arquivo e carregado.

local Language = require("language")

-- O banco bilingue fica em language.lua. Este arquivo expoe uma lista com
-- tamanho fixo e resolve cada questao sob demanda, evitando que o require()
-- armazene permanentemente a versao em ingles carregada inicialmente.
local QUESTION_COUNT = 20
local questions = {}

local function current_questions()
    if Language and type(Language.get_questions) == "function" then
        return Language.get_questions()
    end
    return {}
end

for index = 1, QUESTION_COUNT do
    questions[index] = setmetatable({}, {
        __index = function(_, key)
            local active = current_questions()
            local question = active[index]
            if question then
                return question[key]
            end
            return nil
        end
    })
end

return questions
