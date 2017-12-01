try
(
	local cadLayer
	cadLayer = LayerManager.getLayerFromName "...cad"
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