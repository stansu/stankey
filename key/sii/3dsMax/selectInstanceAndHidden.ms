try
(
	if selection.count != 0 then
	(
		local os, ns, i, j, oos = #()
		for i = selection do
		(
			if (not i.ishidden) do
			(
				append oos i
			)
		)
		os = #()
		ns = #()
		selectHidden = on
		for i = oos do
		(
			if ((not isGroupHead i) or (not isOpenGroupHead i)) do
			append os i
		)
		for i = os do
		(
			local instances = #()
			if (findItem os i.parent == 0) do
			(
				InstanceMgr.GetInstances i &instances
				trueInstances = for n in instances where (areNodesInstances i n) collect n
				if trueInstances.count > 0 do
				(
					for j = trueInstances do
					(
						if findItem ns j == 0 do
						(
							if ((not j.ishidden) or selectHidden) do
							(
								append ns j
							)
						)
					)
				)
			)
		)
		clearSelection()
		select ns
	)
	else messageBox "Please select something!"
)
catch()