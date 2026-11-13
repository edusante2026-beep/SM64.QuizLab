-- QuizLab - hud.lua
local QuizLab = nil
local Language = require("language")
local BLUE={22,140,255,255}
local GREEN={0,255,117,255}
local BG={7,17,28,232}
local PANEL={13,29,46,255}
local WHITE={242,247,255,255}
local SECONDARY={169,189,209,255}
local RED={255,77,90,255}

HudTabQuizSizeX, HudTabQuizSizeY = 52, 45
HudTabPlacarSizeX, HudTabPlacarSizeY = 84, 92
HudTabConfigSizeX, HudTabConfigSizeY = 52, 60
HudSizeXAtual, HudSizeYAtual = HudTabQuizSizeX, HudTabQuizSizeY

local logoTexture = get_texture_info("QL_logo")
if not logoTexture then
    print(Language.get("LOGO_ERROR")); print(Language.get("LOGO_CHECK"))
else
    print(Language.get("LOGO_OK", tostring(logoTexture.width), tostring(logoTexture.height)))
end

local animAlpha, animScale, animOffsetY, panelAlpha = 1,1,0,1
local animCenterX, animCenterY = 0,0
local function ui_scale()
    local level = QuizLab and QuizLab.get_hud_size and QuizLab.get_hud_size() or 1
    return 1.0 + (math.max(1, math.min(5, tonumber(level) or 1)) - 1) * 0.10
end
local function ease_out(t) return 1-(1-t)*(1-t)*(1-t) end
local function tr(key, ...) return Language.get(key, ...) end
local function color(c) djui_hud_set_color(c[1],c[2],c[3],math.floor(c[4]*animAlpha)) end
local function panel_color(c) djui_hud_set_color(c[1],c[2],c[3],math.floor(c[4]*panelAlpha)) end
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
local function fixed_rect(x,y,w,h) djui_hud_render_rect(x,y,w,h) end
local function draw_logo(x,y,size)
    if not logoTexture then return end
    local u=ui_scale()
    x=animCenterX+(x-animCenterX)*animScale*u; y=animCenterY+(y-animCenterY)*animScale*u+animOffsetY
    djui_hud_set_color(255,255,255,math.floor(255*animAlpha))
    djui_hud_render_texture(logoTexture,x,y,size/256*animScale*u,size/256*animScale*u)
end

local pauseAnimFrame, quizAnimFrame = 24,24
local wasPauseOpen, wasQuizVisible = false,false
local lastPauseScreen, displayedPauseScreen, targetPauseScreen = nil,nil,nil
local pauseTransitionFrame, pauseTargetScale, pauseStartScale, pauseClosingFrame = 30,1,1,nil
local function set_animation(frame)
    local t=math.min(1,frame/24); local e=ease_out(t)
    animAlpha=e; animScale=0.86+0.14*e+math.sin(t*math.pi*2)*(1-t)*0.025
    animOffsetY=(1-e)*25+math.sin(t*math.pi*2)*(1-t)*3
end

local function get_tabs()
    local tabs={{id="main",label=tr("TAB_QUIZ")},{id="score",label=tr("TAB_SCORE")},{id="settings",label=tr("TAB_SETTINGS")}}
    if QuizLab.is_host and QuizLab.is_host() then tabs[#tabs+1]={id="info",label=tr("TAB_INFO")} end
    return tabs
end

local function draw_tabs(x,y,w,active)
    local tabs=get_tabs(); local unit=w/#tabs; local tx=x
    for i,tab in ipairs(tabs) do
        local width=(i==#tabs) and (x+w-tx) or unit
        if tab.id==active then color(BLUE); rect(tx,y+58,width,30); color(WHITE) else color(SECONDARY) end
        local scale=math.min(0.55, width/(math.max(5,#tab.label)*9))
        text(tab.label,tx+8,y+67,scale)
        tx=tx+width
    end
    color({65,91,116,220}); rect(x,y+88,w,2)
end

local function draw_score(x,y,w,h)
    color(WHITE); text(tr("SCORE_TITLE"),x+28,y+105,0.8)
    color(SECONDARY); text(tr("YOUR_SCORE"),x+28,y+150,0.58)
    color(GREEN); text(QuizLab.get_score() or 0,x+w-105,y+174,1.875)
    color(BLUE); rect(x+28,y+220,w-56,3)
    color(SECONDARY); text("#",x+34,y+234,0.52); text(tr("PLAYER"),x+82,y+234,0.52); text(tr("POINTS_COLUMN"),x+w-112,y+234,0.52)
    local players={}
    for i=0,(MAX_PLAYERS or 1)-1 do
        local p=gNetworkPlayers and gNetworkPlayers[i]
        if p and p.connected then
            local value = QuizLab.get_player_score
    and (QuizLab.get_player_score(i) or 0)
    or (i == 0 and (QuizLab.get_score() or 0) or 0)
            players[#players+1]={index=i,name=p.name or ("Player "..(i+1)),score=value}
        end
    end
    if #players==0 then players[1]={index=0,name="Player",score=QuizLab.get_score() or 0} end
    table.sort(players,function(a,b) if a.score==b.score then return a.index<b.index end return a.score>b.score end)
    local rowY,rowH=y+262,30
    local shown=math.min(#players,math.max(1,math.floor((h-310)/rowH)))
    for i=1,shown do
        local p=players[i]; local py=rowY+(i-1)*rowH
        if p.index==0 then color(GREEN); rect(x+24,py-5,w-48,27); color(BG) else color(WHITE) end
        text(i,x+38,py,0.55)
        local name=tostring(p.name or "Player")
        local nameScale=math.max(0.20,math.min(0.44,(w-225)/(math.max(1,#name)*8)))
        color(p.index==0 and BG or WHITE); text(name,x+82,py,nameScale)
        text(p.score,x+w-105,py,0.5)
    end
    color(SECONDARY); text(tr("BACK"),x+28,y+h-28,0.48)
end

local function draw_settings(x,y,w,h)
    local selected = QuizLab.get_settings_selection and QuizLab.get_settings_selection() or 1
    color(WHITE); text(tr("SETTINGS_TITLE"),x+24,y+112,0.82)
    color(SECONDARY); text(tr("RESPONSE_MODE"),x+28,y+158,0.53)
    color(GREEN); text(tr("RESPONSE_CHAT"),x+48,y+181,0.58)
    local rows = {
        { id=1, label=tr("SETTING_LANGUAGE",tr("LANGUAGE_VALUE")) },
        { id=2, label=tr("SETTING_HUD_SIZE",tostring(QuizLab.get_hud_size() or 1)) }
    }
    local rowY = { y+211, y+253 }
    for i,row in ipairs(rows) do
        local iy = rowY[i]
        if selected == row.id then
            color(GREEN); rect(x+18,iy-5,w-36,34)
            color(BG); text("> "..row.label,x+30,iy,0.65)
        else
            color(WHITE); text(row.label,x+38,iy,0.65)
        end
    end
    color(SECONDARY); text(tr("SETTINGS_HINT"),x+24,y+h-42,0.42)
    text(tr("BACK"),x+24,y+h-23,0.42)
end

local function draw_info(x,y,h)
    color(WHITE); text(tr("INFO_TITLE"),x+24,y+116,0.72)
    color(GREEN); text(tr("INFO_VERSION"),x+24,y+166,0.58)
    color(SECONDARY); text(tr("INFO_HOST"),x+24,y+205,0.48)
    color(WHITE); text(tr("INFO_QUESTIONS",QuizLab.get_question_count()),x+24,y+244,0.5)
    color(SECONDARY); text(tr("INFO_COMMANDS"),x+24,y+285,0.38)
    text(tr("BACK"),x+24,y+h-28,0.48)
end

local function get_tab_size(screen)
    if screen=="score" then return HudTabPlacarSizeX,HudTabPlacarSizeY end
    if screen=="settings" then return 68,78 end
    if screen=="info" then return 60,68 end

    if screen=="main" then
        local items = QuizLab.get_pause_menu_items()
        if #items >= 3 then return HudTabQuizSizeX,58 end
    end

    return HudTabQuizSizeX,HudTabQuizSizeY
end

local function update_panel_size(screen,snap)
    local targetX,targetY=get_tab_size(screen)
    if snap then HudSizeXAtual,HudSizeYAtual=targetX,targetY
    else
        HudSizeXAtual=HudSizeXAtual+(targetX-HudSizeXAtual)*0.18
        HudSizeYAtual=HudSizeYAtual+(targetY-HudSizeYAtual)*0.18
        if math.abs(targetX-HudSizeXAtual)<0.15 then HudSizeXAtual=targetX end
        if math.abs(targetY-HudSizeYAtual)<0.15 then HudSizeYAtual=targetY end
    end
end

local function draw_pause(screenOverride,forceRender)
    if not forceRender and not QuizLab.is_pause_menu_open() then return end
    local w,h=djui_hud_get_screen_width(),djui_hud_get_screen_height()
    local userScale=ui_scale()
    local pw,ph=math.min(w*HudSizeXAtual/100,600,w*0.94/userScale),math.min(h*HudSizeYAtual/100,500,h*0.92/userScale)
    local x,y=(w-pw)/2,(h-ph)/2
    djui_hud_set_color(2,7,15,225); fixed_rect(0,0,w,h)
    panel_color(PANEL); rect(x,y,pw,ph); panel_color(BLUE); rect(x,y,pw,4)
    local screen=screenOverride or QuizLab.get_pause_menu_screen()
    draw_logo(x+20,y+13,52); color(GREEN); text(tr("PAUSED_TITLE"),x+82,y+23,0.82)
    draw_tabs(x,y,pw,screen)
    if screen=="score" then draw_score(x,y,pw,ph); return end
    if screen=="settings" then draw_settings(x,y,pw,ph); return end
    if screen=="info" then draw_info(x,y,ph); return end
    color(WHITE); text(tr("POINTS",tostring(QuizLab.get_score())),x+24,y+105,0.65)
    local items,selected=QuizLab.get_pause_menu_items(),QuizLab.get_pause_menu_selection()
    local count=#items
    local rowGap=count>1 and math.min(42,math.max(34,(ph-190)/(count-1))) or 48
    local startY=count>1 and 132 or 145

    for i,item in ipairs(items) do
        local iy=y+startY+(i-1)*rowGap

        if i==selected then
            color(GREEN)
            rect(x+18,iy-5,pw-36,math.min(36,rowGap-4))
            color(BG)
            text("> "..item,x+30,iy,0.75)
        else
            color(WHITE)
            text(item,x+38,iy,0.75)
        end
    end
    color(SECONDARY); text(tr("SELECT").."    "..tr("CLOSE"),x+24,y+ph-28,0.43)
end

-- Mede a largura real quando a API disponibiliza djui_hud_measure_text.
-- O fallback por caracteres mantém compatibilidade com builds sem essa função.
local function measured_width(value)
    local s=tostring(value or "")
    if type(djui_hud_measure_text)=="function" then
        local ok,result=pcall(djui_hud_measure_text,s)
        if ok and tonumber(result) then return tonumber(result) end
    end
    return #s*8
end

local function wrap_text(value,maxWidth,fontScale)
    local source=tostring(value or "")
    local lines={}
    local line=""
    for word in source:gmatch("%S+") do
        local candidate=(line=="" and word or (line.." "..word))
        if line=="" or measured_width(candidate)*fontScale<=maxWidth then
            line=candidate
        else
            lines[#lines+1]=line
            line=word
        end
    end
    if line~="" then lines[#lines+1]=line end
    if #lines==0 then lines[1]="" end
    return lines
end

local function draw_wrapped(lines,x,y,fontScale,lineHeight)
    for i,line in ipairs(lines) do
        text(line,x,y+(i-1)*lineHeight,fontScale)
    end
    return #lines*lineHeight
end

local function draw_quiz_background(dynamicHeight)
    local sw,sh=djui_hud_get_screen_width(),djui_hud_get_screen_height()
    local u=ui_scale()
    local qw=math.min(sw*0.76/u,680/u)
    local maxHeight=sh*0.72/u
    local qh=math.min(maxHeight,math.max(190,dynamicHeight or 190))
    local marginX,marginY=sw*0.035,sh*0.045
    local qx=sw/2+(marginX-sw/2)/u
    local qy=sh/2+(marginY-sh/2)/u
    color(BG); rect(qx,qy,qw,qh); color({35,55,75,220}); rect(qx,qy,qw,5)
    local total=math.max(1,tonumber(QuizLab.get_question_count()) or 1)
    local current=tonumber(QuizLab.get_question_index()) or 0
    current=math.max(0,math.min(current,total))
    local progressWidth=(qw/total)*current
    if progressWidth>0 then color(BLUE); rect(qx,qy,progressWidth,5) end
    return qx,qy,qw,qh
end

local function draw_quiz()
    if not QuizLab.is_active() or QuizLab.is_pause_menu_open() then return end
    local q=QuizLab.get_current_question()
    if not q then return end

    local answers=q.answers or {}
    local answerCount=math.min(4,#answers)
    local sw,sh=djui_hud_get_screen_width(),djui_hud_get_screen_height()
    local u=ui_scale()
    local qw=math.min(sw*0.76/u,680/u)
    local contentWidth=math.max(100,qw-38)

    -- O tamanho da fonte é reduzido apenas quando necessário para caber
    -- todo o conteúdo na altura útil do painel.
    local fontScale=math.max(0.62,math.min(1.12,qw/500))
    local questionLines,answerLines,answerLineCounts
    local questionLineHeight,answerLineHeight,gapBetweenAnswers
    local contentHeight

    for attempt=1,5 do
        questionLineHeight=19*fontScale
        answerLineHeight=18*fontScale
        gapBetweenAnswers=7*fontScale
        questionLines=wrap_text(q.question or tr("INVALID_QUESTION"),contentWidth,0.70*fontScale)
        answerLines={}
        answerLineCounts={}
        for i=1,answerCount do
            local wrapped=wrap_text(answers[i],contentWidth-34*fontScale,0.62*fontScale)
            answerLines[i]=wrapped
            answerLineCounts[i]=#wrapped
        end

        local y=76*fontScale + #questionLines*questionLineHeight + 13*fontScale
        for i=1,answerCount do
            y=y+math.max(1,answerLineCounts[i])*answerLineHeight+gapBetweenAnswers
        end
        contentHeight=y+34*fontScale

        local maxHeight=sh*0.72/u
        if contentHeight<=maxHeight or fontScale<=0.62 then break end
        fontScale=math.max(0.62,fontScale*math.max(0.72,(maxHeight-12)/contentHeight))
    end

    local qx,qy,qw,qh=draw_quiz_background(contentHeight)
    local sx=fontScale
    local function px(v) return qx+v end
    local function py(v) return qy+v end

    color(WHITE); text("QUIZLAB",px(18),py(17*fontScale),1.05*fontScale)
    color(GREEN); text(tr("QUIZ_POINTS",tostring(QuizLab.get_score())),px(qw-175*fontScale),py(19*fontScale),0.62*fontScale)
    color(SECONDARY); text(tr("QUESTION",tostring(QuizLab.get_question_index()),tostring(QuizLab.get_question_count())),px(18),py(49*fontScale),0.52*fontScale)

    local currentY=76*fontScale
    color(WHITE)
    currentY=currentY+draw_wrapped(questionLines,px(18),py(currentY),0.70*fontScale,questionLineHeight)
    currentY=currentY+13*fontScale

    local letters={"A","B","C","D"}
    for i=1,answerCount do
        local wrapped=answerLines[i]
        if QuizLab.has_answer() and QuizLab.get_correct_answer()==i then color(GREEN)
        elseif QuizLab.has_answer() then color(RED)
        else color(GREEN) end
        text(letters[i]..")",px(18),py(currentY),0.62*fontScale)
        color(WHITE)
        draw_wrapped(wrapped,px(48),py(currentY),0.62*fontScale,answerLineHeight)
        currentY=currentY+#wrapped*answerLineHeight+gapBetweenAnswers
    end

    color(SECONDARY)
    text(q.category or tr("CATEGORY_DEFAULT"),px(18),py(math.min(qh-25*fontScale,currentY+4*fontScale)),0.46*fontScale)
end

local function on_hud_render()
    djui_hud_set_resolution(RESOLUTION_DJUI); djui_hud_set_font(FONT_NORMAL)
    QuizLab=_G.QuizLab; if not QuizLab then return end
    local pauseOpen=QuizLab.is_pause_menu_open()
    local quizVisible=QuizLab.is_active() and not pauseOpen
    local currentPauseScreen=pauseOpen and QuizLab.get_pause_menu_screen() or nil

    if pauseOpen and not wasPauseOpen then
        pauseAnimFrame=0; pauseClosingFrame=nil
        displayedPauseScreen=currentPauseScreen or "main"; targetPauseScreen=displayedPauseScreen
        pauseTransitionFrame=30; pauseTargetScale=(displayedPauseScreen=="score") and 1.10 or 1
        update_panel_size(displayedPauseScreen,true)
    elseif pauseOpen and currentPauseScreen~=lastPauseScreen then
        pauseStartScale=(displayedPauseScreen=="score") and 1.10 or 1
        targetPauseScreen=currentPauseScreen; pauseTransitionFrame=0
        pauseTargetScale=(currentPauseScreen=="score") and 1.10 or 1
    end

    if pauseOpen and pauseTransitionFrame>=8 then update_panel_size(currentPauseScreen,false) end
    if quizVisible and not wasQuizVisible then quizAnimFrame=0 end
    if wasPauseOpen and not pauseOpen then
        pauseClosingFrame=0; displayedPauseScreen=displayedPauseScreen or lastPauseScreen or "main"
        targetPauseScreen=displayedPauseScreen
    end
    wasPauseOpen,wasQuizVisible=pauseOpen,quizVisible; lastPauseScreen=currentPauseScreen
    animCenterX,animCenterY=djui_hud_get_screen_width()/2,djui_hud_get_screen_height()/2

    if pauseOpen then
        if pauseTransitionFrame<30 then
            pauseTransitionFrame=math.min(30,pauseTransitionFrame+1)
            local f=pauseTransitionFrame
            if f<8 then
                animAlpha=1-f/8; panelAlpha=1
                animScale=(displayedPauseScreen=="score") and 1.10 or 1; animOffsetY=0
            elseif f<18 then
                displayedPauseScreen=targetPauseScreen
                animAlpha=0; panelAlpha=1
                local t=ease_out((f-8)/10)
                animScale=pauseStartScale+(pauseTargetScale-pauseStartScale)*t; animOffsetY=0
            else
                displayedPauseScreen=targetPauseScreen
                animAlpha=ease_out((f-18)/12); panelAlpha=1
                animScale=pauseTargetScale; animOffsetY=0
            end
        else
            pauseAnimFrame=math.min(24,pauseAnimFrame+1); panelAlpha=1
            set_animation(pauseAnimFrame)
            if displayedPauseScreen=="score" then animScale=1.10 end
        end
        draw_pause(displayedPauseScreen)
        animAlpha,animScale,animOffsetY,panelAlpha=1,1,0,1; return
    end

    if pauseClosingFrame~=nil then
        pauseClosingFrame=math.min(24,pauseClosingFrame+1)
        local e=ease_out(pauseClosingFrame/24)
        animAlpha=1-e; panelAlpha=1-e; animScale=1-0.14*e; animOffsetY=18*e
        draw_pause(displayedPauseScreen,true)
        if pauseClosingFrame>=24 then pauseClosingFrame=nil; displayedPauseScreen=nil; targetPauseScreen=nil end
        animAlpha,animScale,animOffsetY,panelAlpha=1,1,0,1; return
    end
    if quizVisible then quizAnimFrame=math.min(24,quizAnimFrame+1); set_animation(quizAnimFrame); draw_quiz()
    else animAlpha,animScale,animOffsetY=1,1,0 end
    animAlpha,animScale,animOffsetY,panelAlpha=1,1,0,1
end

hook_event(HOOK_ON_HUD_RENDER,on_hud_render)
