 ; ============================================================

DEFAULT_SPEED = 15
DEFAULT_SPEED_MULTIPLIER = 1.5
SPEED_SOUND_TONE = 100
SPEED_SOUND_TONE_INCREASE = 25

CURRENT_X = 0
CURRENT_Y = 0
canMoveMouse = false
canMouseTurboMove = false

; Global ThisKey, 2PriorKey
; ih := InputHook()
; ih.KeyOpt("{All}", "NV")
; ih.OnKeyDown := Func("priorKeyHandler")
; ih.OnKeyUp := Func("postKeyHandler")
; ih.BackspaceIsUndo := false
; ih.Start()

; ;start ToolTip
; SetTimer, ToolTip, 50
; ToolTip:
; ToolTip :=
; ( Join
; 	"ThisKey:`t" ThisKey
; 	"`nA_PriorKey:`t" A_PriorKey
; 	"`n2PriorKey:`t" 2PriorKey
; )
; if ToolTip <> OldToolTip
; 	ToolTip,% OldToolTip := ToolTip
; Return
; ;ToolTip end

; postKeyHandler(ih, vk, sc)
; {
; 	2PriorKey := A_PriorKey
; 	; ThisKey := GetKeyName(Format("vk{1:x}sc{2:x}", vk, sc))
; 	ThisKey := vk
; 	if (vk = "68") {
; 		Click, up
; 	}
; 	return
; }
; priorKeyHandler(ih, vk, sc)
; {
; 	2PriorKey := A_PriorKey
; 	; ThisKey := GetKeyName(Format("vk{1:x}sc{2:x}", vk, sc))
; 	ThisKey := vk
; 	if (vk = "68") {
; 		Click, Down
; 	}
; 	return
; }

; Switch to turn on and off move mouse mode
; TODO: bug, canMoveMouse is treated as true at first run
^!,::
{
	if canMoveMouse {
		canMoveMouse := false
		SoundBeep 250 ; Lower tone
	} else {
		canMoveMouse := true
		SoundBeep 750 ; Higher tone
	}
  return
}

; Turbo Toggle
; Increase
^!m::
{
	SPEED_SOUND_TONE := SPEED_SOUND_TONE + SPEED_SOUND_TONE_INCREASE
	SoundBeep %SPEED_SOUND_TONE%
	DEFAULT_SPEED := DEFAULT_SPEED * DEFAULT_SPEED_MULTIPLIER
	return
}
; Decrease
<+^!m::
{
	SPEED_SOUND_TONE := SPEED_SOUND_TONE - SPEED_SOUND_TONE_INCREASE
	SoundBeep %SPEED_SOUND_TONE%
	DEFAULT_SPEED := DEFAULT_SPEED / DEFAULT_SPEED_MULTIPLIER
	return
}
	

; Mouse emulation code
if canMoveMouse {

	$d::
	{
		; key_state := GetKeyState("d", "P")
		; if (key_state = 1) {
		; 	return
		; } else {
		; 	Send % "{" A_ThisHotkey "}"
		; }

		if canMoveMouse {
			while GetKeyState("d", "P") {
				Click, Down
			}
			Click Up
		} else {
			send d
		}
		return
	}

	; Movement 
	$j::
	{
		if canMoveMouse {
			MouseMove, 0, %DEFAULT_SPEED%, 0, R
		} else {
			send j
		}
		return
	}

	$k::
	{
		if canMoveMouse {
			MouseMove, 0, -%DEFAULT_SPEED%, 0, R
		} else {
			send k
		}
		return
	}

	$h::
	{
		if canMoveMouse {
			MouseMove, -%DEFAULT_SPEED%, 0, 0, R
		} else {
			send h
		}
		return
	}

	$l::
	{
		if canMoveMouse {
			MouseMove, %DEFAULT_SPEED%, 0, 0, R
		} else {
			send l
		}
		return
	}


	; while GetKeyState("d", "P") {
	; 	Click, Down
	; }
	; if GetKeyState("d", "U")
	; Click, Up

	; Clicks
	; $d::
	; {
	; 	key_state := GetKeyState("d", "P")
	; 	if (key_state = 1) {
	; 		return
	; 	} else {
	; 		Send % "{" A_ThisHotkey "}"
	; 	}
	; 	; if canMoveMouse {
	; 	; 	MouseClick, left
	; 		; send d
	; 	; } else {
	; 	; 	send d
	; 	; }
	; 	; return
	; }

	$f::
	{
		if canMoveMouse {
			MouseClick, middle
		} else {
			send f
		}
		return
	}

	$g::
	{
		if canMoveMouse {
			MouseClick, right
		} else {
			send g
		}
		return
	}

	!u::MouseClick, WheelUp
	!d::MouseClick, WheelDown


} else {
	return
}