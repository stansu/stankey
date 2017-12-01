try
(
	local i, currentLayer
	LayerManager.newLayerFromName "...src"
	currentLayer = LayerManager.getLayerFromName "...src"
	for i = selection do
	(
		currentLayer.addnode i
	)
)
catch()