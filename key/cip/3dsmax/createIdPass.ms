(
	if not IsValidNode $LPM_normal then
	(
		g1=LPM_Fun.createPassGroup "Group"
		g1.parent=LPM_Root
		g1.name="LPM_normal"
		g2=LPM_Fun.createPassGroup "Group"
		g2.parent=LPM_Root
		g2.name="LPM_id"
		for pass1 = LPM_root.children do
		(
			if pass1.type == "pass" do
			(
				pass2 = copy pass1
				pass2.name = pass1.name + "_id"
				pass1.parent = g1
				pass2.parent = g2
				for node1 = pass1.children do
				(
					if node1.type != "lightSet" do
					(
						node2 = copy node1
						node2.name = node1.name + "_id"
						node2.parent = pass2
					)
				)
			)
		)
		LPM_treeview_rollout.updateTV()
	) else messagebox "Already have id pass!"
)