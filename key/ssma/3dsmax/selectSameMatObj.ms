(
	a = selection[1].material
	selectHidden = queryBox "Select hidden objects?"
	(
		local instances = #()
		for i = (refs.dependentNodes a) do
		(
			if ((not i.ishidden) or selectHidden) do
			(
				append instances i
			)
		)
		select instances
	)
	if selection.count == 1 do messageBox "No same material objects!"
)