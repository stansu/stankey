try
(
	local toggleLayer
	toggleLayer = LayerManager.getLayerFromName "...hide"
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