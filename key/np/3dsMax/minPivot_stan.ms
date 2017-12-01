if findChildren == undefined do
(
	filein "D:\\stanKey\\maxScriptFunction\\findChildren.ms"
)
try
(
	setCommandPanelTaskMode #create
	local m, k, a, i, j
	local c = #()
	if $ == selection then c = $ as array else append c $
	for m = c do
	(
		if findItem c m.parent == 0	do
		(
			k = #()
			append k m
			findChildren m k
			real_min = m.center
			for i = k do
			(
				if canConvertTo i mesh and superclassof i != shape do
				(
					if 	i.min.x < real_min.x do
					(
						a = snapshotAsMesh i
						aNumVerts = a.numverts
						for j = 1 to aNumVerts do
						(
							if (getVert a j).x < real_min.x do real_min.x = (getVert a j).x
						)
					)
					if 	i.min.y < real_min.y do
					(
						a = snapshotAsMesh i
						aNumVerts = a.numverts
						for j = 1 to aNumVerts do
						(
							if (getVert a j).y < real_min.y do real_min.y = (getVert a j).y
						)
					)
					if 	i.min.z < real_min.z do
					(
						a = snapshotAsMesh i
						aNumVerts = a.numverts
						for j = 1 to aNumVerts do
						(
							if (getVert a j).z < real_min.z do real_min.z = (getVert a j).z
						)
					)
				)
				if superclassof i == shape or classof i == LinkComposite do
				(
					if ((numKnots i) > 7000) then
					(
						messagebox "knots over 7000!"
					)else
					(
						addModifier i (Edit_Mesh())
						if i.min.x < real_min.x do real_min.x = i.min.x
						if i.min.y < real_min.y do real_min.y = i.min.y
						if i.min.z < real_min.z do real_min.z = i.min.z
						deleteModifier i 1
					)
				)
			)
			m.pivot = real_min
			if getCoordCenter() != #System  do setCoordCenter #local
		)
	)
)
catch()