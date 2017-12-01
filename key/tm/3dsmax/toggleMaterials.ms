(
	MatEditor.Close()
-- 	toggleState = "normal"
	for m = (getClassInstances Redshift_Material_Blender) do
	(
		if (matchPattern m.name pattern:"*matIdSwitcher") and (not (matchPattern m.name pattern:"*UnwrapChecker*")) do
		(
			if (matchPattern m.baseColor_map.name pattern:"*_ID") then
			(
				m.baseColor_map = m.layerColor1_map
			) else
			(
				m.baseColor_map = m.layerColor2_map
			)
		)
	)
	if (matchPattern (getClassInstances Redshift_Material_Blender)[1].baseColor_map.name pattern:"*_ID") then
	(
		for i = $LPM_* do
		(
			if isproperty i "pEnable" do	i.pEnable = 3
			if isproperty i "active" do i.name += "_ID"
		)
		try ((getClassInstances Redshift_Physical_Sky)[1].on = off) catch()
	) else
	(
		for i = $LPM_* do
		(
			if isproperty i "pEnable" do i.pEnable = 2
			if isproperty i "active" do i.name = substitutestring i.name "_ID" ""
		)
		try((getClassInstances Redshift_Physical_Sky)[1].on = on) catch()
	)
	filein "$MAX/scripts/LPM/include.ms"
)