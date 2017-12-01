try
(
	local i, currentLayer
	LayerManager.newLayerFromName "...cad"
	currentLayer = LayerManager.getLayerFromName "...cad"
	for i = selection do
	(
		currentLayer.addnode i
	)
)
catch()