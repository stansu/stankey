if findparent == undefined do
(
	filein "D:\\stanKey\\maxScriptFunction\\findParent.ms"
)
if findHighestParent == undefined do
(
	filein "D:\\stanKey\\maxScriptFunction\\findHighestParent.ms"
)
try
(
	if selection.count != 0 do
	(
		local ro, snapstate, op1, op2, objNormal, dp1, dp2, dstNormal, da, oa, viewTM
		viewTM = (getViewTM()).rotationpart
		ro = (findParent selection)[1]
		op1 = pickobject prompt:"pick source rotation\n"
		op1 = findHighestParent op1
		if viewTM == (quat 0.5 -0.5 -0.5 0.5) or viewTM == (quat -0.5 -0.5 -0.5 -0.5) then
		(
			ro[3][2][1].value = op1[3][2][1].value
		) else if viewTM == (quat 0.707107 0 0 0.707107) or viewTM == (quat 0 -0.707107 -0.707107 0) then
		(
			ro[3][2][2].value = op1[3][2][2].value
		) else
		(
			ro[3][2][3].value = op1[3][2][3].value
		)
	)
)
catch()