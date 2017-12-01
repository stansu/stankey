actionMan.executeAction 0 "40006"  -- File: Save File
actionMan.executeAction 0 "40007"  -- File: Save File As
if (querybox "Change all materials to pure color?") do
(
	useEnvironmentMap = off
	for i = (getclassinstances Lens_Effects) do
	(
		setActive i off
	)
	standardMatMaps = #()
	for i = 1 to 24 do
	(
		append standardMatMaps false
	)
	standardMatMaps[7] = true
	fn randomColor = color (random 0 255) (random 0 255) (random 0 255)
	for m = scenematerials do
	(
		if (matchPattern m.name pattern:"*glass*") or (matchPattern m.name pattern:"*light_gradient*") do
		(
			b = mental_ray name:m.name
			replaceInstances m b
		)
	)	
	for m = (getClassInstances Arch___Design__mi) do
	(
		if m.name != "mirror" do
		(
			if m.refr_color_map != undefined do a = m.refr_color_map
			if m.cutout_map != undefined do a = m.cutout_map
			b = Standardmaterial name:m.name
			b.opacityMap = a
			replaceInstances m b
		)
	)
	for k = (getClassInstances Standardmaterial) do
	(
		k.mapEnables = standardMatMaps
		k.diffuse = randomColor()
		k.selfIllumAmount = 100
		k.specularLevel = 0
		k.twoSided = on
	)
	for k = (getClassInstances Environment_Background_Switcher__mi) do
	(
		k.environment = color 255 255 255 0
		k.environment_connected = off
	)	
	renderers.current.RaytraceEnable = off
	renderers.current.ShadowsEnable = off
)