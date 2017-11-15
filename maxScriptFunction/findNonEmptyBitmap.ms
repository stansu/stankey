(
	tempFilePath = getFilenamePath rendOutputFilename
	fn getFilesRecursive root pattern =
	(
		dir_array = #()
		dir_array = GetDirectories (root+"/*")
		for d in dir_array do
		  join dir_array (GetDirectories (d+"/*"))
		my_files = #()
		for f in dir_array do
		  join my_files (getFiles (f + pattern))
		my_files
	)
	files = (getFilesRecursive tempFilePath "*.png")
	for f = files do
	(
		a = openBitMap f
		tempBitmapInfo = getBitmapInfo a
		x = tempBitmapInfo[3]
		y = tempBitmapInfo[4] - 1
		tempArray = #()
		for i = 0 to y do
		(
			join tempArray (getPixels a [0,i] x)
		)
		tempMark = off
		for i = tempArray do
		(
			if i.a > 0 do
			(
				tempMark = on
				exit
			)
		)
		if tempMark == off do deleteFile f
	)
)