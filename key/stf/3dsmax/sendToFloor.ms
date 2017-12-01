try
(
	local i, currentLayer
	LayerManager.newLayerFromName "..floor"
	currentLayer = LayerManager.getLayerFromName "..floor"
	for i = selection do
	(
		currentLayer.addnode i
	)
)
catch()