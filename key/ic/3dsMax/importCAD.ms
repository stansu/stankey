-- try
(
	local b, i, CadLayer, lc, cl, isoSelectHelper, zeroLayer
	SetSelectFilter 1
	LayerManager.newLayerFromName "...cad"
	CadLayer = LayerManager.getLayerFromName "...cad"
	zeroLayer = LayerManager.getLayerFromName "0"
	zeroLayer.on = on
	CadLayer.on = on
	CadLayer.lock = off
	CadLayer.current=on
	hideByCategory.shapes = off
	hideByCategory.geometry = off
	try (delete $isoSelectHelper) catch()
	point name:#isoSelectHelper
	select $isoSelectHelper
	IsolateSelection.EnterIsolateSelectionMode()
	importFile (maxFilePath + "drawing1.dwg") #noPrompt
	max select all
	IsolateSelection.ExitIsolateSelectionMode()
	IsolateSelection.EnterIsolateSelectionMode()
	b = selection as array
	for i = b where i.colorByLayer do
	(
		TempColor = i.layer.wirecolor
		i.colorByLayer = off
		i.wirecolor = TempColor
	)
	for i = 1 to b.count do
	(
		CadLayer.addnode b[i]
		b[i].controller = copy b[i].controller
	)
	max select none
	lc=LayerManager.count - 1
	cl=LayerManager.getLayer 0
	cl.current=on
	for i = lc to 1 by -1 do
	(
		cl=LayerManager.getLayer i
		clr=cl.layerAsRefTarg
		clrt=refs.dependents clr
		if clrt.count == 2
		do LayerManager.deleteLayerByName cl.name
	)
	delete $isoSelectHelper
)
-- catch()