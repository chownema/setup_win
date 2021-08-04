;; ======================================================================================

;; Start Keybindngs note: inplicit retrun after "::"
; Taskview
^!/::Send {RWin down}{Tab down}{Tab up}{RWin up}
^!n:: Send {RWin down}{Ctrl down}{Right down}{Ctrl up}{RWin up}{Right up} 

^!p::Send {RWin down}{Ctrl down}{Left down}{Ctrl up}{RWin up}{Left up}
; if GetKeyState("p", "P") {
;   Send {RWin down}{Ctrl down}{Left down}{Tab up}{Ctrl up}{RWin up}{Left up}
;   Return
; } else {
;   Return
; }

;; Win Remap
RAlt::RWin

; Alt f4
; Ctrl + Alt + q
^!q::Send {alt down}{f4 down}{f4 up}{alt up}
;; End Keybindngs

;; Remap AltTab
^!'::AltTabMenu
; LControl & p::ShiftAltTab

;; Add pgup/dn
!Down::PgDn
!Up::PgUp