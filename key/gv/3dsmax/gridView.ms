if findparent == undefined do
(
	filein "D:\\stanKey\\maxScriptFunction\\findParent.ms"
)
if selection.count != 0 then
(
	local tempGrid
	if (getClassInstances grid)[1] == undefined then
	(
		tempGrid = grid()
	) else
	(
		tempGrid = (refs.dependentNodes (getClassInstances grid)[1])[1]
	)
	tempObj = (findParent selection)[1]
	tempGrid.width = tempGrid.length = (nodeLocalBoundingBox tempObj)[1][1] * 0.2
	tempGrid.grid =  (nodeLocalBoundingBox tempObj)[1][1] * 0.1
	tempGrid.transform = tempObj.transform
	activegrid = tempGrid
-- 	activegrid = undefined
-- 	viewport.getType()
	viewport.setType #view_grid
	select tempGrid
	toolMode.coordsys #grid
) else
(
	if (getClassInstances grid)[1] == undefined then
	(
		toolMode.coordsys #view
	) else
	(
		viewport.setType #view_grid
		toolMode.coordsys #grid
	)
)