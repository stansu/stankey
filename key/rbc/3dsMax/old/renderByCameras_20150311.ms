(
	if querybox "Render by cameras?" do
	(
		if not keyboard.escPressed then
		(
			renderSceneDialog.close()
			rendTimeType = 4
			rendSaveFile = on
			tempFilePath = getFilenamePath rendOutputFilename
			tempFileType = getFilenameType rendOutputFilename
			layerI = LayerManager.count - 1
			layerS = for i = 0 to layerI collect (LayerManager.getlayer i).on
			for i = (getclassinstances Targetcamera) do
			(
				for k = (refs.dependentNodes i) do
				(
					tempNode = k
					if not tempNode.isFrozen do
					(
						for i = 0 to layerI do (LayerManager.getlayer i).on = off
						tempLayers = execute (getUserProp tempNode "layers")
						for j = tempLayers do
						(
							(LayerManager.getLayerFromName j).on = on
						)
						tempFinal = tempFilePath + (getFilenameFile maxFileName) + "_" + tempNode.name + tempFileType
						rendOutputFilename = tempFinal
						rendPickupFrames = (getUserProp tempNode "frames") as string
						select tempNode
						max vpt camera
						max quick render
					)
				)				
			)
		) else
		(
			for i = 0 to layerI do (LayerManager.getlayer i).on = layerS[i + 1]
			exit
		)
		for i = 0 to layerI do (LayerManager.getlayer i).on = layerS[i + 1]
	)
)