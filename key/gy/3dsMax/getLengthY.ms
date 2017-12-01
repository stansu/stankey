(
	bbx = nodeLocalBoundingBox selection[1]
	dist = abs(bbx[1].y-bbx[2].y)
	setclipboardText (dist as  string)
)