-- QuizLab - language.lua
-- Centraliza os textos da interface e o banco de perguntas em portugues/ingles.

local Language = {}
local current = "en"

local strings = {
    en = {
        TAB_QUIZ="QUIZ", TAB_SCORE="SCORE", TAB_SETTINGS="SETTINGS", TAB_INFO="INFO",
        PAUSED_TITLE="QUIZLAB - PAUSED", POINTS="POINTS: %s", SCORE_TITLE="LEADERBOARD",
        YOUR_SCORE="YOUR SCORE", PLAYER="PLAYER", POINTS_COLUMN="POINTS", BACK="B - BACK",
        SETTINGS_TITLE="SETTINGS", RESPONSE_MODE="ANSWER METHOD", RESPONSE_CHAT="CHAT: A / B / C / D",
        SETTING_LANGUAGE="LANGUAGE: %s", SETTING_HUD_SIZE="HUD SIZE: %s", SETTING_LANGUAGE_VALUE="CURRENT: %s",
        QUESTIONS_LOADED="QUESTIONS LOADED", LANGUAGE="LANGUAGE", LANGUAGE_VALUE="ENGLISH",
        CHANGE_LANGUAGE="A - CHANGE LANGUAGE", SETTINGS_HINT="UP/DOWN: SELECT  |  A: CHANGE",
        INFO_TITLE="QUIZLAB INFORMATION", INFO_VERSION="VERSION 1.0", INFO_HOST="HOST CONTROLS THE QUIZ",
        INFO_QUESTIONS="QUESTIONS: %s", INFO_COMMANDS="COMMANDS: /quiz, /quiz stop, /quiz next, /quiz score",
        QUIZ_POINTS="POINTS: %s", QUESTION="QUESTION %s/%s", INVALID_QUESTION="Invalid question.",
        CATEGORY_DEFAULT="Science", SELECT="A - SELECT", CLOSE="START - CLOSE",
        NEW_QUIZ="NEW QUIZ", RANDOM_QUESTION="RANDOM QUESTION", NEXT_QUESTION="NEXT QUESTION", STOP_QUIZ="STOP QUIZ",
        CHAT_HELP="start, stop, next or score", ERR_LOAD="QuizLab: could not load questions.",
        STARTED="QuizLab: quiz started!", NEW_STARTED="QuizLab: new quiz started!",
        STOPPED="QuizLab: quiz ended!", NEXT="QuizLab: next question!",
        CORRECT="QuizLab: CORRECT!", WRONG="QuizLab: WRONG!",
        LOGO_ERROR="[QuizLab] ERROR: texture 'QL_logo' was not loaded.",
        LOGO_CHECK="[QuizLab] Check that textures/QL_logo.png exists in the mod.",
        LOGO_OK="[QuizLab] Logo loaded: %s x %s"
    },
    pt = {
        TAB_QUIZ="QUIZ", TAB_SCORE="PLACAR", TAB_SETTINGS="CONFIGURACOES", TAB_INFO="INFORMACOES",
        PAUSED_TITLE="QUIZLAB - PAUSADO", POINTS="PONTOS: %s", SCORE_TITLE="CLASSIFICACAO",
        YOUR_SCORE="SUA PONTUACAO", PLAYER="JOGADOR", POINTS_COLUMN="PONTOS", BACK="B - VOLTAR",
        SETTINGS_TITLE="CONFIGURACOES", RESPONSE_MODE="MODO DE RESPOSTA", RESPONSE_CHAT="CHAT: A / B / C / D",
        SETTING_LANGUAGE="IDIOMA ATUAL: %s", SETTING_HUD_SIZE="TAMANHO DO HUD: %s", SETTING_LANGUAGE_VALUE="PORTUGUES",
        QUESTIONS_LOADED="PERGUNTAS CARREGADAS", LANGUAGE="IDIOMA", LANGUAGE_VALUE="PORTUGUES",
        CHANGE_LANGUAGE="A - ALTERAR IDIOMA", SETTINGS_HINT="CIMA/BAIXO: SELECIONAR  |  A: ALTERAR",
        INFO_TITLE="INFORMACOES DO QUIZLAB", INFO_VERSION="VERSAO 1.0", INFO_HOST="O HOST CONTROLA O QUIZ",
        INFO_QUESTIONS="PERGUNTAS: %s", INFO_COMMANDS="COMANDOS: /quiz, /quiz stop, /quiz next, /quiz score",
        QUIZ_POINTS="PONTOS: %s", QUESTION="PERGUNTA %s/%s", INVALID_QUESTION="Pergunta invalida.",
        CATEGORY_DEFAULT="Ciencias", SELECT="A - SELECIONAR", CLOSE="START - FECHAR",
        NEW_QUIZ="NOVO QUIZ", RANDOM_QUESTION="PERGUNTA ALEATORIA", NEXT_QUESTION="PROXIMA PERGUNTA", STOP_QUIZ="PARAR QUIZ",
        CHAT_HELP="start, stop, next ou score", ERR_LOAD="QuizLab: nao foi possivel carregar as perguntas.",
        STARTED="QuizLab: quiz iniciado!", NEW_STARTED="QuizLab: novo quiz iniciado!",
        STOPPED="QuizLab: quiz encerrado!", NEXT="QuizLab: proxima pergunta!",
        CORRECT="QuizLab: CORRETO!", WRONG="QuizLab: ERRADO!",
        LOGO_ERROR="[QuizLab] ERRO: textura 'QL_logo' nao carregada.",
        LOGO_CHECK="[QuizLab] Verifique se existe textures/QL_logo.png no mod.",
        LOGO_OK="[QuizLab] Logo carregada: %s x %s"
    }
}

-- Banco de perguntas: cada idioma possui a mesma ordem, respostas e indice correto.
local question_data = {
    en = {
        { question = "What is the smallest living unit that makes up living things?", answers = { "The cell", "The tissue", "The organ", "The system" }, correct = 1, category = "Cells" },
        { question = "Which part of the cell controls many of its activities?", answers = { "The membrane", "The nucleus", "The cytoplasm", "The cell wall" }, correct = 2, category = "Cells" },
        { question = "Which structure surrounds the cell and helps control what enters and leaves it?", answers = { "The nucleus", "The cell membrane", "The brain", "The blood" }, correct = 2, category = "Cells" },
        { question = "What do we call a group of similar cells that perform a function?", answers = { "Tissue", "Organ", "System", "Organism" }, correct = 1, category = "Cells" },
        { question = "What do we call a structure made of different tissues working together?", answers = { "Cell", "Organ", "Nucleus", "Neuron" }, correct = 2, category = "Human body" },
        { question = "Which system coordinates the body's movements, thoughts, and senses?", answers = { "Digestive system", "Nervous system", "Respiratory system", "Circulatory system" }, correct = 2, category = "Nervous system" },
        { question = "What is the main cell of the nervous system?", answers = { "Red blood cell", "Neuron", "Platelet", "Osteocyte" }, correct = 2, category = "Nervous system" },
        { question = "Which organ is the main control center of the nervous system?", answers = { "Heart", "Lung", "Brain", "Stomach" }, correct = 3, category = "Nervous system" },
        { question = "Which part of the nervous system is protected inside the spinal column?", answers = { "Spinal cord", "Lung", "Stomach", "Trachea" }, correct = 1, category = "Nervous system" },
        { question = "Which neuron structure receives signals from other cells?", answers = { "Dendrites", "Lungs", "Red blood cells", "Platelets" }, correct = 1, category = "Nervous system" },
        { question = "Which neuron structure carries nerve impulses to other cells?", answers = { "Axon", "Nucleus", "Membrane", "Ribosome" }, correct = 1, category = "Nervous system" },
        { question = "What do we call the communication between neurons?", answers = { "Digestion", "Synapse", "Circulation", "Respiration" }, correct = 2, category = "Nervous system" },
        { question = "Which sense allows us to perceive sounds?", answers = { "Sight", "Hearing", "Touch", "Taste" }, correct = 2, category = "Senses" },
        { question = "Which sense allows us to perceive lights, colors, and shapes?", answers = { "Smell", "Hearing", "Sight", "Touch" }, correct = 3, category = "Senses" },
        { question = "Which sense allows us to perceive smells?", answers = { "Smell", "Taste", "Hearing", "Sight" }, correct = 1, category = "Senses" },
        { question = "Which system transports blood throughout the body?", answers = { "Nervous system", "Circulatory system", "Digestive system", "Respiratory system" }, correct = 2, category = "Human body" },
        { question = "Which organ pumps blood throughout the body?", answers = { "Heart", "Brain", "Lung", "Kidney" }, correct = 1, category = "Human body" },
        { question = "Which system helps the body obtain oxygen from the air?", answers = { "Respiratory system", "Nervous system", "Digestive system", "Skeletal system" }, correct = 1, category = "Human body" },
        { question = "Which system breaks down food into nutrients the body can use?", answers = { "Nervous system", "Digestive system", "Circulatory system", "Skeletal system" }, correct = 2, category = "Human body" },
        { question = "Which system provides support and protection for the body?", answers = { "Skeletal system", "Digestive system", "Nervous system", "Respiratory system" }, correct = 1, category = "Human body" }
    },
    pt = {
        { question = "Qual e a menor unidade viva que forma os seres vivos?", answers = { "A celula", "O tecido", "O orgao", "O sistema" }, correct = 1, category = "Celulas" },
        { question = "Qual parte da celula controla muitas das suas atividades?", answers = { "A membrana", "O nucleo", "O citoplasma", "A parede celular" }, correct = 2, category = "Celulas" },
        { question = "Qual estrutura envolve a celula e ajuda a controlar o que entra e sai dela?", answers = { "O nucleo", "A membrana celular", "O cerebro", "O sangue" }, correct = 2, category = "Celulas" },
        { question = "Como chamamos um conjunto de celulas semelhantes que realizam uma funcao?", answers = { "Tecido", "Orgao", "Sistema", "Organismo" }, correct = 1, category = "Celulas" },
        { question = "Como chamamos uma estrutura formada por diferentes tecidos que trabalham juntos?", answers = { "Celula", "Orgao", "Nucleo", "Neuronio" }, correct = 2, category = "Corpo humano" },
        { question = "Qual sistema coordena os movimentos, pensamentos e sentidos do corpo?", answers = { "Sistema digestorio", "Sistema nervoso", "Sistema respiratorio", "Sistema circulatorio" }, correct = 2, category = "Sistema nervoso" },
        { question = "Qual e a principal celula do sistema nervoso?", answers = { "Hemacia", "Neuronio", "Plaqueta", "Osteocito" }, correct = 2, category = "Sistema nervoso" },
        { question = "Qual orgao e o principal centro de controle do sistema nervoso?", answers = { "Coracao", "Pulmao", "Cerebro", "Estomago" }, correct = 3, category = "Sistema nervoso" },
        { question = "Qual parte do sistema nervoso fica protegida dentro da coluna vertebral?", answers = { "Medula espinhal", "Pulmao", "Estomago", "Traqueia" }, correct = 1, category = "Sistema nervoso" },
        { question = "Qual estrutura do neuronio recebe sinais de outras celulas?", answers = { "Dendritos", "Pulmoes", "Hemacias", "Plaquetas" }, correct = 1, category = "Sistema nervoso" },
        { question = "Qual estrutura do neuronio conduz o impulso nervoso para outras celulas?", answers = { "Axonio", "Nucleo", "Membrana", "Ribossomo" }, correct = 1, category = "Sistema nervoso" },
        { question = "Como chamamos a comunicacao entre neuronios?", answers = { "Digestao", "Sinapse", "Circulacao", "Respiracao" }, correct = 2, category = "Sistema nervoso" },
        { question = "Qual sentido nos permite perceber sons?", answers = { "Visao", "Audicao", "Tato", "Paladar" }, correct = 2, category = "Sentidos" },
        { question = "Qual sentido nos permite perceber luzes, cores e formas?", answers = { "Olfato", "Audicao", "Visao", "Tato" }, correct = 3, category = "Sentidos" },
        { question = "Qual sentido nos permite perceber cheiros?", answers = { "Olfato", "Paladar", "Audicao", "Visao" }, correct = 1, category = "Sentidos" },
        { question = "Qual sistema transporta sangue pelo corpo?", answers = { "Sistema nervoso", "Sistema circulatorio", "Sistema digestorio", "Sistema respiratorio" }, correct = 2, category = "Corpo humano" },
        { question = "Qual orgao bombeia o sangue para o corpo?", answers = { "Coracao", "Cerebro", "Pulmao", "Rim" }, correct = 1, category = "Corpo humano" },
        { question = "Qual sistema ajuda o corpo a obter oxigenio do ar?", answers = { "Sistema respiratorio", "Sistema nervoso", "Sistema digestorio", "Sistema osseo" }, correct = 1, category = "Corpo humano" },
        { question = "Qual sistema transforma os alimentos em nutrientes que o corpo pode utilizar?", answers = { "Sistema nervoso", "Sistema digestorio", "Sistema circulatorio", "Sistema osseo" }, correct = 2, category = "Corpo humano" },
        { question = "Qual sistema da sustentacao e protecao ao corpo?", answers = { "Sistema osseo", "Sistema digestorio", "Sistema nervoso", "Sistema respiratorio" }, correct = 1, category = "Corpo humano" }
    }
}

function Language.set(code)
    if code == "pt" or code == "en" then current = code; return true end
    return false
end

function Language.get(key, ...)
    local value = strings[current][key] or strings.en[key] or key
    if select("#", ...) > 0 then return string.format(value, ...) end
    return value
end

function Language.get_current() return current end
function Language.toggle()
    current = current == "en" and "pt" or "en"
    return current
end
function Language.available() return { "en", "pt" } end

-- Retorna as perguntas no idioma ativo. Copia os dados para evitar que o mod
-- altere acidentalmente o banco original durante uma partida.
function Language.get_questions()
    local source = question_data[current] or question_data.en
    local result = {}
    for i, item in ipairs(source) do
        local answers = {}
        for j, answer in ipairs(item.answers) do
            answers[j] = answer
        end
        result[i] = {
            question = item.question,
            answers = answers,
            correct = item.correct,
            category = item.category
        }
    end
    return result
end

return Language
