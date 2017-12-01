try
(
	local i, currentLayer
	LayerManager.newLayerFromName "..ceil"
	currentLayer = LayerManager.getLayerFromName "..ceil"
	for i = selection do
	(
		currentLayer.addnode i
	)
)
catch()