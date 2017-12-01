try
(
	local a, i, wireColor = off
	max group detach
	a = LayerManager.current
	if selection[1].colorByLayer == off do
	(
		wireColor = queryBox "Set line color by layer?"
	)
	if wireColor do
	(
		selection.colorByLayer = on
	)
	for i = selection do
	(
		a.addnode i
	)
)
catch()