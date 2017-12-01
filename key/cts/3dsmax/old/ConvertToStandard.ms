if querybox "convert corona to standard?" do
(
	setCommandPanelTaskMode #create
	MatEditor.close()
	for m = (getClassInstances stanmat) do replaceInstances m m.normalMat
	for m = (getClassInstances CoronaMtl) do
	(
		tempMtl=Standard()
		tempMtl.name=m.name
		tempMtl.diffuse = m.colorDiffuse
		tempMtl.diffuseMap = m.texmapDiffuse
		replaceInstances m tempMtl
	)
)