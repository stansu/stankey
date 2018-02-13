#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Recommended for catching common errors.
#SingleInstance, force ;Avoid multiple thread.
#EscapeChar /
#UseHook
SetControlDelay 0
SetTitleMatchMode, 2
SetWorkingDir, d:\punchCard

Run, d:\punchCard\punchCard.ahk
WinWait, ahk_class IEFrame
MsgBox, 4,, % "Start work routine?"
IfMsgBox yes
{
	IfWinNotExist, ahk_class rctrl_renwnd32
	{
		Run, D:\lnk\Microsoft Office Outlook 2007,, max
		WinWait, ahk_class rctrl_renwnd32
	}
	;~ IfWinNotExist, ahk_class CabinetWClass
	;~ {
		;~ Run, D:\3d\2017,, min
		;~ WinWait, ahk_class CabinetWClass
	;~ }
	IfWinNotExist, Autodesk AutoCAD 2018
	{
		Run, D:\lnk\acad2018
		WinWait, AutoCAD
	}
	IfWinNotExist, ahk_class 3DSMAX
	{
		Run, D:\lnk\3ds Max 2014
		WinWait, ahk_class 3DSMAX
	}
	return
}

#Hotstring o * ?

::`dd::
FormatTime, CurrentDateTime,, yyyyMMdd
SendInput %CurrentDateTime%
return

::`tt::
FormatTime, CurrentDateTime,, HH:mm
SendInput %CurrentDateTime%
return

#If not WinActive("AutoCAD")
::`pp::polygonmesh@yahoo.com.tw
::`ss::stan.stz@gmail.com
::`db::DB9708944
::`ee::emmayang7@hotmail.com
:R:`rt::{%((getLocalTime())[2] as string)+"//"+((getLocalTime())[4] as string)+"_"}{RenderTimeString}

#If WinActive("MAXScript")
::`mm::meditmaterials[]{left}
::`sm::scenematerials[]{left}
::`gc::(getClassInstances ){left}

#If WinActive("AutoCAD")
::`e::explode{enter}
::`ff::{Esc 2}fillmode{enter}0{enter}re{enter}
::`fn::{Esc 2}fillmode{enter}1{enter}re{enter}
::`m::{Esc 2}MEASUREGEOM{enter}
::`r::{Esc 2}rec{enter}
::`x::selectsimilar{enter}
::`u::{Esc 2}-layer{enter}u{enter}*{enter 2}
::`v::{Esc 2}syswindows{enter}v{enter}
::`z::{Esc 2}zoom{enter}all{enter}
::`de::erase{enter}
::`dt::
Run, c:\stankey-master\key\dt\acad\deleteTrashCAD.ahk
return

#If WinActive("stan.ahk")
^s::
{
	SendInput, ^s
	Reload
	return
}
