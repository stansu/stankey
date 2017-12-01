(
	if selection.count != 0 do
	(
		temp = #()
		for ii = $ do
		(
			if (ii.modifiers.count != 0) do
			(
				for jj = ii.modifiers do
				(
					appendIfUnique temp jj
				)
			)
		)
		for ii = 1 to temp.count do
		(
			if classof (execute temp[ii].name[temp[ii].name.count]) != integer do
			(
				temp[ii].name += ii as string
			)
		)
		setCommandPanelTaskMode #create
		setCommandPanelTaskMode #modify
		stanModifierArray = #()
		rollout delModifier "delete Modifier"
		(
			button okButton "delete selected modifier"
			MultiListBox modifierList "modifierList:" height:temp.count selection:#{1..(temp.count)} items:(for m = temp collect m.name)
			on okButton pressed do
			(
				for ii = (modifierList.selection as array) do
				(
					append stanModifierArray temp[ii]
				)
				for ii = stanModifierArray do
				(
					for jj = $ do
					(
						try (deleteModifier jj ii) catch(continue)
					)
				)
				DestroyDialog delModifier
			)
			on delModifier close do
			(
				for ii = 1 to temp.count do
				(
					tempCount = temp[ii].name.count
					for jj = 1 to tempCount do
					(
						if classof (execute temp[ii].name[jj]) == integer do
						(
							temp[ii].name = replace temp[ii].name jj (tempCount-(jj-1)) ""
							exit
						)
					)
				)
			setCommandPanelTaskMode #create
			setCommandPanelTaskMode #modify
			)
		)
		createDialog delModifier pos:mouse.screenpos()
	)
)