#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

if %clipboard%
{
	dest = Y:\公用區\01定期清除\stan
	MsgBox, 4, , copy `n%clipboard%`n to`n %dest%?
	IfMsgBox, yes
	{
		Run, %dest%
		WinWaitActive, stan
		Send, ^v
	}
} else
{
	MsgBox, please copy folder into Clipboard first!
}