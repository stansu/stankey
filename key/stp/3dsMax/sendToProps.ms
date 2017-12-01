try
(
	local i, currentLayer
	LayerManager.newLayerFromName "..props"
	currentLayer = LayerManager.getLayerFromName "..props"
	for i = selection do
	(
		currentLayer.addnode i
	)
)
catch()