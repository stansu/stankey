(
	question = yesNoCancelBox "Convert mtl to raySwitch(yes) or invert(no)?"
	if question == #yes do
	(
		for i = geometry do
		(
			if (classof i.material == CoronaMtl) do
			(
				if (i.material.levelReflect > 0.0) and (i.material.levelRefract < 0.01) then
				(
					oldMat = copy i.material
					noReflectMat = copy i.material
					noReflectMat.levelReflect = 0.0
					newMat = CoronaRaySwitchMtl()
					newMat.giMtl = noReflectMat
					newMat.refractMtl = oldMat
					newMat.reflectMtl = oldMat
					newMat.directMtl = oldMat
					newMat.name = i.material.name + "_RS"
					newMat.giMtl.name += "_GI"
					replaceInstances i.material newMat
					print ("Material <"+(i.material.name)+"> converted!")
				)
				else
				(
					if i.material.levelRefract > 0.0 do
					(
						oldMat = copy i.material
						noRefractMat = copy i.material
						noRefractMat.colorOpacity = (color 0 0 0)
						newMat = CoronaRaySwitchMtl()
						newMat.giMtl = noRefractMat
						newMat.refractMtl = oldMat
						newMat.reflectMtl = oldMat
						newMat.directMtl = oldMat
						newMat.name = i.material.name + "_RS"
						newMat.giMtl.name += "_GI"
						replaceInstances i.material newMat
						print ("Material <"+(i.material.name)+"> converted!")
					)
				)
			)
		)
	)
	if question == #no do
	(
		for i = geometry do
		(
			if (classof i.material == CoronaRaySwitchMtl) do
			(
				replaceInstances i.material i.material.directMtl
			)
		)
	)
)