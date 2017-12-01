(
	setCommandPanelTaskMode #create
	a=pickobject message:"Pick source base object..."
	if a != undefined and a != #escape do
	(
		$.baseobject = a.baseobject
		if (queryBox "Instance material too?") do
		(
			$.material = a.material
		)
	)
	setCommandPanelTaskMode #modify
)