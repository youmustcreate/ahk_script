#Requires AutoHotkey v2.0

SendMode "Input"

F1::{
    SendInput "^c"  ; 复制
}

F2::{
    SendInput "^v"  ; 粘贴
}

F3::{
    SendInput "{Alt down}{Tab}{Alt up}"   ; 上一个任务
}

F4::^1                ;  截图

F5::{
    SendInput "^x"    ;   剪切
}

MButton::{
    run "./c.exe"
}

RAlt::{
    SendInput "#{Down}"
}

+CapsLock::CapsLock

CapsLock::{
    SendInput "^c"      ;   查找 find
    SendInput "^f"      ;   查找 find
}






global CurrentBrightness := 50
global nircmdPath := "C:\APP\x64tools\nircmd.exe"

!WheelUp::
{
    if  CurrentBrightness < 96
    {
        global CurrentBrightness += 2
        SetBrightness()
    }
}

!WheelDown::{
    if CurrentBrightness > 4
    {
        global CurrentBrightness -= 2
        SetBrightness()
    }
}


;----------------------------explorer--------------------------------------------------
#HotIf WinActive("ahk_exe explorer.exe")
q::
{
    ; 获取当前获得焦点的控件类名
    focusedControlClass := ControlGetClassNN(ControlGetFocus("A"))
    ; 检查获得焦点的控件是否为编辑框或任何DesktopChildSiteBridge
    if (InStr(focusedControlClass, "Edit") > 0 or InStr(focusedControlClass, "Microsoft.UI.Content.DesktopChildSiteBridge") > 0)
    {
        SendInput "q"
    }
    else
    {
        SendInput "{Alt down}{Left}{Alt up}"
    }
}

e::
{
    focusedControlClass := ControlGetClassNN(ControlGetFocus("A"))
    ; 检查获得焦点的控件是否为编辑框或任何DesktopChildSiteBridge
    if (InStr(focusedControlClass, "Edit") > 0 or InStr(focusedControlClass, "Microsoft.UI.Content.DesktopChildSiteBridge") > 0)
    {
        SendInput "e"
    }
    else
    {
        SendInput "{Enter}"
    }
}

n::
{
    focusedControlClass := ControlGetClassNN(ControlGetFocus("A"))
    ; 检查获得焦点的控件是否为编辑框或任何DesktopChildSiteBridge
    if (InStr(focusedControlClass, "Edit") > 0 or InStr(focusedControlClass, "Microsoft.UI.Content.DesktopChildSiteBridge") > 0)
    {
        SendInput "n"
    }
    else
    {
        SendInput "^+n" ;新建文件夹
    }
}
#HotIf



;----------------------------chrome--------------------------------------------------
#HotIf WinActive("ahk_exe chrome.exe")
F11::
{
SendText "请帮我解释一下这是什么意思："
}

F12::
{
SendInput "作为翻译大师，请帮我翻译一下："
}
#HotIf



;----------------------------FoxitPDFEditor--------------------------------------------------
#HotIf WinActive("ahk_exe FoxitPDFEditor.exe")
F5::{
SendInput "^6"
SendInput "^a"
SendInput "^c"
SendInput "^6"
}
#HotIf



;----------------------------语雀--------------------------------------------------
#HotIf WinActive("ahk_exe 语雀.exe")

~LAlt::                                ; ~ 导致不影响 esc 本身功能
KeyLAlt(ThisHotkey)                    ; 命名的函数热键.
{
    static winc_presses := 0
    if winc_presses > 0                ; SetTimer 已经启动, 所以我们记录键击.
    {
        winc_presses += 1
        return
    }
    winc_presses := 1       ; 否则, 这是新开始系列中的首次按下. 把次数设为 1 并启动计时器
    SetTimer After180, -200 ; 在 200 毫秒内等待更多的键击.  将在 180 ms 后调用 After180, 然后删除定时器
    After180()              ; 这是一个嵌套函数.
    {
        if winc_presses = 2 ; 此键按下了两次.
        {
            SendInput "^!,"
        }
        winc_presses := 0   ; 不论触发了上面的哪个动作, 都对 count 进行重置  为下一个系列的按键做准备:
    }
}
`::
{
SendInput "{· 3}+{enter}"
}
-::
{
SendInput "{- 3}`n`n"
}
^w::
{
SendInput "{`n 20}"
}
F5::
{
SendInput "^u"
}
F6::
{
SendInput "{backspace}"
}
#HotIf


;----------------------------code--------------------------------------------------
#HotIf WinActive("ahk_exe code.exe")
RControl::{
    SendInput "^f"
}

PgUp::
{
    SendInput "{Shift down}{Enter}{Shift up}"
}
PgDn::{
    SendInput "{Enter}"
}

~Alt::                                 ; ~ 导致不影响 esc 本身功能
KeyWinssD(ThisHotkey)                    ; 命名的函数热键.
{
    static winc_presses := 0
    if winc_presses > 0                ; SetTimer 已经启动, 所以我们记录键击.
    {
        winc_presses += 1
        return
    }
    winc_presses := 1       ; 否则, 这是新开始系列中的首次按下. 把次数设为 1 并启动计时器
    SetTimer After180, -200 ; 在 200 毫秒内等待更多的键击.  将在 180 ms 后调用 After180, 然后删除定时器
    After180()              ; 这是一个嵌套函数.
    {
        if winc_presses = 2 ; 此键按下了两次.
        {
            SendInput "^b"
        }
        winc_presses := 0   ; 不论触发了上面的哪个动作, 都对 count 进行重置  为下一个系列的按键做准备:
    }
}
#HotIf



;----------------------------WinSCP.exe    --------------------------------------------------
#HotIf WinActive("ahk_exe WinSCP.exe")
q::Backspace
e::Enter
w::{
    SendInput "^!c"
}

#HotIf





;----------------------------pycharm64--------------------------------------------------
#HotIf WinActive("ahk_exe pycharm64.exe")
PgDn::
{
    SendInput "{F8}"
}
PgUp::{
    SendInput "{^F5}"
}
#HotIf



;----------------------------clion64--------------------------------------------------
#HotIf WinActive("ahk_exe clion64.exe")
PgDn::
{
    SendInput "{F8}"
}
PgUp::{
    SendInput "+{F9}"
}
RControl::{
    SendInput "+{F10}"
}

RAlt::{
    SendInput "^a"   ;
    SendInput "{Up}" ;
    SendText "#include `"some_header.h`"`r`r" ;
}
#HotIf



;----------------------------双击esc--------------------------------------------------
~Esc::                                 ; ~ 导致不影响 esc 本身功能
KeyWinD(ThisHotkey)                    ; 命名的函数热键.
{
    static winc_presses := 0
    if winc_presses > 0                ; SetTimer 已经启动, 所以我们记录键击.
    {
        winc_presses += 1
        return
    }
    winc_presses := 1       ; 否则, 这是新开始系列中的首次按下. 把次数设为 1 并启动计时器
    SetTimer After180, -200 ; 在 200 毫秒内等待更多的键击.  将在 180 ms 后调用 After180, 然后删除定时器
    After180()              ; 这是一个嵌套函数.
    {
        if winc_presses = 2 ; 此键按下了两次.
        {
            SendInput "{Alt down}{F4}{Alt up}"
        }
        winc_presses := 0   ; 不论触发了上面的哪个动作, 都对 count 进行重置  为下一个系列的按键做准备:
    }
}



;----------------------------鼠标光标右下角--------------------------------------------------
CoordMode "Mouse", "Screen"

global EWD_Triggered := false
global screenWidth   := A_ScreenWidth
global screenHeight  := A_ScreenHeight

; Loop{
;   MouseGetPos &EWD_MouseStartX, &EWD_MouseStartY
  
;   If (EWD_MouseStartX >= A_ScreenWidth - 1 && EWD_MouseStartY >= A_ScreenHeight - 1 )   {     ; 右下角多任务界面
;     If (!EWD_Triggered){
;       SendInput "^!{Tab}"
;       EWD_Triggered := true  
;     }
;   }
;   Else {
;     EWD_Triggered := false
;   }
;    Sleep 1
; }
; -------------------------------------------------------------------------------
; Win (Windows 徽标键).                                           #
; Alt                                                            !
; Ctrl                                                           ^
; Shift                                                          +      
; 符号可以用来组合任意两个按键或鼠标按钮                            &                          
; <!a 相当于 !a, 但只有使用左边的 Alt 键才可以触发.     左 alt + a         >  右


Loop {
    MouseGetPos &EWD_MouseStartX, &EWD_MouseStartY
    If (EWD_MouseStartX >= screenWidth - 1 && EWD_MouseStartY >= screenHeight - 1) {  ; 右下角多任务界面
        If (!EWD_Triggered) {
            SendInput "^!{Tab}"
            EWD_Triggered := true
        }
    }
    Else If (EWD_MouseStartX >= screenWidth - 1) {
        EWD_Triggered := false
    }
    Else {
        EWD_Triggered := false
    }
    Sleep 10
}






SetBrightness()
{
    RunWait(nircmdPath . " setbrightness " . CurrentBrightness, , "Hide")
}
