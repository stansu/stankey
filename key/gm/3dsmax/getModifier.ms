(
	if selection.count != 0 then
	(
		setCommandPanelTaskMode #modify
		global stanModifier
		stanModifier = modPanel.getCurrentObject()
		messagebox ((stanModifier as string)+" copied")
	)
	else messagebox "Please select some object!"
)