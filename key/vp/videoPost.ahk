ControlSetText, MXS_Scintilla2, , ahk_class 3DSMAX 
Sleep, 100
Control, EditPaste, max videopost, MXS_Scintilla2, ahk_class 3DSMAX
Sleep, 100
ControlSend, MXS_Scintilla2, {NumpadEnter}, ahk_class 3DSMAX
WinWait, ahk_class VideoPostPopUp
ControlClick, CustButton17, ahk_class VideoPostPopUp