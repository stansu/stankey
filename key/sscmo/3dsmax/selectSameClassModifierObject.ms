try
(
	local a, i, currentSelection = #()
	geometrySelection = for i = selection where (superclassof i == GeometryClass) collect i
	a = (getClassInstances (classof (modPanel.getCurrentObject())))
	if a == undefined then
	(
		messagebox "Please select object that show some modifiers!"
	)
	else
	(
		selectHidden = queryBox "Select hidden objects?"
		for i = selection do
		(
			if (not i.ishidden) do
			(
				append geometrySelection i
			)
		)
-- 		if (geometrySelection[1].modifiers[1] == undefined) then
-- 		(
-- 			messagebox "Only base object,No modifiers!"
-- 		)
-- 		else
		(
			local instances = #()
			for k = a do
			(
				for i = (refs.dependentNodes k) do
				(
					if ((not i.ishidden) or selectHidden) do
					(
						append instances i
					)
				)
				select instances
				if currentSelection.count == instances.count do messagebox "No same modifiers!"
			)
-- 			deselect currentSelection
		)
	)
)
catch()