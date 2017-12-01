if compareName == undefined do filein "D:\\stanKey\\maxScriptFunction\\compareName.ms"
(
	if (not getSaveRequired()) or (selection.count > 0) then
	(
-- 		filein "D:\\stanKey\\maxScriptFunction\\fn_cleanDoubleMat.ms"
		tempSelect = #()
		for i = 1 to 24 do meditmaterials[i] = standard()
		if selection.count != 0 do
		(
			for i = $ where i.material != undefined do
			(
				if classof i.material == multimaterial then
				(
					for j = i.material.material do
					(
						appendIfUnique tempSelect j
					)
				)else
				(
					appendIfUnique tempSelect i.material
				)
			)
		)
		setCommandPanelTaskMode #create
		if classof renderers.current == CoronaRenderer do
		(
			renderers.current.Use_render_stamp = off
			renderers.current.Use_3dsmax_environment = on
			renderers.current.GI_secondary_solver = 0
			renderers.current.Type_of_VFB_window = 0
		)
		fn randomColor = color (random 0 255) (random 0 255) (random 0 255)
		tempCoronaMat = CoronaMtl()
		tempCoronaMat.name = "people"
		for i = (getClassInstances multimaterial) do
		(
			if (matchPattern i.name pattern:"*male*") do
			(
				replaceInstances i tempCoronaMat
			)
		)
		if (getClassInstances CoronaMtl)[1].levelDiffuse != 0.0 do
		(
			for i = (getClassInstances freeSpot) do
			(
				i.on = off
			)
			for i = (getClassInstances targetSpot) do
			(
				i.on = off
			)
			for i = (getClassInstances CoronaSun) do
			(
				i.on = off
			)
			for i = (getclassinstances Lens_Effects) do
			(
				setActive i off
			)
			CRSM = (getClassInstances CoronaRaySwitchMtl)
			for m = 1 to CRSM.count do
			(
				if (matchPattern CRSM[m].name pattern:"*none*") then
				(
					tempMat = CoronaRaySwitchMtl()
					tempMat.name = "none"+(m as string)
					replaceInstances CRSM[m] tempMat
				)
				else
				(
					if CRSM[m].directMtl != undefined do
					(
						replaceInstances CRSM[m] CRSM[m].directMtl
					)
				)
			)
			CLM = (getClassInstances CoronaLightMtl)
			for m = 1 to CLM.count do
			(
				tempMat = CoronaMtl()
				tempMat.name = "light"+(m as string)
				replaceInstances CLM[m] tempMat
			)
			CRSM = (getClassInstances CoronaRaySwitchMtl)
			tempCount = CRSM.count
			for m = (getClassInstances CoronaMtl) do
			(
				m.alphaMode = 2
				if not (matchPattern m.name pattern:"*MR*") then
				(
					a = undefined
					if m.texmapOpacity != undefined do a = m.texmapOpacity
					if (matchPattern m.name pattern:"*none*") then
					(
						tempMat = CoronaRaySwitchMtl()
						tempCount += 1
						tempMat.name = "none"+(tempCount as string)
						replaceInstances m tempMat
					)
					else
					(
						if (matchPattern m.name pattern:"*glass*") then
						(
							m.levelDiffuse = 0.0
							m.levelReflect = 0.0
							m.levelTranslucency = 0.0
							m.opacityTexmap = a
							m.texmapOnOpacity = on
							m.levelRefract = 1.0
							m.colorRefract = color 255 255 255
						)
						else
						(
							m.colorSelfIllum = randomColor()
							m.levelDiffuse = 0.0
							m.levelReflect = 0.0
							m.levelTranslucency = 0.0
							m.levelSelfIllum = 1.0
							m.opacityTexmap = a
							m.texmapOnOpacity = on
							m.texmapOnSelfIllum = off
						)
					)
				)
				else
				(
					m.colorReflect = color 255 255 255
					m.texmapOnReflect = off
					m.levelReflect = 1.0
					m.reflectGlossiness = 1.0
					m.fresnelIor = 999.0
				)
			)
		)
		setCommandPanelTaskMode #create
		renderSceneDialog.close()
		useEnvironmentMap = off
		rendTimeType = 4
		rendSaveFile = on
		tempFilePath = getFilenamePath rendOutputFilename
		tempJpg = getFiles (tempFilePath+"*.jpg")
		tempDir = getDirectories (tempFilePath+"*")
		fileName = (getFilenameFile maxFileName)+"_"
		for j = tempDir do
		(
			tempDirJpg = getFiles (j+"*.jpg")
			if tempDirJpg.count > 0 do deleteFile tempDirJpg[1]
		)
		layerI = LayerManager.count - 1
		layerS = for i = 0 to layerI collect (LayerManager.getlayer i).on
		tempArray = for i = (getclassinstances Targetcamera) collect (refs.dependentNodes i)[1]
		qsort tempArray compareName
-- 		/*
		for k = tempArray do
		(
			if keyboard.controlPressed do exit
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
					if keyboard.controlPressed do exit
					rendPickupFrames = f
					tempFolder = fileName+k.name+"_"+(formattedPrint (f as integer) format:"04d")
					makeDir (tempFilePath+tempFolder+"\\")
					for p = tempJpg do
					(
						if (matchPattern p pattern:("*"+tempFolder+"*")) do
						(
							copyFile p (tempFilePath+tempFolder+"\\"+(filenameFromPath p))
						)
					)
					if tempSelect.count == 0 do tempSelect = getClassInstances CoronaMtl
					for m = tempSelect do
					(
						if keyboard.controlPressed do exit
						m.alphaMode = 1
						tempFinal = tempFilePath+tempFolder+"\\"+k.name+"_"+m.name+"_.png"
						rendOutputFilename = tempFinal
						max quick render
						m.alphaMode = 2
					)
				)
			)
		)
-- 		*/
		for i = 0 to layerI do (LayerManager.getlayer i).on = layerS[i + 1]
		renderers.current.Type_of_VFB_window = 2
		rendOutputFilename = tempFilePath
		for d = tempDir do
		(
			if keyboard.controlPressed do exit
			tempDirJpg = getFiles (d+"*.jpg")
			if tempDirJpg.count > 0 do
			(
				DOSCommand ("D:\\stanKey\\key\\de\\bat\\deleteEmpty.bat \""+d+"\"")
			)
		)
		DOSCommand ("copy \"D:\\stanKey\\photoshopJsx\\filesToLayers.jsx\" "+"\""+tempFilePath+"\"")
		if not keyboard.controlPressed do HiddenDOSCommand ("(\"C:\\Program Files\\Adobe\\Adobe Photoshop CS5.1 (64 Bit)\\Photoshop.exe\" "+"\""+tempFilePath+"filesToLayers.jsx\")") donotwait:on
	)
	else messagebox "Save file before render materials!(or select object to re-render)"
)