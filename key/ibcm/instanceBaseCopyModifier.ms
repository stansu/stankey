(
	setCommandPanelTaskMode #create
	newSel = #()
	final = #()
	for i = selection do
	(
		maxOps.CloneNodes i cloneType:#copy newNodes:&newSel
		newSel[1].baseobject = i.baseobject
		append final newSel[1]
	)
	setCommandPanelTaskMode #modify
	select final
	max spacebar
	select final
	)
)