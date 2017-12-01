if findparent == undefined do
(
	filein "D:\\stanKey\\maxScriptFunction\\findParent.ms"
)
try
(
	clearListener()
	if selection.count != 0 do
	(
		local ro, snapstate, op1, op2, objNormal, dp1, dp2, dstNormal, da, oa, viewTM
		viewTM = (getViewTM()).rotationpart
		snapstate = snapMode.active
		snapMode.active = on
		ro = findParent selection
		op1 = pickpoint prompt:"pick object point 1\n" snap:#3D
		ro.pivot = op1
		op2 = pickpoint prompt:"pick object point 2\n" snap:#3D rubberBand:op1
		if viewTM == (quat 0.5 -0.5 -0.5 0.5) or viewTM == (quat -0.5 -0.5 -0.5 -0.5) then
		(
			objNormal = normalize ([0,op2[2] - op1[2],op2[3] - op1[3]])
			oa = acos (dot objNormal [0,1,0])
			if objNormal.z < 0 do
			(
				oa = 360 - oa
			)
			dp1 = pickpoint prompt:"pick destiny point 1\n" snap:#3D
			undo on
			(
				ro.pos.z = dp1.z
				ro.pos.y = dp1.y
			)
			dp2 = pickpoint prompt:"pick destiny point 2\n" snap:#3D rubberBand:dp1
			dstNormal = normalize ([0,dp2[2] - dp1[2],dp2[3] - dp1[3]])
			da = acos (dot dstNormal [0,1,0])
			if dstNormal.z < 0 do
			(
				da = 360 - da
			)
			rotate ro (da - oa) [1,0,0]
		) else if viewTM == (quat 0.707107 0 0 0.707107) or viewTM == (quat 0 -0.707107 -0.707107 0) then
		(
			objNormal = normalize ([op2[1] - op1[1],0,op2[3] - op1[3]])
			oa = acos (dot objNormal [1,0,0])
			if objNormal.z > 0 do
			(
				oa = 360 - oa
			)
			dp1 = pickpoint prompt:"pick destiny point 1\n" snap:#3D
			undo on
			(
				ro.pos.z = dp1.z
				ro.pos.x = dp1.x
			)
			dp2 = pickpoint prompt:"pick destiny point 2\n" snap:#3D rubberBand:dp1
			dstNormal = normalize ([dp2[1] - dp1[1],0,dp2[3] - dp1[3]])
			da = acos (dot dstNormal [1,0,0])
			if dstNormal.z > 0 do
			(
				da = 360 - da
			)
			rotate ro (da - oa) [0,1,0]
		) else
		(
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
		)
		snapMode.active = snapstate
	)
)
catch()