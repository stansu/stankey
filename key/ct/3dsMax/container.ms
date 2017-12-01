(
	tempObj = startObjectCreation container returnNewNodes:on
	for i = tempObj do
	(
		i.overrideNodeProperties = on
		i.autoUpdateClosed = on
	)
)