(
	setCommandPanelTaskMode #create
	MatEditor.close()
	for m = (getClassInstances Standard) do
	(
		tempMtl=ai_standard_surface()
		tempMtl.name=m.name
		tempMtl.base_color = m.Diffuse
		tempMtl.base_color_shader = m.diffuseMap
		replaceInstances m tempMtl
	)
)