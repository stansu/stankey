(
	setCommandPanelTaskMode #create
	MatEditor.close()
	for m = (getClassInstances vraymtl) do
	(
		tempMtl=standard()
		tempMtl.name=m.name
		tempMtl.Diffuse=m.Diffuse
		tempMtl.diffuseMap=m.texmap_diffuse
		replaceInstances m tempMtl
	)
)