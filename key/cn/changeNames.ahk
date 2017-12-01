#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
currentDir = %clipboard%
currentDirName =
IfExist %currentDir%
{
	SplitPath, currentDir, currentDirName
	MsgBox, 4, , change file name under `n`n%clipboard%`n`n?(sub-folder's name will also change.)
	IfMsgBox, yes
	{
		Loop, %currentDir%\*.*, 1, 0
		{
			If InStr(FileExist(A_LoopFileLongPath), "D")
			{
				FileMoveDir, %A_LoopFileLongPath%, %currentDir%\%currentDirName%_%A_LoopFileTimeCreated%%A_Index%
				;~ MsgBox, %currentDir%\%currentDirName%_%A_LoopFileTimeCreated%
				;~ MsgBox, %A_Index%
			}
			Else
			{
				FileMove, %A_LoopFileLongPath%, %currentDir%\%currentDirName%_%A_LoopFileTimeCreated%%A_Index%.%A_LoopFileExt%
				;~ MsgBox, %currentDir%\%currentDirName%_%A_LoopFileTimeCreated%.%A_LoopFileExt%
				;~ MsgBox, %A_Index%
			}
		}
	}
} else
{
	MsgBox, please copy folder into Clipboard first!
}