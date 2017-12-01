renderSceneDialog.close()
if postRendScript == "" or not(doesFileExist postRendScript) then
(
	currentRenderDir = getFilenamePath rendOutputFilename
	renderDirIndex = (findString currentRenderDir "render") + 6
	renderDir = substring currentRenderDir 1 renderDirIndex
	f = createFile (renderDir+"temp.ahk")
	tempStr = "FileEncoding ,UTF-8\n"
	tempStr += "target := \"\"\n"
	tempStr += "Loop, "+renderDir+"*.lnk\n{\nFileGetShortcut, %A_LoopFileLongPath%, target\n}\n"
	tempStr += "file := FileOpen(\""+renderDir+"temp.txt\", \"w\")\n"
	tempStr += "file.Write(target)\n"
	tempStr += "file.Close()\n"
	format "%" tempStr to:f
	close f
	doscommand ("\""+renderDir+"temp.ahk"+"\"")
	deleteFile (renderDir+"temp.ahk")
	f = openFile (renderDir+"temp.txt")
	targetStr = readLine f
	close f
	deleteFile (renderDir+"temp.txt")
	f = createFile (renderDir+"temp.ms")
	tempStr = "dest_folder = \""+targetStr+"\"\n"
	tempStr += "dest_folder = dest_folder + \"\stan_3D\"\n"
	tempStr += "makeDir dest_folder\n"
	tempStr += "fileTemp = $LPM_Root.rootdir\n"
	tempStr += "fileTemp += \"*vfb*\"\n"
	tempStr += "maxName = substituteString maxFileName \".max\" \"\"\n"
	tempStr += "verName = substring maxName (maxName.count - 3) 4\n"
	tempStr += "for i = (getFiles fileTemp) do (\n"
	tempStr += "\tdeleteFile (dest_folder+\"\\\\\"+(filenameFromPath (substituteString i verName \"\")))\n"
	tempStr += "\tcopyfile i (dest_folder+\"\\\\\"+(filenameFromPath  i))\n"
	tempStr += "\trenameFile (dest_folder+\"\\\\\"+(filenameFromPath  i)) (dest_folder+\"\\\\\"+(filenameFromPath  (substituteString i verName \"\")))\n"
	tempStr += ")"
	format "%" tempStr to:f
	close f
	postRendScript = (renderDir+"temp.ms")
	filein postRendScript
)
else filein postRendScript