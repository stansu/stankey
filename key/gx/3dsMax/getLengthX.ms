(
	bbx = nodeLocalBoundingBox selection[1]
	dist = abs(bbx[1].x-bbx[2].x)
	setclipboardText (dist as  string)
)