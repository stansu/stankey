(
	for o = selection do
	(
		if o.modifiers["UVW Map"] == undefined then
		(
			au = Uvwmap()
			addModifier o au
		)
		else
		(
			au = o.modifiers["UVW Map"]
		)
		au.maptype = 4
		
		oTm = o.transform
		bb = nodeGetBoundingBox o oTm
		bbLength = bb[2] - bb[1]
		bbLength = #(bbLength[1],bbLength[2],bbLength[3])
		bbMax = amax bbLength
		maxAxis = findItem bbLength bbMax
		
		case maxAxis of
		(
			1:
			(
				au.axis = 0
			)
			2:
			(
				au.axis = 1
			)
			3:
			(
				au.axis = 2
			)
		)
	)
)