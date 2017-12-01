(
	bbx = nodeLocalBoundingBox selection[1]
	dist = abs(bbx[1].z-bbx[2].z)
	setclipboardText (dist as  string)
)