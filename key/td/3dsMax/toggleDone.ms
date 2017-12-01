try
(
	local toggleLayer
	toggleLayer = LayerManager.getLayerFromName "..done"
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