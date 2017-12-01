MsgBox, 4, ,Change clipboard character?
IfMsgBox, yes
{
	StringReplace, clipboard, clipboard, %A_SPACE%, _, All
	StringReplace, clipboard, clipboard, `r`n, _, All
	StringReplace, clipboard, clipboard, -, _, All
}