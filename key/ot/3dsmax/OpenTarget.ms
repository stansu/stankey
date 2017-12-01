(
	currentRenderDir = getFilenamePath rendOutputFilename
	renderDirIndex = (findString currentRenderDir "render") + 6
	renderDir = substring currentRenderDir 1 renderDirIndex
	for i = ( getFiles (renderDir + "*.lnk")) do
		(
			ShellLaunch i ""
		)
)