try
(
	local i, currentLayer
	LayerManager.newLayerFromName "...old"
	currentLayer = LayerManager.getLayerFromName "...old"
	for i = selection do
	(
		currentLayer.addnode i
	)
)
catch()