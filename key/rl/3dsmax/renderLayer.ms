(
	fn randomColor = color (random 0 255) (random 0 255) (random 0 255)
	getLayerFromName = layermanager.getLayerFromName
	filein "D:\\stanKey\\key\\rc\\3dsMax\\renderColor.ms"
	if (querybox "Change materials by layers?") do
	(
		renderSceneDialog.close()
		rendOutputFilename = substituteString rendOutputFilename "_byMaterials.png" "_byLayers.png"
		for i = (getClassInstances Forest_Lite) do
		(
			tempNode = (refs.dependentNodes i)[1]
			tempNode.consmat = off
		)
		for i = geometry do
		(
			tempColor = (getLayerFromName i.layer.name).wireColor
			m = coronamtl()
			m.levelDiffuse = 0.0
			m.levelSelfIllum = 1.0
			m.colorSelfIllum = tempColor
			if i.material == undefined then
			(
				i.material = m
			) else
			(
				if classof i.material != CoronaRaySwitchMtl do
				(
					tempSubMats = getNumSubMtls i.material
					if (refs.dependentNodes i.material).count > 1 then
					(
						if tempSubMats == 0 then
						(
							if hasproperty i.material "opacitytexmap" do
							(
								if i.material.opacitytexmap != undefined then
								(
									i.material = copy i.material
									i.material.color = tempColor
								) else
								(
									i.material = m
								)
							)
							if hasproperty i.material "texmapOpacity" do
							(
								if i.material.texmapOpacity != undefined then
								(
									i.material = copy i.material
									i.material.colorSelfIllum = tempColor
								) else
								(
									i.material = m
								)
							)
						) else
						(
							i.material = copy i.material
							for j = 1 to tempSubMats do
							(
								if i.material[j] != undefined do
								(
									if hasproperty i.material[j] "opacitytexmap" do
									(
										if i.material[j].opacitytexmap != undefined then
										(
											i.material[j] = copy i.material[j]
											i.material[j].color = tempColor
										) else
										(
											i.material[j] = m
										)
									)
									if hasproperty i.material[j] "texmapOpacity" do
									(
										if i.material[j].texmapOpacity != undefined then
										(
											i.material[j] = copy i.material[j]
											i.material[j].colorSelfIllum = tempColor
										) else
										(
											i.material[j] = m
										)
									)
								)
							)
						)
					) else
					(
						if tempSubMats == 0 then
						(
							try i.material.colorSelfIllum = tempColor catch()
							try i.material.color = tempColor catch()
						) else
						(
							for j = 1 to tempSubMats do
							(
								try i.material[j].colorSelfIllum = tempColor catch()
								try i.material[j].color = tempColor catch()
							)
						)
					)
				)
			)
		)
		for i = (getClassInstances Forest_Lite) do
		(
			tempNode = (refs.dependentNodes i)[1]
			m = coronamtl()
			tempColor = (getLayerFromName tempNode.layer.name).wireColor
			m.levelDiffuse = 0.0
			m.levelSelfIllum = 1.0
			m.colorSelfIllum = tempColor
			tempNode.matlist[1] = m
		)
	)
)