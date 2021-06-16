#Persistent
#SingleInstance,force
SetTimer, DrawRect, 50
border_thickness = 6
border_color = 9B4C48
DrawRect:
WinGetPos, x, y, w, h, A
WinGet, OutputVar , MinMax, A
; make maximized windows movable
; -1: The window is minimized (WinRestore can unminimize it).
;  1: The window 
; is maximized (WinRestore can unmaximize it).
;0: The window is neither minimized nor maximized.
if(OutputVar == 1){
   WinGetPos,x,y,w,h
   WinRestore,A
   Sleep,500
   WinMove,A,,% x + 3, % y + 3, % A_ScreenWidth - 199, % A_ScreenHeight - 199
 }
Gui, +Lastfound +AlwaysOnTop +Toolwindow
iw:= w+4
ih:= h + 4
w:=w+ 8
h:=h + 8
x:= x - border_thickness
y:= y - border_thickness
Gui, Color, 9B4C48
Gui, -Caption
WinSet, Region, 0-0 %w%-0 %w%-%h% 0-%h% 0-0 %border_thickness%-%border_thickness% %iw%-%border_thickness% %iw%-%ih% %border_thickness%-%ih% %border_thickness%-%border_thickness%
try{
Gui, Show, w%w% h%h% x%x% y%y% NoActivate, Table awaiting Action
     } catch {
        Sleep,2000
     }
return