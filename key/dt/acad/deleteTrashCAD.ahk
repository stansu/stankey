#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Recommended for catching common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;~ MsgBox, 4, , delete trash?
;~ IfMsgBox, yes
{
	SendInput, {Esc 2}
	SendInput, ssx{space 2}e{space}hatch{space 2}erase{space}p{space 2}
	SendInput, ssx{space 2}e{space}DIMENSION{space 2}erase{space}p{space 2}
	SendInput, ssx{space 2}e{space}leader{space 2}erase{space}p{space 2}
	SendInput, ssx{space 2}e{space}mtext{space 2}erase{space}p{space 2}
	SendInput, ssx{space 2}e{space}wipeout{space 2}erase{space}p{space 2}
	SendInput, ssx{space 2}e{space}MULTILEADER{space 2}erase{space}p{space 2}
	SendInput, ssx{space 2}e{space}text{space 2}erase{space}p{space 2}
	SendInput, ssx{space 2}e{space}solid{space 2}erase{space}p{space 2}
	SendInput, ssx{space 2}e{space}lwpolyline{space 2}pedit{space}m{space}p{space 2}width{space}0{space 2} ; this command must at last, incase there is no polyLine.
}