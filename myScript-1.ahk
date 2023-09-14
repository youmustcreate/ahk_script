#Requires AutoHotkey v2.0

SendMode "Input"

F1::
    {
        SendInput "^c"
    }

F2::
    {
        SendInput "^v"
    }

F3::
    {
        SendInput "{Alt down}{Tab}{Alt up}"
    }


F4::^x

F8::{
    SendInput "^x"
}


RAlt::{
    run "c.exe"
}


; MButton::
; {
;     SendInput "^1"
; }

; RAlt::#d ; 显示桌面


PrintScreen::
{
    SendInput "#+s"
}






+CapsLock::CapsLock
CapsLock::^1




#HotIf WinActive("ahk_exe chrome.exe")
PgDn::
{
SendInput "^{Tab}"
}
PgUp::
{
SendInput "^+{Tab}"
}
RControl::
{
SendInput "^w"
}
F8::
{
SendInput "^t"      ;打开新的标签页，并跳转到该标签页
}
#HotIf







#HotIf WinActive("ahk_exe FoxitPDFEditor.exe")
F5::{
SendInput "^6"
SendInput "^a"
}
#HotIf ; 这里让后续的重映射和热键对所有窗口生效.






#HotIf WinActive("ahk_exe 语雀.exe")
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
F6::
{
SendInput "^u"
}
#HotIf ; 这里让后续的重映射和热键对所有窗口生效.








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
#HotIf


#HotIf WinActive("ahk_exe pycharm64.exe")
PgDn::
{
    SendInput "F8"
}
PgUp::{
    SendInput "^F5"
}
#HotIf




~Esc::     ; ~ 导致不影响 esc 本身功能
KeyWinD(ThisHotkey)  ; 命名的函数热键.   双击alt 返回桌面
{
    static winc_presses := 0
    if winc_presses > 0                ; SetTimer 已经启动, 所以我们记录键击.
    {
        winc_presses += 1
        return
    }
    winc_presses := 1   ; 否则, 这是新开始系列中的首次按下. 把次数设为 1 并启动计时器
    SetTimer After180, -200 ; 在 200 毫秒内等待更多的键击.  将在 180 ms 后调用 After180, 然后删除定时器
    After180()  ; 这是一个嵌套函数.
    {
        if winc_presses = 2 ; 此键按下了两次.
        {
            SendInput "{Alt down}{F4}{Alt up}"
        }
        winc_presses := 0   ; 不论触发了上面的哪个动作, 都对 count 进行重置  为下一个系列的按键做准备:
    }
}






    ; RControl::
    ; Key(ThisHotkey)  ; 命名的函数热键.   双击alt 返回桌面
    ; {
    ;     static winc_presses := 0
    ;     if winc_presses > 0                ; SetTimer 已经启动, 所以我们记录键击.
    ;     {
    ;         winc_presses += 1
    ;         return
    ;     }
    ;     winc_presses := 1   ; 否则, 这是新开始系列中的首次按下. 把次数设为 1 并启动计时器
    ;     SetTimer After180, -200 ; 在 200 毫秒内等待更多的键击.  将在 180 ms 后调用 After180, 然后删除定时器
    ;     After180()  ; 这是一个嵌套函数.
    ;     {
    ;         if winc_presses = 2 ; 此键按下了两次.
    ;         {
    ;             send "^f"
    ;         }
    ;         winc_presses := 0   ; 不论触发了上面的哪个动作, 都对 count 进行重置  为下一个系列的按键做准备:
    ;     }
    ; }











CoordMode "Mouse", "Screen"


global EWD_Triggered := false

Loop
{
  MouseGetPos &EWD_MouseStartX, &EWD_MouseStartY
  
  If (EWD_MouseStartX >= A_ScreenWidth -1 && EWD_MouseStartY >= A_ScreenHeight -1 ) 
  {
    If (!EWD_Triggered)
    {
      SendInput "#d"
      EWD_Triggered := true  
    }
  }
  Else IF(EWD_MouseStartX <= 1 && EWD_MouseStartY >= A_ScreenHeight -1 )
  {
    If (!EWD_Triggered)
    {
      SendInput "^!{Tab}"
      EWD_Triggered := true
    }
  }
;   Else IF(EWD_MouseStartX < 1 && EWD_MouseStartY >= A_ScreenHeight -1)
;     {
;       If (!EWD_Triggered)
;       {
;         SendInput "^1"
;         EWD_Triggered := true  
;       }
;     }
  Else 
  {
    EWD_Triggered := false
  }
   Sleep 10 ; 每隔 100 毫秒检测一次鼠标位置
}


