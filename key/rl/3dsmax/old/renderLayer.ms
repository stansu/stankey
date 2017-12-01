(
	filein "D:\\stanKey\\key\\rc\\3dsMax\\renderColor.ms"
	if (querybox "Change materials by layers?") do
	(
		renderSceneDialog.close()
		rendOutputFilename = substituteString rendOutputFilename "_byMaterials.png" "_byLayers.png"
		fn randomColor = color (random 0 255) (random 0 255) (random 0 255)
		tempMats = #()
		layerCount = LayerManager.count
		for i = (getClassInstances Forest_Lite) do
		(
			tempNode = (refs.dependentNodes i)[1]
			tempNode.consmat = off
		)
		for i = 1 to layerCount do
		(
			nodes = #()
			m = (getClassInstances CoronaMtl)[i]
			m.colorSelfIllum = randomColor()
			m.levelDiffuse = 0.0
			m.levelReflect = 0
			m.levelSelfIllum = 1.0
			append tempMats m
			tempLayer = LayerManager.getLayer (i - 1)
			tempLayer.nodes &nodes
			nodes.material = tempMats[i]
		)
		for i = (getClassInstances Forest_Lite) do
		(
			tempNode = (refs.dependentNodes i)[1]
			tempNode.matlist[1] = tempNode.material
		)
	)
)