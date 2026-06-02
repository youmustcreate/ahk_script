#Requires AutoHotkey v2.0
SendMode "Input"


; ==================== 基础全局快捷键 ====================
F1::Send("^c")                      ; 复制
F2::Send("^v")                      ; 粘贴
F3::Send("{Alt down}{Tab}{Alt up}") ; 上一个任务
F5::Send("^x")                      ; 剪切


RAlt::Send("#{Down}")               ; 窗口最小化
+CapsLock::CapsLock
CapsLock::Send("^c^f")              ; 复制并查找





; ==================== 文件资源管理器 ====================
#HotIf WinActive("ahk_exe explorer.exe")
q::Send(IsExplorerEdit() ? "q" : "{Alt down}{Left}{Alt up}")
e::Send(IsExplorerEdit() ? "e" : "{Enter}")
n::Send(IsExplorerEdit() ? "n" : "^+n")

; 提取出的公用判断函数，增加了 try 语句防止获取焦点失败时报错
IsExplorerEdit() {
    try {
        focused := ControlGetClassNN(ControlGetFocus("A"))
        return InStr(focused, "Edit") || InStr(focused, "Microsoft.UI.Content.DesktopChildSiteBridge")
    }
    return false
}
#HotIf

; ==================== 浏览器 ====================
#HotIf WinActive("ahk_exe chrome.exe")
F11::SendText "请帮我解释一下这是什么意思："
F12::SendText "作为翻译大师，请帮我翻译一下："
#HotIf

; ==================== Foxit PDF ====================
#HotIf WinActive("ahk_exe FoxitPDFEditor.exe")
F5::Send("^6^a^c^6")
#HotIf

; ==================== 语雀 ====================
#HotIf WinActive("ahk_exe 语雀.exe")
`::Send("{· 3}+{enter}")
-::Send("{- 3}`n`n")
^w::Send("{`n 20}")
F5::Send("^u")
F6::Send("{backspace}")

~LAlt:: {
    static winc_presses := 0
    if winc_presses > 0 {
        winc_presses += 1
        return
    }
    winc_presses := 1
    SetTimer After180, -200
    After180() {
        if winc_presses == 2
            Send("^!,")
        winc_presses := 0
    }
}
#HotIf

; ==================== VS Code ====================
#HotIf WinActive("ahk_exe code.exe")
RControl::Send("^f")
PgUp::Send("{Shift down}{Enter}{Shift up}")
PgDn::Send("{Enter}")

~Alt:: {
    static winc_presses := 0
    if winc_presses > 0 {
        winc_presses += 1
        return
    }
    winc_presses := 1
    SetTimer After180, -200
    After180() {
        if winc_presses == 2
            Send("^b")
        winc_presses := 0
    }
}
#HotIf






; ==================== 全局双击 Esc 关闭窗口 ====================
~Esc:: {
    static winc_presses := 0
    if winc_presses > 0 {
        winc_presses += 1
        return
    }
    winc_presses := 1
    SetTimer After180, -200
    After180() {
        if winc_presses == 2
            Send("{Alt down}{F4}{Alt up}")
        winc_presses := 0
    }
}



SetTimer CheckScreenCorners, 50

CheckScreenCorners() {
    static BR_Triggered          := false        ; 右下角触发标记
    static TL_Triggered          := false        ; 左上角触发标记
    static TR_Top3rd_Triggered   := false        ; 右边上三分之一触发标记
    static L_Top3rd_Triggered    := false        ; 左边上三分之一触发标记
    static L_Bottom3rd_Triggered := false        ;  
    static L_B3rd_Triggered      := false        ;  
    CoordMode "Mouse", "Screen"
    
    try {
        MouseGetPos(&mx, &my)

        ; 左上角检测 (触发 F9)
        if (mx <= 0 && my <= 0) {
            if (!TL_Triggered) {
                Send("{F9}")              
                TL_Triggered := true
            }
        } else {
            TL_Triggered := false
        }
        
        ; 右下角检测 (触发多任务界面 Ctrl+Alt+Tab)
        if (mx >= A_ScreenWidth - 1 && my >= A_ScreenHeight - 1) {
            if (!BR_Triggered) {
                Send("^!{Tab}")           
                BR_Triggered := true
            }
        } else {
            BR_Triggered := false
        }
        

        ; 右上四分之一边缘检测 (触发 Alt+Tab)
        if (mx >= A_ScreenWidth - 1 && my >= 80 && my <= A_ScreenHeight / 4) {
            if (!TR_Top3rd_Triggered) {
                Send("!{Tab}")
                TR_Top3rd_Triggered := true
            }
        } else {
            TR_Top3rd_Triggered := false
        }

        ; X在最左侧边缘，且Y在 20 到 屏幕总高度/4 之间
        if (mx <= 0 && my >= 80 && my <= A_ScreenHeight / 4) {
            if (!L_Top3rd_Triggered) {
                Run("./c.exe")
                L_Top3rd_Triggered := true
            }
        } else {
            L_Top3rd_Triggered := false
        }

        ; X左下
        if (mx <= 0 && my >= A_ScreenHeight - 1) {
            if (!L_Bottom3rd_Triggered) {
                Send("#d")   ;显示桌面
                L_Bottom3rd_Triggered := true
            }
        } else {
            L_Bottom3rd_Triggered := false
        }

        ; X左下
        if (mx <= 0 && my >= A_ScreenHeight - A_ScreenHeight/4  && my <= A_ScreenHeight - 80) {
            if (!L_B3rd_Triggered) {
                Send "{LWin}"
                L_B3rd_Triggered := true
            }
        } else {
            L_B3rd_Triggered := false
        }

    }
}


