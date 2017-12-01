#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Recommended for catching common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
#IfWinActive, ahk_class AfxMDIFrame100u
{
	SendInput, ssx{enter 2}e{enter}hatch{enter 2}erase{enter}p{enter 2}
	SendInput, ssx{enter 2}e{enter}DIMENSION{enter 2}erase{enter}p{enter 2}
	SendInput, ssx{enter 2}e{enter}leader{enter 2}erase{enter}p{enter 2}
	SendInput, ssx{enter 2}e{enter}mtext{enter 2}erase{enter}p{enter 2}
	SendInput, ssx{enter 2}e{enter}wipeout{enter 2}erase{enter}p{enter 2}
	SendInput, ssx{enter 2}e{enter}MULTILEADER{enter 2}erase{enter}p{enter 2}
	SendInput, ssx{enter 2}e{enter}text{enter 2}erase{enter}p{enter 2}
}