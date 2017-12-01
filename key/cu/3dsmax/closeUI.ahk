#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Recommended for catching common errors.
#SingleInstance, force
#NoTrayIcon
SetControlDelay -1
SetTitleMatchMode, 2
;~ posY = 115
{
	WinClose, Measure
	WinClose, Display Floater
	WinClose, Layer: 
	WinClose, Transform Type-In
	WinClose, Material Editor -
	WinClose, Render Setup: 
	WinClose, Scene Explorer -
	WinClose, materialByName
	WinClose, LPM v2.00   
}
return