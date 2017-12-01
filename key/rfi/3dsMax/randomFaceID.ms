if querybox "only current focus object will random face ID !\n(did you try material by element?)" do
(
	for i = $ do
	(
		if i.modifiers.count != 0 do
		(
			tempMod = modPanel.getCurrentObject()
			if classof tempMod == Edit_Poly do
			(
				subObjectLevel = 4
				numberOfFace = tempMod.GetNumFaces()
				tempMod.SetOperation #SetMaterial
				for i = 1 to numberOfFace do
				(
					tempMod.select #face (#(i) as bitarray)
					tempMod.materialIDToSet = random 0 5
					tempMod.SetOperation #SetMaterial
					tempMod.setSelection #face #{}
				)
			)
		)
	)
)