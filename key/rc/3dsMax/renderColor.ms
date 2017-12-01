(
	if not getSaveRequired() then
	(
		filein "D:\\stanKey\\key\\cdm\\3dsMax\\cleanDoubleMat.ms"
		setCommandPanelTaskMode #create
		renderSceneDialog.close()
		if IsValidNode $LPM_Root do $LPM_Root.fileType = "png"
		rendOutputFilename = substituteString rendOutputFilename ".jpg" "_byMaterials.png"
		useEnvironmentMap = off
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
		for m = (getClassInstances CoronaMtl) do
		(
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
		for m = (getClassInstances CoronaLightMtl) do
		(
			m.texmapOn = off
			m.emitLight = off
			m.multiplier = 1.0
			m.color = randomColor()
			if (matchPattern m.name pattern:"*matter*") do
			(
				m.color = color 255 255 255
			)
			
		)
		if classof renderers.current == CoronaRenderer do
		(
			renderers.current.progressive_time_limit = 0.0
			renderers.current.Use_render_stamp = off
			renderers.current.Use_3dsmax_environment = on
		)
	)
	else messagebox "Save file before change materials to pure colors!"
)