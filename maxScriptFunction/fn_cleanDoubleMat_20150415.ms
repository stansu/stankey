(
--	if (querybox "Delete duplicate material? (Please backup!)") do
	(
		tempMatName = #()
		tempMat = #()
		allMat = #()
		matCounter = 0
		for i = geometry do
		(
			if i.material != undefined do
			(
				appendIfUnique allMat i.material
				if appendIfUnique tempMatName i.material.name do
				(
					append tempMat i.material
				)
			)
		)
		for i = 1 to allMat.count do
		(
			for j = 1 to tempMatName.count do
			(
				if (allMat[i].name == tempMatName[j]) and (allMat[i] != tempMat[j]) do
				(
					replaceinstances allMat[i] tempMat[j]
					matCounter += 1
				)
			)
		)
		tt = (matCounter as string) + " material(s) deleted."
		messagebox tt
	)
)