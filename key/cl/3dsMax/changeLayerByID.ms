(
	rollout changeLayerByID "ID to Layer"
	(
		spinner s1 "ID " range:[0,65535,777] type:#integer fieldwidth:40 align:#left
		edittext e1 "Layer " fieldwidth:100 text:"0" align:#left
		button b1 "Do it!"
		on b1 pressed do
		(
			tempLayer = LayerManager.getLayerFromName e1.text
			if tempLayer == undefined then
			(
				messageBox "Invalid layer name!"
			)
			else
			(
				for i = geometry do
				(
					if i.gbufferchannel == s1.value do
					(
						tempLayer.addnode i
					)
				)
			)
			DestroyDialog changeLayerByID
		)
	)
	CreateDialog changeLayerByID
)