if (querybox "Already save file before try lookAt?") do
(
	target = pickobject message:"select target..."
	id = target.inode.handle
	for i = $ do
	(
		i[3].controller = prs()
		i[3][2][3].controller = Float_Script()
		tempParent = i.parent
		i.parent = undefined
		setInheritanceFlags i (#{1..5, 7..9})
		i.parent = tempParent		
		i[3][2][3].controller.script = "try
		(
			local a
			refsArray = (refs.dependents this)
			for i in refsArray where isvalidnode i do a = i
			b = maxOps.getNodeByHandle " + (id as string) + "
			pt1 = a.pos
			pt2 = b.pos
			pt1.z = pt2.z = 0
			tempDir = normalize(pt2 - pt1)
			oa = acos (dot tempDir [1,0,0])
			if tempDir.y < 0 do
				(
					oa = 360 - oa
				)
			degToRad (oa + 90)
		)catch(0)"
	)
)