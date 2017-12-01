Try
(
	confirm = on
	for i = selection do
	(
		count = i.modifiers.count
		if (count > 0) and (confirm == on) then 
		(
			tempObj = modPanel.getCurrentObject()
			isModifierBar = (isProperty tempObj "Modified_Object")
			if isModifierBar do
			(
				modPanel.addModToSelection (EmptyModifier()) ui:on
				tempObj = modPanel.getCurrentObject()
			)
			if ((superclassof tempObj) != modifier) and not (isProperty tempObj "Modified_Object") then
			(
				confirm = on
				exit
			)else
			(
				tempIndex = modPanel.getModifierIndex (selection as array)[1] tempObj
				for j = count to 1 by -1 do
				(
					if (((classof i.modifiers[j]) == Normalmodifier) or ((classof i.modifiers[j]) == clone)) do
					(
						if (j < tempIndex) then
						(
							confirm = on
							exit
						)else
						(
							confirm = off
							exit
						)
					)
				)
			)
		)else exit
	)
	if confirm then
	(
		modPanel.addModToSelection (Edit_Poly ()) ui:on
	)else
	(
		modPanel.addModToSelection (Turn_to_Mesh ()) ui:on
		modPanel.addModToSelection (Edit_Poly ()) ui:on
	)
)
catch()