(
	if selection.count != 0 then
	(
		setCommandPanelTaskMode #modify
		b = pickobject prompt:"Pick target object"
		if b != undefined do
		(
			tempModArray = for i = b.modifiers collect i
			case of
			(
				(tempModArray.count > 1):
				(
					bTM = b.objecttransform
					rollout copyModifierTM "I_M"
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
				(tempModArray.count == 0): messagebox "No valid modifier!"
				(tempModArray.count == 1): 
				(
					bTM = b.objecttransform
					modPanel.addModToSelection tempModArray[1]
					bModTM = getModContextTM b tempModArray[1]
					bModWTM =  (inverse bModTM) * bTM
					for i = selection do
					(
						aTM = i.objecttransform
						finalTM = (inverse (bModWTM * (inverse aTM)))
						setModContextTM i tempModArray[1] finalTM
					)
					tempModArray[1].enabled = off
					tempModArray[1].enabled = on
					if (queryBox "Instance material too?") do
					(
						selection.material = b.material
					)
				)
			)
		)
	)
	else messagebox "Please select some object!"
)