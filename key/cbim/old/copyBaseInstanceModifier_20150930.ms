(
	currentSel = selection as array
	if currentSel.count == 1 do
	(
		temp = for i = currentSel where i.modifiers.count != 0 collect i
		setCommandPanelTaskMode #modify
		global stanModifierArray
		stanModifierArray = #()
		rollout instanceModifier "instanceModifier"
		(
			button okButton "Instance selected modifier"
			MultiListBox modifierList "modifierList:" height:(temp[temp.count].modifiers).count selection:0 items:(for m = temp[temp.count].modifiers collect m.name)
			on okButton pressed do
			(
				for i = (modifierList.selection as array) do
				(
					append stanModifierArray temp[temp.count].modifiers[i]
				)
				DestroyDialog instanceModifier
				maxOps.CloneNodes currentSel cloneType:#copy newNodes:&newSel
				for i = stanModifierArray do
				(
					deleteModifier newSel newSel[1].modifiers[(i.name)]
				)
				select newSel
				for o = stanModifierArray.count to 1 by -1 do
				(
					modPanel.addModToSelection stanModifierArray[o]
				)
			)
		)
		createDialog instanceModifier pos:mouse.screenpos()
	)
)