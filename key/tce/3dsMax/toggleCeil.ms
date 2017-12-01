try
(
	local cadLayer
	cadLayer = LayerManager.getLayerFromName "..ceil"
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