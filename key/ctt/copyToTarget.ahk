#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
source := ""
target := ""
Loop, %A_ScriptDir%\source\*.lnk
{
	FileGetShortcut, %A_LoopFileLongPath%, source
}
Loop, %A_ScriptDir%\target\*.lnk
{
	FileGetShortcut, %A_LoopFileLongPath%, target
}
MsgBox, 4, , copy `n%source%`n to`n %target%`n?
SplitPath, source, SourceFolderName
IfMsgBox, yes
{
	FileCopyDir, %source%, %target%\%SourceFolderName%, 1
}