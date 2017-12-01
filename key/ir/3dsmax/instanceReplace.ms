(
	b = pickobject prompt:"Pick target object"
	if b != undefined do
	(
		instanceReplace selection b
		if (queryBox "Instance material too?") do
		(
			selection.material = b.material
		)
	)
)