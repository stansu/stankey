#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

autocadLocation = C:\Program Files\Autodesk\AutoCAD 2013\acad.exe
scriptFile = D:\stanKey\key\lf\acad\toggleXREF.scr
MsgBox, 4, , Run %scriptFile% `n in `n%clipboard%`n?
IfMsgBox, yes
{
	Loop, Parse, clipboard, `n, `r
	{
		tempString := autocadLocation " """ . A_LoopField . """ /b """ . scriptFile . """"
		MsgBox, %tempString%
		;~ RunWait, %tempString%
	}
}