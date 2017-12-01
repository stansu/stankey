FileSelectFile, file, 32,, Pick a shortcut to analyze., Shortcuts (*.lnk)
if file =
    return
FileGetShortcut, %file%, OutTarget, OutDir, OutArgs, OutDesc, OutIcon, OutIconNum, OutRunState
MsgBox %OutTarget%`n%OutDir%`n%OutArgs%`n%OutDesc%`n%OutIcon%`n%OutIconNum%`n%OutRunState%