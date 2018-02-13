if findparent == undefined do filein "c:\\stankey-master\\maxScriptFunction\\findParent.ms"
(
	tempRCS = getRefCoordSys()
	setRefCoordSys #hybrid
	targetParents = findparent selection
	op1 = pickobject prompt:"pick source rotation\n"
	if superclassof (superclassof op1) == MAXWrapper do
	(
		while op1.parent != undefined do
		(
			op1 = op1.parent
		)
		for i = 1 to 3 do
		(
			if (mod op1[3][2][i].value 90) != 0 do
			(
				for j = targetParents do
				(
					j[3][2][i].value = op1[3][2][i].value
				)
			)
		)
	)
	setRefCoordSys tempRCS
)
