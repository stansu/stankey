(
	MatEditor.Close()
	for m = (getClassInstances Redshift_Material_Blender) do
	(
		if (matchPattern m.name pattern:"*matIdSwitcher") and (not (matchPattern m.name pattern:"*UnwrapChecker*")) do
		(
			if (matchPattern m.baseColor_map.name pattern:"*_ID") then
			(
				if IsValidNode $LPM_Root do $LPM_Root.fileType = "jpg"
				m.baseColor_map = m.layerColor1_map
				for i = $LPM_* do
				(
					if isproperty i "pEnable" do
					(
						i.pEnable = 2
					)
				)
			) else
			(
				if IsValidNode $LPM_Root do $LPM_Root.fileType = "png"
				m.baseColor_map = m.layerColor2_map
				for i = $LPM_* do
				(
					if isproperty i "pEnable" do
					(
						i.pEnable = 3
					)
				)
			)
		)
	)
	filein "$MAX/scripts/LPM/include.ms"
	for m = (getClassInstances Redshift_Material_Blender) do
	(
		if (matchPattern m.name pattern:"*matIdSwitcher") do
		(
			if (matchPattern m.baseColor_map.name pattern:"*_ID") then
			(
				try ((getClassInstances Redshift_Physical_Sky)[1].on = off) catch()
				exit
			) else
			(
				try((getClassInstances Redshift_Physical_Sky)[1].on = on) catch()
				exit
			)
		)
	)
)