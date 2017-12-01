(
	if selection.count != 0 then
	(
		setCommandPanelTaskMode #modify
		b = pickobject prompt:"Pick target object"
		if b != undefined do
		(
			tempModArray = for i = b.modifiers collect i
			if tempModArray.count > 0 then
			(
				bTM = b.objecttransform
				rollout copyModifierTM "copyModifierTM"
				(
					listbox modifierList "modifierList:" height:tempModArray.count selection:0 items:(for m = tempModArray collect m.name)
					on modifierList selected arg do
					(
						modPanel.addModToSelection tempModArray[arg]
						bModTM = getModContextTM b tempModArray[arg]
						bModWTM =  (inverse bModTM) * bTM
						for i = selection do
						(
							aTM = i.objecttransform
							finalTM = (inverse (bModWTM * (inverse aTM)))
							setModContextTM i tempModArray[arg] finalTM
						)
						tempModArray[arg].enabled = off
						tempModArray[arg].enabled = on
						if (queryBox "Instance material too?") do
						(
							selection.material = b.material
						)
						DestroyDialog copyModifierTM
					)
				)
				createDialog copyModifierTM pos:mouse.screenpos()
			)
			else messagebox "No valid modifier!"
		)
	)
	else messagebox "Please select some object!"
)