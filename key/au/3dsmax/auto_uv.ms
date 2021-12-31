(
	for o = selection do
	(
		if o.modifiers["stan_UVW_Map"] == undefined then
		(
			au = Uvwmap()
			addModifier o au
			--modPanel.addModToSelection au ui:on
			au.name = "stan_UVW_Map"
		)
		else
		(
			au = o.modifiers["stan_UVW_Map"]
		)
		au.maptype = 4
		
		oTm = o.transform
		bb = nodeGetBoundingBox o oTm
		bbLength = bb[2] - bb[1]
		bbLength = #(bbLength[1],bbLength[2],bbLength[3])
		bbMax = amax bbLength
		maxAxis = findItem bbLength bbMax
		au.gizmo.transform = matrix3 [1,0,0] [0,1,0] [0,0,1] (in coordsys oTm o.center)
		
		case maxAxis of
		(
			1:
			(
				au.axis = 0
				au.length = bbLength[2]
				au.width = bbLength[3]
				au.height = bbLength[1]
			)
			2:
			(
				au.axis = 1
				au.length = bbLength[3]
				au.width = bbLength[1]
				au.height = bbLength[2]
			)
			3:
			(
				au.axis = 2
				au.length = bbLength[2]
				au.width = bbLength[1]
				au.height = bbLength[3]
			)
		)
	)
)