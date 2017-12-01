(
	if querybox "make today folder?" do
	(
		renderSceneDialog.close()
		tempFilePath = ((substituteString maxFilePath "03_max\\" "")+"05_render\\"+((getLocalTime())[1] as string)+(formattedPrint ((getLocalTime())[2]) format:"02d")+(formattedPrint ((getLocalTime())[4]) format:"02d")+"\\")
		makeDir tempFilePath
		tempFileFile = substituteString maxFileName "max" "jpg"
		rendOutputFilename = tempFilePath + tempFileFile
		try ($LPM_Root.rootdir = tempFilePath) catch()
	)
)