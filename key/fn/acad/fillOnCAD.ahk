#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Recommended for catching common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;~ #IfWinActive, ahk_class AfxMDIFrame100u
SendInput, {esc 2}
SendInput, fillmode{enter}
SendInput, 1{enter}
SendInput, re{enter}