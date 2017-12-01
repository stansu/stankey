(
	if (querybox "Render all materials mask?") do
	(
		if (querybox "Delete duplicate material? (Please backup!)") do
		(
			filein "D:\\stanKey\\maxScriptFunction\\fn_cleanDoubleMat.ms"
		)
		setCommandPanelTaskMode #create
		renderSceneDialog.close()
		useEnvironmentMap = off
		rendTimeType = 4
		rendSaveFile = on
		tempFilePath = getFilenamePath rendOutputFilename
		layerI = LayerManager.count - 1
		layerS = for i = 0 to layerI collect (LayerManager.getlayer i).on
		if classof renderers.current == CoronaRenderer do
		(
			renderers.current.Use_render_stamp = off
			renderers.current.Use_3dsmax_environment = on
			renderers.current.GI_secondary_solver = 0
			renderers.current.Type_of_VFB_window = 0
		)
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
		fn randomColor = color (random 0 255) (random 0 255) (random 0 255)
		for m = (getClassInstances CoronaRaySwitchMtl) do
		(
			if (matchPattern m.name pattern:"*glass*") or (matchPattern m.name pattern:"*none*") then
			(
				replaceInstances m (CoronaRaySwitchMtl())
			) else
			(
				if m.directMtl != undefined do
				(
					replaceInstances m m.directMtl
				)
			)
		)
		for m = (getClassInstances CoronaLightMtl) do
		(
			replaceInstances m (CoronaMtl())
		)
		for m = (getClassInstances CoronaMtl) do
		(
			m.alphaMode = 2
			if not (matchPattern m.name pattern:"*MR*") then
			(
				a = undefined
				if m.texmapOpacity != undefined do a = m.texmapOpacity
				if (matchPattern m.name pattern:"*glass*") or (matchPattern m.name pattern:"*none*") then
				(
					replaceInstances m (CoronaRaySwitchMtl())
				) else
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
			else
			(
				m.colorReflect = color 255 255 255
				m.texmapOnReflect = off
				m.levelReflect = 1.0
				m.reflectGlossiness = 1.0
				m.fresnelIor = 999.0
			)
		)
		if (querybox "Render by cameras?") do
		(
			for i = (getclassinstances Targetcamera) do
			(
				if keyboard.escPressed do exit
				for k = (refs.dependentNodes i) do
				(
					if keyboard.escPressed do exit
					tempNode = k
					if not tempNode.isFrozen do
					(
						select tempNode
						max vpt camera
						for i = 0 to layerI do (LayerManager.getlayer i).on = off
						tempLayers = execute (getUserProp tempNode "layers")
						for j = tempLayers do
						(
							(LayerManager.getLayerFromName j).on = on
						)
						tempFrames = execute (getUserProp tempNode "frames")
						for f = tempFrames do
						(
							if keyboard.escPressed do exit
							rendPickupFrames = f
							makeDir (tempFilePath+tempNode.name+"\\"+f+"\\")
							for m = (getClassInstances CoronaMtl) do
							(
								if keyboard.escPressed do exit
								m.alphaMode = 1
								tempFinal = tempFilePath+tempNode.name+"\\"+f+"\\"+(getFilenameFile maxFileName)+"_"+tempNode.name+"_"+m.name+".png"
								rendOutputFilename = tempFinal
								max quick render
								m.alphaMode = 2
							)
							
						)
					)
				)				
			)
		)
		for i = 0 to layerI do (LayerManager.getlayer i).on = layerS[i + 1]
		renderers.current.Type_of_VFB_window = 2
		rendOutputFilename = tempFilePath
	)
)