#SingleInstance, force
; http://www.autohotkey.com/board/topic/90589-how-to-get-pid-just-by-a-scripts-title/
DetectHiddenWindows, On  ; Detect hidden windows
SetTitleMatchMode, RegEx ; Find window titles by regex
Script := "test_gosub.ahk"
; Get the PID of the window with the title matching the format "*\Scriptname - AutoHotkey v*"
WinGet, PID, PID, % "i)^.+\\" CleanEx(Script) " - AutoHotkey v.+$"
; MsgBox, % Script "'s PID is:`n" PID
CleanEx(Needle)
{ ; Sanitize the RegEx input
    StringReplace, Needle, Needle, \, \\, All
    StringReplace, Needle, Needle, ., \., All
    StringReplace, Needle, Needle, *, \*, All
    StringReplace, Needle, Needle, ?, \?, All
    StringReplace, Needle, Needle, +, \+, All
    StringReplace, Needle, Needle, [, \[, All
    StringReplace, Needle, Needle, `{, \`{, All
    StringReplace, Needle, Needle, |, \|, All
    StringReplace, Needle, Needle, (, \(, All
    StringReplace, Needle, Needle, ), \), All
    StringReplace, Needle, Needle, ^, \^, All
    StringReplace, Needle, Needle, $, \$, All
    Return Needle
}

for n, param in A_Args  ; For each parameter:
{
    If (%n% = "-k")
        Process, Close, %PID%
    MsgBox Parameter number %n% is %param%.
}

Global ThisKey, 2PriorKey
ih := InputHook()
ih.KeyOpt("{All}", "NV")
ih.OnKeyDown := Func("priorKeyHandler")
ih.BackspaceIsUndo := false
ih.Start()
;start ToolTip
SetTimer, ToolTip, 50
ToolTip:
ToolTip :=
( Join
	"ThisKey:`t" ThisKey
	"`nA_PriorKey:`t" A_PriorKey
	"`n2PriorKey:`t" 2PriorKey
)
IF (ToolTip <> OldToolTip)
	ToolTip,% OldToolTip := ToolTip
Return
;ToolTip end
priorKeyHandler(ih, vk, sc)
{
	2PriorKey := A_PriorKey
	; ThisKey := GetKeyName(Format("vk{1:x}sc{2:x}", vk, sc))
	ThisKey := vk
}