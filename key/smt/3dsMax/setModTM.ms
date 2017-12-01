(
	if selection.count != 0 then
	(
		setCommandPanelTaskMode #modify
		sourceModifier = modPanel.getCurrentObject()
		if superclassof sourceModifier == modifier then
		(
			b = pickobject prompt:"Pick target object"
			if b != undefined do
			(
				tempModArray = for i = b.modifiers collect i
				if tempModArray.count > 0 then
				(
					bTM = b.objecttransform
					bModTM = getModContextTM b sourceModifier
					if bModTM == undefined then
					(
						rollout copyModifierTM "copyModifierTM"
						(
							listbox modifierList "modifierList:" height:tempModArray.count selection:0 items:(for m = tempModArray collect m.name)
							on modifierList selected arg do
							(
								replaceInstances sourceModifier tempModArray[arg]
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
								DestroyDialog copyModifierTM
							)
						)
						createDialog copyModifierTM pos:mouse.screenpos()
					)
					else
					(
						bModWTM =  (inverse bModTM) * bTM
						for i = selection do
						(
							aTM = i.objecttransform
							finalTM = (inverse (bModWTM * (inverse aTM)))
							setModContextTM i sourceModifier finalTM
						)
						sourceModifier.enabled = off
						sourceModifier.enabled = on
					)
				)
				else messagebox "No valid modifier!"
			)
		)
		else  messagebox "No valid modifier!"
	)
	else messagebox "Please select some object!"
)