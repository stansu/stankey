try
(
	local toggleLayer
	toggleLayer = LayerManager.getLayerFromName "...src"
	if toggleLayer.on then
	(
		toggleLayer.on = off
	)
	else
	(
		toggleLayer.on = on
	)
)
catch()