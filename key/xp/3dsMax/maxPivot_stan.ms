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
			real_max = m.center
			for i = k do
			(
				if canConvertTo i mesh and superclassof i != shape do
				(
					if 	i.max.x > real_max.x do
					(
						a = snapshotAsMesh i
						aNumVerts = a.numverts
						for j = 1 to aNumVerts do
						(
							if (getVert a j).x > real_max.x do real_max.x = (getVert a j).x
						)
					)
					if 	i.max.y > real_max.y do
					(
						a = snapshotAsMesh i
						aNumVerts = a.numverts
						for j = 1 to aNumVerts do
						(
							if (getVert a j).y > real_max.y do real_max.y = (getVert a j).y
						)
					)
					if 	i.max.z > real_max.z do
					(
						a = snapshotAsMesh i
						aNumVerts = a.numverts
						for j = 1 to aNumVerts do
						(
							if (getVert a j).z > real_max.z do real_max.z = (getVert a j).z
						)
					)
				)
				if superclassof i == shape or classof i == LinkComposite do
				(
					if ((numKnots i) > 5000) then
					(
						messagebox "knots over 5000!"
					)else
					(
						addModifier i (Edit_Mesh())
						if i.max.x > real_max.x do real_max.x = i.max.x
						if i.max.y > real_max.y do real_max.y = i.max.y
						if i.max.z > real_max.z do real_max.z = i.max.z
						deleteModifier i 1
					)
				)
			)
			m.pivot = real_max
			if getCoordCenter() != #System  do setCoordCenter #local
		)
	)
)
catch()