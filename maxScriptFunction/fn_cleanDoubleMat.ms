(
	if getSaveRequired() then
	(
		if querybox "clean double material without backup?" then
		(
			tempAns = on
		) else
		(
			tempAns = off
		)
	) else
	(
		tempAns = on
	)
	if tempAns do
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
				if (appendIfUnique tempMatName i.material.name) and (classof i.material != Arch___Design__mi) do
				(
					append tempMat i.material
				)
			)
		)
		for i = (getClassInstances multimaterial) do
		(
			for j = i.material do
			(
				if j != undefined do
				(
					appendIfUnique allMat j
					if appendIfUnique tempMatName j.name do
					(
						append tempMat j
					)
				)
			)
		)
		tempMatNameCount = tempMatName.count
		for i = 1 to allMat.count do
		(
			allMatName = allMat[i].name
			for j = 1 to tempMatNameCount do
			(
				if (allMatName == tempMatName[j]) and (allMat[i] != tempMat[j]) and (querybox ("replace "+allMatName+"?"))do
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