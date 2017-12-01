(
	question = yesNoCancelBox "Convert mtl to raySwitch(yes) or invert(no)?"
	if question == #yes do
	(
		for i = (getclassinstances CoronaMtl) do
		(
			isCoronaRaySwitchMtl = off
			for j = (refs.dependents i) do
			(
				if (classof j) == CoronaRaySwitchMtl do
				(
					isCoronaRaySwitchMtl = on
					exit
				)
			)
			if not isCoronaRaySwitchMtl do
			(
				if i.levelReflect > 0.0 do
				(
					oldMat = copy i
					noReflecMat = copy i
					noReflecMat.levelReflect = 0.0
					newMat = CoronaRaySwitchMtl()
					newMat.giMtl = noReflecMat
					newMat.refractMtl = oldMat
					newMat.reflectMtl = oldMat
					newMat.directMtl = oldMat
					newMat.name = i.name + "_RS"
					newMat.giMtl.name += "_GI"
					replaceInstances i newMat
					print ("Material <"+(i.name)+"> converted!")
				)
			)
		)
	)
	if question == #no do
	(
		for m = (getClassInstances CoronaRaySwitchMtl) do
		(
			replaceInstances m m.directMtl
		)
	)
)