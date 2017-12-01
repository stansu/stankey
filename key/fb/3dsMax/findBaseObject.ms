if selection.count != 0 do
(
	co = $.baseobject
	tempClassArray = getClassInstances (classof co)
	tempArray = #()
	for c in tempClassArray do
	(
		for o = 1 to (refs.dependentNodes c).count do
		(
			append tempArray ((refs.dependentNodes c)[o])
		)
	)
	rollout findBaseObject "findBaseObject"
	(
		listbox BaseObjectList "BaseObjectList:" selection:0 items:(for o in tempArray collect o.name)
		on BaseObjectList selected listIndex do
		(
			$.baseobject = tempArray[listIndex]
			$.name = uniqueName tempArray[listIndex].name
			if (queryBox "Instance material too?") do
			(
				$.material = tempArray[listIndex].material
			)
			DestroyDialog findBaseObject
		)
	)
	createDialog findBaseObject pos:mouse.screenpos()
)