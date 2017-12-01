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
		filein "D:\\stanKey\\key\\cdm\\3dsMax\\cleanDoubleMat.ms"
		setCommandPanelTaskMode #create
		MatEditor.close()
		for m = (getClassInstances stanmat) do replaceInstances m m.normalMat
		fn randomColor = color (random 0 255) (random 0 255) (random 0 255)
		for m = (getClassInstances CoronaMtl) do
		(
			tempStanMat=stanMat()
			tempStanMat.name = m.name
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
			tempStanMat.name = m.name
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
			tempStanMat.name = m.name
			tempStanMat.normalMat = copy m
			tempName = m.name + "_ID"
			tempMtl = tempStanMat.idMat
			tempMtl.name = tempName
			replaceInstances m tempStanMat
		)
	)
)