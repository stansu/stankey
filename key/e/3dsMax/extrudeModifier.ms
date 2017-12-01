-- try
(
	if validModifier $ Extrude then
	(
		setCommandPanelTaskMode #modify
		global stan_extrude
		local op1, op2, p1, p2
		snapState = snapMode.active
		helpersState = hideByCategory.helpers
		snapMode.active = on
		if stan_extrude == undefined do stan_extrude = Extrude ()
		op1 = pickpoint prompt:"pick object point 1\n" snap:#3d
		if (classof op1) == point3 do
		(
			op2 = pickpoint prompt:"pick object point 2\n" snap:#3d rubberBand:op1
			hideByCategory.helpers = off
			p1=point pos:op1
			p2=point pos:op2
			op1 = in coordsys selection[1] p1.pos
			op2 = in coordsys selection[1] p2.pos
			delete p1
			delete p2
			modPanel.addModToSelection (stan_extrude = copy stan_extrude) ui:on
			stan_extrude.Amount = abs(op2.z - op1.z)
			if op2.z < 0 do stan_extrude.Amount *= -1
			stan_extrude = stan_extrude
			clearListener()
		)
		if op1 == #rightClick do modPanel.addModToSelection (stan_extrude = copy stan_extrude) ui:on
		snapMode.active = snapstate
		hideByCategory.helpers = helpersState
	)
	else messagebox "Can't apply extrude modifier!"
)
-- catch()