#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.

arrayDict := {}
arrayTarget := {}
arrayResult := {}

;~ get source
FileRead, csv, %A_WorkingDir%\key\mw\dict.csv
StringTrimRight, NewCsv, csv, 2 ;remove last string "`r`n"
Loop, parse, NewCsv, `,`n
{
	StringReplace, NewStr, A_LoopField, `r, , All
	StringReplace, NewStr, NewStr, `n, , All
	arrayDict.Insert(NewStr)
}

;~ get target
;~ ToolTip, 拷貝欲取代項目〈於一分鐘內〉
;~ clipboard := ""
;~ ClipWait, 60
;~ if ErrorLevel
;~ {
    ;~ MsgBox, The attempt to copy failed.
    ;~ Exit
;~ }
StringTrimRight, NewClipboard, Clipboard, 2 ;remove last string "`r`n"
Loop, parse, NewClipboard, `n
{
	StringReplace, NewStr, A_LoopField, `r, , All
	StringReplace, NewStr, NewStr, `n, , All
	arrayTarget.Insert(NewStr)
}

;~ matching
for k3, v3 in arrayTarget
{
	checker := 0
	strTrue := ""
	for k1, v1 in arrayDict
	{
		IfInString, v3, %v1%
		{
			checker := k1
			strTrue .= arrayDict[checker-1] " "
			;~ MsgBox, target: %v3%`nsource: %v1%`nmatch: %checker%`nstrTrue: %strTrue%
			;~ break
		}
		;~ v3L := StrLen(v3)
		;~ v1L := StrLen(v1)
		;~ MsgBox, target: %v3% %v3L%`n source: %v1% %v1L%`n match: %checker%
	}
	if (checker == 0)
		arrayResult.Insert(v3)
	else
		arrayResult.Insert(strTrue)
}
s := ""
For k, v in arrayResult
    s .= v "`n"
StringTrimRight, s, s, 1 ;remove last string "`n"
clipboard := s
ToolTip, 轉換完成，代碼於剪貼簿中
Sleep, 1000
ToolTip