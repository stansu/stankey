#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Recommended for catching common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance force

#Persistent
SetTimer, WatchCursor, 2000
return

WatchCursor:
MouseGetPos, , , id, control
WinGetTitle, title, ahk_id %id%
WinGetClass, class, ahk_id %id%
TrayTip, , ahk_id %id%`nahk_class %class%`n%title%`nControl: %control%
return