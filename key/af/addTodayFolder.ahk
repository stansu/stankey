#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Recommended for catching common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance, force
#NoTrayIcon
DetectHiddenText, Off
;~ SetTitleMatchMode, Slow
WinGetClass, currentWin, A
;~ WinGetTitle, currentWin, A
;~ MsgBox, %currentWin%
if (currentWin = "ExploreWClass") or (currentWin = "CabinetWClass")
{
	;~ MsgBox, %currentWin%
	WinGetText, currentWindowText, A
	;~ MsgBox, %currentWindowText%
	tempFolder =
	Loop, Parse, currentWindowText, `n, `r
	{
		If A_LoopField =
			Continue
		foundNumber := InStr(A_LoopField, ":\")
		;~ MsgBox, %foundNumber%
		If foundNumber > 0
		{
			tempFolder = %A_LoopField%
			If foundNumber > 2
			{
				foundNumber -= 2
				StringTrimLeft, tempFolder, tempFolder, %foundNumber%
			}
			;~ MsgBox, bigger zero %A_LoopField%
			break
		}
		;~ if foundNumber = 0
		;~ {
			;~ foundNumber := InStr(A_LoopField, "\\")
			;~ If foundNumber > 0
			;~ {
			;~ tempFolder = %A_LoopField%
			;~ MsgBox, equal zero %A_LoopField%
			;~ break
			;~ }
		;~ }
	}
	if (tempFolder != "")
	{
		FileCreateDir, %tempFolder%\%A_YYYY%%A_MM%%A_DD%
		;~ MsgBox, folder %tempFolder%\%A_YYYY%%A_MM%%A_DD% created
	}
	return
}else
	MsgBox, Please select a folder to add today folder!