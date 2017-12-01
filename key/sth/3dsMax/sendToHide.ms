try
(
	local i, currentLayer
	LayerManager.newLayerFromName "...hide"
	currentLayer = LayerManager.getLayerFromName "...hide"
	for i = selection do
	(
		currentLayer.addnode i
	)
)
catch()