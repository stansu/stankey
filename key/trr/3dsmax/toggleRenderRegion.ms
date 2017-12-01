renderSceneDialog.close()
if getRenderType() == #view then
(
	setRenderType #region
	if not EditRenderRegion.IsEditing do EditRenderRegion.EditRegion()
)
else
(
	setRenderType #view
	if EditRenderRegion.IsEditing do EditRenderRegion.EditRegion()
)