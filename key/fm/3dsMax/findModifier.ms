if compareName == undefined do
(
	filein "D:\\stanKey\\maxScriptFunction\\compareName.ms"
)
if selection.count != 0 then
(
	co = modPanel.getCurrentObject()
	tempArray = getClassInstances (classof co)
	qsort tempArray compareName
	rollout findModifier "findModifier"
	(
		listbox modifierList "Modifiers:" selection:0 items:(for o = tempArray collect o.name)
		on modifierList selected listIndex do
		(
			tempModifier = tempArray[listIndex]
			if (queryBox "Instance material too?") do
			(
				tempObj = (refs.dependentNodes tempModifier)[1]
				$.material = tempObj.material
			)
			for i = selection do if i.modifiers.count != 0 do deleteModifier i co
			modPanel.addModToSelection tempModifier
			DestroyDialog findModifier
		)
	)
	createDialog findModifier pos:mouse.screenpos()
) 
else
(
	messagebox "Please select an object with modifiers!"
)