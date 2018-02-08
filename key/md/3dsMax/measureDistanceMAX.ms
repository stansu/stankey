(
	snapstate = snapMode.active
	snapMode.active = on
	dist = 0
	pt1 = pickpoint snap:#3d
	if classof pt1 == point3 do
	(
		pt2 = pickpoint snap:#3d rubberband:pt1
		if classof pt2 == point3 do
		(
			dist = (distance pt1 pt2)
			setclipboardText (dist as  string)
		)
	)
	snapMode.active = snapstate
	units.formatValue dist
)
