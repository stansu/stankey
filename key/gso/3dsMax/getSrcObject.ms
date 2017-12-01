if compareName == undefined do
(
	filein "D:\\stanKey\\maxScriptFunction\\compareName.ms"
)
if findparent == undefined do
(
	filein "D:\\stanKey\\maxScriptFunction\\findParent.ms"
)
(
	srcLayer = LayerManager.getLayerFromName "...src"
	currentLayer = LayerManager.current
	srcLayer.nodes &theNodes
	qsort theNodes compareName
	rollout getSrcObject "getSrcObject"
	(
		listbox objList "objList:" height:(if theNodes.count > 70 then 70 else theNodes.count) selection:0 items:(for o = theNodes collect o.name)
		on objList selected listIndex do
		(
			DestroyDialog getSrcObject
			instanceObj = queryBox "Instance(Yes) or copy(No)?"
			maxOps.CloneNodes theNodes[listIndex] expandHierarchy:on cloneType:(if instanceObj then #instance else #copy) newNodes:&newNodes
			parentNode = (findParent newNodes)[1]
			parentNode.pos = pickPoint prompt:"Pick pos for new clone object..." snap:#3d
			currentLayer.addnode parentNode
		)
	)
	createDialog getSrcObject pos:[(mouse.screenpos)[1], (mouse.screenpos)[2]]
-- 	createDialog getSrcObject
)