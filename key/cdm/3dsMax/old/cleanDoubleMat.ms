(
	if (querybox "Delete duplicate material? (Please backup!)") do
	(
	-- 	tempState = InstanceMgr.autoMtlPropagation
	-- 	InstanceMgr.autoMtlPropagation = off
		tempMatName = #()
		tempMat = #()
		for i = geometry do
		(
			if i.material != undefined do
			(
				if appendIfUnique tempMatName i.material.name do
				(
					append tempMat i.material
				)
			)
		)
		for i = geometry do
		(
			if i.material != undefined do
			(
				for j = 1 to tempMatName.count do
				(
					if (i.material.name == tempMatName[j]) and (i.material != tempMat[j]) do
					(
						i.material = tempMat[j]
					)
				)
			)
		)
	-- 	InstanceMgr.autoMtlPropagation = tempState
	)
)