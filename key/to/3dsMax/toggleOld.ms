try
(
	local cadLayer
	cadLayer = LayerManager.getLayerFromName "...old"
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