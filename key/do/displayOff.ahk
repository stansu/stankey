#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Sleep 1000  ; Give user a chance to release keys (in case their release would wake up the monitor again).
SendMessage, 0x112, 0xF170, 2,, Program Manager