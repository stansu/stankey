try
(
	local i, currentLayer
	LayerManager.newLayerFromName "..ext"
	currentLayer = LayerManager.getLayerFromName "..ext"
	for i = selection do
	(
		currentLayer.addnode i
	)
)
catch()