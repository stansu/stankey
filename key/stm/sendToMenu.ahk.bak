#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Recommended for catching common errors.
#SingleInstance, force ;Avoid multiple thread.
SetControlDelay 0
CoordMode, Mouse, Screen
CoordMode, ToolTip, Screen
CoordMode, Pixel, Screen
#UseHook
;~ #WinActivateForce

if %clipboard%
{
	stanCodeFolder := "D:\study\"
	MyEdit := ""
	;~ MyClipBoard = %Clipboard%

	Gui, Add, Edit, r10 +ReadOnly vMyClipBoard, %Clipboard%
	Gui, Add, Text,, 輸入文字過濾資料夾
	Gui, Add, Edit, r1 gMyEdit vMyEdit
	Gui, add, Button, gMyButton1, 創建資料夾
	Gui, add, Button, gMyButton2, 複製
	Gui, Add, ListView, r20 Grid gMyListView, Folder
	Gui, +AlwaysOnTop

	Loop, %stanCodeFolder%\*.*, 2
	{
		LV_Add("Select", A_LoopFileName)
	}
	LV_ModifyCol(1, "AutoHdr")
	LV_ModifyCol(1, "Sort")

	Gui, Show
	GuiControl, Focus, MyEdit

	return
	
	MyButton1:
	FileCreateDir, %stanCodeFolder%%MyEdit%
	goto, MyEdit
	return

	MyButton2:
	RowNumber = 0
	Loop
	{
		RowNumber := LV_GetNext(RowNumber)
		if not RowNumber
			break
		LV_GetText(Text, RowNumber)
		Run, %stanCodeFolder%%Text%
		WinWaitActive, %Text%
		Send, ^v
		Sleep, 100
		WinClose, %Text%
	}
	ExitApp
	return

	MyEdit:
	Gui, submit, NoHide
	LV_Delete()
	Loop, %stanCodeFolder%\*.*, 2
	{
		If InStr(A_LoopFileName, MyEdit)
		{
			LV_Add("Select", A_LoopFileName)
		}
	}
	LV_ModifyCol(1, "AutoHdr")
	LV_ModifyCol(1, "Sort")
	return

	MyListView:
	return

	GuiClose:
	ExitApp
} else
{
	MsgBox, 請先拷貝檔案到剪貼簿中
}