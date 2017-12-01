#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, force ;Avoid multiple thread.

;~ WinActivate, ahk_class 3DSMAX
tempStr := "filein ""D:\\stanKey\\key\\ld\\3dsMax\\ms\\lineDetach.ms"""
Control, EditPaste, %tempStr%, MXS_Scintilla2, ahk_class 3DSMAX
Sleep, 100
ControlSend, MXS_Scintilla2, {NumpadEnter}, ahk_class 3DSMAX ;execute pasted code
lastCode := tempStr
lastName := A_LoopFileName
stanCommandName := ""

WinWait, Detach, , 3
if ErrorLevel
{
    return
}
else
{
	SendInput, {enter}
	return
}