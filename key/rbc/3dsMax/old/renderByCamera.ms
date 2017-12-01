(
	if querybox "change render file name as current camera?" do
	(
		renderSceneDialog.close()
		rendTimeType = 4
		for i = (getclassinstances Targetcamera) do
		(
			if not keyboard.escPressed then
			(
				tempNode = (refs.dependentNodes i)[1]
				if not tempNode.isFrozen do
				(
					tempFilePath = getFilenamePath rendOutputFilename
					tempFileType = getFilenameType rendOutputFilename
					tempFileName = tempNode.name
					tempFinal = tempFilePath + (getFilenameFile maxFileName) + "_" + tempFileName + tempFileType
					rendOutputFilename = tempFinal
					rendPickupFrames = (getUserProp tempNode "frames") as string
					select tempNode
					max vpt camera
					max quick render
				)
			)else
			(
				exit
			)
		)
	)
)