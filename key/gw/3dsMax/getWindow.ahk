#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Recommended for catching common errors.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, force ;Avoid multiple thread.
SetTitleMatchMode, RegEx
windowName := ""
InputBox, windowName, Type window name...
IfWinExist, %windowName%
{
	WinActivate, %windowName%
	WinMove, %windowName%, ,0 ,0
	return
}
else
{
	MsgBox, Not Exist!
	return
}
return