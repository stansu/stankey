if (querybox "Change all materials to pure color?") do
(
	setCommandPanelTaskMode #create
	renderSceneDialog.close()
	rendOutputFilename = substituteString rendOutputFilename ".jpg" ".png"
	useEnvironmentMap = off
	for i = (getclassinstances Lens_Effects) do
	(
		setActive i off
	)
	fn randomColor = color (random 0 255) (random 0 255) (random 0 255)
	for m = (getClassInstances CoronaLightMtl) do
	(
		if m.name != "mirror" do
		(
			if m.opacityTexmap != undefined do a = m.opacityTexmap
			b = CoronaMtl name:m.name
			b.opacityTexmap = a
			replaceInstances m b
		)
	)
	for m = (getClassInstances CoronaRaySwitchMtl) do
	(
		replaceInstances m m.directMtl
	)
	for m = (getClassInstances CoronaMtl) do
	(
		if m.name != "mirror" do
		(
			if m.texmapOpacity != undefined do a = m.texmapOpacity
			if (matchPattern m.name pattern:"*glass*") or (matchPattern m.name pattern:"*none*") then
			(
				b = CoronaMtl name:m.name
				b.twosidedGlass = off
				b.Use_caustics = off
				b.ior = 1.0
				b.levelRefract = 1.0
				b.colorRefract = (color 255 255 255)
				b.opacityTexmap = a
				b.texmapOnOpacity = on
				replaceInstances m b
			) else
			(
				b = CoronaMtl name:m.name
				b.colorSelfIllum = randomColor()
				b.levelDiffuse = 0.0
				b.levelSelfIllum = 1.0
				b.opacityTexmap = a
				b.texmapOnOpacity = on
				replaceInstances m b
			)
		)
	)
	for m = (getClassInstances fR_Advanced) do
	(
		if m.name != "mirror" do
		(
			if m.opacityMap != undefined do a = m.opacityMap
			if (matchPattern m.name pattern:"*glass*") or (matchPattern m.name pattern:"*none*") then
			(
				b = fR_Glass name:m.name
				b.reflectColor = (color 0 0 0)
				b.useSpecular = off
				b.refractIOR = 1.0
				b.refractColor = (color 255 255 255)
				b.refractMap = a
				b.refractMapEnable = on
				replaceInstances m b
			) else
			(
				b = CoronaMtl name:m.name
				b.colorSelfIllum = randomColor()
				b.levelDiffuse = 0.0
				b.levelSelfIllum = 1.0
				b.opacityTexmap = a
				b.texmapOnOpacity = on
				replaceInstances m b
			)
		)
	)
)