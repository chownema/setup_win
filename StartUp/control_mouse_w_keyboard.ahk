 ; ============================================================

DEFAULT_SPEED = 15
DEFAULT_SPEED_MULTIPLIER = 1.5
SPEED_SOUND_TONE = 100
SPEED_SOUND_TONE_INCREASE = 25

CURRENT_X = 0
CURRENT_Y = 0
canMoveMouse = false
canMouseTurboMove = false

; Switch to turn on and off move mouse mode
; TODO: bug, canMoveMouse is treated as true at first run
Esc::
{
	if canMoveMouse {
		canMoveMouse := false
		SoundBeep 500 ; Lower tone
	} else {
		send {Esc}
	}
	return
}
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

	; Clicks
	$d::
	{
		if canMoveMouse {
			MouseClick, left
		} else {
			send d
		}
		return
	}

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

	; Scroll Wheel
	; Alt
	!u::MouseClick, WheelUp
	!d::MouseClick, WheelDown
} else {
	return
}