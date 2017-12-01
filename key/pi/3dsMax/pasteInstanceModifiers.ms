if stanModifierArray != undefined do
(
	setCommandPanelTaskMode #modify
	for o = stanModifierArray.count to 1 by -1 do
	(
		modPanel.addModToSelection stanModifierArray[o]
	)
)