try
(
	local toggleLayer
	toggleLayer = LayerManager.getLayerFromName "..window"
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