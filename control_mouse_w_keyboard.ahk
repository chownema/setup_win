; ;; Start Mouse movement
; #KeyHistory
; #MaxHotkeysPerInterval, 10000

; DEFAULT_SPEED = 1
; DEFAULT_SPEED_MULTIPLIER = 10

; BASE_SPEED = 1
; BASE_SPEED_MULTIPLIER = 10

; isMovingMouse = false
; canMoveMouse = false

; ; speed multiplier
; $r::
; {
;   if (canMoveMouse = "true") {
;     BASE_SPEED = 0.3
;     BASE_SPEED_MULTIPLIER = 5;
;   } else {
;     Send r
;   }
;   Return
; }

; $s::
; {
;   if (canMoveMouse = "true") {
;     BASE_SPEED = 0.3
;     BASE_SPEED_MULTIPLIER = 40
;   } else {
;     Send s
;   }
;   Return
; }

; $r Up::
; $s Up::
; {
;   BASE_SPEED = %DEFAULT_SPEED%
;   BASE_SPEED_MULTIPLIER = %DEFAULT_SPEED_MULTIPLIER%
;   Return
; }

; $g::
; {
;   if (canMoveMouse = "true") {
;     Click, down, middle
;   } else {
;     Send g
;   }
;   Return
; }

; $g Up::
; {
;   if (canMoveMouse = "true") {
;     Click, up, middle
;   }
;   Return
; }

; $f::
; {
;   if (canMoveMouse = "true") {
;     Click down
;   } else {
;     Send f
;   }
;   Return
; }
; $f Up::
; {
;   if (GetKeyState("d", "P")) {
;     Click up
;   }
;   Return
; }

; $v::
; {
;   if (GetKeyState("d", "P")) {
;     Click, down, right
;   } else {
;     Send v
;   }
;   Return
; }
; $v Up::
; {
;   if (GetKeyState("d", "P")) {
;     Click, up, right
;   }
;   Return
; }


; $h::
; {
;   if (canMoveMouse = "true") {
;     isMovingMouse = true
;     While GetKeyState("h", "P") {
;       if (GetKeyState("j", "P")) {
;         MouseMove, -%BASE_SPEED_MULTIPLIER%, %BASE_SPEED_MULTIPLIER%, %BASE_SPEED%, R
;       } else if (GetKeyState("k", "P")) {
;         MouseMove, -%BASE_SPEED_MULTIPLIER%, -%BASE_SPEED_MULTIPLIER%, %BASE_SPEED%, R
;       } else {
;         MouseMove, -%BASE_SPEED_MULTIPLIER%, 0, %BASE_SPEED%, R
;       }
;     }
;   } else {
;     Send h
;   }
;   Return
; }

; $l::
; {
;   if (canMoveMouse = "true") {
;     isMovingMouse = true
;     While GetKeyState("l", "P") {
;       if (GetKeyState("j", "P")) {
;         MouseMove, %BASE_SPEED_MULTIPLIER%, %BASE_SPEED_MULTIPLIER%, %BASE_SPEED%, R
;       } else if (GetKeyState("k", "P")) {
;         MouseMove, %BASE_SPEED_MULTIPLIER%, -%BASE_SPEED_MULTIPLIER%, %BASE_SPEED%, R
;       } else {
;         MouseMove, %BASE_SPEED_MULTIPLIER%, 0, %BASE_SPEED%, R
;       }
;     }
;   } else {
;     Send l
;   }
;   Return
; }

; ; DOWN
; $j::
; {
;   if (canMoveMouse = "true") {
;     isMovingMouse = true
;     While GetKeyState("j", "P") {
;       if (GetKeyState("h", "P")) {
;         MouseMove, -%BASE_SPEED_MULTIPLIER%, %BASE_SPEED_MULTIPLIER%, %BASE_SPEED%, R
;       } else if (GetKeyState("l", "P")) {
;         MouseMove, %BASE_SPEED_MULTIPLIER%, %BASE_SPEED_MULTIPLIER%, %BASE_SPEED%, R
;       } else if (GetKeyState("x", "P")) {
;         Click, WheelDown
;         Sleep, 50
;       } else {
;         MouseMove, 0, %BASE_SPEED_MULTIPLIER%, %BASE_SPEED%, R
;       }
;     }
;   } else {
;     Send j
;   }
;   Return
; }

; ; UP
; $k::
; {
;   if (canMoveMouse = "true") {
;     isMovingMouse = true
;     While GetKeyState("k", "P") {
;       if (GetKeyState("h", "P")) { ; also move cursor left
;         MouseMove, -%BASE_SPEED_MULTIPLIER%, -%BASE_SPEED_MULTIPLIER%, %BASE_SPEED%, R
;       } else if (GetKeyState("l", "P")) { ; also move cursor right
;         MouseMove, %BASE_SPEED_MULTIPLIER%, -%BASE_SPEED_MULTIPLIER%, %BASE_SPEED%, R
;       } else if (GetKeyState("x", "P")) { ; mousewheel
;         Click, WheelUp
;         Sleep, 50
;       } else { ; move cursor up
;         MouseMove, 0, -%BASE_SPEED_MULTIPLIER%, %BASE_SPEED%, R
;       }
;     }
;   } else {
;     Send k
;   }
;   Return
; }


; ^!,::
; {
; ;   if ((A_PriorKey = "f") or (A_PriorKey="k")) and (A_TimeSincePriorHotkey < 50) {
;  Send {BackSpace}
;  canMoveMouse = true
; KeyWait, d
; ;   } else {
; ;     Send d
; ;   }
;   Return
; }

; $d Up::
; {
;   isMovingMouse = false
;   canMoveMouse = false
; }

; ; ============================================================

DEFAULT_SPEED = 15
DEFAULT_SPEED_MULTIPLIER = 30

; CURRENT_X = 0
; CURRENT_Y = 0
canMoveMouse = false

; Switch to turn on and off move mouse mode
; TODO: bug, canMoveMouse is treated as true at first run
^!,::
{
	if canMoveMouse {
		canMoveMouse := false
		SoundBeep 500 ; Lower tone
	} else {
		canMoveMouse := true
		SoundBeep 750 ; Higher tone
	}
  return
}

; Movement 

$j::
{
	if canMoveMouse {
		MouseMove, 0, %DEFAULT_SPEED%, 0, R
	} else {
		send $j
	}
	return
}

$k::
{
	if canMoveMouse {
		; MouseGetPos, CURRENT_X, CURRENT_Y
		; CURRENT_X = CURRENT_X - DEFAULT_SPEED
		MouseMove, 0, -%DEFAULT_SPEED%, 0, R
	} else {
		send $k
	}
	return
}

$h::
{
	if canMoveMouse {
		MouseMove, -%DEFAULT_SPEED%, 0, 0, R
	} else {
		send $h
	}
	return
}

$l::
{
	if canMoveMouse {
		MouseMove, %DEFAULT_SPEED%, 0, 0, R
	} else {
		send $l
	}
	return
}