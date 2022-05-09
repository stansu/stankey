if selection.count != 0 then
(
	if querybox "collapse shape then corner knots?" do
	(
		cs = selection as Array
		max modify mode
		for c = cs do
		(
			if superClassOf c == shape do
			(
				select c
				macros.run "Modifier Stack" "Convert_to_Spline"
				for s = 1 to (numSplines c) do
				(
					(
						knots = numKnots c s
						for k = 1 to knots do setKnotType c s k #corner
					)
				)
				updateshape c
				modpanel.setCurrentObject c.baseobject
			)
		)
		select cs
	)
) else messageBox "please select some curves"
