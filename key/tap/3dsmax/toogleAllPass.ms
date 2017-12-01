(
	for i = $LPM_* do
	(
		if isproperty i "expanded" do
		(
			i.expanded = not i.expanded
		)
	)
	LPM_treeview_rollout.updateTV()
)