#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SendLevel ,0
; Send a Pause command to another script.
;~ DetectHiddenWindows, On
;~ WM_COMMAND := 0x111
;~ ID_FILE_PAUSE := 65403
;~ PostMessage, WM_COMMAND, ID_FILE_PAUSE,,, D:\stanKey\stanMouseKey.ahk ahk_class AutoHotkey

IfWinNotExist, 工時管理
{
	run, C:\Program Files\Internet Explorer\iexplore.exe
	;~ Sleep, 1000
}
WinWait, 工時管理, , 3
{
	WinActivate, ahk_class IEFrame
	WinMaximize, ahk_class IEFrame
	SendInput, {Lwin down}{left}{lwin up}
	;~ sleep, 111
	MouseClick, left, 230, 140
	SendInput, {Home}{ShiftDown}{End}{ShiftUp}{BackSpace}
	;~ sleep, 111
	SendInput, F127283821
	MouseClick, left, 590, 140
	;~ Sleep, 1000
	MouseClick, left, 230, 290
	SendInput, emma0213
	MouseClick, left, 590, 290
	MouseClick, left, 150, 460
	;~ MouseClick, left, 450, 460
	return
}

; Send a Pause command to another script.
;~ DetectHiddenWindows, On
;~ WM_COMMAND := 0x111
;~ ID_FILE_PAUSE := 65403
;~ PostMessage, WM_COMMAND, ID_FILE_PAUSE,,, D:\stanKey\stanMouseKey.ahk ahk_class AutoHotkey

return