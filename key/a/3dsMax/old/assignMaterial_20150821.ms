if selection.count != 0 then
(
-- 	if (querybox "assign material?") do
	(
		tempObj = pickObject message:"select an object's material, then assign to current object."
		if 	tempObj != undefined do
		(
			if tempObj.material != undefined then
			(
				state = InstanceMgr.autoMtlPropagation
				InstanceMgr.autoMtlPropagation = querybox "Propagate source material to all instances?"
				if tempObj != undefined do
				(
					if (getNumSubMtls tempObj.material > 0) and ((classof tempObj.material) != CoronaRaySwitchMtl) do messagebox "source material has sub-materials!"
					$.material = tempObj.material
					InstanceMgr.autoMtlPropagation = state
					if classof tempObj.modifiers[1] == Uvwmap do
					(
						ask = querybox "instance UVW_modifier too?"
						if ask do
						(
							modPanel.addModToSelection (tempObj.modifiers[1]) ui:on
-- 							addModifier $ tempObj.modifiers[1]
						)
					)
					try
					(
						$.realWorldMapSize = tempObj.realWorldMapSize
					)catch()
					try
					(
						$.realWorldMapSize = tempObj.modifiers[1].realWorldMapSize
					)catch()
					try
					(
						$.modifiers[1].realWorldMapSize = tempObj.realWorldMapSize
					)catch()
					try
					(
						$.modifiers[1].realWorldMapSize = tempObj.modifiers[1].realWorldMapSize
					)catch()
					clearListener()
				)
			)
			else
			(
				if querybox "Target haven't material! assign wire color?" do
				(
					$.wirecolor = tempObj.wirecolor
				)
			)
		)
	)
)
else messageBox "Please select object for assign material!"
