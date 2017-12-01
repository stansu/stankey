if querybox "collapse shape then corner knots?" do
(
	spl = selection[1]
	tempMod = modPanel.getCurrentObject()
	tempModIndex = modPanel.getModifierIndex spl tempMod
	maxOps.CollapseNodeTo spl tempModIndex on
	for s = 1 to (numSplines spl) do
	(
		(
			knots = numKnots spl s
			for k = 1 to knots do setKnotType spl s k #corner
		)
	)
	updateshape spl
	modpanel.setCurrentObject spl.baseobject
)