(
	if selection.count == 1 then
	(
		originalObj = selection[1]
		tempModArray = for i = originalObj.modifiers collect i
		setCommandPanelTaskMode #modify
		stanModifierArray = #()
		case of
		(
			(tempModArray.count == 0): messagebox "No valid modifier!"
			(tempModArray.count > 1):
			(
				rollout instanceModifier "C_B_I_M"
				(
					button okButton "ok"
					MultiListBox modifierList "modifierList:" height:tempModArray.count selection:#{1..(tempModArray.count)} items:(for m = tempModArray collect m.name)
					on okButton pressed do
					(
						for i = (modifierList.selection as array) do
						(
							append stanModifierArray tempModArray[i]
						)
						DestroyDialog instanceModifier
						maxOps.CloneNodes originalObj cloneType:#copy newNodes:&newSel
						bTM = originalObj.objecttransform
						for i = stanModifierArray do
						(
							deleteModifier newSel newSel[1].modifiers[(i.name)]
						)
						select newSel
						for o = stanModifierArray.count to 1 by -1 do
						(
							modPanel.addModToSelection stanModifierArray[o]
							bModTM = getModContextTM originalObj stanModifierArray[o]
							bModWTM =  (inverse bModTM) * bTM
							aTM = newSel[1].objecttransform
							finalTM = (inverse (bModWTM * (inverse aTM)))
							setModContextTM newSel[1] stanModifierArray[o] finalTM
						)
						newSel[1].baseobject = originalObj.baseobject
						newSel[1].baseobject = copy originalObj.baseobject
					)
				)
				createDialog instanceModifier pos:mouse.screenpos()
			)
			(tempModArray.count == 1):
			(
				append stanModifierArray tempModArray[1]
				maxOps.CloneNodes originalObj cloneType:#copy newNodes:&newSel
				bTM = originalObj.objecttransform
				deleteModifier newSel newSel[1].modifiers[1]
				select newSel
				modPanel.addModToSelection stanModifierArray[1]
				bModTM = getModContextTM originalObj stanModifierArray[1]
				bModWTM =  (inverse bModTM) * bTM
				aTM = newSel[1].objecttransform
				finalTM = (inverse (bModWTM * (inverse aTM)))
				setModContextTM newSel[1] stanModifierArray[1] finalTM
				newSel[1].baseobject = originalObj.baseobject
				newSel[1].baseobject = copy originalObj.baseobject
			)
		)
	) else messagebox "Please select one object only!"
)