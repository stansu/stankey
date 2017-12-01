if findparent == undefined do
(
	filein "D:\\stanKey\\maxScriptFunction\\findParent.ms"
)
try
(
	clearListener()
	if selection.count != 0 do
	(
		local ro, snapstate, op1, op2, objNormal, dp1, dp2, dstNormal, da, oa
		snapstate = snapMode.active
		snapMode.active = on
		ro = findParent selection
-- 		ro = ro[1]
--		roa = ro.rotation.z_rotation
		op1 = pickpoint prompt:"pick object point 1\n" snap:#3D
		ro.pivot = op1
		op2 = pickpoint prompt:"pick object point 2\n" snap:#3D rubberBand:op1
		objNormal = normalize ([op2[1] - op1[1],op2[2] - op1[2],0])
		oa = acos (dot objNormal [1,0,0])
		if objNormal.y < 0 do
		(
			oa = 360 - oa
		)
		dp1 = pickpoint prompt:"pick destiny point 1\n" snap:#3D
		undo on
		(
			ro.pos.x = dp1.x
			ro.pos.y = dp1.y
		)
		dp2 = pickpoint prompt:"pick destiny point 2\n" snap:#3D rubberBand:dp1
		dstNormal = normalize ([dp2[1] - dp1[1],dp2[2] - dp1[2],0])
		da = acos (dot dstNormal [1,0,0])
		if dstNormal.y < 0 do
		(
			da = 360 - da
		)
		rotate ro (da - oa) [0,0,1]
		snapMode.active = snapstate
	)
)
catch()