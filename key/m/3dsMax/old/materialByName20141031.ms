if compareName == undefined do filein "D:\\stanKey\\maxScriptFunction\\compareName.ms"
try(if materialByName.isdisplayed do DestroyDialog materialByName)catch()
-- if selection.count != 0 then
-- (
	tempArray = #()
-- 	getSubFlag = querybox "Include sub_materials?"
	for o in geometry do
	(
		if o.material != undefined do
		(
			appendIfUnique tempArray o.material
-- 			if getSubFlag do
-- 			(
-- 				numOfSub = getNumSubMtls o.material
-- 				if numOfSub > 0 do
-- 				(
-- 					for i = 1 to numOfSub do
-- 					(
-- 						tempMat = getSubMtl o.material i
-- 						if tempMat != undefined do
-- 						(
-- 							appendIfUnique tempArray tempMat
-- 						)
-- 					)
-- 				)
-- 			)
		)
	)
	qsort tempArray compareName

	rollout materialByName "materialByName"
	(
		listbox materialList "materialList:" width:180 height:(if tempArray.count > 70 then 70 else tempArray.count) selection:0 items:(for o = tempArray collect o.name)
		on materialList selected listIndex do
		(
-- 			tempState = InstanceMgr.autoMtlPropagation
-- 			InstanceMgr.autoMtlPropagation = off
-- 			if (queryBox "propagate material to instance?") then InstanceMgr.autoMtlPropagation = on else InstanceMgr.autoMtlPropagation = off
			if selection.count > 0 do
			(
				$.material = tempArray[listIndex]
			)
-- 			print tempArray[listIndex]
-- 			$.material = tempArray[listIndex]
-- 			DestroyDialog materialByName
-- 			InstanceMgr.autoMtlPropagation = tempState
			)
	)
-- 	createDialog materialByName pos:[(mouse.screenpos)[1], (mouse.screenpos)[2]]
	createDialog materialByName width:195 pos:[1530,82]
-- )
-- else
-- (
-- 	messageBox "Please select some object!"
-- )