try
(
	local toggleLayer
	toggleLayer = LayerManager.getLayerFromName "..floor"
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