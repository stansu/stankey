(
	if querybox "Render by cameras?" do
	(
		renderSceneDialog.close()
		rendTimeType = 4
		layerI = LayerManager.count - 1
		layerS = for i = 0 to layerI collect (LayerManager.getlayer i).on
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
					tempLayers = execute (getUserProp tempNode "layers")
					for j = tempLayers do
					(
						(LayerManager.getLayerFromName j).on = off
					)
					for j = tempLayers do
					(
						(LayerManager.getLayerFromName j).on = on
						tempLayer = j
						tempLayer = filterString tempLayer "."
						tempFinal = tempFilePath + (getFilenameFile maxFileName) + "_" + tempFileName + "_" + tempLayer[1] + tempFileType
						rendOutputFilename = tempFinal
						rendPickupFrames = (getUserProp tempNode "frames") as string
						select tempNode
						max vpt camera
						max quick render
						(LayerManager.getLayerFromName j).on = off
					)
				)
			)
			else
			(
				for i = 0 to layerI do (LayerManager.getlayer i).on = layerS[i + 1]
				exit
			)
		)
		for i = 0 to layerI do (LayerManager.getlayer i).on = layerS[i + 1]
	)
)