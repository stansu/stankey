if findparent == undefined do filein "D:\\stanKey\\maxScriptFunction\\findParent.ms"
(
	tempRCS = getRefCoordSys()
	setRefCoordSys #hybrid
	targetParents = findparent selection
	op1 = pickobject prompt:"pick source rotation\n"
	while op1.parent != undefined do
	(
		op1 = op1.parent
	)
	for i = targetParents do
	(
		for j = 1 to 3 do
		(
			if (mod op1[3][2][j].value 90) != 0 do
			(
				i[3][2][j].value = op1[3][2][j].value
			)
		)
	)
	setRefCoordSys tempRCS
)
