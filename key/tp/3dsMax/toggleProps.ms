try
(
	local cadLayer
	cadLayer = LayerManager.getLayerFromName "..props"
	if cadLayer.on then
	(
		cadLayer.on = off
	)
	else
	(
		cadLayer.on = on
	)
)
catch()