(
	tempFilePath = getFilenamePath rendOutputFilename
	tempJpg = getFiles (tempFilePath+"*.jpg")
	tempDir = getDirectories (tempFilePath+"*")
-- 	for j = tempDir do
-- 	(
-- 		tempDirJpg = getFiles (j+"*.jpg")
-- 		if tempDirJpg.count > 0 do deleteFile tempDirJpg[1]
-- 	)
	for i = (getclassinstances Targetcamera) do
	(
		if keyboard.controlPressed do exit
		for k = (refs.dependentNodes i) do
		(
			if keyboard.controlPressed do exit
			tempFrames = execute (getUserProp k "frames")
			for f = tempFrames do
			(
				if keyboard.controlPressed do exit
				tempFolder = k.name+"_"+(formattedPrint (f as integer) format:"04d")
				for p = tempJpg do
				(
					if keyboard.controlPressed do exit
					if (matchPattern p pattern:("*"+tempFolder+"*")) do
					(
						if not k.isFrozen do copyFile p (tempFilePath+tempFolder+"\\"+(filenameFromPath p))
					)
				)
			)
		)				
	)
	DOSCommand ("copy \"D:\\stanKey\\photoshopJsx\\filesToLayers.jsx\" "+"\""+tempFilePath+"\"")
	HiddenDOSCommand ("(\"C:\\Program Files\\Adobe\\Adobe Photoshop CS5.1 (64 Bit)\\Photoshop.exe\" "+"\""+tempFilePath+"filesToLayers.jsx\")") donotwait:on
)