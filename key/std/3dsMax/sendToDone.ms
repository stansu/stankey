try
(
	local i, currentLayer
	LayerManager.newLayerFromName "..done"
	currentLayer = LayerManager.getLayerFromName "..done"
	for i = selection do
	(
		currentLayer.addnode i
	)
)
catch()