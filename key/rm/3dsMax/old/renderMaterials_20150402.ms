(
	if not getSaveRequired() then
	(
		filein "D:\\stanKey\\maxScriptFunction\\fn_cleanDoubleMat.ms"
		if classof renderers.current == CoronaRenderer do
		(
			renderers.current.Use_render_stamp = off
		)
		for m = (getClassInstances CoronaLightMtl) do
		(
			if m.texmap == undefined do
			(
				m.texmap = Color_Correction()
				m.texmap.color = m.color
			)
			m.color = color 0 0 0
			m.texmapOn = off
			m.affectAlpha = off
		)
		for m = (getClassInstances CoronaRaySwitchMtl) do
		(
			m.name += "_CoronaRaySwitchMtl"
		)
		tempMat3 = CoronaMtl()
		tempMat3.name = "matter"
		tempMat3.levelDiffuse = 0.0
		tempMat3.colorSelfIllum = color 0 0 0
		tempMat3.levelSelfIllum = 1.0
		tempMat3.alphaMode = 2
		for m = (getClassInstances CoronaMtl) do
		(
			tempMat1 = CoronaRaySwitchMtl()
			tempMat2 = copy m
			tempMat1.name = tempMat2.name
			tempMat1.baseMtl = tempMat2
			tempMat1.reflectMtl = tempMat2
			tempMat1.refractMtl = tempMat2
			tempMat1.directMtl = tempMat3
			replaceInstances m tempMat1
		)
		setCommandPanelTaskMode #create
		renderSceneDialog.close()
		rendTimeType = 4
		rendSaveFile = on
		tempFilePath = getFilenamePath rendOutputFilename
		tempJpg = getFiles (tempFilePath+"*.jpg")
		tempDir = getDirectories (tempFilePath+"*")
		for j = tempDir do
		(
			tempDirJpg = getFiles (j+"*.jpg")
			if tempDirJpg.count > 0 do deleteFile tempDirJpg[1]
		)
		layerI = LayerManager.count - 1
		layerS = for i = 0 to layerI collect (LayerManager.getlayer i).on
		for i = (getclassinstances Targetcamera) do
		(
			if keyboard.escPressed do exit
			for k = (refs.dependentNodes i) do
			(
				if keyboard.escPressed do exit
				tempFrames = execute (getUserProp k "frames")
				if not k.isFrozen do
				(
					select k
					max vpt camera
					tempLayers = getUserProp k "layers"
					if tempLayers != undefined do
					(
						for i = 0 to layerI do (LayerManager.getlayer i).on = off
						tempLayers = execute tempLayers
						for l = tempLayers do
						(
							(LayerManager.getLayerFromName l).on = on
						)
					)
					for f = tempFrames do
					(
						if keyboard.escPressed do exit
						rendPickupFrames = f
						tempFolder = k.name+"_"+(formattedPrint (f as integer) format:"04d")
						makeDir (tempFilePath+tempFolder+"\\")
						for p = tempJpg do
						(
							if (matchPattern p pattern:("*"+tempFolder+"*")) do
							(
								copyFile p (tempFilePath+tempFolder+"\\"+(filenameFromPath p))
							)
						)
						for m = (getClassInstances CoronaRaySwitchMtl) do
						(
							if keyboard.escPressed do exit
							tempFinal = tempFilePath+tempFolder+"\\"+k.name+"_"+m.name+"_.png"
							rendOutputFilename = tempFinal
							if not (matchPattern m.name pattern:"*_CoronaRaySwitchMtl*") do
							(
								m.directMtl = m.baseMtl
								max quick render
								m.directMtl = tempMat3
							)
						)
						for m = (getClassInstances CoronaLightMtl) do
						(
							if keyboard.escPressed do exit
							tempFinal = tempFilePath+tempFolder+"\\"+k.name+"_"+m.name+"_.png"
							rendOutputFilename = tempFinal
							m.affectAlpha = on
							m.texmapOn = on
							max quick render
							m.affectAlpha = off
							m.color = color 0 0 0
							m.texmapOn = off
						)
					)
				)
			)				
		)
		for i = 0 to layerI do (LayerManager.getlayer i).on = layerS[i + 1]
		renderers.current.Type_of_VFB_window = 2
		rendOutputFilename = tempFilePath
		for d = tempDir do
		(
			if keyboard.escPressed do exit
			tempDirJpg = getFiles (d+"*.jpg")
			if tempDirJpg.count > 0 do
			(
				DOSCommand ("D:\\stanKey\\key\\de\\bat\\deleteEmpty.bat \""+d+"\"")
			)
		)
		DOSCommand ("copy \"D:\\stanKey\\photoshopJsx\\filesToLayers.jsx\" "+"\""+tempFilePath+"\"")
		if not keyboard.escPressed do HiddenDOSCommand ("(\"C:\\Program Files\\Adobe\\Adobe Photoshop CS5.1 (64 Bit)\\Photoshop.exe\" "+"\""+tempFilePath+"filesToLayers.jsx\")") donotwait:on
	)
	else messagebox "Save file before render materials!"
)