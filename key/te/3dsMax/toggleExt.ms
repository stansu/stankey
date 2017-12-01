try
(
	local toggleLayer
	toggleLayer = LayerManager.getLayerFromName "..ext"
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