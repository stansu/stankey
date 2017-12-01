(
	setCommandPanelTaskMode mode:#modify
--	sourceObj = pickobject message:"pick reference matrix"
--	sourceObjTM =sourceObj.objecttransform
	targetObj = selection as array
	try
	(
		local a, groupFlag
		a = selection as array
		groupFlag = on
		while groupFlag
		do
		(
			select a
			groupFlag = actionMan.executeAction 0 "40142"
		)
	)
	catch()
	targetObjCenter = selection.center
	for i = targetObj do
	(
		if superclassof i != light do
		(
			try
			(
				resetpivot i
				InstanceMgr.MakeObjectsUnique i  #individual
				targetObjTM = i.transform
				targetMod = xform()
				select i
				modPanel.addModToSelection (targetMod)
				targetMod.gizmo.value = targetObjTM
				i.transform = matrix3 1
				targetMod = xform()
				modPanel.addModToSelection (targetMod)
				targetMod.gizmo.position = -1 * targetObjCenter
				i.pos = targetObjCenter
			)
			catch()
		)
	)
	try
	(
		local a, groupFlag
		a = selection as array
		groupFlag = on
		while groupFlag
		do
		(
			select a
			groupFlag = actionMan.executeAction 0 "40143"
		)
	)
	catch()
)