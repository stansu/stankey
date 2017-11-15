#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

#Warn  ; Recommended for catching common errors.

#SingleInstance, force ;Avoid multiple thread.

SetTitleMatchMode, 2

SetControlDelay -1

CoordMode, Mouse, Screen

CoordMode, ToolTip, Screen

CoordMode, Pixel, Screen

#UseHook

 

stanCodeFolder := "D:\stanKey\key\"

appType := ""

appClass := ""

lastCode := ""

lastName := ""

lastApp := ""

stanCommandName := ""

TPX := 795

TPY := 530

 

RemoveToolTip:

SetTimer, RemoveToolTip, Off

ToolTip

return

 

LShift & Space::

{

        tempTitle = stanKey_%lastName%

        if WinActive("ahk_class AfxMDIFrame100u")

        {

                appType := "\acad"

        }

        else if WinActive("ahk_class 3DSMAX")

        {

                appType := "\3dsMax"

                appClass := "ahk_class 3DSMAX"

        }

        else if WinActive("Autodesk 3ds Max 2018")

        {

                appType := "\3dsMax"

                appClass := "Autodesk 3ds Max 2018"

        }

        else

        {

                appType := ""

        }

        InputBox, stanCommandName, %tempTitle%, , , 330, 100, , , , ,

        if ErrorLevel

        {

                return

        }

        else

        {

                WinWaitClose, stanKey_

                if (stanCommandName = "")

                {

                        if (lastApp == appType) or (lastApp == "")

                        {

                                If InStr(lastCode, ".ms")

                                {

                                        Control, EditPaste, %lastCode%, MXS_Scintilla2, A

                                        ControlSend, MXS_Scintilla2, {NumpadEnter}, A

                                        return

                                }

                                else If InStr(lastCode, ".ahk") or InStr(lastCode, ".bat")

                                or InStr(lastCode, ".exe")

                                {

                                        Run, %lastCode%

                                        return

                                }

                                return

                        }

                        else

                        {

                                ToolTip, not same App!

                                SetTimer, RemoveToolTip, 1000

                                return

                        }

                }

                else

                {

                        FileSetTime, , %stanCodeFolder%%stanCommandName%

                        FileSetTime, , %stanCodeFolder%%stanCommandName%\*.*

                        FileSetTime, , %stanCodeFolder%%stanCommandName%%appType%

                        FileSetTime, , %stanCodeFolder%%stanCommandName%%appType%\*.*

                        Loop, %stanCodeFolder%%stanCommandName%%appType%\*.*

                        {

                                if (A_LoopFileExt = "ms")

                                {

                                        tempStr := "filein """ . A_LoopFileFullPath . """"

                                        StringReplace, tempStr, tempStr, `\, `\`\, ALL

                                        Control, EditPaste, %tempStr%, MXS_Scintilla2, A

                                        ControlSend, MXS_Scintilla2, {NumpadEnter}, A

                                        lastCode := tempStr

                                        lastName := A_LoopFileName

                                        lastApp := appType

                                        stanCommandName := ""

                                        return

                                }

                                else if not (A_LoopFileExt = "bak")

                                {

                                        Run, %A_LoopFileFullPath%

                                        lastCode := A_LoopFileFullPath

                                        lastName := A_LoopFileName

                                        lastApp := appType

                                        stanCommandName := ""

                                        return

                                }

                        }

                        Loop, %stanCodeFolder%%stanCommandName%\*.*

                        {

                                if (A_LoopFileExt = "ms")

                                {

                                        tempStr := "filein """ . A_LoopFileFullPath . """"

                                        StringReplace, tempStr, tempStr, `\, `\`\, ALL

                                        Control, EditPaste, %tempStr%, MXS_Scintilla2, A

                                        ControlSend, MXS_Scintilla2, {NumpadEnter}, A

                                        lastCode := tempStr

                                        lastName := A_LoopFileName

                                        lastApp := ""

                                        stanCommandName := ""

                                        return

                                }

                                else if not (A_LoopFileExt = "bak")

                                {

                                        Run, %A_LoopFileFullPath%

                                        lastCode := A_LoopFileFullPath

                                        lastName := A_LoopFileName

                                        lastApp := ""

                                        stanCommandName := ""

                                        return

                                }

                        }

                }

        }

        if stanCommandName

        {

                ToolTip, No such command!

                SetTimer, RemoveToolTip, 1000

        }

        return

}

 

#If WinExist("stanKey_")

Space::ControlClick, Button1, stanKey_

 

#If WinActive("stanKey.ahk")

^s::

{

        SendInput, ^s

        Reload

        return

}
