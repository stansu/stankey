if compareName == undefined do filein "D:\\stanKey\\maxScriptFunction\\compareName.ms"
(
	renderSceneDialog.close()
	rendTimeType = 4
	rendSaveFile = on
	tempFilePath = getFilenamePath rendOutputFilename
	tempFileType = getFilenameType rendOutputFilename
	layerI = LayerManager.count - 1
	layerS = for i = 0 to layerI collect (LayerManager.getlayer i).on
	layerV = for i = 0 to layerI collect (LayerManager.getlayer i).primaryVisibility
	tempArray = for i = (getclassinstances Targetcamera) collect (refs.dependentNodes i)[1]
	qsort tempArray compareName
	for k = tempArray do
	(
		if keyboard.controlPressed do exit
		if not k.isFrozen do
		(
-- 			tempFileType = ".jpg"
			for i = 0 to layerI do (LayerManager.getlayer i).primaryVisibility = layerV[i + 1]
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
-- 			LayersV = getUserProp k "visible"
-- 			if LayersV != undefined do
-- 			(
-- 				tempFileType = ".png"
-- 				for i = 0 to layerI do (LayerManager.getlayer i).primaryVisibility = off
-- 				tempLayers = execute LayersV
-- 				for j = tempLayers do
-- 				(
-- 					(LayerManager.getLayerFromName j).primaryVisibility = on
-- 				)
-- 				VLayers = getUserProp k "Vlayers"
-- 				tempLayers = execute VLayers
-- 				for j = tempLayers do
-- 				(
-- 					(LayerManager.getLayerFromName j).on = on
-- 				)
-- 			)
			tempFinal = tempFilePath + (getFilenameFile maxFileName) + "_" + k.name + "_" + tempFileType
			rendOutputFilename = tempFinal
			select k
			max vpt camera
			tempFrames = execute (getUserProp k "frames")
			for f = tempFrames do
			(
				if keyboard.controlPressed do exit
				rendPickupFrames = f
				max quick render
				
			)
		)
	)				
	for i = 0 to layerI do (LayerManager.getlayer i).on = layerS[i + 1]
	for i = 0 to layerI do (LayerManager.getlayer i).primaryVisibility = layerV[i + 1]
-- 	if not keyboard.controlPressed do filein postRendScript
)
	
