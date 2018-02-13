(
	renderSceneDialog.close()
	rendTimeType = 4
	rendSaveFile = on
	tempFilePath = getFilenamePath rendOutputFilename
	tempFileType = getFilenameType rendOutputFilename
	layerI = LayerManager.count - 1
	layerS = for i = 0 to layerI collect (LayerManager.getlayer i).on
	tempArray = for i = (getclassinstances Targetcamera) collect (refs.dependentNodes i)[1]
	if compareName == undefined do filein "c:\\stankey-master\\maxScriptFunction\\compareName.ms"
	qsort tempArray compareName
	for k = tempArray do
	(
		if keyboard.escPressed do exit
		if not k.isFrozen do
		(
			tempLayers = getUserProp k "layers"
			if tempLayers != undefined do
			(
				for i = 0 to layerI do (LayerManager.getlayer i).on = off
				tempLayers = execute tempLayers
				for j = tempLayers do
				(
					(LayerManager.getLayerFromName j).on = on
				)
			)
			tempFinal = tempFilePath + (getFilenameFile maxFileName) + "_" + k.name + "_" + tempFileType
			rendOutputFilename = tempFinal
			select k
			max vpt camera
			tempFrames = execute (getUserProp k "frames")
			for f = tempFrames do
			(
				if keyboard.escPressed do exit
				rendPickupFrames = f
				max quick render
				
			)
		)
	)				
	for i = 0 to layerI do (LayerManager.getlayer i).on = layerS[i + 1]
)
	
