if (querybox "Convert all materials to standard_material?") do
(
	for i = geometry do
	(
		if i.material != standard do
		(
			tempName = i.material.name
			tempMat = standard()
			tempMat.name = tempName
			replaceinstances i.material tempMat
		)
	)
)