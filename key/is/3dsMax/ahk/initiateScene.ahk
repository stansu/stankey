#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Recommended for catching common errors.
#SingleInstance, force
#NoTrayIcon
SetControlDelay -1
WinWait, Render Setup
ControlClick, CustButton6, Render Setup
;~ ControlSetText, Edit7, 45, Render Setup
;~ ControlSend, Edit7, {Enter}, Render Setup
WinClose, Grid and Snap Settings