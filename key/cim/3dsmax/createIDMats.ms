(
	if getSaveRequired() then
	(
		if querybox "continue without saving file?" then
		(
			tempAns = on
		) else
		(
			tempAns = off
		)
	) else
	(
		tempAns = on
	)
	if tempAns do
	(
		if querybox "clean materials?" do filein "c:\\stankey-master\\key\\cdm\\3dsMax\\cleanDoubleMat.ms"
		setCommandPanelTaskMode #create
		MatEditor.close()
		case of
		(
			(classof renderers.current == CoronaRenderer):
			(
				for m = (getClassInstances stanmat) do replaceInstances m m.normalMat
				fn randomColor = color (random 0 255) (random 0 255) (random 0 255)
				for m = (getClassInstances CoronaMtl) do
				(
					tempStanMat=stanMat()
					tempStanMat.name = m.name + "_stan"
					tempStanMat.normalMat = copy m
					tempName = m.name + "_ID"
					tempMtl = tempStanMat.idMat
					tempMtl.name = tempName
					if not (matchPattern m.name pattern:"*MR*") then
					(
						a = undefined
						if m.opacityTexmap != undefined do a = m.opacityTexmap
						if (matchPattern m.name pattern:"*glass*") then
						(
							tempMtl = CoronaRaySwitchMtl()
							tempMtl.name = tempName
							tempStanMat.idMat = tempMtl
							replaceInstances m tempStanMat
						) else
						(
							tempMtl.opacityTexmap = a
							replaceInstances m tempStanMat
						)
					)
					else
					(
						tempMtl.colorReflect = color 255 255 255
						tempMtl.texmapOnReflect = off
						tempMtl.levelReflect = 1.0
						tempMtl.reflectGlossiness = 1.0
						tempMtl.fresnelIor = 999.0
						replaceInstances m tempStanMat
					)
				)
				for m = (getClassInstances CoronaLightMtl) do
				(
					tempStanMat=stanMat()
					tempStanMat.name = m.name + "_stan"
					tempStanMat.normalMat = copy m
					tempName = m.name + "_ID"
					tempMtl = tempStanMat.idMat
					tempMtl.name = tempName
					a = undefined
					if m.opacityTexmap != undefined do a = m.opacityTexmap
					if (matchPattern m.name pattern:"*none*") then
					(
						tempMtl = CoronaRaySwitchMtl()
						tempMtl.name = tempName
						tempStanMat.idMat = tempMtl
						replaceInstances m tempStanMat
					) else
					(
						tempMtl.opacityTexmap = a
						replaceInstances m tempStanMat
					)
				)
				for m = (getClassInstances Standardmaterial) do
				(
					tempStanMat=stanMat()
					tempStanMat.name = m.name + "_stan"
					tempStanMat.normalMat = copy m
					tempName = m.name + "_ID"
					tempMtl = tempStanMat.idMat
					tempMtl.name = tempName
					replaceInstances m tempStanMat
				)
			)
			(classof renderers.current == Redshift_Renderer):
			(
				for m = (getClassInstances Redshift_Material_Blender) do
				(
					if (matchPattern m.name pattern:"*matIdSwitcher") do
					(
						if (matchPattern m.layerColor2_map.name pattern:"*_ID") then
						(
							replaceInstances m (copy m.layerColor1_map)
						)else
						(
							replaceInstances m (copy m.layerColor2_map)
						)
					)
				)
				fn randomColor = color (random 0 255) (random 0 255) (random 0 255)
				for m = (getClassInstances Redshift_Material) do
				(
					tempRedshift_Material_Blender = Redshift_Material_Blender()
					tempRedshift_Material_Blender.layerColor2_map = Redshift_Material()
					tempRedshift_Material_Blender.layerColor2_map.emission_color = randomColor()
					tempRedshift_Material_Blender.layerColor2_map.diffuse_weight = 0.0
					tempRedshift_Material_Blender.layerColor2_map.refl_weight = 0.0
					tempRedshift_Material_Blender.layerColor2_map.refr_weight = 0.0
					tempRedshift_Material_Blender.layerColor2_map.opacity_color_mapenable = on
					tempRedshift_Material_Blender.layerColor2_map.emission_color_mapenable = off
					tempRedshift_Material_Blender.layerColor2_map.emission_weight = 1
					tempRedshift_Material_Blender.name = m.name + "_matIdSwitcher"
					tempRedshift_Material_Blender.baseColor_map = copy m
					tempRedshift_Material_Blender.layerColor1_map = copy m
					tempName = m.name + "_ID"
					tempMtl = tempRedshift_Material_Blender.layerColor2_map
					tempMtl.name = tempName
					if not (matchPattern m.name pattern:"*MR*") then
					(
						a = undefined
						if m.opacity_color_map != undefined do a = m.opacity_color_map
						if (matchPattern m.name pattern:"*glass*") or (matchPattern m.name pattern:"*none*") then
						(
							tempMtl = Redshift_Architectural()
							tempMtl.name = tempName
							tempMtl.diffuse_weight = 0.0
							tempMtl.reflectivity = 0.0
							tempMtl.cutout_opacity = 0.0
							tempRedshift_Material_Blender.layerColor2_map = tempMtl
							replaceInstances m tempRedshift_Material_Blender
						) else
						(
							tempMtl.opacity_color_map = a
							replaceInstances m tempRedshift_Material_Blender
						)
					)
					else
					(
						tempMtl.refl_color = color 255 255 255
						tempMtl.refl_color_mapenable = off
						tempMtl.reflectivity = 1.0
						tempMtl.refl_gloss = 1.0
						tempMtl.brdf_fresnel = off
						tempMtl.brdf_0_degree_refl = 1.0
						replaceInstances m tempRedshift_Material_Blender
					)
				)
				for m = (getClassInstances Redshift_Incandescent) do
				(
					tempRedshift_Material_Blender = Redshift_Material_Blender()
					tempRedshift_Material_Blender.layerColor2_map = Redshift_Material()
					tempRedshift_Material_Blender.layerColor2_map.emission_color = randomColor()
					tempRedshift_Material_Blender.layerColor2_map.diffuse_weight = 0.0
					tempRedshift_Material_Blender.layerColor2_map.refl_weight = 0.0
					tempRedshift_Material_Blender.layerColor2_map.refr_weight = 0.0
					tempRedshift_Material_Blender.layerColor2_map.opacity_color_mapenable = on
					tempRedshift_Material_Blender.layerColor2_map.emission_color_mapenable = off
					tempRedshift_Material_Blender.layerColor2_map.emission_weight = 1
					tempRedshift_Material_Blender.name = m.name + "_matIdSwitcher"
					tempRedshift_Material_Blender.baseColor_map = copy m
					tempRedshift_Material_Blender.layerColor1_map = copy m
					tempName = m.name + "_ID"
					tempMtl = tempRedshift_Material_Blender.layerColor2_map
					tempMtl.name = tempName
					replaceInstances m tempRedshift_Material_Blender
				)
				for m = (getClassInstances Standardmaterial) do
				(
					tempRedshift_Material_Blender = Redshift_Material_Blender()
					tempRedshift_Material_Blender.layerColor2_map = Redshift_Material()
					tempRedshift_Material_Blender.layerColor2_map.emission_color = randomColor()
					tempRedshift_Material_Blender.layerColor2_map.diffuse_weight = 0.0
					tempRedshift_Material_Blender.layerColor2_map.refl_weight = 0.0
					tempRedshift_Material_Blender.layerColor2_map.refr_weight = 0.0
					tempRedshift_Material_Blender.layerColor2_map.opacity_color_mapenable = on
					tempRedshift_Material_Blender.layerColor2_map.emission_color_mapenable = off
					tempRedshift_Material_Blender.layerColor2_map.emission_weight = 1
					tempRedshift_Material_Blender.name = m.name + "_matIdSwitcher"
					tempRedshift_Material_Blender.baseColor_map = copy m
					tempRedshift_Material_Blender.layerColor1_map = copy m
					tempName = m.name + "_ID"
					tempMtl = tempRedshift_Material_Blender.layerColor2_map
					tempMtl.name = tempName
					replaceInstances m tempRedshift_Material_Blender
				)
			)
		)
	)
)
