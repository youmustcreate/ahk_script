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


; ============================================================
;  屏幕热区 · 数据驱动版
;  ・所有坐标使用 AHK 原生体系：左上角为原点，Y 轴向下
;  ・新增 / 删除 / 修改热区只需编辑下方的 zones 数组
; ============================================================

CornerSize := 3   ; 角落热区边长（像素）
OverlayW   := 5    ; 边缘标记条宽度（像素）
W          := A_ScreenWidth
H          := A_ScreenHeight

; ============================================================
;  热区配置表
;  x1/y1 ── 热区左上角坐标
;  x2/y2 ── 热区右下角坐标（含边界）
;  color  ── 标记窗口背景色（十六进制 RGB）
;  label  ── 调试用说明
;  action ── 鼠标进入热区时执行的操作
; ============================================================
zones := [
    ; ── 四个角落 ────────────────────────────────────────────
    { key:"TL",
      x1:0,            y1:0,            x2:CornerSize-1,  y2:CornerSize-1,
      color:"06c2f6",  label:"左上角（F9）",
      action:() => Send("{F9}") },

    { key:"TR",
      x1:W-CornerSize, y1:0,            x2:W-1,           y2:CornerSize-1,
      color:"06c2f6",  label:"右上角（Ctrl+Alt+Shift+I）",
      action:() => Send("^!+i") },

    { key:"BR",
      x1:W-CornerSize, y1:H-CornerSize, x2:W-1,           y2:H-1,
      color:"06c2f6",  label:"右下角（Win+Tab）",
      action:() => Send("#{Tab}") },

    { key:"BL",
      x1:0,            y1:H-CornerSize, x2:CornerSize-1,  y2:H-1,
      color:"06c2f6",  label:"左下角（Win+D）",
      action:() => Send("#d") },

    ; ── 三个边缘区域 ─────────────────────────────────────────
    { key:"RE",
      x1:W-OverlayW,   y1:80,           x2:W-1,           y2:H//4,
      color:"34f404",  label:"右边缘上区（Alt+Tab）",
      action:() => Send("!{Tab}") },

    { key:"LM",
      x1:0,            y1:H//6-40,      x2:OverlayW-1,    y2:H//6,
      color:"37ca2a",  label:"左边缘中上区（启动 c.exe）",
      action:() => Run("./c.exe") },

    { key:"LB",
      x1:0,            y1:H*5//6,       x2:OverlayW-1,    y2:H*6//7,
      color:"00FF88",  label:"左边缘中下区（Win 键）",
      action:() => Send("{LWin}") },

    { key:"RD",
      x1:W-OverlayW,   y1:H//2+1,       x2:W-1,           y2:H*2//3,
      color:"FF8800",  label:"右边缘中区（切换右桌面）",
      action:() => Send("^#{Right}") },

    { key:"LD",
      x1:0,            y1:H//4+1,       x2:OverlayW-1,    y2:H//2,
      color:"FF8800",  label:"左边缘中区（切换左桌面）",
      action:() => Send("^#{Left}") }
]

; ============================================================
;  工厂函数：统一创建标记 GUI
; ============================================================
CreateOverlay(x, y, w, h, color) {
    ov := Gui()
    ov.Opt("-Caption +ToolWindow +AlwaysOnTop +E0x20")
    ov.BackColor := color
    WinSetTransparent(120, ov)
    ov.Show("x" x " y" y " w" w " h" h " NoActivate")
    return ov
}

; ── 批量创建所有标记窗口，并用实际渲染位置覆盖触发坐标 ──────
for z in zones {
    z.overlay := CreateOverlay(
        z.x1, z.y1,
        z.x2 - z.x1 + 1,
        z.y2 - z.y1 + 1,
        z.color
    )
    ; 读回 overlay 实际可见物理坐标，同步给触发区域
    rc := Buffer(16)
    DllCall("dwmapi\DwmGetWindowAttribute",
        "Ptr",  z.overlay.Hwnd,
        "UInt", 9,          ; DWMWA_EXTENDED_FRAME_BOUNDS
        "Ptr",  rc,
        "UInt", 16)
    z.x1 := NumGet(rc,  0, "Int")
    z.y1 := NumGet(rc,  4, "Int")
    z.x2 := NumGet(rc,  8, "Int") - 1   ; right 是开区间，减 1 变闭区间
    z.y2 := NumGet(rc, 12, "Int") - 1
}

; ============================================================
;  定时器：每 30ms 轮询鼠标位置，遍历配置表统一判断
; ============================================================
SetTimer CheckZones, 50

CheckZones() {
    global zones
    static triggered := Map()

    CoordMode "Mouse", "Screen"
    try {
        MouseGetPos(&mx, &my)
        for i, z in zones {
            hit    := (mx >= z.x1 && mx <= z.x2 && my >= z.y1 && my <= z.y2)
            wasHit := triggered.Get(i, false)
            if hit && !wasHit {
                fn := z.action   ; ← 脱离对象上下文再调用
                fn()
                triggered[i] := true
            } else if !hit && wasHit {
                triggered[i] := false
            }
        }
    } catch as e {
        FileAppend(
            FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss")
                " [" e.What "] " e.Message "`n",
            A_ScriptDir "\hotzone_err.log"
        )
    }
}
