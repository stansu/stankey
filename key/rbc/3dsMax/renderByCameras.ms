if compareName == undefined do filein "D:\\stanKey\\maxScriptFunction\\compareName.ms"
(
	renderSceneDialog.close()
	rendTimeType = 4
	rendSaveFile = on
	tempFilePath = ((substituteString maxFilePath "03_max\\" "")+"05_render\\"+((getLocalTime())[1] as string)+(formattedPrint ((getLocalTime())[2]) format:"02d")+(formattedPrint ((getLocalTime())[4]) format:"02d")+"\\")
	makeDir tempFilePath
	tempFileType = getFilenameType rendOutputFilename
	layerI = LayerManager.count - 1
	layerS = for i = 0 to layerI collect (LayerManager.getlayer i).on
-- 	layerV = for i = 0 to layerI collect (LayerManager.getlayer i).primaryVisibility
	tempArray = for i = (getclassinstances Targetcamera) collect (refs.dependentNodes i)[1]
	qsort tempArray compareName
	for k = tempArray do
	(
		if keyboard.controlPressed do exit
		if not k.isFrozen do
		(
			lights.on = off
			tempLights = getUserProp k "lights"
			if tempLights != undefined do
			(
				for i = (filterString tempLights ",") do
				(
					execute ("$"+i+"*.on = on")
				)
			)
-- 			for i = 0 to layerI do (LayerManager.getlayer i).primaryVisibility = layerV[i + 1]
			tempLayers = getUserProp k "layers"
			if tempLayers != undefined do
			(
				for i = 0 to layerI do (LayerManager.getlayer i).on = off
				for j = (filterString tempLayers ",") do
				(
					(LayerManager.getLayerFromName j).on = on
				)
			)
			tempFinal = tempFilePath + (getFilenameFile maxFileName) + "_" + k.name + "_" + tempFileType
			rendOutputFilename = tempFinal
			select k
			max vpt camera
			tempFrames = filterString (getUserProp k "frames") ","
			for f = tempFrames do
			(
				if keyboard.controlPressed do exit
				rendPickupFrames = f
				max quick render
				
			)
		)
	)				
	for i = 0 to layerI do (LayerManager.getlayer i).on = layerS[i + 1]
-- 	for i = 0 to layerI do (LayerManager.getlayer i).primaryVisibility = layerV[i + 1]
-- 	if not keyboard.controlPressed do filein postRendScript
)
	
