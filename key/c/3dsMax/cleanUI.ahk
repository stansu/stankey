#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Recommended for catching common errors.
#SingleInstance, force
#NoTrayIcon
SetControlDelay -1
SetTitleMatchMode, 2

posY = 126
;~ appClass := ""

;~ if WinActive("ahk_class 3DSMAX")
;~ {
	;~ appClass := "ahk_class 3DSMAX"
;~ }
;~ else if WinActive("Autodesk 3ds Max 2018")
;~ {
	;~ appClass := "Autodesk 3ds Max 2018"
;~ }

{
	ControlSetText, MXS_Scintilla2, , A
	Sleep, 100
	Control, EditPaste, filein "D:\\stanKey\\key\\mf\\3dsMax\\measureFloater.ms"; filein "D:\\stanKey\\key\\so\\3dsMax\\shadowOff.ms"; max display floater; macros.run "Layers" "LayerManager"; max tti; filein "D:\\stanKey\\key\\m\\3dsMax\\materialByName.ms"; filein "D:\\stanKey\\key\\pm\\3dsMax\\passManager.ms", MXS_Scintilla2, A
	Sleep, 100
	ControlSend, MXS_Scintilla2, {NumpadEnter}, A
	Sleep, 100
	WinMove, Measure, , 0, posY
	WinMove, Display Floater, , 0, (posY+285)
	WinMove, Layer: , , 0, (posY+706)
	WinMove, Transform Type-In, , 0, (posY+1700)
	WinMove, Material Editor -, , 3022, 0
	WinMove, Render Setup: , , 661, 0
	WinMove, Scene Explorer - , , 0, (posY+706)
	WinActivate, Layer
	ControlClick, x100 y35, Display Floater, , , ,NA
	ControlClick, , Layer, , , ,NA
}
;~ ToolTip, A
;~ Sleep, 1000
;~ ToolTip
return