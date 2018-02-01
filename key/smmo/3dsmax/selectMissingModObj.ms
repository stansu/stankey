(
	missingMods = getClassInstances Missing_OSM
	for m = missingMods do
	(
		selectmore (refs.dependentNodes m)
	)
	$.ishidden=off
	actionMan.executeAction 0 "310"  -- Tools: Zoom Extents Selected
)