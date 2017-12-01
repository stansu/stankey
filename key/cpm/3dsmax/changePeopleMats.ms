for i = (getClassInstances standard) do
(
	if (matchPattern i.name pattern:"*male*") do
	(
		tempMap = i.diffuseMap
		tempName = i.name
		tempMat = CoronaMtl()
		tempMat.name = tempName
		tempMat.texmapDiffuse = tempMap
		tempMat.texmapOnDiffuse
		tempMat.colorOpacity = color 128 128 128
		replaceInstances i tempMat
	)
)