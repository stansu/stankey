(
	tempFilePath = getFilenamePath rendOutputFilename
	tempFileType = getFilenameType rendOutputFilename
	tempArray = for i = (getclassinstances Targetcamera) collect (refs.dependentNodes i)[1]
	for k = tempArray do
	(
		if keyboard.escPressed do exit
		if not k.isFrozen do
		(
			tempFinal = tempFilePath + (getFilenameFile maxFileName) + "_" + k.name +tempFileType
			renderSceneDialog.close()
			rendOutputFilename = tempFinal
			renderSceneDialog.open()
			select k
			max vpt camera
			max quick render
		)
	)				
)