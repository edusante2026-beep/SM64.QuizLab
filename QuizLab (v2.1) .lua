-- name: \\#00FF75\\QuizLab \\#9AFF27\\(v2.1)
-- description: \\#0F75\\QuizLab \\#\\ - Test your knowledge in SM64CoopDX!\n\n\\#0F9\\Random Questions\\#\\ and \\#FFD447\\Next Question\\#\\!\n\\#FF66CC\\Track your score\\#\\ and enjoy animated menus!\n\n\\#2AF\\Available in English and Portuguese.\n\\#AAA\\Made for SM64CoopDX 1.5.1.\n\n\\#FA3\\Play and learn!
-- Textos localizados da interface. O banco de perguntas fica em base.lua.
local Language = {}
local current = "en"
local strings = {
en = {
TAB_QUIZ="QUIZ", TAB_SCORE="LEADERBOARD", TAB_SETTINGS="SETTINGS", TAB_INFO="INFO",
PAUSED_TITLE="QUIZLAB - PAUSED", POINTS="POINTS: %s", SCORE_TITLE="LEADERBOARD",
YOUR_SCORE="YOUR SCORE", PLAYER="PLAYER", POINTS_COLUMN="POINTS", BACK="B - BACK",
SETTINGS_TITLE="SETTINGS", RESPONSE_MODE="ANSWER METHOD", RESPONSE_CHAT="CHAT: A / B / C / D",
SETTING_LANGUAGE="LANGUAGE: %s", SETTING_PAUSE_SIZE="PAUSE SIZE: %s", SCORE_SCROLL="UP/DOWN: SCROLL",
LANGUAGE_VALUE="ENGLISH", SETTING_PALETTE="COLOR PALETTE: %s", PALETTE_NORMAL="BLUE", PALETTE_INVERTED="GREEN",
SETTINGS_HINT="UP/DOWN: SELECT  |  A: CHANGE",
INFO_TITLE="QUIZLAB INFORMATION", INFO_VERSION="VERSION 2.1", INFO_HOST="HOST CONTROLS THE QUIZ",
INFO_QUESTIONS="QUESTIONS: %s", INFO_COMMANDS="COMMANDS: /quiz, /quiz stop, /quiz next, /quiz score",
QUIZ_POINTS="POINTS: %s", QUESTION="QUESTION %s/%s", INVALID_QUESTION="Invalid question.",
CATEGORY_DEFAULT="Science", SELECT="A - SELECT", CLOSE="START - CLOSE",
NEW_QUIZ="NEW QUIZ", RANDOM_QUESTION="RANDOM QUESTION", NEXT_QUESTION="NEXT QUESTION", STOP_QUIZ="STOP QUIZ",
CHAT_HELP="start, stop, next or score", ERR_LOAD="QuizLab: could not load questions.",
STARTED="QuizLab: quiz started!", NEW_STARTED="QuizLab: new quiz started!", STOPPED="QuizLab: quiz ended!", NEXT="QuizLab: next question!",
CORRECT="QuizLab: CORRECT!", WRONG="QuizLab: WRONG!",
},
pt = {
TAB_QUIZ="QUIZ", TAB_SCORE="PLACAR", TAB_SETTINGS="CONFIGURAÇÕES", TAB_INFO="INFORMAÇÕES",
PAUSED_TITLE="QUIZLAB - PAUSADO", POINTS="PONTOS: %s", SCORE_TITLE="CLASSIFICAÇÃO",
YOUR_SCORE="SUA PONTUACAO", PLAYER="JOGADOR", POINTS_COLUMN="PONTOS", BACK="B - VOLTAR",
SETTINGS_TITLE="CONFIGURAÇÕES", RESPONSE_MODE="MODO DE RESPOSTA", RESPONSE_CHAT="CHAT: A / B / C / D",
SETTING_LANGUAGE="IDIOMA: %s", SETTING_PAUSE_SIZE="TAMANHO DO PAUSE: %s", SCORE_SCROLL="CIMA/BAIXO: ROLAR",
LANGUAGE_VALUE="PORTUGUÊS", SETTING_PALETTE="PALETA DE CORES: %s", PALETTE_NORMAL="AZUL", PALETTE_INVERTED="VERDE",
SETTINGS_HINT="CIMA/BAIXO: SELECIONAR  |  A: ALTERAR",
INFO_TITLE="INFORMACOES DO QUIZLAB", INFO_VERSION="VERSAO 2.1", INFO_HOST="O HOST CONTROLA O QUIZ",
INFO_QUESTIONS="PERGUNTAS: %s", INFO_COMMANDS="COMANDOS: /quiz, /quiz stop, /quiz next, /quiz score",
QUIZ_POINTS="PONTOS: %s", QUESTION="PERGUNTA %s/%s", INVALID_QUESTION="Pergunta invalida.",
CATEGORY_DEFAULT="Ciências", SELECT="A - SELECIONAR", CLOSE="START - FECHAR",
NEW_QUIZ="NOVO QUIZ", RANDOM_QUESTION="PERGUNTA ALEATÓRIA", NEXT_QUESTION="PRÓXIMA PERGUNTA", STOP_QUIZ="PARAR QUIZ",
CHAT_HELP="start, stop, next ou score", ERR_LOAD="QuizLab: nao foi possivel carregar as perguntas.",
STARTED="QuizLab: quiz iniciado!", NEW_STARTED="QuizLab: novo quiz iniciado!", STOPPED="QuizLab: quiz encerrado!", NEXT="QuizLab: proxima pergunta!",
CORRECT="QuizLab: CORRETO!", WRONG="QuizLab: ERRADO!",
}
}
function Language.set(code) if code=="pt" or code=="en" then current=code; return true end return false end
function Language.get(key,...)
local value=(strings[current] and strings[current][key]) or strings.en[key] or key
if select("#",...)>0 then return string.format(value,...) end
return value
end
function Language.get_current() return current end
function Language.toggle() current=current=="en" and "pt" or "en"; return current end
function Language.available() return {"en","pt"} end
-- QuizLab v2.1 - base.lua
-- Banco revisado com 200 perguntas de Ciências do 6º ano, em português e inglês.
-- Cada pergunta possui tema, subtema, quatro alternativas, gabarito e dificuldade individual (0–200).
local question_data = {
{
question_pt="Qual é a menor unidade estrutural e funcional dos seres vivos?",
question_en="What is the smallest structural and functional unit of living things?",
answers_pt={"Organismo", "Tecido", "Célula", "Órgão"},
answers_en={"Organism", "Tissue", "Cell", "Organ"},
correct=3,
category_pt="Células e organização dos seres vivos", category_en="Cells and organization of living things",
subcategory_pt="Estrutura e funções celulares", subcategory_en="Cell structure and functions",
difficulty=0
},
{
question_pt="Que estrutura envolve a célula e controla a entrada e a saída de muitas substâncias?",
question_en="Which structure surrounds a cell and controls the entry and exit of many substances?",
answers_pt={"Núcleo", "Membrana celular", "Parede do estômago", "Citoplasma"},
answers_en={"Nucleus", "Cell membrane", "Stomach wall", "Cytoplasm"},
correct=2,
category_pt="Células e organização dos seres vivos", category_en="Cells and organization of living things",
subcategory_pt="Estrutura e funções celulares", subcategory_en="Cell structure and functions",
difficulty=1
},
{
question_pt="Em muitas células, qual estrutura contém o material genético e coordena atividades celulares?",
question_en="In many cells, which structure contains genetic material and coordinates cell activities?",
answers_pt={"Núcleo", "Vacúolo", "Membrana", "Parede celular"},
answers_en={"Nucleus", "Vacuole", "Membrane", "Cell wall"},
correct=1,
category_pt="Células e organização dos seres vivos", category_en="Cells and organization of living things",
subcategory_pt="Estrutura e funções celulares", subcategory_en="Cell structure and functions",
difficulty=2
},
{
question_pt="Como se chama a região interna da célula, geralmente gelatinosa, onde ficam várias estruturas celulares?",
question_en="What is the usually gel-like inner region of a cell, where many cell structures are found, called?",
answers_pt={"Esqueleto", "Citoplasma", "Tecido", "Epiderme"},
answers_en={"Skeleton", "Cytoplasm", "Tissue", "Epidermis"},
correct=2,
category_pt="Células e organização dos seres vivos", category_en="Cells and organization of living things",
subcategory_pt="Estrutura e funções celulares", subcategory_en="Cell structure and functions",
difficulty=3
},
{
question_pt="Qual estrutura rígida, presente em células vegetais, ajuda a proteger e sustentar a célula?",
question_en="Which rigid structure, found in plant cells, helps protect and support the cell?",
answers_pt={"Membrana do núcleo", "Parede celular", "Hemácia", "Dendrito"},
answers_en={"Nuclear membrane", "Cell wall", "Red blood cell", "Dendrite"},
correct=2,
category_pt="Células e organização dos seres vivos", category_en="Cells and organization of living things",
subcategory_pt="Estrutura e funções celulares", subcategory_en="Cell structure and functions",
difficulty=4
},
{
question_pt="Que estrutura das células vegetais contém clorofila e participa da fotossíntese?",
question_en="Which structure in plant cells contains chlorophyll and participates in photosynthesis?",
answers_pt={"Núcleo", "Lisossomo", "Mitocôndria", "Cloroplasto"},
answers_en={"Nucleus", "Lysosome", "Mitochondrion", "Chloroplast"},
correct=4,
category_pt="Células e organização dos seres vivos", category_en="Cells and organization of living things",
subcategory_pt="Estrutura e funções celulares", subcategory_en="Cell structure and functions",
difficulty=5
},
{
question_pt="Um organismo formado por uma única célula é classificado como:",
question_en="An organism made of a single cell is classified as:",
answers_pt={"Unicelular", "Vertebrado", "Inanimado", "Pluricelular"},
answers_en={"Unicellular", "Vertebrate", "Inanimate", "Multicellular"},
correct=1,
category_pt="Células e organização dos seres vivos", category_en="Cells and organization of living things",
subcategory_pt="Estrutura e funções celulares", subcategory_en="Cell structure and functions",
difficulty=6
},
{
question_pt="Uma árvore é formada por muitas células. Por isso, ela é um organismo:",
question_en="A tree is made of many cells. Therefore, it is a:",
answers_pt={"Pluricelular", "Unicelular", "Mineral", "Sem células"},
answers_en={"Multicellular", "Unicellular", "Mineral", "Cell-free"},
correct=1,
category_pt="Células e organização dos seres vivos", category_en="Cells and organization of living things",
subcategory_pt="Estrutura e funções celulares", subcategory_en="Cell structure and functions",
difficulty=7
},
{
question_pt="Como é chamado um conjunto de células semelhantes que desempenham uma função?",
question_en="What is a group of similar cells that perform a function called?",
answers_pt={"Tecido", "População", "Sistema", "Órgão"},
answers_en={"Tissue", "Population", "System", "Organ"},
correct=1,
category_pt="Células e organização dos seres vivos", category_en="Cells and organization of living things",
subcategory_pt="Estrutura e funções celulares", subcategory_en="Cell structure and functions",
difficulty=8
},
{
question_pt="O coração é formado por diferentes tecidos que atuam juntos. Ele é um exemplo de:",
question_en="The heart is made of different tissues that work together. It is an example of a:",
answers_pt={"Molécula", "Órgão", "Célula", "Organismo"},
answers_en={"Molecule", "Organ", "Cell", "Organism"},
correct=2,
category_pt="Células e organização dos seres vivos", category_en="Cells and organization of living things",
subcategory_pt="Estrutura e funções celulares", subcategory_en="Cell structure and functions",
difficulty=9
},
{
question_pt="Um conjunto de órgãos que trabalham de forma integrada forma:",
question_en="A group of organs that work together forms a:",
answers_pt={"Sistema", "Espécie", "Célula", "Tecido"},
answers_en={"System", "Species", "Cell", "Tissue"},
correct=1,
category_pt="Células e organização dos seres vivos", category_en="Cells and organization of living things",
subcategory_pt="Estrutura e funções celulares", subcategory_en="Cell structure and functions",
difficulty=10
},
{
question_pt="Qual sequência apresenta níveis de organização do corpo, do menor para o maior?",
question_en="Which sequence shows levels of body organization from smallest to largest?",
answers_pt={"Tecido, sistema, célula e órgão", "Sistema, órgão, tecido e célula", "Órgão, célula, sistema e tecido", "Célula, tecido, órgão e sistema"},
answers_en={"Tissue, system, cell, and organ", "System, organ, tissue, and cell", "Organ, cell, system, and tissue", "Cell, tissue, organ, and system"},
correct=4,
category_pt="Células e organização dos seres vivos", category_en="Cells and organization of living things",
subcategory_pt="Estrutura e funções celulares", subcategory_en="Cell structure and functions",
difficulty=11
},
{
question_pt="Qual instrumento permite observar células que não podem ser vistas a olho nu?",
question_en="Which instrument allows us to observe cells that cannot be seen with the naked eye?",
answers_pt={"Telescópio", "Barômetro", "Microscópio", "Termômetro"},
answers_en={"Telescope", "Barometer", "Microscope", "Thermometer"},
correct=3,
category_pt="Células e organização dos seres vivos", category_en="Cells and organization of living things",
subcategory_pt="Estrutura e funções celulares", subcategory_en="Cell structure and functions",
difficulty=12
},
{
question_pt="Por que uma pessoa usa uma lente de aumento ou um microscópio para estudar células?",
question_en="Why does a person use a magnifying lens or microscope to study cells?",
answers_pt={"Porque o instrumento cria células maiores", "Porque as células só existem no escuro", "Porque as células não refletem luz", "Porque muitas células são pequenas demais para serem vistas sem ampliação"},
answers_en={"Because the instrument creates larger cells", "Because cells exist only in darkness", "Because cells do not reflect light", "Because many cells are too small to be seen without magnification"},
correct=4,
category_pt="Células e organização dos seres vivos", category_en="Cells and organization of living things",
subcategory_pt="Estrutura e funções celulares", subcategory_en="Cell structure and functions",
difficulty=13
},
{
question_pt="As bactérias são exemplos de seres vivos que, em geral, possuem:",
question_en="Bacteria are examples of living things that generally have:",
answers_pt={"Uma única célula", "Sistemas de ossos", "Milhões de órgãos", "Tecidos vegetais"},
answers_en={"A single cell", "Bone systems", "Millions of organs", "Plant tissues"},
correct=1,
category_pt="Células e organização dos seres vivos", category_en="Cells and organization of living things",
subcategory_pt="Estrutura e funções celulares", subcategory_en="Cell structure and functions",
difficulty=14
},
{
question_pt="O fermento biológico usado em algumas receitas contém leveduras. Esses seres vivos são, em geral:",
question_en="Baker's yeast used in some recipes contains yeasts. These living things are generally:",
answers_pt={"Animais vertebrados", "Fungos unicelulares", "Plantas com flores", "Bactérias pluricelulares"},
answers_en={"Vertebrate animals", "Unicellular fungi", "Flowering plants", "Multicellular bacteria"},
correct=2,
category_pt="Células e organização dos seres vivos", category_en="Cells and organization of living things",
subcategory_pt="Estrutura e funções celulares", subcategory_en="Cell structure and functions",
difficulty=15
},
{
question_pt="Uma diferença comum entre células vegetais e animais é que as células vegetais possuem:",
question_en="A common difference between plant and animal cells is that plant cells have:",
answers_pt={"Parede celular e, muitas vezes, cloroplastos", "Hemoglobina em todas as células", "Apenas membrana e nenhum citoplasma", "Ossos e músculos"},
answers_en={"A cell wall and, often, chloroplasts", "Hemoglobin in every cell", "Only a membrane and no cytoplasm", "Bones and muscles"},
correct=1,
category_pt="Células e organização dos seres vivos", category_en="Cells and organization of living things",
subcategory_pt="Estrutura e funções celulares", subcategory_en="Cell structure and functions",
difficulty=16
},
{
question_pt="Ao observar uma amostra de água ao microscópio, uma estudante encontra seres formados por uma célula. O que ela observou?",
question_en="While observing a water sample under a microscope, a student finds organisms made of one cell. What did she observe?",
answers_pt={"Seres unicelulares", "Tecidos de uma árvore", "Órgãos isolados", "Rochas microscópicas vivas"},
answers_en={"Unicellular organisms", "Tissues from a tree", "Isolated organs", "Living microscopic rocks"},
correct=1,
category_pt="Células e organização dos seres vivos", category_en="Cells and organization of living things",
subcategory_pt="Estrutura e funções celulares", subcategory_en="Cell structure and functions",
difficulty=17
},
{
question_pt="Por que uma célula é considerada viva, e não apenas uma pequena parte de matéria?",
question_en="Why is a cell considered living rather than merely a small piece of matter?",
answers_pt={"Porque nunca muda", "Porque é feita de metal", "Porque é sempre visível sem instrumentos", "Porque realiza funções vitais, como obter e utilizar matéria e energia"},
answers_en={"Because it never changes", "Because it is made of metal", "Because it is always visible without instruments", "Because it carries out vital functions, such as obtaining and using matter and energy"},
correct=4,
category_pt="Células e organização dos seres vivos", category_en="Cells and organization of living things",
subcategory_pt="Estrutura e funções celulares", subcategory_en="Cell structure and functions",
difficulty=18
},
{
question_pt="Algumas bactérias não possuem núcleo organizado como o das células animais e vegetais. Isso significa que o material genético delas:",
question_en="Some bacteria do not have a nucleus organized like the one in animal and plant cells. This means their genetic material:",
answers_pt={"Fica dentro de um coração", "Fica em uma região do citoplasma", "É guardado em ossos", "Não existe"},
answers_en={"Is kept inside a heart", "Is found in a region of the cytoplasm", "Is stored in bones", "Does not exist"},
correct=2,
category_pt="Células e organização dos seres vivos", category_en="Cells and organization of living things",
subcategory_pt="Estrutura e funções celulares", subcategory_en="Cell structure and functions",
difficulty=19
},
{
question_pt="Qual é a principal função do sistema digestório?",
question_en="What is the main function of the digestive system?",
answers_pt={"Transformar alimentos e permitir a absorção de nutrientes", "Controlar a entrada de luz nos olhos", "Produzir os movimentos dos planetas", "Levar ar diretamente aos ossos"},
answers_en={"Break down food and allow nutrients to be absorbed", "Control the amount of light entering the eyes", "Produce the movements of planets", "Carry air directly to bones"},
correct=1,
category_pt="Corpo humano", category_en="Human body",
subcategory_pt="Órgãos e sistemas", subcategory_en="Organs and body systems",
difficulty=20
},
{
question_pt="Em qual parte do sistema digestório ocorre a maior parte da absorção dos nutrientes?",
question_en="In which part of the digestive system does most nutrient absorption occur?",
answers_pt={"Boca", "Esôfago", "Intestino delgado", "Intestino grosso"},
answers_en={"Mouth", "Esophagus", "Small intestine", "Large intestine"},
correct=3,
category_pt="Corpo humano", category_en="Human body",
subcategory_pt="Órgãos e sistemas", subcategory_en="Organs and body systems",
difficulty=21
},
{
question_pt="Qual é uma função importante do estômago durante a digestão?",
question_en="What is an important function of the stomach during digestion?",
answers_pt={"Bombear sangue para o corpo", "Produzir o ar que respiramos", "Misturar o alimento com o suco gástrico", "Filtrar o sangue e formar urina"},
answers_en={"Pump blood through the body", "Produce the air we breathe", "Mix food with gastric juice", "Filter blood and form urine"},
correct=3,
category_pt="Corpo humano", category_en="Human body",
subcategory_pt="Órgãos e sistemas", subcategory_en="Organs and body systems",
difficulty=22
},
{
question_pt="Como o alimento passa do esôfago até o estômago?",
question_en="How does food move from the esophagus to the stomach?",
answers_pt={"Por movimentos dos pulmões", "Por contrações musculares que empurram o alimento", "Por batimentos do coração", "Pela ação da luz solar"},
answers_en={"By lung movements", "By muscle contractions that push the food along", "By heartbeats", "Through sunlight"},
correct=2,
category_pt="Corpo humano", category_en="Human body",
subcategory_pt="Órgãos e sistemas", subcategory_en="Organs and body systems",
difficulty=23
},
{
question_pt="Qual órgão produz a bile, substância que auxilia na digestão das gorduras?",
question_en="Which organ produces bile, a substance that helps digest fats?",
answers_pt={"Fígado", "Rim", "Coração", "Pulmão"},
answers_en={"Liver", "Kidney", "Heart", "Lung"},
correct=1,
category_pt="Corpo humano", category_en="Human body",
subcategory_pt="Órgãos e sistemas", subcategory_en="Organs and body systems",
difficulty=24
},
{
question_pt="Em qual estrutura dos pulmões ocorre a troca de gases entre o ar e o sangue?",
question_en="In which lung structure does gas exchange between air and blood occur?",
answers_pt={"Traqueia", "Laringe", "Faringe", "Alvéolos pulmonares"},
answers_en={"Trachea", "Larynx", "Pharynx", "Lung alveoli"},
correct=4,
category_pt="Corpo humano", category_en="Human body",
subcategory_pt="Órgãos e sistemas", subcategory_en="Organs and body systems",
difficulty=25
},
{
question_pt="Qual músculo participa dos movimentos de inspiração e expiração, separando o tórax do abdômen?",
question_en="Which muscle participates in inhalation and exhalation and separates the chest from the abdomen?",
answers_pt={"Masseter", "Bíceps", "Diafragma", "Panturrilha"},
answers_en={"Masseter", "Biceps", "Diaphragm", "Calf muscle"},
correct=3,
category_pt="Corpo humano", category_en="Human body",
subcategory_pt="Órgãos e sistemas", subcategory_en="Organs and body systems",
difficulty=26
},
{
question_pt="Qual componente do sangue transporta grande parte do oxigênio?",
question_en="Which component of blood carries much of the oxygen?",
answers_pt={"Plaquetas", "Plasma apenas", "Hemácias", "Pele"},
answers_en={"Platelets", "Plasma alone", "Red blood cells", "Skin"},
correct=3,
category_pt="Corpo humano", category_en="Human body",
subcategory_pt="Órgãos e sistemas", subcategory_en="Organs and body systems",
difficulty=27
},
{
question_pt="Qual órgão funciona como uma bomba que impulsiona o sangue?",
question_en="Which organ acts as a pump that drives blood through the body?",
answers_pt={"Estômago", "Fígado", "Pâncreas", "Coração"},
answers_en={"Stomach", "Liver", "Pancreas", "Heart"},
correct=4,
category_pt="Corpo humano", category_en="Human body",
subcategory_pt="Órgãos e sistemas", subcategory_en="Organs and body systems",
difficulty=28
},
{
question_pt="Qual é a principal característica das artérias?",
question_en="What is the main characteristic of arteries?",
answers_pt={"Levam o sangue para fora do coração", "Conduzem alimentos ao estômago", "Produzem células de defesa", "Sempre transportam sangue sem oxigênio"},
answers_en={"Carry blood away from the heart", "Carry food to the stomach", "Produce defense cells", "Always carry blood without oxygen"},
correct=1,
category_pt="Corpo humano", category_en="Human body",
subcategory_pt="Órgãos e sistemas", subcategory_en="Organs and body systems",
difficulty=29
},
{
question_pt="O que acontece principalmente nos capilares sanguíneos?",
question_en="What mainly happens in blood capillaries?",
answers_pt={"Os ossos são produzidos", "O ar é filtrado pelos pelos do nariz", "Ocorrem trocas de substâncias entre o sangue e os tecidos", "O alimento é mastigado"},
answers_en={"Bones are produced", "Air is filtered by nose hairs", "Substances are exchanged between the blood and tissues", "Food is chewed"},
correct=3,
category_pt="Corpo humano", category_en="Human body",
subcategory_pt="Órgãos e sistemas", subcategory_en="Organs and body systems",
difficulty=30
},
{
question_pt="Quais órgãos filtram o sangue e participam da formação da urina?",
question_en="Which organs filter blood and take part in urine formation?",
answers_pt={"Rins", "Olhos", "Intestinos", "Pulmões"},
answers_en={"Kidneys", "Eyes", "Intestines", "Lungs"},
correct=1,
category_pt="Corpo humano", category_en="Human body",
subcategory_pt="Órgãos e sistemas", subcategory_en="Organs and body systems",
difficulty=31
},
{
question_pt="Qual sistema elimina, pela urina, parte dos resíduos produzidos pelo organismo?",
question_en="Which system removes some of the body's waste through urine?",
answers_pt={"Sistema urinário", "Sistema nervoso", "Sistema esquelético", "Sistema respiratório"},
answers_en={"Urinary system", "Nervous system", "Skeletal system", "Respiratory system"},
correct=1,
category_pt="Corpo humano", category_en="Human body",
subcategory_pt="Órgãos e sistemas", subcategory_en="Organs and body systems",
difficulty=32
},
{
question_pt="Qual é uma função essencial do esqueleto humano?",
question_en="What is an essential function of the human skeleton?",
answers_pt={"Absorver oxigênio do ar", "Sustentar o corpo e proteger órgãos internos", "Realizar a digestão dos alimentos", "Produzir os sons da voz"},
answers_en={"Absorb oxygen from the air", "Support the body and protect internal organs", "Digest food", "Produce the sounds of the voice"},
correct=2,
category_pt="Corpo humano", category_en="Human body",
subcategory_pt="Órgãos e sistemas", subcategory_en="Organs and body systems",
difficulty=33
},
{
question_pt="Qual estrutura óssea protege o cérebro?",
question_en="Which bony structure protects the brain?",
answers_pt={"Fêmur", "Crânio", "Pelve", "Costelas"},
answers_en={"Femur", "Skull", "Pelvis", "Ribs"},
correct=2,
category_pt="Corpo humano", category_en="Human body",
subcategory_pt="Órgãos e sistemas", subcategory_en="Organs and body systems",
difficulty=34
},
{
question_pt="Que conjunto de ossos protege órgãos como o coração e os pulmões?",
question_en="Which group of bones protects organs such as the heart and lungs?",
answers_pt={"Ossos dos dedos", "Vértebras lombares apenas", "Costelas", "Ossos do tornozelo"},
answers_en={"Finger bones", "Lumbar vertebrae alone", "Ribs", "Ankle bones"},
correct=3,
category_pt="Corpo humano", category_en="Human body",
subcategory_pt="Órgãos e sistemas", subcategory_en="Organs and body systems",
difficulty=35
},
{
question_pt="Como são chamadas as regiões onde dois ou mais ossos se encontram?",
question_en="What are the places where two or more bones meet called?",
answers_pt={"Sinapses", "Articulações", "Glândulas", "Alvéolos"},
answers_en={"Synapses", "Joints", "Glands", "Alveoli"},
correct=2,
category_pt="Corpo humano", category_en="Human body",
subcategory_pt="Órgãos e sistemas", subcategory_en="Organs and body systems",
difficulty=36
},
{
question_pt="De que maneira muitos músculos ajudam a movimentar os ossos?",
question_en="How do many muscles help move bones?",
answers_pt={"Eles se transformam em cartilagem", "Eles se contraem e puxam os ossos", "Eles bombeiam ar para o estômago", "Eles dissolvem os ossos"},
answers_en={"They turn into cartilage", "They contract and pull on bones", "They pump air into the stomach", "They dissolve bones"},
correct=2,
category_pt="Corpo humano", category_en="Human body",
subcategory_pt="Órgãos e sistemas", subcategory_en="Organs and body systems",
difficulty=37
},
{
question_pt="Qual função da pele ajuda a manter o equilíbrio do organismo?",
question_en="Which function of the skin helps maintain the body's balance?",
answers_pt={"Realizar a troca de gases nos alvéolos", "Controlar diretamente os movimentos dos planetas", "Participar da proteção e da regulação da temperatura", "Produzir a maior parte do sangue"},
answers_en={"Exchange gases in the alveoli", "Directly control the movements of planets", "Help protect the body and regulate temperature", "Produce most of the blood"},
correct=3,
category_pt="Corpo humano", category_en="Human body",
subcategory_pt="Órgãos e sistemas", subcategory_en="Organs and body systems",
difficulty=38
},
{
question_pt="Durante uma corrida, respiração e batimentos cardíacos aumentam. O que isso demonstra?",
question_en="During a run, breathing and heart rate increase. What does this show?",
answers_pt={"O sistema digestório deixa de existir", "Cada sistema trabalha sem relação com os outros", "Os sistemas do corpo atuam de forma integrada", "Os músculos não precisam de energia"},
answers_en={"The digestive system stops existing", "Each system works with no connection to the others", "The body's systems work together", "Muscles do not need energy"},
correct=3,
category_pt="Corpo humano", category_en="Human body",
subcategory_pt="Órgãos e sistemas", subcategory_en="Organs and body systems",
difficulty=39
},
{
question_pt="Em qual parte do olho se forma a imagem que dá origem aos sinais enviados ao cérebro?",
question_en="In which part of the eye is the image formed, giving rise to signals sent to the brain?",
answers_pt={"Íris", "Córnea apenas", "Retina", "Pálpebra"},
answers_en={"Iris", "Cornea alone", "Retina", "Eyelid"},
correct=3,
category_pt="Sistema nervoso e sentidos", category_en="Nervous system and senses",
subcategory_pt="Percepção e respostas do corpo", subcategory_en="Perception and body responses",
difficulty=40
},
{
question_pt="Qual é a função da pupila?",
question_en="What is the function of the pupil?",
answers_pt={"Permitir a entrada de luz no olho", "Produzir lágrimas", "Detectar sabores", "Transformar sons em sinais nervosos"},
answers_en={"Allow light to enter the eye", "Produce tears", "Detect flavors", "Turn sounds into nerve signals"},
correct=1,
category_pt="Sistema nervoso e sentidos", category_en="Nervous system and senses",
subcategory_pt="Percepção e respostas do corpo", subcategory_en="Perception and body responses",
difficulty=41
},
{
question_pt="A íris altera o tamanho da pupila. Com isso, ela ajuda a:",
question_en="The iris changes the size of the pupil. In doing so, it helps:",
answers_pt={"Controlar a circulação do sangue", "Focar sons no ouvido", "Produzir o líquido do estômago", "Regular a quantidade de luz que entra no olho"},
answers_en={"Control blood circulation", "Focus sounds in the ear", "Produce stomach fluid", "Regulate how much light enters the eye"},
correct=4,
category_pt="Sistema nervoso e sentidos", category_en="Nervous system and senses",
subcategory_pt="Percepção e respostas do corpo", subcategory_en="Perception and body responses",
difficulty=42
},
{
question_pt="Qual estrutura leva informações visuais da retina em direção ao cérebro?",
question_en="Which structure carries visual information from the retina toward the brain?",
answers_pt={"Tímpano", "Nervo óptico", "Esôfago", "Nervo olfatório"},
answers_en={"Eardrum", "Optic nerve", "Esophagus", "Olfactory nerve"},
correct=2,
category_pt="Sistema nervoso e sentidos", category_en="Nervous system and senses",
subcategory_pt="Percepção e respostas do corpo", subcategory_en="Perception and body responses",
difficulty=43
},
{
question_pt="Qual parte do ouvido vibra quando é atingida pelas ondas sonoras?",
question_en="Which part of the ear vibrates when struck by sound waves?",
answers_pt={"Íris", "Retina", "Tímpano", "Língua"},
answers_en={"Iris", "Retina", "Eardrum", "Tongue"},
correct=3,
category_pt="Sistema nervoso e sentidos", category_en="Nervous system and senses",
subcategory_pt="Percepção e respostas do corpo", subcategory_en="Perception and body responses",
difficulty=44
},
{
question_pt="Qual estrutura do ouvido interno transforma vibrações em sinais nervosos relacionados à audição?",
question_en="Which inner-ear structure converts vibrations into nerve signals related to hearing?",
answers_pt={"Epiderme", "Pupila", "Cóclea", "Faringe"},
answers_en={"Epidermis", "Pupil", "Cochlea", "Pharynx"},
correct=3,
category_pt="Sistema nervoso e sentidos", category_en="Nervous system and senses",
subcategory_pt="Percepção e respostas do corpo", subcategory_en="Perception and body responses",
difficulty=45
},
{
question_pt="Qual sentido permite perceber odores presentes no ar?",
question_en="Which sense allows us to detect odors in the air?",
answers_pt={"Tato", "Olfato", "Visão", "Audição"},
answers_en={"Touch", "Smell", "Sight", "Hearing"},
correct=2,
category_pt="Sistema nervoso e sentidos", category_en="Nervous system and senses",
subcategory_pt="Percepção e respostas do corpo", subcategory_en="Perception and body responses",
difficulty=46
},
{
question_pt="Que estruturas da língua participam da percepção dos sabores?",
question_en="Which structures on the tongue participate in the perception of flavors?",
answers_pt={"Plaquetas", "Papilas gustativas", "Alvéolos", "Dendritos do braço"},
answers_en={"Platelets", "Taste buds", "Alveoli", "Arm dendrites"},
correct=2,
category_pt="Sistema nervoso e sentidos", category_en="Nervous system and senses",
subcategory_pt="Percepção e respostas do corpo", subcategory_en="Perception and body responses",
difficulty=47
},
{
question_pt="A pele possui receptores que ajudam a perceber:",
question_en="The skin has receptors that help detect:",
answers_pt={"Toque, pressão e temperatura", "Apenas sons agudos", "A composição das estrelas", "Apenas cores"},
answers_en={"Touch, pressure, and temperature", "High-pitched sounds only", "The composition of stars", "Colors only"},
correct=1,
category_pt="Sistema nervoso e sentidos", category_en="Nervous system and senses",
subcategory_pt="Percepção e respostas do corpo", subcategory_en="Perception and body responses",
difficulty=48
},
{
question_pt="Depois que os olhos captam luz, por que o cérebro é importante para a visão?",
question_en="After the eyes detect light, why is the brain important for vision?",
answers_pt={"Porque substitui a retina", "Porque transforma o olho em lente", "Porque produz a luz que entra nos olhos", "Porque interpreta as informações recebidas"},
answers_en={"Because it replaces the retina", "Because it turns the eye into a lens", "Because it produces the light entering the eyes", "Because it interprets the information received"},
correct=4,
category_pt="Sistema nervoso e sentidos", category_en="Nervous system and senses",
subcategory_pt="Percepção e respostas do corpo", subcategory_en="Perception and body responses",
difficulty=49
},
{
question_pt="Qual estrutura conduz informações entre o encéfalo e várias partes do corpo, passando pelo interior da coluna vertebral?",
question_en="Which structure carries information between the brain and various parts of the body through the vertebral column?",
answers_pt={"Medula espinhal", "Aorta", "Traqueia", "Tendão"},
answers_en={"Spinal cord", "Aorta", "Trachea", "Tendon"},
correct=1,
category_pt="Sistema nervoso e sentidos", category_en="Nervous system and senses",
subcategory_pt="Percepção e respostas do corpo", subcategory_en="Perception and body responses",
difficulty=50
},
{
question_pt="Ao retirar rapidamente a mão de uma superfície muito quente, a pessoa realiza uma resposta que pode ocorrer antes de perceber conscientemente a dor. Essa resposta é chamada de:",
question_en="When quickly pulling a hand away from a very hot surface, a person performs a response that can occur before consciously noticing the pain. This response is called a:",
answers_pt={"Digestão", "Polinização", "Evaporação", "Reflexo"},
answers_en={"Digestion", "Pollination", "Evaporation", "Reflex"},
correct=4,
category_pt="Sistema nervoso e sentidos", category_en="Nervous system and senses",
subcategory_pt="Percepção e respostas do corpo", subcategory_en="Perception and body responses",
difficulty=51
},
{
question_pt="Qual situação representa uma ação voluntária?",
question_en="Which situation represents a voluntary action?",
answers_pt={"Decidir levantar a mão para responder", "O joelho reagir a um reflexo", "A pupila ajustar-se à luz", "O coração bater sem decisão consciente"},
answers_en={"Deciding to raise a hand to answer", "The knee reacting in a reflex", "The pupil adjusting to light", "The heart beating without a conscious decision"},
correct=1,
category_pt="Sistema nervoso e sentidos", category_en="Nervous system and senses",
subcategory_pt="Percepção e respostas do corpo", subcategory_en="Perception and body responses",
difficulty=52
},
{
question_pt="Qual órgão sensorial também participa da manutenção do equilíbrio corporal?",
question_en="Which sensory organ also helps maintain body balance?",
answers_pt={"Língua", "Retina", "Ouvido interno", "Pele da palma da mão"},
answers_en={"Tongue", "Retina", "Inner ear", "Skin on the palm"},
correct=3,
category_pt="Sistema nervoso e sentidos", category_en="Nervous system and senses",
subcategory_pt="Percepção e respostas do corpo", subcategory_en="Perception and body responses",
difficulty=53
},
{
question_pt="Por que alimentos parecem ter menos sabor quando estamos com o nariz congestionado?",
question_en="Why does food seem to have less flavor when our nose is congested?",
answers_pt={"Porque a língua deixa de ter papilas", "Porque os alimentos perdem todos os nutrientes", "Porque o ouvido controla o paladar", "Porque olfato e paladar trabalham juntos na percepção dos sabores"},
answers_en={"Because the tongue loses its taste buds", "Because food loses all its nutrients", "Because the ear controls taste", "Because smell and taste work together in flavor perception"},
correct=4,
category_pt="Sistema nervoso e sentidos", category_en="Nervous system and senses",
subcategory_pt="Percepção e respostas do corpo", subcategory_en="Perception and body responses",
difficulty=54
},
{
question_pt="Em um ambiente pouco iluminado, a pupila normalmente aumenta de tamanho. Qual é a vantagem disso?",
question_en="In a dimly lit environment, the pupil normally becomes larger. What is the advantage?",
answers_pt={"Aumentar a produção de sons", "Permitir a entrada de mais luz", "Melhorar a percepção de cheiros", "Impedir toda entrada de luz"},
answers_en={"Increase sound production", "Allow more light to enter", "Improve smell detection", "Prevent all light from entering"},
correct=2,
category_pt="Sistema nervoso e sentidos", category_en="Nervous system and senses",
subcategory_pt="Percepção e respostas do corpo", subcategory_en="Perception and body responses",
difficulty=55
},
{
question_pt="Quando passamos para um local muito iluminado, a pupila tende a diminuir. Essa mudança ajuda a:",
question_en="When we enter a brightly lit place, the pupil tends to become smaller. This change helps:",
answers_pt={"Transformar luz em som", "Impedir o funcionamento da retina", "Reduzir a quantidade de luz que entra no olho", "Aumentar a entrada de poeira no olho"},
answers_en={"Turn light into sound", "Prevent the retina from working", "Reduce the amount of light entering the eye", "Increase the amount of dust entering the eye"},
correct=3,
category_pt="Sistema nervoso e sentidos", category_en="Nervous system and senses",
subcategory_pt="Percepção e respostas do corpo", subcategory_en="Perception and body responses",
difficulty=56
},
{
question_pt="Por que é importante evitar exposição prolongada a sons muito altos?",
question_en="Why is it important to avoid prolonged exposure to very loud sounds?",
answers_pt={"Porque melhora a visão", "Porque fortalece sempre o tímpano", "Porque pode causar danos à audição", "Porque impede a circulação sanguínea"},
answers_en={"Because it improves vision", "Because it always strengthens the eardrum", "Because it can damage hearing", "Because it stops blood circulation"},
correct=3,
category_pt="Sistema nervoso e sentidos", category_en="Nervous system and senses",
subcategory_pt="Percepção e respostas do corpo", subcategory_en="Perception and body responses",
difficulty=57
},
{
question_pt="Uma pessoa vê um objeto se aproximando e se desvia. Qual sequência descreve melhor o processo?",
question_en="A person sees an object approaching and moves aside. Which sequence best describes the process?",
answers_pt={"O músculo percebe a luz e cria o objeto", "O estômago envia imagens diretamente à retina", "O sangue transforma o objeto em som", "Um estímulo é percebido, a informação é processada e ocorre uma resposta"},
answers_en={"The muscle detects light and creates the object", "The stomach sends images directly to the retina", "The blood turns the object into sound", "A stimulus is detected, the information is processed, and a response occurs"},
correct=4,
category_pt="Sistema nervoso e sentidos", category_en="Nervous system and senses",
subcategory_pt="Percepção e respostas do corpo", subcategory_en="Perception and body responses",
difficulty=58
},
{
question_pt="Por que os sentidos são importantes para a sobrevivência?",
question_en="Why are the senses important for survival?",
answers_pt={"Produzem alimento para o corpo", "Impedem qualquer mudança no ambiente", "Substituem todos os órgãos internos", "Ajudam o organismo a perceber mudanças e responder ao ambiente"},
answers_en={"They produce food for the body", "They prevent any change in the environment", "They replace all internal organs", "They help the organism detect changes and respond to the environment"},
correct=4,
category_pt="Sistema nervoso e sentidos", category_en="Nervous system and senses",
subcategory_pt="Percepção e respostas do corpo", subcategory_en="Perception and body responses",
difficulty=59
},
{
question_pt="O que é um ecossistema?",
question_en="What is an ecosystem?",
answers_pt={"Somente o solo de uma região", "O conjunto de seres vivos, elementos não vivos e suas interações", "Um grupo de indivíduos da mesma espécie", "Apenas os animais de uma floresta"},
answers_en={"Only the soil of an area", "The living things, nonliving components, and their interactions", "A group of individuals of the same species", "Only the animals in a forest"},
correct=2,
category_pt="Ecologia", category_en="Ecology",
subcategory_pt="Ecossistemas e relações alimentares", subcategory_en="Ecosystems and feeding relationships",
difficulty=60
},
{
question_pt="Como se chama o lugar onde um organismo vive e encontra recursos e condições para sobreviver?",
question_en="What is the place where an organism lives and finds the resources and conditions it needs called?",
answers_pt={"Cadeia mineral", "Clima global", "Hábitat", "Órgão"},
answers_en={"Mineral chain", "Global climate", "Habitat", "Organ"},
correct=3,
category_pt="Ecologia", category_en="Ecology",
subcategory_pt="Ecossistemas e relações alimentares", subcategory_en="Ecosystems and feeding relationships",
difficulty=61
},
{
question_pt="Um grupo de capivaras que vive na mesma região forma uma:",
question_en="A group of capybaras living in the same area forms a:",
answers_pt={"População", "Biosfera artificial", "Célula", "Comunidade de espécies diferentes"},
answers_en={"Population", "Artificial biosphere", "Cell", "Community of different species"},
correct=1,
category_pt="Ecologia", category_en="Ecology",
subcategory_pt="Ecossistemas e relações alimentares", subcategory_en="Ecosystems and feeding relationships",
difficulty=62
},
{
question_pt="Em uma lagoa, peixes, algas, insetos e sapos de espécies diferentes formam uma:",
question_en="In a pond, fish, algae, insects, and frogs of different species form a:",
answers_pt={"Rocha", "Espécie única", "População de uma espécie", "Comunidade"},
answers_en={"Rock", "Single species", "Population of one species", "Community"},
correct=4,
category_pt="Ecologia", category_en="Ecology",
subcategory_pt="Ecossistemas e relações alimentares", subcategory_en="Ecosystems and feeding relationships",
difficulty=63
},
{
question_pt="Qual alternativa apresenta apenas fatores bióticos de um ambiente?",
question_en="Which option lists only biotic factors in an environment?",
answers_pt={"Umidade, solo e luz solar", "Areia, vento e rochas", "Árvores, fungos e insetos", "Água, luz e temperatura"},
answers_en={"Humidity, soil, and sunlight", "Sand, wind, and rocks", "Trees, fungi, and insects", "Water, light, and temperature"},
correct=3,
category_pt="Ecologia", category_en="Ecology",
subcategory_pt="Ecossistemas e relações alimentares", subcategory_en="Ecosystems and feeding relationships",
difficulty=64
},
{
question_pt="Qual alternativa apresenta apenas fatores abióticos?",
question_en="Which option lists only abiotic factors?",
answers_pt={"Árvores, aves e bactérias", "Fungos, capim e minhocas", "Peixes, algas e insetos", "Água, luz solar e temperatura"},
answers_en={"Trees, birds, and bacteria", "Fungi, grass, and earthworms", "Fish, algae, and insects", "Water, sunlight, and temperature"},
correct=4,
category_pt="Ecologia", category_en="Ecology",
subcategory_pt="Ecossistemas e relações alimentares", subcategory_en="Ecosystems and feeding relationships",
difficulty=65
},
{
question_pt="Em uma cadeia alimentar, qual é o papel típico das plantas?",
question_en="In a food chain, what is the typical role of plants?",
answers_pt={"Predadoras de topo", "Decompositoras", "Produtoras", "Consumidoras secundárias"},
answers_en={"Top predators", "Decomposers", "Producers", "Secondary consumers"},
correct=3,
category_pt="Ecologia", category_en="Ecology",
subcategory_pt="Ecossistemas e relações alimentares", subcategory_en="Ecosystems and feeding relationships",
difficulty=66
},
{
question_pt="Como os consumidores obtêm matéria e energia?",
question_en="How do consumers obtain matter and energy?",
answers_pt={"Criando água do nada", "Produzindo luz solar", "Transformando rochas em clorofila", "Alimentando-se de outros seres vivos"},
answers_en={"By creating water from nothing", "By producing sunlight", "By turning rocks into chlorophyll", "By feeding on other living things"},
correct=4,
category_pt="Ecologia", category_en="Ecology",
subcategory_pt="Ecossistemas e relações alimentares", subcategory_en="Ecosystems and feeding relationships",
difficulty=67
},
{
question_pt="Qual é a importância dos decompositores, como muitos fungos e bactérias?",
question_en="Why are decomposers, such as many fungi and bacteria, important?",
answers_pt={"Decompõem restos orgânicos e devolvem nutrientes ao ambiente", "Transformam consumidores em minerais imediatamente", "Produzem todos os raios solares", "Impedem a reciclagem de nutrientes"},
answers_en={"They break down organic remains and return nutrients to the environment", "They immediately turn consumers into minerals", "They produce all sunlight", "They prevent nutrient recycling"},
correct=1,
category_pt="Ecologia", category_en="Ecology",
subcategory_pt="Ecossistemas e relações alimentares", subcategory_en="Ecosystems and feeding relationships",
difficulty=68
},
{
question_pt="Qual sequência forma uma cadeia alimentar simples e coerente?",
question_en="Which sequence forms a simple and coherent food chain?",
answers_pt={"Gafanhoto → cobra → capim → sapo", "Cobra → capim → sapo → Sol", "Sapo → Sol → capim → gafanhoto", "Capim → gafanhoto → sapo → cobra"},
answers_en={"Grasshopper → snake → grass → frog", "Snake → grass → frog → Sun", "Frog → Sun → grass → grasshopper", "Grass → grasshopper → frog → snake"},
correct=4,
category_pt="Ecologia", category_en="Ecology",
subcategory_pt="Ecossistemas e relações alimentares", subcategory_en="Ecosystems and feeding relationships",
difficulty=69
},
{
question_pt="Em uma cadeia alimentar, para onde aponta a seta entre o alimento e o consumidor?",
question_en="In a food chain, which way does the arrow between food and consumer point?",
answers_pt={"Do organismo que serve de alimento para aquele que o consome", "Do consumidor para o Sol", "Sempre para o produtor, sem considerar a alimentação", "Do predador para a rocha"},
answers_en={"From the organism being eaten to the organism that eats it", "From the consumer to the Sun", "Always toward the producer, regardless of feeding", "From the predator to the rock"},
correct=1,
category_pt="Ecologia", category_en="Ecology",
subcategory_pt="Ecossistemas e relações alimentares", subcategory_en="Ecosystems and feeding relationships",
difficulty=70
},
{
question_pt="Um animal que se alimenta principalmente de plantas é chamado de:",
question_en="An animal that feeds mainly on plants is called a:",
answers_pt={"Carnívoro", "Decompositor", "Herbívoro", "Produtor"},
answers_en={"Carnivore", "Decomposer", "Herbivore", "Producer"},
correct=3,
category_pt="Ecologia", category_en="Ecology",
subcategory_pt="Ecossistemas e relações alimentares", subcategory_en="Ecosystems and feeding relationships",
difficulty=71
},
{
question_pt="Um animal que se alimenta de outros animais é classificado como:",
question_en="An animal that feeds on other animals is classified as a:",
answers_pt={"Produtor", "Carnívoro", "Vegetal", "Herbívoro"},
answers_en={"Producer", "Carnivore", "Plant", "Herbivore"},
correct=2,
category_pt="Ecologia", category_en="Ecology",
subcategory_pt="Ecossistemas e relações alimentares", subcategory_en="Ecosystems and feeding relationships",
difficulty=72
},
{
question_pt="Um urso que pode comer frutos e animais é classificado como:",
question_en="A bear that can eat fruits and animals is classified as an:",
answers_pt={"Produtor", "Onívoro", "Herbívoro obrigatório", "Decompositor"},
answers_en={"Producer", "Omnivore", "Obligate herbivore", "Decomposer"},
correct=2,
category_pt="Ecologia", category_en="Ecology",
subcategory_pt="Ecossistemas e relações alimentares", subcategory_en="Ecosystems and feeding relationships",
difficulty=73
},
{
question_pt="Em uma relação de predação, qual é a função do predador?",
question_en="In a predation relationship, what is the predator's role?",
answers_pt={"Decompor rochas", "Capturar outro organismo para se alimentar", "Ser sempre menor que a presa", "Produzir seu alimento por fotossíntese"},
answers_en={"Decompose rocks", "Capture another organism for food", "Always be smaller than the prey", "Produce food through photosynthesis"},
correct=2,
category_pt="Ecologia", category_en="Ecology",
subcategory_pt="Ecossistemas e relações alimentares", subcategory_en="Ecosystems and feeding relationships",
difficulty=74
},
{
question_pt="Na relação entre uma onça e uma capivara quando a onça a caça, a capivara é:",
question_en="In the relationship between a jaguar and a capybara when the jaguar hunts it, the capybara is the:",
answers_pt={"Presa", "Fator abiótico", "Produtora", "Decompositora"},
answers_en={"Prey", "Abiotic factor", "Producer", "Decomposer"},
correct=1,
category_pt="Ecologia", category_en="Ecology",
subcategory_pt="Ecossistemas e relações alimentares", subcategory_en="Ecosystems and feeding relationships",
difficulty=75
},
{
question_pt="Por que uma região com grande variedade de espécies costuma ser considerada rica em biodiversidade?",
question_en="Why is an area with a wide variety of species considered rich in biodiversity?",
answers_pt={"Porque possui apenas uma espécie dominante", "Porque apresenta grande variedade de formas de vida", "Porque não ocorrem relações alimentares", "Porque não contém fatores abióticos"},
answers_en={"Because it has only one dominant species", "Because it contains a wide variety of life forms", "Because feeding relationships do not occur", "Because it has no abiotic factors"},
correct=2,
category_pt="Ecologia", category_en="Ecology",
subcategory_pt="Ecossistemas e relações alimentares", subcategory_en="Ecosystems and feeding relationships",
difficulty=76
},
{
question_pt="Se uma espécie invasora se espalha em um ambiente, qual consequência pode ocorrer?",
question_en="If an invasive species spreads through an environment, what consequence may occur?",
answers_pt={"Ela sempre aumenta todas as populações", "Ela pode competir com espécies nativas por recursos", "Ela impede qualquer relação ecológica", "Ela transforma fatores abióticos em animais"},
answers_en={"It always increases every population", "It may compete with native species for resources", "It prevents all ecological relationships", "It turns abiotic factors into animals"},
correct=2,
category_pt="Ecologia", category_en="Ecology",
subcategory_pt="Ecossistemas e relações alimentares", subcategory_en="Ecosystems and feeding relationships",
difficulty=77
},
{
question_pt="O que poderia acontecer com o solo de uma floresta se os decompositores desaparecessem?",
question_en="What could happen to forest soil if decomposers disappeared?",
answers_pt={"A fotossíntese passaria a ocorrer sem luz", "A decomposição de restos orgânicos diminuiria e a reciclagem de nutrientes seria prejudicada", "As rochas deixariam de existir", "Todos os animais se tornariam produtores"},
answers_en={"Photosynthesis would begin occurring without light", "The breakdown of organic remains would decrease and nutrient recycling would be harmed", "Rocks would cease to exist", "All animals would become producers"},
correct=2,
category_pt="Ecologia", category_en="Ecology",
subcategory_pt="Ecossistemas e relações alimentares", subcategory_en="Ecosystems and feeding relationships",
difficulty=78
},
{
question_pt="Em uma área, a redução intensa de predadores pode aumentar inicialmente o número de presas. Por que isso pode afetar as plantas?",
question_en="In an area, a major reduction in predators may initially increase the number of prey. Why can this affect plants?",
answers_pt={"Mais herbívoros podem consumir uma quantidade maior de vegetação", "A vegetação deixa de precisar de luz", "Os predadores eram a única fonte de água das plantas", "As presas passam a realizar fotossíntese"},
answers_en={"More herbivores may consume a larger amount of vegetation", "Vegetation no longer needs light", "Predators were the plants' only source of water", "The prey begin performing photosynthesis"},
correct=1,
category_pt="Ecologia", category_en="Ecology",
subcategory_pt="Ecossistemas e relações alimentares", subcategory_en="Ecosystems and feeding relationships",
difficulty=79
},
{
question_pt="Qual processo permite que plantas, algas e alguns microrganismos produzam matéria orgânica usando energia luminosa?",
question_en="Which process allows plants, algae, and some microorganisms to produce organic matter using light energy?",
answers_pt={"Combustão", "Digestão", "Fermentação animal", "Fotossíntese"},
answers_en={"Combustion", "Digestion", "Animal fermentation", "Photosynthesis"},
correct=4,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Plantas e seus processos", subcategory_en="Plants and their processes",
difficulty=80
},
{
question_pt="Qual gás as plantas utilizam como fonte de carbono durante a fotossíntese?",
question_en="Which gas do plants use as a carbon source during photosynthesis?",
answers_pt={"Hidrogênio puro", "Hélio", "Nitrogênio", "Gás carbônico"},
answers_en={"Pure hydrogen", "Helium", "Nitrogen", "Carbon dioxide"},
correct=4,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Plantas e seus processos", subcategory_en="Plants and their processes",
difficulty=81
},
{
question_pt="Qual é a principal fonte de energia usada na fotossíntese da maioria das plantas?",
question_en="What is the main energy source used in photosynthesis by most plants?",
answers_pt={"Energia dos ventos diretamente", "Calor do centro da Terra", "Som do ambiente", "Luz solar"},
answers_en={"Wind energy directly", "Heat from Earth's core", "Environmental sound", "Sunlight"},
correct=4,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Plantas e seus processos", subcategory_en="Plants and their processes",
difficulty=82
},
{
question_pt="Qual é uma função importante das raízes?",
question_en="What is an important function of roots?",
answers_pt={"Captar oxigênio diretamente dos alvéolos", "Realizar a maior parte da polinização", "Absorver água e sais minerais do solo", "Produzir sons para atrair insetos"},
answers_en={"Capture oxygen directly from alveoli", "Carry out most pollination", "Absorb water and mineral salts from the soil", "Produce sounds to attract insects"},
correct=3,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Plantas e seus processos", subcategory_en="Plants and their processes",
difficulty=83
},
{
question_pt="Qual é uma função comum do caule nas plantas?",
question_en="What is a common function of a plant stem?",
answers_pt={"Absorver luz com os olhos", "Substituir todas as raízes", "Sustentar partes da planta e transportar substâncias", "Produzir sementes em todos os casos"},
answers_en={"Absorb light with eyes", "Replace all roots", "Support plant parts and transport substances", "Produce seeds in every case"},
correct=3,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Plantas e seus processos", subcategory_en="Plants and their processes",
difficulty=84
},
{
question_pt="Que estrutura das folhas permite trocas gasosas com o ambiente?",
question_en="Which leaf structure allows gas exchange with the environment?",
answers_pt={"Articulações", "Alvéolos", "Estômatos", "Escamas"},
answers_en={"Joints", "Alveoli", "Stomata", "Scales"},
correct=3,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Plantas e seus processos", subcategory_en="Plants and their processes",
difficulty=85
},
{
question_pt="Como se chama a perda de água em forma de vapor pelas partes aéreas da planta, especialmente pelas folhas?",
question_en="What is the loss of water as vapor from the aerial parts of a plant, especially its leaves, called?",
answers_pt={"Fecundação", "Germinação", "Polinização", "Transpiração"},
answers_en={"Fertilization", "Germination", "Pollination", "Transpiration"},
correct=4,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Plantas e seus processos", subcategory_en="Plants and their processes",
difficulty=86
},
{
question_pt="Qual substância dá a muitas folhas sua cor verde e absorve luz para a fotossíntese?",
question_en="Which substance gives many leaves their green color and absorbs light for photosynthesis?",
answers_pt={"Queratina", "Hemoglobina", "Clorofila", "Amido animal"},
answers_en={"Keratin", "Hemoglobin", "Chlorophyll", "Animal starch"},
correct=3,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Plantas e seus processos", subcategory_en="Plants and their processes",
difficulty=87
},
{
question_pt="Quais são dois produtos importantes da fotossíntese?",
question_en="What are two important products of photosynthesis?",
answers_pt={"Açúcares e oxigênio", "Sal e gás hélio", "Proteínas e fumaça", "Areia e gás nitrogênio"},
answers_en={"Sugars and oxygen", "Salt and helium gas", "Proteins and smoke", "Sand and nitrogen gas"},
correct=1,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Plantas e seus processos", subcategory_en="Plants and their processes",
difficulty=88
},
{
question_pt="Por que a maioria das plantas precisa transportar água das raízes até as folhas?",
question_en="Why do most plants need to transport water from their roots to their leaves?",
answers_pt={"Porque a água participa da fotossíntese e de outras funções", "Porque as folhas produzem água a partir de rochas", "Porque a água substitui a luz solar", "Porque a água é usada apenas para dar cor às flores"},
answers_en={"Because water participates in photosynthesis and other functions", "Because leaves produce water from rocks", "Because water replaces sunlight", "Because water is used only to color flowers"},
correct=1,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Plantas e seus processos", subcategory_en="Plants and their processes",
difficulty=89
},
{
question_pt="O que é polinização nas plantas com flores?",
question_en="What is pollination in flowering plants?",
answers_pt={"Transferência do pólen até a parte receptora da flor", "Formação do solo a partir de rochas", "Transformação de uma folha em fruto", "Absorção de água pelas raízes"},
answers_en={"Transfer of pollen to the receiving part of a flower", "Formation of soil from rocks", "Transformation of a leaf into a fruit", "Absorption of water by roots"},
correct=1,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Plantas e seus processos", subcategory_en="Plants and their processes",
difficulty=90
},
{
question_pt="Em muitas flores, para onde o grão de pólen precisa ser levado para que a reprodução possa prosseguir?",
question_en="In many flowers, where must a pollen grain be carried for reproduction to proceed?",
answers_pt={"Raiz", "Caule subterrâneo", "Ponta da folha", "Estigma"},
answers_en={"Root", "Underground stem", "Leaf tip", "Stigma"},
correct=4,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Plantas e seus processos", subcategory_en="Plants and their processes",
difficulty=91
},
{
question_pt="Após a fecundação em uma planta com flor, o óvulo geralmente se desenvolve e origina:",
question_en="After fertilization in a flowering plant, the ovule usually develops into a:",
answers_pt={"Estômato", "Semente", "Raiz adulta", "Folha"},
answers_en={"Stoma", "Seed", "Adult root", "Leaf"},
correct=2,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Plantas e seus processos", subcategory_en="Plants and their processes",
difficulty=92
},
{
question_pt="Qual é uma função comum do fruto nas plantas com flores?",
question_en="What is a common function of fruit in flowering plants?",
answers_pt={"Absorver luz no lugar das folhas", "Impedir a formação de sementes", "Produzir raízes para todas as plantas", "Proteger sementes e, em muitos casos, ajudar na dispersão"},
answers_en={"Absorb light instead of leaves", "Prevent seeds from forming", "Produce roots for all plants", "Protect seeds and, in many cases, help with their dispersal"},
correct=4,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Plantas e seus processos", subcategory_en="Plants and their processes",
difficulty=93
},
{
question_pt="Uma semente começa a germinar quando encontra condições adequadas. Qual conjunto é geralmente necessário?",
question_en="A seed begins to germinate when it finds suitable conditions. Which set is generally needed?",
answers_pt={"Apenas luz intensa e areia seca", "Som alto e solo congelado", "Água, oxigênio e temperatura adequada", "Sal, óleo e ausência de ar"},
answers_en={"Only intense light and dry sand", "Loud sound and frozen soil", "Water, oxygen, and a suitable temperature", "Salt, oil, and no air"},
correct=3,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Plantas e seus processos", subcategory_en="Plants and their processes",
difficulty=94
},
{
question_pt="Como é chamada a fase inicial de desenvolvimento de uma planta que acaba de germinar?",
question_en="What is the early development stage of a newly germinated plant called?",
answers_pt={"Esporo animal", "Larva", "Presa", "Plântula"},
answers_en={"Animal spore", "Larva", "Prey", "Seedling"},
correct=4,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Plantas e seus processos", subcategory_en="Plants and their processes",
difficulty=95
},
{
question_pt="Qual forma de reprodução permite que algumas plantas originem novas plantas a partir de caules, folhas ou raízes, sem formação de sementes?",
question_en="Which form of reproduction allows some plants to produce new plants from stems, leaves, or roots without forming seeds?",
answers_pt={"Fecundação animal", "Polinização cruzada obrigatória", "Reprodução vegetativa", "Metamorfose"},
answers_en={"Animal fertilization", "Obligatory cross-pollination", "Vegetative reproduction", "Metamorphosis"},
correct=3,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Plantas e seus processos", subcategory_en="Plants and their processes",
difficulty=96
},
{
question_pt="Por que os caules de alguns cactos são grossos e suculentos?",
question_en="Why are the stems of some cacti thick and succulent?",
answers_pt={"Porque transformam areia em alimento sem energia", "Porque servem para respirar no fundo do mar", "Porque armazenam água, ajudando a planta em ambientes secos", "Porque substituem a necessidade de luz"},
answers_en={"Because they turn sand into food without energy", "Because they are used to breathe on the seafloor", "Because they store water, helping the plant in dry environments", "Because they replace the need for light"},
correct=3,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Plantas e seus processos", subcategory_en="Plants and their processes",
difficulty=97
},
{
question_pt="Como folhas largas e flutuantes podem ajudar algumas plantas aquáticas?",
question_en="How can broad floating leaves help some aquatic plants?",
answers_pt={"Aumentam a área exposta à luz e facilitam trocas com o ar", "Substituem as raízes em todas as espécies", "Permitem andar sobre o fundo", "Impedem qualquer contato com a água"},
answers_en={"They increase the area exposed to light and help with gas exchange", "They replace roots in every species", "They allow the plant to walk along the bottom", "They prevent any contact with water"},
correct=1,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Plantas e seus processos", subcategory_en="Plants and their processes",
difficulty=98
},
{
question_pt="Uma planta cresce inclinada em direção a uma janela iluminada. Esse crescimento orientado pela luz é chamado de:",
question_en="A plant grows tilted toward a bright window. This growth oriented by light is called:",
answers_pt={"Predação", "Erosão", "Condensação", "Fototropismo"},
answers_en={"Predation", "Erosion", "Condensation", "Phototropism"},
correct=4,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Plantas e seus processos", subcategory_en="Plants and their processes",
difficulty=99
},
{
question_pt="Qual característica define os animais vertebrados?",
question_en="Which characteristic defines vertebrate animals?",
answers_pt={"Possuem sempre seis patas", "Vivem apenas na água", "Possuem coluna vertebral", "Produzem alimento por fotossíntese"},
answers_en={"They always have six legs", "They live only in water", "They have a backbone", "They produce food through photosynthesis"},
correct=3,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Animais, classificação e adaptações", subcategory_en="Animals, classification, and adaptations",
difficulty=101
},
{
question_pt="Animais como minhocas, águas-vivas e insetos são agrupados como invertebrados porque:",
question_en="Animals such as earthworms, jellyfish, and insects are grouped as invertebrates because:",
answers_pt={"Têm esqueleto interno ósseo", "Não possuem coluna vertebral", "Possuem penas", "São todos microscópicos"},
answers_en={"They have an internal bony skeleton", "They do not have a backbone", "They have feathers", "They are all microscopic"},
correct=2,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Animais, classificação e adaptações", subcategory_en="Animals, classification, and adaptations",
difficulty=102
},
{
question_pt="Qual característica é típica dos mamíferos?",
question_en="Which characteristic is typical of mammals?",
answers_pt={"As fêmeas possuem glândulas mamárias que produzem leite", "Todos respiram por brânquias", "Todos têm penas", "Todos botam ovos com casca"},
answers_en={"Females have mammary glands that produce milk", "They all breathe through gills", "They all have feathers", "They all lay hard-shelled eggs"},
correct=1,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Animais, classificação e adaptações", subcategory_en="Animals, classification, and adaptations",
difficulty=103
},
{
question_pt="Qual característica exclusiva das aves é uma cobertura corporal formada por:",
question_en="Which distinctive body covering is characteristic of birds?",
answers_pt={"Concha externa", "Pelos", "Escamas úmidas", "Penas"},
answers_en={"External shell", "Hair", "Moist scales", "Feathers"},
correct=4,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Animais, classificação e adaptações", subcategory_en="Animals, classification, and adaptations",
difficulty=104
},
{
question_pt="Como a maioria dos peixes obtém oxigênio dissolvido na água?",
question_en="How do most fish obtain oxygen dissolved in water?",
answers_pt={"Pela pele seca e impermeável", "Pelos pulmões como os mamíferos terrestres", "Por meio das brânquias", "Por folhas modificadas"},
answers_en={"Through dry, waterproof skin", "Through lungs like terrestrial mammals", "Through their gills", "Through modified leaves"},
correct=3,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Animais, classificação e adaptações", subcategory_en="Animals, classification, and adaptations",
difficulty=105
},
{
question_pt="Qual característica é comum aos anfíbios, como sapos e salamandras?",
question_en="Which characteristic is common to amphibians such as frogs and salamanders?",
answers_pt={"Respiram exclusivamente por brânquias durante toda a vida", "A pele geralmente é fina e precisa permanecer úmida", "Possuem seis patas", "O corpo é coberto por penas"},
answers_en={"They breathe exclusively through gills throughout life", "Their skin is generally thin and needs to remain moist", "They have six legs", "Their bodies are covered in feathers"},
correct=2,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Animais, classificação e adaptações", subcategory_en="Animals, classification, and adaptations",
difficulty=106
},
{
question_pt="Qual característica ajuda a identificar muitos répteis?",
question_en="Which characteristic helps identify many reptiles?",
answers_pt={"Corpo formado por uma única célula", "Pele sempre úmida e sem proteção", "Pele coberta por escamas secas", "Penas que cobrem todo o corpo"},
answers_en={"A body made of a single cell", "Always moist, unprotected skin", "Skin covered with dry scales", "Feathers covering the whole body"},
correct=3,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Animais, classificação e adaptações", subcategory_en="Animals, classification, and adaptations",
difficulty=107
},
{
question_pt="Quantas pernas um inseto adulto normalmente possui?",
question_en="How many legs does an adult insect normally have?",
answers_pt={"Dez", "Quatro", "Seis", "Oito"},
answers_en={"Ten", "Four", "Six", "Eight"},
correct=3,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Animais, classificação e adaptações", subcategory_en="Animals, classification, and adaptations",
difficulty=108
},
{
question_pt="Qual característica diferencia as aranhas dos insetos?",
question_en="Which characteristic distinguishes spiders from insects?",
answers_pt={"Aranhas têm penas", "Aranhas possuem seis pernas e asas", "Aranhas adultas geralmente têm oito pernas", "Aranhas são plantas carnívoras"},
answers_en={"Spiders have feathers", "Spiders have six legs and wings", "Adult spiders generally have eight legs", "Spiders are carnivorous plants"},
correct=3,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Animais, classificação e adaptações", subcategory_en="Animals, classification, and adaptations",
difficulty=109
},
{
question_pt="Caranguejos e camarões pertencem a um grupo de artrópodes chamado:",
question_en="Crabs and shrimp belong to an arthropod group called:",
answers_pt={"Crustáceos", "Anfíbios", "Anelídeos", "Mamíferos"},
answers_en={"Crustaceans", "Amphibians", "Annelids", "Mammals"},
correct=1,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Animais, classificação e adaptações", subcategory_en="Animals, classification, and adaptations",
difficulty=110
},
{
question_pt="Qual sequência representa corretamente a metamorfose completa de uma borboleta?",
question_en="Which sequence correctly represents the complete metamorphosis of a butterfly?",
answers_pt={"Lagarta, ovo, adulto e pupa", "Ovo, lagarta, pupa e adulto", "Ovo, adulto, pupa e lagarta", "Pupa, adulto, ovo e lagarta"},
answers_en={"Caterpillar, egg, adult, and pupa", "Egg, caterpillar, pupa, and adult", "Egg, adult, pupa, and caterpillar", "Pupa, adult, egg, and caterpillar"},
correct=2,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Animais, classificação e adaptações", subcategory_en="Animals, classification, and adaptations",
difficulty=111
},
{
question_pt="Por que o girino de muitas espécies de sapos possui cauda e brânquias?",
question_en="Why does the tadpole of many frog species have a tail and gills?",
answers_pt={"Porque precisa voar antes de virar adulto", "Porque já é um mamífero terrestre", "Porque realiza fotossíntese", "Porque vive na água e sua forma corporal é adaptada a essa fase"},
answers_en={"Because it must fly before becoming an adult", "Because it is already a terrestrial mammal", "Because it performs photosynthesis", "Because it lives in water and its body is adapted to that life stage"},
correct=4,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Animais, classificação e adaptações", subcategory_en="Animals, classification, and adaptations",
difficulty=112
},
{
question_pt="Pés com membranas entre os dedos podem ajudar patos a:",
question_en="Feet with webbing between the toes can help ducks:",
answers_pt={"Escalar paredes lisas", "Empurrar a água e nadar", "Enxergar no escuro", "Cavar rochas sólidas"},
answers_en={"Climb smooth walls", "Push against water and swim", "See in the dark", "Dig through solid rock"},
correct=2,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Animais, classificação e adaptações", subcategory_en="Animals, classification, and adaptations",
difficulty=113
},
{
question_pt="A camada de gordura sob a pele de muitos mamíferos polares ajuda principalmente a:",
question_en="The layer of fat beneath the skin of many polar mammals mainly helps them:",
answers_pt={"Aumentar a perda de água pelas folhas", "Produzir luz", "Reduzir a perda de calor", "Transformar o gelo em alimento"},
answers_en={"Increase water loss through leaves", "Produce light", "Reduce heat loss", "Turn ice into food"},
correct=3,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Animais, classificação e adaptações", subcategory_en="Animals, classification, and adaptations",
difficulty=114
},
{
question_pt="Por que alguns animais migram em determinadas épocas do ano?",
question_en="Why do some animals migrate at certain times of the year?",
answers_pt={"Para se transformar em outra espécie", "Para encontrar alimento, locais de reprodução ou condições mais favoráveis", "Porque a gravidade desaparece", "Porque deixam de precisar de água"},
answers_en={"To turn into another species", "To find food, breeding areas, or more favorable conditions", "Because gravity disappears", "Because they no longer need water"},
correct=2,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Animais, classificação e adaptações", subcategory_en="Animals, classification, and adaptations",
difficulty=115
},
{
question_pt="A coloração que ajuda um animal a se confundir com o ambiente é um exemplo de:",
question_en="Coloring that helps an animal blend into its surroundings is an example of:",
answers_pt={"Germinação", "Camuflagem", "Fossilização", "Condensação"},
answers_en={"Germination", "Camouflage", "Fossilization", "Condensation"},
correct=2,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Animais, classificação e adaptações", subcategory_en="Animals, classification, and adaptations",
difficulty=116
},
{
question_pt="Como abelhas podem contribuir para a reprodução de muitas plantas?",
question_en="How can bees contribute to the reproduction of many plants?",
answers_pt={"Transportando pólen entre flores", "Transformando folhas em raízes", "Produzindo sementes dentro do solo", "Impedindo a fecundação"},
answers_en={"By carrying pollen between flowers", "By turning leaves into roots", "By producing seeds inside the soil", "By preventing fertilization"},
correct=1,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Animais, classificação e adaptações", subcategory_en="Animals, classification, and adaptations",
difficulty=117
},
{
question_pt="Um animal que se alimenta tanto de sementes quanto de pequenos insetos é classificado como:",
question_en="An animal that feeds on both seeds and small insects is classified as a:",
answers_pt={"Produtor", "Onívoro", "Decompositor", "Carnívoro estrito"},
answers_en={"Producer", "Omnivore", "Decomposer", "Strict carnivore"},
correct=2,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Animais, classificação e adaptações", subcategory_en="Animals, classification, and adaptations",
difficulty=118
},
{
question_pt="Um peixe possui corpo alongado e nadadeiras. Como essas características ajudam sua sobrevivência?",
question_en="A fish has a streamlined body and fins. How do these features help it survive?",
answers_pt={"Permitem respirar fora da água por longos períodos", "Facilitam o deslocamento e a direção na água", "Produzem alimento usando luz", "Impedem qualquer movimento"},
answers_en={"They allow it to breathe out of water for long periods", "They make movement and steering in water easier", "They produce food using light", "They prevent all movement"},
correct=2,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Animais, classificação e adaptações", subcategory_en="Animals, classification, and adaptations",
difficulty=119
},
{
question_pt="Por que a classificação dos animais considera características compartilhadas, e não apenas o local onde vivem?",
question_en="Why does animal classification consider shared characteristics rather than only where animals live?",
answers_pt={"Porque animais de ambientes diferentes podem pertencer ao mesmo grupo evolutivo", "Porque todos os animais de um mesmo lugar são da mesma espécie", "Porque animais aquáticos não têm parentesco com animais terrestres", "Porque o hábitat determina sozinho a estrutura corporal"},
answers_en={"Because animals from different environments can belong to the same evolutionary group", "Because all animals in one place are the same species", "Because aquatic animals are unrelated to terrestrial animals", "Because habitat alone determines body structure"},
correct=1,
category_pt="Seres vivos", category_en="Living things",
subcategory_pt="Animais, classificação e adaptações", subcategory_en="Animals, classification, and adaptations",
difficulty=120
},
{
question_pt="Onde está localizada a maior parte da água existente na superfície da Terra?",
question_en="Where is most of the water on Earth's surface located?",
answers_pt={"Nos oceanos", "Na atmosfera", "Nos lagos de água doce", "Nos rios"},
answers_en={"In the oceans", "In the atmosphere", "In freshwater lakes", "In rivers"},
correct=1,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Água e ciclo da água", subcategory_en="Water and the water cycle",
difficulty=121
},
{
question_pt="Como se chama a transformação da água líquida em vapor?",
question_en="What is the change of liquid water into vapor called?",
answers_pt={"Condensação", "Evaporação", "Fusão", "Solidificação"},
answers_en={"Condensation", "Evaporation", "Melting", "Freezing"},
correct=2,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Água e ciclo da água", subcategory_en="Water and the water cycle",
difficulty=122
},
{
question_pt="No ciclo da água, o que acontece durante a condensação?",
question_en="In the water cycle, what happens during condensation?",
answers_pt={"O vapor de água esfria e forma gotículas líquidas", "A água desaparece da natureza", "O solo transforma água em oxigênio", "A água líquida vira gelo diretamente pelo Sol"},
answers_en={"Water vapor cools and forms liquid droplets", "Water disappears from nature", "Soil turns water into oxygen", "Liquid water turns directly into ice because of the Sun"},
correct=1,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Água e ciclo da água", subcategory_en="Water and the water cycle",
difficulty=123
},
{
question_pt="Qual nome recebe a água que cai das nuvens como chuva, neve ou granizo?",
question_en="What is water that falls from clouds as rain, snow, or hail called?",
answers_pt={"Infiltração", "Evaporação", "Precipitação", "Transpiração"},
answers_en={"Infiltration", "Evaporation", "Precipitation", "Transpiration"},
correct=3,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Água e ciclo da água", subcategory_en="Water and the water cycle",
difficulty=124
},
{
question_pt="Quando parte da água da chuva penetra no solo, ocorre:",
question_en="When some rainwater enters the soil, this process is called:",
answers_pt={"Combustão", "Condensação", "Infiltração", "Fusão"},
answers_en={"Combustion", "Condensation", "Infiltration", "Melting"},
correct=3,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Água e ciclo da água", subcategory_en="Water and the water cycle",
difficulty=125
},
{
question_pt="A água da chuva que escorre pela superfície em direção a rios e lagos é chamada de:",
question_en="Rainwater that flows over the surface toward rivers and lakes is called:",
answers_pt={"Sublimação", "Transpiração", "Condensação", "Escoamento superficial"},
answers_en={"Sublimation", "Transpiration", "Condensation", "Surface runoff"},
correct=4,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Água e ciclo da água", subcategory_en="Water and the water cycle",
difficulty=126
},
{
question_pt="Como a transpiração das plantas participa do ciclo da água?",
question_en="How does plant transpiration take part in the water cycle?",
answers_pt={"Libera vapor de água para a atmosfera", "Retira toda a água dos oceanos", "Impede a formação de nuvens", "Transforma vapor em rocha"},
answers_en={"It releases water vapor into the atmosphere", "It removes all water from the oceans", "It prevents clouds from forming", "It turns vapor into rock"},
correct=1,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Água e ciclo da água", subcategory_en="Water and the water cycle",
difficulty=127
},
{
question_pt="Qual fonte de energia impulsiona grande parte da evaporação da água na Terra?",
question_en="Which energy source drives much of the evaporation of water on Earth?",
answers_pt={"Som dos oceanos", "Núcleo da Terra apenas", "Lua", "Sol"},
answers_en={"The sound of the oceans", "Earth's core alone", "The Moon", "The Sun"},
correct=4,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Água e ciclo da água", subcategory_en="Water and the water cycle",
difficulty=128
},
{
question_pt="De que são formadas as nuvens comuns da atmosfera?",
question_en="What are ordinary clouds in the atmosphere made of?",
answers_pt={"Pequenas gotículas de água e/ou cristais de gelo", "Grãos de areia derretidos", "Fumaça sólida de rochas", "Apenas oxigênio puro"},
answers_en={"Tiny water droplets and/or ice crystals", "Melted grains of sand", "Solid smoke from rocks", "Pure oxygen only"},
correct=1,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Água e ciclo da água", subcategory_en="Water and the water cycle",
difficulty=129
},
{
question_pt="Por que o ciclo da água é chamado de ciclo?",
question_en="Why is the water cycle called a cycle?",
answers_pt={"Porque toda água é usada uma única vez", "Porque a água só se move em linha reta", "Porque a quantidade de água dobra a cada chuva", "Porque a água circula continuamente entre a superfície e a atmosfera"},
answers_en={"Because all water is used only once", "Because water moves only in a straight line", "Because the amount of water doubles after every rain", "Because water continuously circulates between the surface and the atmosphere"},
correct=4,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Água e ciclo da água", subcategory_en="Water and the water cycle",
difficulty=130
},
{
question_pt="O que significa dizer que a água é potável?",
question_en="What does it mean to say that water is potable?",
answers_pt={"Que contém necessariamente sal em grande quantidade", "Que está sempre congelada", "Que não possui nenhuma molécula dissolvida", "Que está própria para consumo humano, segundo padrões de qualidade"},
answers_en={"That it necessarily contains a large amount of salt", "That it is always frozen", "That it contains no dissolved molecules", "That it is suitable for human consumption under quality standards"},
correct=4,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Água e ciclo da água", subcategory_en="Water and the water cycle",
difficulty=131
},
{
question_pt="Qual é um dos objetivos do tratamento da água antes de sua distribuição?",
question_en="What is one purpose of treating water before distribution?",
answers_pt={"Transformar água doce em água salgada", "Remover impurezas e reduzir microrganismos que podem causar doenças", "Adicionar areia para aumentar a turbidez", "Retirar todo o oxigênio da água"},
answers_en={"Turn freshwater into saltwater", "Remove impurities and reduce microorganisms that can cause disease", "Add sand to increase turbidity", "Remove all oxygen from the water"},
correct=2,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Água e ciclo da água", subcategory_en="Water and the water cycle",
difficulty=132
},
{
question_pt="Em uma estação de tratamento, para que serve a filtração da água?",
question_en="At a water treatment plant, what is water filtration used for?",
answers_pt={"Separar o oxigênio da água por imã", "Transformar sais dissolvidos em vapor", "Aumentar a quantidade de microrganismos", "Reter partículas e materiais suspensos"},
answers_en={"Separate oxygen from water with a magnet", "Turn dissolved salts into vapor", "Increase the number of microorganisms", "Trap suspended particles and materials"},
correct=4,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Água e ciclo da água", subcategory_en="Water and the water cycle",
difficulty=133
},
{
question_pt="Por que a desinfecção, como a realizada com cloro em quantidade controlada, é importante no tratamento da água?",
question_en="Why is disinfection, such as treatment with a controlled amount of chlorine, important in water treatment?",
answers_pt={"Porque aumenta a salinidade para níveis oceânicos", "Porque transforma água em combustível", "Porque remove todas as partículas de areia por peneiração", "Porque ajuda a eliminar ou inativar microrganismos causadores de doenças"},
answers_en={"Because it raises salinity to ocean levels", "Because it turns water into fuel", "Because it removes all sand particles by sieving", "Because it helps kill or inactivate disease-causing microorganisms"},
correct=4,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Água e ciclo da água", subcategory_en="Water and the water cycle",
difficulty=134
},
{
question_pt="Por que o esgoto doméstico deve ser tratado antes de ser lançado em rios?",
question_en="Why should household sewage be treated before being released into rivers?",
answers_pt={"Para aumentar a quantidade de resíduos na água", "Para reduzir poluentes e riscos à saúde e aos ecossistemas", "Para impedir o ciclo natural da água", "Para retirar todos os seres vivos do rio"},
answers_en={"To increase the amount of waste in the water", "To reduce pollutants and risks to health and ecosystems", "To stop the natural water cycle", "To remove all living things from the river"},
correct=2,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Água e ciclo da água", subcategory_en="Water and the water cycle",
difficulty=135
},
{
question_pt="Uma torneira apresenta vazamento contínuo. Qual atitude ajuda diretamente a evitar desperdício de água?",
question_en="A faucet has a continuous leak. Which action directly helps prevent water waste?",
answers_pt={"Deixar a torneira aberta para lavar o chão", "Cobrir a torneira sem fechar o registro", "Consertar o vazamento", "Aumentar a pressão da água"},
answers_en={"Leave the faucet running to wash the floor", "Cover the faucet without closing the valve", "Repair the leak", "Increase the water pressure"},
correct=3,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Água e ciclo da água", subcategory_en="Water and the water cycle",
difficulty=136
},
{
question_pt="Em cidades muito pavimentadas, por que chuvas fortes podem causar mais alagamentos?",
question_en="In heavily paved cities, why can heavy rain cause more flooding?",
answers_pt={"Porque o asfalto absorve toda a chuva", "Porque o concreto aumenta a evaporação instantaneamente", "Porque superfícies impermeáveis reduzem a infiltração da água no solo", "Porque a chuva deixa de cair nos rios"},
answers_en={"Because asphalt absorbs all the rain", "Because concrete instantly increases evaporation", "Because impermeable surfaces reduce water infiltration into the soil", "Because rain stops falling into rivers"},
correct=3,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Água e ciclo da água", subcategory_en="Water and the water cycle",
difficulty=137
},
{
question_pt="Durante uma seca prolongada, qual medida contribui para preservar a água disponível?",
question_en="During a prolonged drought, which measure helps preserve available water?",
answers_pt={"Despejar resíduos em nascentes", "Priorizar usos essenciais e evitar desperdícios", "Lavar calçadas diariamente com mangueira", "Deixar reservatórios abertos ao sol"},
answers_en={"Dump waste into springs", "Prioritize essential uses and avoid waste", "Wash sidewalks daily with a hose", "Leave reservoirs open in the Sun"},
correct=2,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Água e ciclo da água", subcategory_en="Water and the water cycle",
difficulty=138
},
{
question_pt="Por que a preservação de nascentes é importante para o abastecimento de água?",
question_en="Why is protecting springs important for water supply?",
answers_pt={"Porque elas contribuem para a formação e manutenção de cursos d'água", "Porque impedem a infiltração no solo", "Porque transformam água doce em petróleo", "Porque produzem água sem depender do ciclo natural"},
answers_en={"Because they help form and maintain watercourses", "Because they prevent soil infiltration", "Because they turn freshwater into petroleum", "Because they produce water without depending on the natural cycle"},
correct=1,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Água e ciclo da água", subcategory_en="Water and the water cycle",
difficulty=139
},
{
question_pt="Gotículas aparecem do lado de fora de um copo com bebida gelada. De onde vem essa água?",
question_en="Droplets appear on the outside of a glass containing a cold drink. Where does this water come from?",
answers_pt={"Da água que atravessa o vidro", "Do líquido que sai do fundo do copo", "Da transformação do vidro em água", "Do vapor de água do ar, que se condensa na superfície fria"},
answers_en={"From water passing through the glass", "From liquid leaking out of the bottom of the glass", "From the glass turning into water", "From water vapor in the air, which condenses on the cold surface"},
correct=4,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Água e ciclo da água", subcategory_en="Water and the water cycle",
difficulty=140
},
{
question_pt="O que é a atmosfera terrestre?",
question_en="What is Earth's atmosphere?",
answers_pt={"A camada de rochas no centro da Terra", "Uma camada formada apenas por vapor de água", "O conjunto de todos os oceanos", "A camada de gases que envolve o planeta"},
answers_en={"The layer of rocks at Earth's center", "A layer made only of water vapor", "All the oceans together", "The layer of gases surrounding the planet"},
correct=4,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Ar, atmosfera e tempo", subcategory_en="Air, atmosphere, and weather",
difficulty=141
},
{
question_pt="Qual gás é o mais abundante no ar seco da atmosfera terrestre?",
question_en="Which gas is the most abundant in Earth's dry atmosphere?",
answers_pt={"Hélio", "Gás carbônico", "Nitrogênio", "Oxigênio"},
answers_en={"Helium", "Carbon dioxide", "Nitrogen", "Oxygen"},
correct=3,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Ar, atmosfera e tempo", subcategory_en="Air, atmosphere, and weather",
difficulty=142
},
{
question_pt="Aproximadamente quanto do ar seco da atmosfera é formado por oxigênio?",
question_en="Approximately how much of dry air is made up of oxygen?",
answers_pt={"Cerca de 21%", "Cerca de 78%", "Cerca de 99%", "Cerca de 1%"},
answers_en={"About 21%", "About 78%", "About 99%", "About 1%"},
correct=1,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Ar, atmosfera e tempo", subcategory_en="Air, atmosphere, and weather",
difficulty=143
},
{
question_pt="Por que o gás carbônico presente no ar é importante para as plantas?",
question_en="Why is carbon dioxide in the air important to plants?",
answers_pt={"É o único gás que as raízes absorvem", "Substitui a água em todas as funções da planta", "É utilizado como fonte de carbono na fotossíntese", "Impede a formação de matéria orgânica"},
answers_en={"It is the only gas roots absorb", "It replaces water in all plant functions", "It is used as a carbon source in photosynthesis", "It prevents organic matter from forming"},
correct=3,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Ar, atmosfera e tempo", subcategory_en="Air, atmosphere, and weather",
difficulty=144
},
{
question_pt="Qual observação demonstra que o ar ocupa espaço?",
question_en="Which observation shows that air takes up space?",
answers_pt={"O gelo derrete ao sol", "Um copo aparentemente vazio, colocado de boca para baixo na água, retém ar e dificulta a entrada da água", "Uma pedra afunda em um rio", "Uma sombra aparece atrás de um objeto"},
answers_en={"Ice melts in sunlight", "An apparently empty cup placed upside down in water traps air and prevents water from entering easily", "A stone sinks in a river", "A shadow appears behind an object"},
correct=2,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Ar, atmosfera e tempo", subcategory_en="Air, atmosphere, and weather",
difficulty=145
},
{
question_pt="O que é a pressão atmosférica?",
question_en="What is atmospheric pressure?",
answers_pt={"A temperatura do solo", "A pressão exercida pelo peso do ar", "A velocidade de rotação da Lua", "A força produzida apenas pelas ondas do mar"},
answers_en={"The temperature of the soil", "The pressure exerted by the weight of the air", "The Moon's rotation speed", "The force produced only by ocean waves"},
correct=2,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Ar, atmosfera e tempo", subcategory_en="Air, atmosphere, and weather",
difficulty=146
},
{
question_pt="O vento é o movimento do ar. Em geral, ele se desloca de regiões de:",
question_en="Wind is the movement of air. In general, it moves from regions of:",
answers_pt={"Maior umidade para o espaço", "Menor temperatura para maior altitude sempre", "Ausência total de pressão para o centro da Terra", "Maior pressão para menor pressão"},
answers_en={"Higher humidity into space", "Lower temperature to higher altitude in every case", "Zero pressure toward Earth's center", "Higher pressure to lower pressure"},
correct=4,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Ar, atmosfera e tempo", subcategory_en="Air, atmosphere, and weather",
difficulty=147
},
{
question_pt="O que são nuvens?",
question_en="What are clouds?",
answers_pt={"Buracos na atmosfera", "Conjuntos visíveis de gotículas de água e/ou cristais de gelo suspensos no ar", "Massas de fumaça produzidas sempre por vulcões", "Pedaços sólidos do espaço"},
answers_en={"Holes in the atmosphere", "Visible collections of water droplets and/or ice crystals suspended in the air", "Smoke masses always produced by volcanoes", "Solid pieces of outer space"},
correct=2,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Ar, atmosfera e tempo", subcategory_en="Air, atmosphere, and weather",
difficulty=148
},
{
question_pt="Qual alternativa diferencia corretamente tempo atmosférico e clima?",
question_en="Which option correctly distinguishes weather from climate?",
answers_pt={"Clima muda a cada minuto; tempo é uma média de séculos", "Tempo descreve condições de curto prazo; clima resume padrões de longos períodos", "Tempo e clima significam exatamente a mesma coisa", "Tempo existe apenas nos oceanos"},
answers_en={"Climate changes every minute; weather is an average over centuries", "Weather describes short-term conditions; climate summarizes patterns over long periods", "Weather and climate mean exactly the same thing", "Weather exists only over oceans"},
correct=2,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Ar, atmosfera e tempo", subcategory_en="Air, atmosphere, and weather",
difficulty=149
},
{
question_pt="O que indica a umidade do ar?",
question_en="What does air humidity indicate?",
answers_pt={"A quantidade de areia suspensa no solo", "A velocidade dos rios", "A intensidade da luz das estrelas", "A quantidade de vapor de água presente no ar"},
answers_en={"The amount of sand suspended in soil", "The speed of rivers", "The intensity of starlight", "The amount of water vapor present in the air"},
correct=4,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Ar, atmosfera e tempo", subcategory_en="Air, atmosphere, and weather",
difficulty=150
},
{
question_pt="Qual instrumento é usado para medir a temperatura do ar?",
question_en="Which instrument is used to measure air temperature?",
answers_pt={"Termômetro", "Pluviômetro", "Anemômetro", "Bússola"},
answers_en={"Thermometer", "Rain gauge", "Anemometer", "Compass"},
correct=1,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Ar, atmosfera e tempo", subcategory_en="Air, atmosphere, and weather",
difficulty=151
},
{
question_pt="Qual instrumento meteorológico mede a velocidade do vento?",
question_en="Which meteorological instrument measures wind speed?",
answers_pt={"Termômetro", "Pluviômetro", "Anemômetro", "Microscópio"},
answers_en={"Thermometer", "Rain gauge", "Anemometer", "Microscope"},
correct=3,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Ar, atmosfera e tempo", subcategory_en="Air, atmosphere, and weather",
difficulty=152
},
{
question_pt="Qual instrumento permite medir a quantidade de chuva que caiu em determinado período?",
question_en="Which instrument measures how much rain fell during a given period?",
answers_pt={"Barômetro", "Higrômetro de solo", "Pluviômetro", "Telescópio"},
answers_en={"Barometer", "Soil hygrometer", "Rain gauge", "Telescope"},
correct=3,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Ar, atmosfera e tempo", subcategory_en="Air, atmosphere, and weather",
difficulty=153
},
{
question_pt="Por que o efeito estufa natural é importante para a Terra?",
question_en="Why is the natural greenhouse effect important for Earth?",
answers_pt={"Ajuda a manter temperaturas adequadas à existência de vida", "Elimina todos os gases da atmosfera", "Congela os oceanos", "Impede que a luz solar chegue ao planeta"},
answers_en={"It helps keep temperatures suitable for life", "It removes all gases from the atmosphere", "It freezes the oceans", "It prevents sunlight from reaching the planet"},
correct=1,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Ar, atmosfera e tempo", subcategory_en="Air, atmosphere, and weather",
difficulty=154
},
{
question_pt="A queima de combustíveis fósseis em veículos e indústrias pode piorar a qualidade do ar porque:",
question_en="Why can burning fossil fuels in vehicles and industries worsen air quality?",
answers_pt={"Impede a formação de qualquer nuvem", "Retira o nitrogênio da atmosfera instantaneamente", "Libera gases e partículas poluentes", "Transforma todos os poluentes em oxigênio"},
answers_en={"It prevents all clouds from forming", "It instantly removes nitrogen from the atmosphere", "It releases polluting gases and particles", "It turns all pollutants into oxygen"},
correct=3,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Ar, atmosfera e tempo", subcategory_en="Air, atmosphere, and weather",
difficulty=155
},
{
question_pt="Como o solo se forma ao longo do tempo?",
question_en="How does soil form over time?",
answers_pt={"Pela compactação de nuvens", "Apenas pela água do mar congelada", "Pela transformação instantânea do ar em areia", "Pela alteração das rochas e pelo acúmulo e transformação de matéria orgânica"},
answers_en={"By compacting clouds", "Only from frozen seawater", "By instantly turning air into sand", "Through rock weathering and the accumulation and transformation of organic matter"},
correct=4,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Solo, rochas e fósseis", subcategory_en="Soil, rocks, and fossils",
difficulty=156
},
{
question_pt="Como é chamada a matéria orgânica escura, resultante da decomposição de restos de seres vivos, presente no solo?",
question_en="What is the dark organic matter formed from decomposed remains of living things in soil called?",
answers_pt={"Magma", "Húmus", "Granito", "Argila pura"},
answers_en={"Magma", "Humus", "Granite", "Pure clay"},
correct=2,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Solo, rochas e fósseis", subcategory_en="Soil, rocks, and fossils",
difficulty=157
},
{
question_pt="Qual característica costuma ser mais comum em solos arenosos?",
question_en="Which characteristic is usually common in sandy soils?",
answers_pt={"Não possuem espaços entre partículas", "Retêm sempre mais água que solos argilosos", "São formados apenas por matéria orgânica", "A água escoa com relativa facilidade entre os grãos"},
answers_en={"They have no spaces between particles", "They always retain more water than clay soils", "They are made only of organic matter", "Water drains relatively easily between the grains"},
correct=4,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Solo, rochas e fósseis", subcategory_en="Soil, rocks, and fossils",
difficulty=158
},
{
question_pt="Qual característica costuma ser comum em solos ricos em argila?",
question_en="Which characteristic is commonly found in clay-rich soils?",
answers_pt={"A água atravessa sempre com enorme rapidez", "São compostos apenas de folhas", "Podem reter bastante água e ter drenagem mais lenta", "Não contêm partículas minerais"},
answers_en={"Water always passes through very quickly", "They are made only of leaves", "They can retain a lot of water and drain more slowly", "They contain no mineral particles"},
correct=3,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Solo, rochas e fósseis", subcategory_en="Soil, rocks, and fossils",
difficulty=159
},
{
question_pt="O que contribui para a fertilidade de muitos solos agrícolas?",
question_en="What contributes to the fertility of many agricultural soils?",
answers_pt={"A ausência completa de água", "A retirada de todos os organismos do solo", "A cobertura permanente de plástico", "Nutrientes minerais e matéria orgânica em condições adequadas"},
answers_en={"A complete absence of water", "The removal of all soil organisms", "Permanent plastic covering", "Mineral nutrients and organic matter in suitable conditions"},
correct=4,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Solo, rochas e fósseis", subcategory_en="Soil, rocks, and fossils",
difficulty=160
},
{
question_pt="O desgaste e o transporte de partículas do solo pela água ou pelo vento são chamados de:",
question_en="The wearing away and transport of soil particles by water or wind is called:",
answers_pt={"Condensação", "Fecundação", "Erosão", "Fotossíntese"},
answers_en={"Condensation", "Fertilization", "Erosion", "Photosynthesis"},
correct=3,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Solo, rochas e fósseis", subcategory_en="Soil, rocks, and fossils",
difficulty=161
},
{
question_pt="Como a vegetação pode reduzir a erosão do solo?",
question_en="How can vegetation reduce soil erosion?",
answers_pt={"As raízes ajudam a manter o solo preso e as folhas reduzem o impacto da chuva", "As raízes removem todas as partículas minerais", "As plantas transformam o vento em rocha", "As folhas impedem toda infiltração de água"},
answers_en={"Roots help hold soil in place, and leaves reduce the impact of rain", "Roots remove all mineral particles", "Plants turn wind into rock", "Leaves prevent all water infiltration"},
correct=1,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Solo, rochas e fósseis", subcategory_en="Soil, rocks, and fossils",
difficulty=162
},
{
question_pt="Como são chamadas as diferentes camadas que podem ser observadas em um perfil de solo?",
question_en="What are the different layers observed in a soil profile called?",
answers_pt={"Órbitas minerais", "Horizontes do solo", "Fases da Lua", "Camadas da atmosfera"},
answers_en={"Mineral orbits", "Soil horizons", "Moon phases", "Atmospheric layers"},
correct=2,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Solo, rochas e fósseis", subcategory_en="Soil, rocks, and fossils",
difficulty=163
},
{
question_pt="O que é o material rochoso relativamente pouco alterado que pode aparecer abaixo das camadas de solo?",
question_en="What is the relatively unweathered rock material that may occur beneath soil layers called?",
answers_pt={"Nuvem", "Rocha matriz", "Húmus", "Lençol de ar"},
answers_en={"Cloud", "Parent rock", "Humus", "Layer of air"},
correct=2,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Solo, rochas e fósseis", subcategory_en="Soil, rocks, and fossils",
difficulty=164
},
{
question_pt="O que um fóssil pode revelar aos cientistas?",
question_en="What can a fossil reveal to scientists?",
answers_pt={"A idade de qualquer objeto moderno", "A previsão exata do tempo para amanhã", "A composição atual de todos os oceanos", "Informações sobre seres vivos e ambientes do passado"},
answers_en={"The age of any modern object", "The exact weather forecast for tomorrow", "The current composition of all oceans", "Information about organisms and environments from the past"},
correct=4,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Solo, rochas e fósseis", subcategory_en="Soil, rocks, and fossils",
difficulty=165
},
{
question_pt="Como muitas rochas sedimentares se formam?",
question_en="How do many sedimentary rocks form?",
answers_pt={"Pelo resfriamento direto de lava em todos os casos", "Pela evaporação de metal líquido", "Pela congelamento do ar", "Pelo acúmulo, compactação e cimentação de sedimentos"},
answers_en={"By the direct cooling of lava in every case", "By evaporating liquid metal", "By freezing air", "Through the accumulation, compaction, and cementation of sediments"},
correct=4,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Solo, rochas e fósseis", subcategory_en="Soil, rocks, and fossils",
difficulty=166
},
{
question_pt="Qual processo forma rochas ígneas, também chamadas magmáticas?",
question_en="Which process forms igneous rocks, also called magmatic rocks?",
answers_pt={"Compactação de conchas no fundo do mar apenas", "Resfriamento e solidificação do magma ou da lava", "Decomposição de folhas", "Acúmulo de vapor de água"},
answers_en={"Compaction of shells on the seafloor only", "Cooling and solidification of magma or lava", "Decomposition of leaves", "Accumulation of water vapor"},
correct=2,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Solo, rochas e fósseis", subcategory_en="Soil, rocks, and fossils",
difficulty=167
},
{
question_pt="Como uma rocha metamórfica pode se formar?",
question_en="How can a metamorphic rock form?",
answers_pt={"Quando a água evapora de uma poça", "Quando restos vegetais viram húmus", "Quando uma rocha preexistente é transformada por calor e pressão", "Quando areia é levada pelo vento sem sofrer alteração"},
answers_en={"When water evaporates from a puddle", "When plant remains become humus", "When a pre-existing rock is changed by heat and pressure", "When sand is carried by wind without changing"},
correct=3,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Solo, rochas e fósseis", subcategory_en="Soil, rocks, and fossils",
difficulty=168
},
{
question_pt="Qual é a diferença entre mineral e rocha?",
question_en="What is the difference between a mineral and a rock?",
answers_pt={"Mineral é uma substância natural com composição e estrutura características; rocha é um agregado de um ou mais minerais", "Mineral é um ser vivo e rocha é um órgão", "Rocha é sempre líquida e mineral é sempre gasoso", "Os dois termos significam exatamente a mesma coisa"},
answers_en={"A mineral is a natural substance with characteristic composition and structure; a rock is an aggregate of one or more minerals", "A mineral is a living thing and a rock is an organ", "Rock is always liquid and mineral is always gaseous", "The two terms mean exactly the same thing"},
correct=1,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Solo, rochas e fósseis", subcategory_en="Soil, rocks, and fossils",
difficulty=169
},
{
question_pt="Qual prática ajuda a reduzir a erosão em uma encosta usada para agricultura?",
question_en="Which practice helps reduce erosion on a hillside used for farming?",
answers_pt={"Abrir sulcos no sentido da descida da água", "Compactar o solo e impedir o crescimento de raízes", "Retirar toda a vegetação e deixar o solo exposto", "Manter cobertura vegetal e plantar acompanhando as curvas de nível"},
answers_en={"Make furrows in the direction water flows downhill", "Compact the soil and prevent roots from growing", "Remove all vegetation and leave the soil exposed", "Maintain plant cover and plant along contour lines"},
correct=4,
category_pt="Terra e ambiente", category_en="Earth and environment",
subcategory_pt="Solo, rochas e fósseis", subcategory_en="Soil, rocks, and fossils",
difficulty=170
},
{
question_pt="Na ciência, o que caracteriza a matéria?",
question_en="In science, what characterizes matter?",
answers_pt={"Possuir massa e ocupar espaço", "Ser sempre visível", "Estar apenas no estado sólido", "Produzir luz própria obrigatoriamente"},
answers_en={"Having mass and occupying space", "Always being visible", "Existing only as a solid", "Necessarily producing its own light"},
correct=1,
category_pt="Matéria e materiais", category_en="Matter and materials",
subcategory_pt="Propriedades, estados e misturas", subcategory_en="Properties, states, and mixtures",
difficulty=171
},
{
question_pt="Qual característica é típica dos materiais no estado sólido?",
question_en="Which characteristic is typical of materials in the solid state?",
answers_pt={"Possuem forma e volume geralmente definidos", "Não possuem volume", "Assumem sempre a forma do recipiente e ocupam todo o espaço", "Fluem como gases"},
answers_en={"They generally have a definite shape and volume", "They have no volume", "They always take the container's shape and fill all available space", "They flow like gases"},
correct=1,
category_pt="Matéria e materiais", category_en="Matter and materials",
subcategory_pt="Propriedades, estados e misturas", subcategory_en="Properties, states, and mixtures",
difficulty=172
},
{
question_pt="Como um líquido se comporta quando é colocado em recipientes de formatos diferentes?",
question_en="How does a liquid behave when placed in containers of different shapes?",
answers_pt={"Deixa de ocupar espaço", "Mantém aproximadamente o volume, mas assume a forma do recipiente", "Mantém sempre a mesma forma", "Expande-se para preencher todo o espaço como um gás"},
answers_en={"It stops occupying space", "It keeps roughly the same volume but takes the container's shape", "It always keeps the same shape", "It expands to fill all space like a gas"},
correct=2,
category_pt="Matéria e materiais", category_en="Matter and materials",
subcategory_pt="Propriedades, estados e misturas", subcategory_en="Properties, states, and mixtures",
difficulty=173
},
{
question_pt="Qual comportamento é típico de um gás dentro de um recipiente fechado?",
question_en="Which behavior is typical of a gas inside a closed container?",
answers_pt={"Espalha-se e ocupa todo o volume disponível", "Mantém forma própria e volume fixo", "Fica sempre no fundo sem se misturar", "Transforma-se imediatamente em sólido"},
answers_en={"It spreads out and occupies all available volume", "It keeps its own shape and fixed volume", "It always stays at the bottom without mixing", "It immediately turns into a solid"},
correct=1,
category_pt="Matéria e materiais", category_en="Matter and materials",
subcategory_pt="Propriedades, estados e misturas", subcategory_en="Properties, states, and mixtures",
difficulty=174
},
{
question_pt="Como se chama a passagem do estado sólido para o líquido?",
question_en="What is the change from solid to liquid called?",
answers_pt={"Sublimação", "Condensação", "Solidificação", "Fusão"},
answers_en={"Sublimation", "Condensation", "Freezing", "Melting"},
correct=4,
category_pt="Matéria e materiais", category_en="Matter and materials",
subcategory_pt="Propriedades, estados e misturas", subcategory_en="Properties, states, and mixtures",
difficulty=175
},
{
question_pt="Qual mudança de estado ocorre quando a água líquida se transforma em gelo?",
question_en="Which change of state occurs when liquid water turns into ice?",
answers_pt={"Vaporização", "Fusão", "Solidificação", "Condensação"},
answers_en={"Vaporization", "Melting", "Freezing", "Condensation"},
correct=3,
category_pt="Matéria e materiais", category_en="Matter and materials",
subcategory_pt="Propriedades, estados e misturas", subcategory_en="Properties, states, and mixtures",
difficulty=176
},
{
question_pt="A passagem de uma substância do estado líquido para o gasoso é chamada de:",
question_en="The change of a substance from liquid to gas is called:",
answers_pt={"Fusão", "Vaporização", "Condensação", "Solidificação"},
answers_en={"Melting", "Vaporization", "Condensation", "Freezing"},
correct=2,
category_pt="Matéria e materiais", category_en="Matter and materials",
subcategory_pt="Propriedades, estados e misturas", subcategory_en="Properties, states, and mixtures",
difficulty=177
},
{
question_pt="Quando o vapor de água forma gotículas líquidas em uma superfície fria, ocorre:",
question_en="When water vapor forms liquid droplets on a cold surface, this is:",
answers_pt={"Fusão", "Condensação", "Sublimação", "Solidificação direta do metal"},
answers_en={"Melting", "Condensation", "Sublimation", "Direct freezing of metal"},
correct=2,
category_pt="Matéria e materiais", category_en="Matter and materials",
subcategory_pt="Propriedades, estados e misturas", subcategory_en="Properties, states, and mixtures",
difficulty=178
},
{
question_pt="Dissolver açúcar em água, sem formar uma nova substância, é geralmente considerado:",
question_en="Dissolving sugar in water without forming a new substance is generally considered a:",
answers_pt={"Combustão", "Transformação nuclear", "Transformação física", "Reação que cria outro elemento químico"},
answers_en={"Combustion", "Nuclear transformation", "Physical change", "A reaction that creates another chemical element"},
correct=3,
category_pt="Matéria e materiais", category_en="Matter and materials",
subcategory_pt="Propriedades, estados e misturas", subcategory_en="Properties, states, and mixtures",
difficulty=179
},
{
question_pt="Um portão de ferro enferruja após ficar exposto à chuva e ao ar. A ferrugem é resultado de:",
question_en="An iron gate rusts after being exposed to rain and air. Rust is the result of a:",
answers_pt={"Mudança apenas de formato", "Transformação química", "Fusão do ferro", "Dissolução sem reação"},
answers_en={"A change in shape only", "Chemical change", "Melting of iron", "Dissolving without a reaction"},
correct=2,
category_pt="Matéria e materiais", category_en="Matter and materials",
subcategory_pt="Propriedades, estados e misturas", subcategory_en="Properties, states, and mixtures",
difficulty=180
},
{
question_pt="Uma mistura em que não conseguimos distinguir seus componentes a olho nu e que apresenta aspecto uniforme é chamada de:",
question_en="A mixture whose components cannot be distinguished with the naked eye and that has a uniform appearance is called:",
answers_pt={"Heterogênea", "Radioativa", "Metamórfica", "Homogênea"},
answers_en={"Heterogeneous", "Radioactive", "Metamorphic", "Homogeneous"},
correct=4,
category_pt="Matéria e materiais", category_en="Matter and materials",
subcategory_pt="Propriedades, estados e misturas", subcategory_en="Properties, states, and mixtures",
difficulty=181
},
{
question_pt="Uma mistura de água e areia, na qual é possível observar fases diferentes, é:",
question_en="A mixture of water and sand, in which different phases can be observed, is:",
answers_pt={"Uma substância pura", "Um elemento químico", "Heterogênea", "Homogênea"},
answers_en={"A pure substance", "A chemical element", "Heterogeneous", "Homogeneous"},
correct=3,
category_pt="Matéria e materiais", category_en="Matter and materials",
subcategory_pt="Propriedades, estados e misturas", subcategory_en="Properties, states, and mixtures",
difficulty=182
},
{
question_pt="Qual método pode separar areia misturada à água usando um material poroso que retém o sólido?",
question_en="Which method can separate sand mixed with water using a porous material that traps the solid?",
answers_pt={"Filtração", "Imantação obrigatória", "Evaporação do ferro", "Destilação do solo"},
answers_en={"Filtration", "Mandatory magnetic separation", "Evaporation of iron", "Distillation of soil"},
correct=1,
category_pt="Matéria e materiais", category_en="Matter and materials",
subcategory_pt="Propriedades, estados e misturas", subcategory_en="Properties, states, and mixtures",
difficulty=183
},
{
question_pt="Ao deixar uma mistura de água e óleo em repouso, os líquidos formam camadas. Qual método simples pode ajudar a separá-los?",
question_en="When a mixture of water and oil is left to stand, the liquids form layers. Which simple method can help separate them?",
answers_pt={"Filtração magnética", "Decantação", "Catação", "Peneiração"},
answers_en={"Magnetic filtration", "Decantation", "Hand sorting", "Sieving"},
correct=2,
category_pt="Matéria e materiais", category_en="Matter and materials",
subcategory_pt="Propriedades, estados e misturas", subcategory_en="Properties, states, and mixtures",
difficulty=184
},
{
question_pt="Como recuperar o sal dissolvido em uma amostra de água salgada, deixando a água evaporar?",
question_en="How can dissolved salt be recovered from a sample of salt water by allowing the water to evaporate?",
answers_pt={"Por separação manual dos grãos", "Por atração com ímã", "Por filtração com peneira grossa", "Por evaporação da água"},
answers_en={"By manually sorting the grains", "By using a magnet", "By filtering with a coarse sieve", "By evaporating the water"},
correct=4,
category_pt="Matéria e materiais", category_en="Matter and materials",
subcategory_pt="Propriedades, estados e misturas", subcategory_en="Properties, states, and mixtures",
difficulty=185
},
{
question_pt="Por que a energia é importante nos fenômenos naturais e nas atividades dos seres vivos?",
question_en="Why is energy important in natural phenomena and the activities of living things?",
answers_pt={"Não participa de movimentos nem transformações", "É sinônimo de matéria", "Permite que ocorram mudanças e processos", "É uma substância que só existe em pilhas"},
answers_en={"It has no role in movement or change", "It is synonymous with matter", "It makes changes and processes possible", "It is a substance that exists only in batteries"},
correct=3,
category_pt="Energia e fenômenos físicos", category_en="Energy and physical phenomena",
subcategory_pt="Calor, luz, som e eletricidade", subcategory_en="Heat, light, sound, and electricity",
difficulty=186
},
{
question_pt="Quando dois corpos em contato têm temperaturas diferentes, em que sentido ocorre a transferência espontânea de calor?",
question_en="When two bodies in contact have different temperatures, in which direction does heat transfer spontaneously occur?",
answers_pt={"Do corpo mais frio para o mais quente, sempre", "Do corpo menor para o maior, independentemente da temperatura", "Não ocorre transferência de energia térmica", "Do corpo de maior temperatura para o de menor temperatura"},
answers_en={"From the colder body to the hotter one, always", "From the smaller body to the larger one, regardless of temperature", "No thermal energy transfer occurs", "From the higher-temperature body to the lower-temperature body"},
correct=4,
category_pt="Energia e fenômenos físicos", category_en="Energy and physical phenomena",
subcategory_pt="Calor, luz, som e eletricidade", subcategory_en="Heat, light, sound, and electricity",
difficulty=187
},
{
question_pt="Uma colher de metal deixada em uma bebida quente também esquenta. Qual processo explica a transferência de calor ao longo da colher?",
question_en="A metal spoon left in a hot drink also becomes warm. Which process explains heat transfer along the spoon?",
answers_pt={"Condução", "Evaporação", "Reflexão", "Convecção"},
answers_en={"Conduction", "Evaporation", "Reflection", "Convection"},
correct=1,
category_pt="Energia e fenômenos físicos", category_en="Energy and physical phenomena",
subcategory_pt="Calor, luz, som e eletricidade", subcategory_en="Heat, light, sound, and electricity",
difficulty=188
},
{
question_pt="Em uma panela com água aquecida, por que a água mais quente tende a subir e a mais fria tende a descer?",
question_en="In a pot of heated water, why does warmer water tend to rise while cooler water tends to sink?",
answers_pt={"Porque diferenças de temperatura e densidade geram correntes de convecção", "Porque a água quente é atraída por ímãs", "Porque a gravidade deixa de atuar", "Porque a água se transforma em luz"},
answers_en={"Because temperature and density differences create convection currents", "Because hot water is attracted to magnets", "Because gravity stops acting", "Because water turns into light"},
correct=1,
category_pt="Energia e fenômenos físicos", category_en="Energy and physical phenomena",
subcategory_pt="Calor, luz, som e eletricidade", subcategory_en="Heat, light, sound, and electricity",
difficulty=189
},
{
question_pt="Como o calor do Sol consegue chegar à Terra atravessando o espaço, onde quase não há matéria?",
question_en="How can the Sun's heat reach Earth through space, where there is almost no matter?",
answers_pt={"Por convecção do ar entre os planetas", "Por condução apenas", "Por radiação", "Por contato direto"},
answers_en={"By convection of air between planets", "By conduction only", "By radiation", "By direct contact"},
correct=3,
category_pt="Energia e fenômenos físicos", category_en="Energy and physical phenomena",
subcategory_pt="Calor, luz, som e eletricidade", subcategory_en="Heat, light, sound, and electricity",
difficulty=190
},
{
question_pt="O que acontece com a luz quando atinge um espelho plano e retorna ao ambiente?",
question_en="What happens to light when it hits a flat mirror and returns to the environment?",
answers_pt={"Ela é refletida", "Ela deixa de se propagar", "Ela é congelada", "Ela é transformada em matéria"},
answers_en={"It is reflected", "It stops propagating", "It is frozen", "It is turned into matter"},
correct=1,
category_pt="Energia e fenômenos físicos", category_en="Energy and physical phenomena",
subcategory_pt="Calor, luz, som e eletricidade", subcategory_en="Heat, light, sound, and electricity",
difficulty=191
},
{
question_pt="Qual material permite que a maior parte da luz atravesse e que objetos sejam vistos com nitidez através dele?",
question_en="Which material allows most light to pass through and objects to be seen clearly through it?",
answers_pt={"Metálico fosco", "Transparente", "Totalmente absorvente", "Opaco"},
answers_en={"Dull metallic", "Transparent", "Fully absorbing", "Opaque"},
correct=2,
category_pt="Energia e fenômenos físicos", category_en="Energy and physical phenomena",
subcategory_pt="Calor, luz, som e eletricidade", subcategory_en="Heat, light, sound, and electricity",
difficulty=192
},
{
question_pt="Por que não ouvimos o som de uma explosão que acontecesse no espaço vazio, longe de qualquer matéria?",
question_en="Why would we not hear the sound of an explosion occurring in empty space, far from any matter?",
answers_pt={"Porque o som viaja apenas na água", "Porque o som precisa de um meio material para se propagar", "Porque a luz impede a audição", "Porque o espaço transforma som em gravidade"},
answers_en={"Because sound travels only in water", "Because sound needs a material medium to travel", "Because light prevents hearing", "Because space turns sound into gravity"},
correct=2,
category_pt="Energia e fenômenos físicos", category_en="Energy and physical phenomena",
subcategory_pt="Calor, luz, som e eletricidade", subcategory_en="Heat, light, sound, and electricity",
difficulty=193
},
{
question_pt="O eco que ouvimos em um local amplo ocorre principalmente devido à:",
question_en="The echo heard in a large space occurs mainly because of:",
answers_pt={"Reflexão das ondas sonoras", "Absorção completa do som", "Condensação do ar", "Produção de luz pelas paredes"},
answers_en={"Reflection of sound waves", "Complete absorption of sound", "Condensation of air", "Light production by walls"},
correct=1,
category_pt="Energia e fenômenos físicos", category_en="Energy and physical phenomena",
subcategory_pt="Calor, luz, som e eletricidade", subcategory_en="Heat, light, sound, and electricity",
difficulty=194
},
{
question_pt="O que é necessário para uma lâmpada simples acender em um circuito elétrico básico?",
question_en="What is needed for a simple bulb to light in a basic electric circuit?",
answers_pt={"Um caminho fechado que permita a passagem de corrente elétrica", "Um fio interrompido em todos os pontos", "A ausência de fonte de energia", "Um circuito sem condutores"},
answers_en={"A closed path that allows electric current to flow", "A wire broken at every point", "The absence of an energy source", "A circuit with no conductors"},
correct=1,
category_pt="Energia e fenômenos físicos", category_en="Energy and physical phenomena",
subcategory_pt="Calor, luz, som e eletricidade", subcategory_en="Heat, light, sound, and electricity",
difficulty=195
},
{
question_pt="O que é o Sol em relação aos demais corpos do Sistema Solar?",
question_en="What is the Sun in relation to the other bodies in the Solar System?",
answers_pt={"Um planeta rochoso", "Um cometa", "Um satélite natural", "Uma estrela"},
answers_en={"A rocky planet", "A comet", "A natural satellite", "A star"},
correct=4,
category_pt="Terra e espaço", category_en="Earth and space",
subcategory_pt="Sistema Solar e movimentos da Terra", subcategory_en="Solar system and Earth's movements",
difficulty=196
},
{
question_pt="Qual movimento da Terra, em torno de seu próprio eixo, está relacionado à alternância entre dia e noite?",
question_en="Which movement of Earth around its own axis is related to the alternation of day and night?",
answers_pt={"Precessão da Lua", "Revolução de Marte", "Translação", "Rotação"},
answers_en={"The Moon's precession", "Mars's orbit", "Revolution", "Rotation"},
correct=4,
category_pt="Terra e espaço", category_en="Earth and space",
subcategory_pt="Sistema Solar e movimentos da Terra", subcategory_en="Solar system and Earth's movements",
difficulty=197
},
{
question_pt="Quanto tempo aproximadamente a Terra leva para completar uma volta ao redor do Sol?",
question_en="Approximately how long does Earth take to complete one orbit around the Sun?",
answers_pt={"Um dia", "Uma semana", "Um mês", "Um ano"},
answers_en={"One day", "One week", "One month", "One year"},
correct=4,
category_pt="Terra e espaço", category_en="Earth and space",
subcategory_pt="Sistema Solar e movimentos da Terra", subcategory_en="Solar system and Earth's movements",
difficulty=198
},
{
question_pt="Por que a aparência iluminada da Lua muda ao longo de aproximadamente um mês?",
question_en="Why does the illuminated appearance of the Moon change over approximately a month?",
answers_pt={"Porque vemos diferentes porções de sua metade iluminada pelo Sol enquanto ela orbita a Terra", "Porque o Sol se apaga em alguns dias", "Porque a Lua produz mais ou menos luz própria", "Porque a sombra da Terra cobre a Lua todas as noites"},
answers_en={"Because we see different portions of its sunlit half as it orbits Earth", "Because the Sun turns off on some days", "Because the Moon produces more or less of its own light", "Because Earth's shadow covers the Moon every night"},
correct=1,
category_pt="Terra e espaço", category_en="Earth and space",
subcategory_pt="Sistema Solar e movimentos da Terra", subcategory_en="Solar system and Earth's movements",
difficulty=199
},
{
question_pt="Qual explicação está mais relacionada à ocorrência das estações do ano na Terra?",
question_en="Which explanation is most closely related to the occurrence of seasons on Earth?",
answers_pt={"A distância entre a Terra e o Sol como única causa", "A mudança mensal das fases da Lua", "A rotação da Lua ao redor da Terra", "A inclinação do eixo terrestre combinada com o movimento de translação"},
answers_en={"The Earth–Sun distance as the only cause", "The monthly change in Moon phases", "The Moon's rotation around Earth", "Earth's axial tilt combined with its revolution around the Sun"},
correct=4,
category_pt="Terra e espaço", category_en="Earth and space",
subcategory_pt="Sistema Solar e movimentos da Terra", subcategory_en="Solar system and Earth's movements",
difficulty=200
},
}
local Questions = {}
local function refresh_questions()
local lang = Language.get_current()
local usePortuguese = (lang == "pt")
Questions = {}
for _, item in ipairs(question_data) do
local sourceAnswers = usePortuguese and item.answers_pt or item.answers_en
local answers = {}
for i, answer in ipairs(sourceAnswers) do
answers[i] = answer
end
Questions[#Questions + 1] = {
question = usePortuguese and item.question_pt or item.question_en,
answers = answers,
correct = item.correct,
category = usePortuguese and item.category_pt or item.category_en,
subcategory = usePortuguese and item.subcategory_pt or item.subcategory_en,
difficulty = item.difficulty
}
end
end
refresh_questions()
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
if playerIndex == nil then return score end
if gPlayerSyncTable ~= nil and gPlayerSyncTable[playerIndex] ~= nil then
return math.max(0, tonumber(gPlayerSyncTable[playerIndex].quiz_score) or 0)
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
function Base.refresh_questions()
refresh_questions()
if questionIndex > #Questions then questionIndex, correctAnswer, answerReceived = 0, 0, false end
return #Questions
end
local function current_question()
if questionIndex < 1 then return nil end
return Questions[questionIndex]
end
function Base.get_current_question() return current_question() end
function Base.get_question_index() return questionIndex end
function Base.get_question_count() return #Questions end
function Base.get_correct_answer() return correctAnswer end
function Base.has_answer() return answerReceived end
function Base.is_active() return active end
function Base.is_paused() return paused end
local function load_question(index)
if #Questions == 0 then return false end
index = math.max(1, math.min(#Questions, tonumber(index) or 0))
local question = Questions[index]
local answers = question and question.answers or nil
local correct = question and tonumber(question.correct) or 0
if type(answers) ~= "table" or #answers ~= 4 or correct < 1 or correct > #answers then
return false
end
questionIndex, correctAnswer = index, correct
answerReceived = false
return true
end
-- Seleciona uma pergunta aleatoria.
function Base.select_question()
if #Questions == 0 then return false end
return load_question(math.random(1, #Questions))
end
-- Alias explicito para a opcao "Pergunta Aleatoria".
function Base.random()
if not active then return false end
return Base.select_question()
end
-- =========================================
-- CONTROLE DO QUIZ
-- =========================================
function Base.start()
Base.refresh_questions()
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
-- Avanca em sequencia e retorna a primeira pergunta depois da ultima.
function Base.next()
if not active or #Questions == 0 then return false end
local nextIndex = questionIndex + 1
if nextIndex > #Questions then nextIndex = 1 end
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
if not active or answerReceived or type(message) ~= "string" then return nil end
local answer = message:lower():match("^%s*(.-)%s*$")
local selected = ({ a = 1, b = 2, c = 3, d = 4 })[answer]
if not selected then return nil end
local q = current_question()
if not q or not q.answers or selected > #q.answers then return nil end
answerReceived = true
if selected == correctAnswer then
set_score(score + 1)
return true
end
return false
end
_G.QuizLabBase = Base
-- main.lua - comandos, controles, menus e integração.
Language.set("en")
local pauseMenuOpen, pauseMenuSelection, pauseMenuScreen = false, 1, "main"
local settingsSelection = 1
local paletteMode = "normal"
local scoreScroll = 0
local pauseMenuItems = {}
local pauseMenuInputsDown, pauseMenuStickCooldownY, pauseMenuStickCooldownX = 0, 0, 0
local pauseStartBlocked = false
local pendingMenuRefresh, menuCloseRenderFrames = false, 0
local MENU_CLOSE_ANIMATION_FRAMES = 26
local function is_host()
return type(network_is_server)=="function" and network_is_server()==true
end
local function get_tabs()
local t={"main","score","settings"}
if is_host() then t[#t+1]="info" end
return t
end
local function update_pause_menu_items()
if Base.is_active() then
pauseMenuItems={Language.get("RANDOM_QUESTION"),Language.get("NEXT_QUESTION"),Language.get("STOP_QUIZ")}
else
pauseMenuItems={Language.get("NEW_QUIZ")}
end
end
local function start_quiz()
if not Base.start() then
djui_chat_message_create("\\#FF4D5A\\"..Language.get("ERR_LOAD"))
return false
end
return true
end
local function stop_quiz()
Base.stop()
end
local function next_question()
return Base.next()
end
local function random_question()
return Base.random()
end
local function open_pause_menu()
if pauseMenuOpen then return end
pauseMenuOpen=true
update_pause_menu_items()
pauseMenuSelection,pauseMenuScreen=1,"main"
scoreScroll=0
Base.set_paused(true)
pauseMenuInputsDown=gMarioStates[0].controller.buttonDown
play_sound(SOUND_MENU_PAUSE,gGlobalSoundSource)
end
local function close_pause_menu(closedWithStart,refreshAfterClose)
if not pauseMenuOpen then return end
pauseMenuOpen=false
pauseMenuSelection,pauseMenuScreen=1,"main"
Base.set_paused(false)
pauseMenuInputsDown=0
if closedWithStart then pauseStartBlocked=true end
if refreshAfterClose then
pendingMenuRefresh=true
menuCloseRenderFrames=0
end
play_sound(SOUND_MENU_CLICK_FILE_SELECT,gGlobalSoundSource)
end
local function change_pause_selection(d)
local n=#pauseMenuItems
if n==0 then return end
pauseMenuSelection=((pauseMenuSelection-1+d)%n)+1
play_sound(SOUND_MENU_CHANGE_SELECT,gGlobalSoundSource)
end
local function change_pause_tab(d)
local tabs,current=get_tabs(),1
for i,v in ipairs(tabs) do
if v==pauseMenuScreen then
current=i
break
end
end
pauseMenuScreen=tabs[((current-1+d)%#tabs)+1]
pauseMenuSelection=1
if pauseMenuScreen=="settings" then settingsSelection=1 end
if pauseMenuScreen=="score" then scoreScroll=0 end
play_sound(SOUND_MENU_CHANGE_SELECT,gGlobalSoundSource)
end
local function select_pause_item()
local selected=pauseMenuItems[pauseMenuSelection]
if selected==Language.get("NEW_QUIZ") then
if start_quiz() then
close_pause_menu(false,true)
djui_chat_message_create("\\#00FF75\\"..Language.get("NEW_STARTED"))
end
elseif selected==Language.get("RANDOM_QUESTION") then
if random_question() then
close_pause_menu(false,false)
end
elseif selected==Language.get("NEXT_QUESTION") then
if next_question() then
close_pause_menu(false,false)
end
elseif selected==Language.get("STOP_QUIZ") then
stop_quiz()
close_pause_menu(false,true)
djui_chat_message_create("\\#FF4D5A\\"..Language.get("STOPPED"))
end
end
local function handle_pause_menu_input(m)
if m.playerIndex~=0 then return end
if not pauseMenuOpen then
if (m.controller.buttonDown & START_BUTTON)==0 then
pauseStartBlocked=false
end
if not pauseStartBlocked and (m.controller.buttonPressed & START_BUTTON)~=0 then
m.controller.buttonPressed=m.controller.buttonPressed & ~START_BUTTON
open_pause_menu()
else
return
end
end
if m.freeze<3 then m.freeze=3 end
local pressed=m.controller.buttonDown & (m.controller.buttonDown ~ pauseMenuInputsDown)
pauseMenuInputsDown=m.controller.buttonDown
m.controller.buttonDown,m.controller.buttonPressed=0,0
m.controller.stickX,m.controller.stickY=0,0
if djui_hud_is_pause_menu_created() then
pauseMenuInputsDown=B_BUTTON
return
end
if (pressed & R_TRIG)~=0 then
djui_open_pause_menu()
return
end
if (pressed & START_BUTTON)~=0 then
close_pause_menu(true,false)
return
end
if pauseMenuScreen~="main" then
if pauseMenuScreen=="score" then
local sy=m.controller.rawStickY
if (pauseMenuInputsDown & D_JPAD)~=0 then sy=sy-65 end
if (pauseMenuInputsDown & U_JPAD)~=0 then sy=sy+65 end
if pauseMenuStickCooldownY>0 then
pauseMenuStickCooldownY=pauseMenuStickCooldownY-1
end
if pauseMenuStickCooldownY==0 then
if sy>64 then
scoreScroll=math.max(0,scoreScroll-1)
pauseMenuStickCooldownY=4
elseif sy< -64 then
scoreScroll=scoreScroll+1
pauseMenuStickCooldownY=4
end
end
elseif pauseMenuScreen=="settings" then
local sy=m.controller.rawStickY
if (pauseMenuInputsDown & D_JPAD)~=0 then sy=sy-65 end
if (pauseMenuInputsDown & U_JPAD)~=0 then sy=sy+65 end
if pauseMenuStickCooldownY>0 then pauseMenuStickCooldownY=pauseMenuStickCooldownY-1 end
if pauseMenuStickCooldownY==0 then
if sy>64 then
settingsSelection=math.max(1,settingsSelection-1)
pauseMenuStickCooldownY=5
play_sound(SOUND_MENU_CHANGE_SELECT,gGlobalSoundSource)
elseif sy< -64 then
settingsSelection=math.min(2,settingsSelection+1)
pauseMenuStickCooldownY=5
play_sound(SOUND_MENU_CHANGE_SELECT,gGlobalSoundSource)
end
end
if (pressed & A_BUTTON)~=0 then
if settingsSelection==1 then
Language.toggle()
Base.refresh_questions()
update_pause_menu_items()
else
paletteMode=paletteMode=="normal" and "inverted" or "normal"
end
play_sound(SOUND_MENU_CHANGE_SELECT,gGlobalSoundSource)
end
end
if (pressed & B_BUTTON)~=0 then
pauseMenuScreen,pauseMenuSelection="main",1
scoreScroll=0
play_sound(SOUND_MENU_CLICK_FILE_SELECT,gGlobalSoundSource)
end
else
local sy=m.controller.rawStickY
if (pauseMenuInputsDown & D_JPAD)~=0 then sy=sy-65 end
if (pauseMenuInputsDown & U_JPAD)~=0 then sy=sy+65 end
if pauseMenuStickCooldownY>0 then
pauseMenuStickCooldownY=pauseMenuStickCooldownY-1
end
if pauseMenuStickCooldownY==0 then
if sy>64 then
change_pause_selection(-1)
pauseMenuStickCooldownY=5
elseif sy< -64 then
change_pause_selection(1)
pauseMenuStickCooldownY=5
end
end
if (pressed & A_BUTTON)~=0 then
select_pause_item()
end
if (pressed & B_BUTTON)~=0 then
close_pause_menu()
end
end
local sx=m.controller.rawStickX
if (pauseMenuInputsDown & L_JPAD)~=0 then sx=sx-65 end
if (pauseMenuInputsDown & R_JPAD)~=0 then sx=sx+65 end
if pauseMenuStickCooldownX>0 then
pauseMenuStickCooldownX=pauseMenuStickCooldownX-1
end
if pauseMenuStickCooldownX==0 then
if sx>64 then
change_pause_tab(1)
pauseMenuStickCooldownX=7
elseif sx< -64 then
change_pause_tab(-1)
pauseMenuStickCooldownX=7
end
end
end
local function before_mario_update(m)
if m.playerIndex==0 then
handle_pause_menu_input(m)
end
end
local function after_pause_close_render()
if not pendingMenuRefresh or pauseMenuOpen then return end
menuCloseRenderFrames=menuCloseRenderFrames+1
if menuCloseRenderFrames>=MENU_CLOSE_ANIMATION_FRAMES then
update_pause_menu_items()
pendingMenuRefresh=false
menuCloseRenderFrames=0
end
end
local function quiz_command(message)
local c=(message or ""):lower():match("^%s*(.-)%s*$")
if c=="" or c=="start" then
if start_quiz() then
update_pause_menu_items()
djui_chat_message_create("\\#00FF75\\"..Language.get("STARTED"))
end
elseif c=="stop" then
stop_quiz()
update_pause_menu_items()
djui_chat_message_create("\\#FF4D5A\\"..Language.get("STOPPED"))
elseif c=="next" then
if next_question() then
djui_chat_message_create("\\#00FF75\\"..Language.get("NEXT"))
end
elseif c=="random" then
if random_question() then
djui_chat_message_create("\\#00FF75\\"..Language.get("NEXT"))
end
elseif c=="score" then
if not pauseMenuOpen then
open_pause_menu()
end
pauseMenuScreen="score"
scoreScroll=0
end
return true
end
local function on_chat_message(m,message)
if not m or m.playerIndex~=0 or not Base.is_active() then
return true
end
local result=Base.check_answer(message)
if result==true then
djui_chat_message_create("\\#00FF75\\"..Language.get("CORRECT"))
return false
elseif result==false then
djui_chat_message_create("\\#FF4D5A\\"..Language.get("WRONG"))
return false
end
return true
end
hook_chat_command("quiz",Language.get("CHAT_HELP"),quiz_command)
hook_event(HOOK_ON_CHAT_MESSAGE,on_chat_message)
hook_event(HOOK_BEFORE_MARIO_UPDATE,before_mario_update)
hook_event(HOOK_ON_HUD_RENDER,after_pause_close_render)
_G.QuizLab={
is_active=Base.is_active,
is_paused=Base.is_paused,
is_pause_menu_open=function() return pauseMenuOpen end,
get_pause_menu_screen=function() return pauseMenuScreen end,
get_pause_menu_items=function() return pauseMenuItems end,
get_pause_menu_selection=function() return pauseMenuSelection end,
get_current_question=Base.get_current_question,
get_question_index=Base.get_question_index,
get_question_count=Base.get_question_count,
get_correct_answer=Base.get_correct_answer,
get_score=Base.get_score,
get_player_score=Base.get_player_score,
has_answer=Base.has_answer,
get_language=Language.get_current,
set_language=function(code)
local ok=Language.set(code)
if ok then
Base.refresh_questions()
update_pause_menu_items()
end
return ok
end,
toggle_language=function()
local v=Language.toggle()
Base.refresh_questions()
update_pause_menu_items()
return v
end,
get_hud_size=function() return 10 end,
get_quiz_hud_size=function() return 10 end,
get_score_scroll=function()
return scoreScroll
end,
set_score_scroll=function(value)
scoreScroll=math.max(0,tonumber(value) or 0)
end,
get_settings_selection=function()
return settingsSelection
end,
get_palette_mode=function()
return paletteMode
end,
toggle_palette=function()
paletteMode=paletteMode=="normal" and "inverted" or "normal"
return paletteMode
end,
is_host=is_host,
start=start_quiz,
stop=stop_quiz,
next=next_question,
random=random_question,
get_text=Language.get
}
update_pause_menu_items()
-- Carrega o HUD depois de registrar a API global do QuizLab.
do
-- QuizLab v2.1 - hud.lua
-- Interface, placar, animações e renderização.
local QuizLab=nil
local PALETTES={
BLUE={BLUE={22,140,255,255},GREEN={0,255,117,255},BG={7,17,28,232},PANEL={13,29,46,255},SECONDARY={169,189,209,255},DIM={65,91,116,220}},
GREEN={BLUE={0,255,117,255},GREEN={22,140,255,255},BG={7,28,17,232},PANEL={13,46,29,255},SECONDARY={169,209,189,255},DIM={65,116,91,220}}
}
local WHITE={242,247,255,255}
local RED={255,77,90,255}
local C={}
local function set_palette(mode)
local v=mode=="inverted" and PALETTES.GREEN or PALETTES.BLUE
C.BLUE=v.BLUE C.GREEN=v.GREEN C.BG=v.BG C.PANEL=v.PANEL C.SECONDARY=v.SECONDARY C.DIM=v.DIM C.WHITE=WHITE C.RED=RED
end
HudTabQuizSizeX,HudTabQuizSizeY=52,45
HudTabPlacarSizeX,HudTabPlacarSizeY=96,100
HudTabConfigSizeX,HudTabConfigSizeY=60,78
HudSizeXAtual,HudSizeYAtual=HudTabQuizSizeX,HudTabQuizSizeY
local animAlpha,animScale,animOffsetY,panelAlpha=1,1,0,1
local animCenterX,animCenterY=0,0
local activeScaleMode="quiz"
local function quiz_scale()
return 1.9
end
-- Pause permanentemente no tamanho máximo.
local function pause_scale()
return 60/45
end
local function ui_scale()
return activeScaleMode=="pause" and pause_scale() or quiz_scale()
end
local function ease_out(t)
return 1-(1-t)*(1-t)*(1-t)
end
local function tr(k,...)
return Language.get(k,...)
end
local function color(c)
djui_hud_set_color(c[1],c[2],c[3],math.floor(c[4]*animAlpha))
end
local function panel_color(c)
djui_hud_set_color(c[1],c[2],c[3],math.floor(c[4]*panelAlpha))
end
local function text(t,x,y,s)
local u=ui_scale()
x=animCenterX+(x-animCenterX)*animScale*u
y=animCenterY+(y-animCenterY)*animScale*u+animOffsetY
djui_hud_print_text(tostring(t),x,y,s*animScale*u)
end
local function rect(x,y,w,h)
local u=ui_scale()
x=animCenterX+(x-animCenterX)*animScale*u
y=animCenterY+(y-animCenterY)*animScale*u+animOffsetY
djui_hud_render_rect(x,y,w*animScale*u,h*animScale*u)
end
local function fixed_rect(x,y,w,h)
djui_hud_render_rect(x,y,w,h)
end
local pauseAnimFrame,quizAnimFrame=24,24
local wasPauseOpen,wasQuizVisible=false,false
local lastPauseScreen,displayedPauseScreen,targetPauseScreen=nil,nil,nil
local pauseTransitionFrame,pauseTargetScale,pauseStartScale,pauseClosingFrame=30,1,1,nil
local function set_animation(frame)
local t=math.min(1,frame/24)
local e=ease_out(t)
animAlpha=e
animScale=0.86+0.14*e+math.sin(t*math.pi*2)*(1-t)*0.025
animOffsetY=(1-e)*25+math.sin(t*math.pi*2)*(1-t)*3
end
local function get_tabs()
local t={
{id="main",label=tr("TAB_QUIZ")},
{id="score",label=tr("TAB_SCORE")},
{id="settings",label=tr("TAB_SETTINGS")}
}
if QuizLab.is_host and QuizLab.is_host() then
t[#t+1]={id="info",label=tr("TAB_INFO")}
end
return t
end
local function draw_tabs(x,y,w,active)
local tabs=get_tabs()
local unit=w/#tabs
local tx=x
for i,tab in ipairs(tabs) do
local width=(i==#tabs) and (x+w-tx) or unit
if tab.id==active then
color(C.BLUE)
rect(tx,y+58,width,30)
color(C.BG)
else
color(C.SECONDARY)
end
local s=math.min(0.55,width/(math.max(5,#tab.label)*9))
text(tab.label,tx+8,y+67,s)
tx=tx+width
end
color(C.DIM)
rect(x,y+88,w,2)
end
local function draw_score(x,y,w,h)
local players={}
for i=0,(MAX_PLAYERS or 1)-1 do
local p=gNetworkPlayers and gNetworkPlayers[i]
if p and p.connected then
local value=QuizLab.get_player_score and (QuizLab.get_player_score(i) or 0)
or (i==0 and (QuizLab.get_score() or 0) or 0)
players[#players+1]={
index=i,
name=p.name or ("Player "..(i+1)),
score=value
}
end
end
if #players==0 then
players[1]={
index=0,
name="Player",
score=QuizLab.get_score() or 0
}
end
table.sort(players,function(a,b)
if a.score==b.score then
return a.index<b.index
end
return a.score>b.score
end)
local localRank=0
for i,p in ipairs(players) do
if p.index==0 then localRank=i end
end
color(C.WHITE)
text(tr("SCORE_TITLE"),x+25,y+96,0.82)
color(C.SECONDARY)
text(tr("YOUR_SCORE"),x+28,y+132,0.52)
color(C.GREEN)
text(tostring(QuizLab.get_score() or 0),x+28,y+151,1.05)
color(C.SECONDARY)
text("RANK  "..tostring(localRank).." / "..tostring(#players),x+135,y+160,0.48)
color(C.DIM)
rect(x+24,y+190,w-48,2)
color(C.SECONDARY)
text("#",x+34,y+201,0.44)
text(tr("PLAYER"),x+82,y+201,0.44)
text(tr("POINTS_COLUMN"),x+w-105,y+201,0.44)
local rowY,rowH=y+225,27
local available=math.max(1,math.floor((h-285)/rowH))
local maxScroll=math.max(0,#players-available)
local scroll=math.max(
0,
math.min(maxScroll,QuizLab.get_score_scroll and QuizLab.get_score_scroll() or 0)
)
if QuizLab.set_score_scroll then
QuizLab.set_score_scroll(scroll)
end
local first,last=scroll+1,math.min(#players,scroll+available)
for i=first,last do
local p=players[i]
local py=rowY+(i-first)*rowH
if p.index==0 then
color(C.GREEN)
rect(x+22,py-3,w-44,24)
color(C.BG)
elseif i==1 then
color({235,185,55,255})
rect(x+22,py-3,4,24)
color(C.WHITE)
elseif i==2 then
color({155,174,190,255})
rect(x+22,py-3,4,24)
color(C.WHITE)
elseif i==3 then
color({183,116,75,255})
rect(x+22,py-3,4,24)
color(C.WHITE)
else
color(C.WHITE)
end
text(string.format("%02d",i),x+34,py,0.46)
local name=tostring(p.name or "Player")
local ns=math.max(0.28,math.min(0.46,(w-205)/(math.max(1,#name)*8)))
text(name,x+82,py,ns)
text(tostring(p.score),x+w-102,py,0.46)
end
if localRank>last or (localRank>0 and localRank<first) then
color(C.GREEN)
text("YOU  #"..localRank.."  -  "..tostring(QuizLab.get_score() or 0),x+28,y+h-47,0.44)
end
color(C.SECONDARY)
text(tr("SCORE_SCROLL"),x+28,y+h-27,0.38)
text(tr("BACK"),x+w-100,y+h-27,0.38)
end
local function draw_settings(x,y,w,h)
local selected=QuizLab.get_settings_selection and QuizLab.get_settings_selection() or 1
color(C.WHITE)
text(tr("SETTINGS_TITLE"),x+24,y+104,0.78)
color(C.SECONDARY)
text(tr("RESPONSE_MODE"),x+28,y+143,0.47)
color(C.GREEN)
text(tr("RESPONSE_CHAT"),x+48,y+163,0.49)
local paletteValue=QuizLab.get_palette_mode and QuizLab.get_palette_mode()=="inverted" and tr("PALETTE_INVERTED") or tr("PALETTE_NORMAL")
local rows={tr("SETTING_LANGUAGE",tr("LANGUAGE_VALUE")),tr("SETTING_PALETTE",paletteValue)}
for i,label in ipairs(rows) do
local iy=y+195+(i-1)*38
if selected==i then
color(C.GREEN)
rect(x+18,iy-4,w-36,29)
color(C.BG)
text("> "..label,x+30,iy,0.54)
else
color(C.WHITE)
text(label,x+38,iy,0.54)
end
end
color(C.SECONDARY)
text(tr("SETTINGS_HINT"),x+24,y+h-42,0.38)
text(tr("BACK"),x+24,y+h-23,0.38)
end
local function draw_info(x,y,h)
color(C.WHITE)
text(tr("INFO_TITLE"),x+24,y+116,0.72)
color(C.GREEN)
text(tr("INFO_VERSION"),x+24,y+166,0.58)
color(C.SECONDARY)
text(tr("INFO_HOST"),x+24,y+205,0.48)
color(C.WHITE)
text(tr("INFO_QUESTIONS",QuizLab.get_question_count()),x+24,y+244,0.5)
color(C.SECONDARY)
text(tr("INFO_COMMANDS"),x+24,y+285,0.38)
text(tr("BACK"),x+24,y+h-28,0.48)
end
local function get_connected_players()
local n=0
for i=0,(MAX_PLAYERS or 1)-1 do
local p=gNetworkPlayers and gNetworkPlayers[i]
if p and p.connected then
n=n+1
end
end
return math.max(1,n)
end
local function get_tab_size(screen)
if screen=="score" then
local n=get_connected_players()
local sh=djui_hud_get_screen_height()
local scale=pause_scale()
local maxLogical=math.min(900,sh*0.92/math.max(1,scale))
local needed=285+27*n
local target=math.min(maxLogical,math.max(sh*0.45,needed))
return 96,(target/math.max(1,sh))*100
end
if screen=="settings" then return 72,78 end
if screen=="info" then return 60,68 end
if screen=="main" and #QuizLab.get_pause_menu_items()>=3 then
return 58,60
end
return 52,45
end
local function update_panel_size(screen,snap)
local tx,ty=get_tab_size(screen)
if snap then
HudSizeXAtual,HudSizeYAtual=tx,ty
else
HudSizeXAtual=HudSizeXAtual+(tx-HudSizeXAtual)*0.18
HudSizeYAtual=HudSizeYAtual+(ty-HudSizeYAtual)*0.18
if math.abs(tx-HudSizeXAtual)<0.15 then HudSizeXAtual=tx end
if math.abs(ty-HudSizeYAtual)<0.15 then HudSizeYAtual=ty end
end
end
local function draw_pause(screenOverride,forceRender)
if not forceRender and not QuizLab.is_pause_menu_open() then
return
end
activeScaleMode="pause"
local w,h=djui_hud_get_screen_width(),djui_hud_get_screen_height()
local us=ui_scale()
local pw=math.min(w*HudSizeXAtual/100,900,w*0.94/us)
local ph=math.min(h*HudSizeYAtual/100,900,h*0.92/us)
local x,y=(w-pw)/2,(h-ph)/2
djui_hud_set_color(C.BG[1],C.BG[2],C.BG[3],225)
fixed_rect(0,0,w,h)
panel_color(C.PANEL)
rect(x,y,pw,ph)
panel_color(C.BLUE)
rect(x,y,pw,4)
local screen=screenOverride or QuizLab.get_pause_menu_screen()
color(C.GREEN)
text(tr("PAUSED_TITLE"),x+24,y+23,0.82)
draw_tabs(x,y,pw,screen)
if screen=="score" then
draw_score(x,y,pw,ph)
return
end
if screen=="settings" then
draw_settings(x,y,pw,ph)
return
end
if screen=="info" then
draw_info(x,y,ph)
return
end
color(C.WHITE)
text(tr("POINTS",tostring(QuizLab.get_score())),x+24,y+105,0.65)
local items,selected=QuizLab.get_pause_menu_items(),QuizLab.get_pause_menu_selection()
local count=#items
local gap=count>1 and math.min(42,math.max(34,(ph-190)/(count-1))) or 48
local start=count>1 and 132 or 145
for i,item in ipairs(items) do
local iy=y+start+(i-1)*gap
if i==selected then
color(C.GREEN)
rect(x+18,iy-5,pw-36,math.min(36,gap-4))
color(C.BG)
text("> "..item,x+30,iy,0.75)
else
color(C.WHITE)
text(item,x+38,iy,0.75)
end
end
color(C.SECONDARY)
text(tr("SELECT").."    "..tr("CLOSE"),x+24,y+ph-28,0.43)
end
local function measured_width(v)
local s=tostring(v or "")
if type(djui_hud_measure_text)=="function" then
local ok,r=pcall(djui_hud_measure_text,s)
if ok and tonumber(r) then
return tonumber(r)
end
end
return #s*8
end
local function wrap_text(v,maxWidth,scale)
local lines,line={},""
for word in tostring(v or ""):gmatch("%S+") do
local c=line=="" and word or (line.." "..word)
if line=="" or measured_width(c)*scale<=maxWidth then
line=c
else
lines[#lines+1]=line
line=word
end
end
if line~="" then
lines[#lines+1]=line
end
if #lines==0 then
lines[1]=""
end
return lines
end
local function draw_wrapped(lines,x,y,s,lh)
for i,v in ipairs(lines) do
text(v,x,y+(i-1)*lh,s)
end
return #lines*lh
end
local function draw_quiz_background(dh)
local sw,sh=djui_hud_get_screen_width(),djui_hud_get_screen_height()
local u=ui_scale()
local qw=math.min(sw*0.76/u,680/u)
local qh=math.min(sh*0.72/u,math.max(190,dh or 190))
local mx,my=sw*0.035,sh*0.045
local qx=sw/2+(mx-sw/2)/u
local qy=sh/2+(my-sh/2)/u
color(C.BG)
rect(qx,qy,qw,qh)
color(C.DIM)
rect(qx,qy,qw,5)
local total=math.max(1,tonumber(QuizLab.get_question_count()) or 1)
local current=math.max(0,math.min(tonumber(QuizLab.get_question_index()) or 0,total))
local pw=(qw/total)*current
if pw>0 then
color(C.BLUE)
rect(qx,qy,pw,5)
end
return qx,qy,qw,qh
end
local function draw_quiz()
activeScaleMode="quiz"
if not QuizLab.is_active() or QuizLab.is_pause_menu_open() then
return
end
local q=QuizLab.get_current_question()
if not q then return end
local answers=q.answers or {}
local n=math.min(4,#answers)
local sw,sh=djui_hud_get_screen_width(),djui_hud_get_screen_height()
local u=ui_scale()
local qw=math.min(sw*0.76/u,680/u)
local cw=math.max(100,qw-38)
local fs=math.max(0.62,math.min(1.12,qw/500))
local ql,al,counts,qlh,alh,gap,content
for attempt=1,5 do
qlh,alh,gap=19*fs,18*fs,7*fs
ql=wrap_text(q.question or tr("INVALID_QUESTION"),cw,0.70*fs)
al,counts={},{}
for i=1,n do
al[i]=wrap_text(answers[i],cw-34*fs,0.62*fs)
counts[i]=#al[i]
end
local yy=76*fs+#ql*qlh+13*fs
for i=1,n do
yy=yy+math.max(1,counts[i])*alh+gap
end
content=yy+34*fs
local mh=sh*0.72/u
if content<=mh or fs<=0.62 then
break
end
fs=math.max(0.62,fs*math.max(0.72,(mh-12)/content))
end
local x,y,w,h=draw_quiz_background(content)
local function px(v) return x+v end
local function py(v) return y+v end
color(C.WHITE)
text("QUIZLAB",px(18),py(17*fs),1.05*fs)
color(C.GREEN)
text(tr("QUIZ_POINTS",tostring(QuizLab.get_score())),px(w-175*fs),py(19*fs),0.62*fs)
color(C.SECONDARY)
text(tr("QUESTION",tostring(QuizLab.get_question_index()),tostring(QuizLab.get_question_count())),px(18),py(49*fs),0.52*fs)
local cy=76*fs
color(C.WHITE)
cy=cy+draw_wrapped(ql,px(18),py(cy),0.70*fs,qlh)+13*fs
local letters={"A","B","C","D"}
for i=1,n do
if QuizLab.has_answer() and QuizLab.get_correct_answer()==i then
color(C.GREEN)
elseif QuizLab.has_answer() then
color(C.RED)
else
color(C.GREEN)
end
text(letters[i]..")",px(18),py(cy),0.62*fs)
color(C.WHITE)
draw_wrapped(al[i],px(48),py(cy),0.62*fs,alh)
cy=cy+#al[i]*alh+gap
end
color(C.SECONDARY)
text(
(q.category or tr("CATEGORY_DEFAULT")).." / "..tostring(q.subcategory or ""),
px(18),
py(math.min(h-25*fs,cy+4*fs)),
0.46*fs
)
end
local function on_hud_render()
djui_hud_set_resolution(RESOLUTION_DJUI)
djui_hud_set_font(FONT_NORMAL)
QuizLab=_G.QuizLab
if not QuizLab then return end
set_palette(QuizLab.get_palette_mode and QuizLab.get_palette_mode() or "normal")
local po=QuizLab.is_pause_menu_open()
local qv=QuizLab.is_active() and not po
local screen=po and QuizLab.get_pause_menu_screen() or nil
if po and not wasPauseOpen then
pauseAnimFrame=0
pauseClosingFrame=nil
displayedPauseScreen=screen or "main"
targetPauseScreen=displayedPauseScreen
pauseTransitionFrame=30
pauseTargetScale=displayedPauseScreen=="score" and 1.10 or 1
update_panel_size(displayedPauseScreen,true)
elseif po and screen~=lastPauseScreen then
pauseStartScale=displayedPauseScreen=="score" and 1.10 or 1
targetPauseScreen=screen
pauseTransitionFrame=0
pauseTargetScale=screen=="score" and 1.10 or 1
end
if po and pauseTransitionFrame>=8 then
update_panel_size(screen,false)
end
if qv and not wasQuizVisible then
quizAnimFrame=0
end
if wasPauseOpen and not po then
pauseClosingFrame=0
displayedPauseScreen=displayedPauseScreen or lastPauseScreen or "main"
targetPauseScreen=displayedPauseScreen
end
wasPauseOpen,wasQuizVisible=po,qv
lastPauseScreen=screen
animCenterX,animCenterY=
djui_hud_get_screen_width()/2,
djui_hud_get_screen_height()/2
if po then
activeScaleMode="pause"
if pauseTransitionFrame<30 then
pauseTransitionFrame=math.min(30,pauseTransitionFrame+1)
local f=pauseTransitionFrame
if f<8 then
animAlpha=1-f/8
panelAlpha=1
animScale=displayedPauseScreen=="score" and 1.10 or 1
animOffsetY=0
elseif f<18 then
displayedPauseScreen=targetPauseScreen
animAlpha=0
panelAlpha=1
local t=ease_out((f-8)/10)
animScale=pauseStartScale+(pauseTargetScale-pauseStartScale)*t
animOffsetY=0
else
displayedPauseScreen=targetPauseScreen
animAlpha=ease_out((f-18)/12)
panelAlpha=1
animScale=pauseTargetScale
animOffsetY=0
end
else
pauseAnimFrame=math.min(24,pauseAnimFrame+1)
panelAlpha=1
set_animation(pauseAnimFrame)
if displayedPauseScreen=="score" then
animScale=1.10
end
end
draw_pause(displayedPauseScreen)
animAlpha,animScale,animOffsetY,panelAlpha=1,1,0,1
return
end
if pauseClosingFrame~=nil then
activeScaleMode="pause"
pauseClosingFrame=math.min(24,pauseClosingFrame+1)
local e=ease_out(pauseClosingFrame/24)
animAlpha=1-e
panelAlpha=1-e
animScale=1-0.14*e
animOffsetY=18*e
draw_pause(displayedPauseScreen,true)
if pauseClosingFrame>=24 then
pauseClosingFrame=nil
displayedPauseScreen=nil
targetPauseScreen=nil
end
animAlpha,animScale,animOffsetY,panelAlpha=1,1,0,1
return
end
activeScaleMode="quiz"
if qv then
quizAnimFrame=math.min(24,quizAnimFrame+1)
set_animation(quizAnimFrame)
draw_quiz()
else
animAlpha,animScale,animOffsetY=1,1,0
end
animAlpha,animScale,animOffsetY,panelAlpha=1,1,0,1
end
hook_event(HOOK_ON_HUD_RENDER,on_hud_render)
end
