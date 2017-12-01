(
	b = pickobject prompt:"Pick target object"
	if b != undefined do
	(
		tempModArray = for i = b.modifiers collect i
		if tempModArray.count > 0 then
		(
			setCommandPanelTaskMode #modify
			sourceModifier = modPanel.getCurrentObject()
			if superclassof sourceModifier == modifier then
			(
				bTM = b.objecttransform
				bModTM = getModContextTM b sourceModifier
				if bModTM != undefined then
				(
					bModBMin = getModContextBBoxMin b sourceModifier
					bModBMax = getModContextBBoxMax b sourceModifier
					bModWTM =  (inverse bModTM) * bTM
					for i = selection do
					(
						aTM = i.objecttransform
						finalTM = (inverse (bModWTM * (inverse aTM)))
						setModContextTM i sourceModifier finalTM
						setModContextBBox i sourceModifier bModBMin bModBMax
					)
					sourceModifier.enabled = off
					sourceModifier.enabled = on
				)
				else messagebox "No shared modifier!"
			)
			else  messagebox "No shared modifier!"
		)
		else messagebox "No valid modifier!"
	)
)