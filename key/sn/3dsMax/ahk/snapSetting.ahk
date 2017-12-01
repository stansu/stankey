#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Recommended for catching common errors.
#SingleInstance, force
#NoTrayIcon
SetControlDelay -1
WinWait, Grid and Snap Settings
ControlSetText, Edit7, 45, Grid and Snap Settings
ControlSend, Edit7, {Enter}, Grid and Snap Settings
WinClose, Grid and Snap Settings