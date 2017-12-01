(
	tempFilePath = getFilenamePath rendOutputFilename
	tempDir = getDirectories (tempFilePath+"*")
	for d = tempDir do
	(
		if keyboard.controlPressed do exit
		tempDirJpg = getFiles (d+"*.jpg")
		if tempDirJpg.count > 0 do
		(
			DOSCommand ("D:\\stanKey\\key\\de\\bat\\deleteEmpty.bat \""+d+"\"")
		)
	)
)