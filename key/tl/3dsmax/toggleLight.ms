try
(
	local toggleLayer
	toggleLayer = LayerManager.getLayerFromName "..light_mesh"
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