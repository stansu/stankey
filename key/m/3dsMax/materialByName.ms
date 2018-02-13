if compareName == undefined do filein "c:\\stankey-master\\maxScriptFunction\\compareName.ms"
try(if materialByName.isdisplayed do DestroyDialog materialByName)catch()
tempArray = #()
fn reloadM =
(
	tempArray = #()
	for o in geometry do
	(
		if o.material != undefined do
		(
			if not ((matchPattern o.material.name pattern:"forest*") or (matchPattern o.material.name pattern:"*male*") or (matchPattern o.material.name pattern:"p_*")) do
			(
				appendIfUnique tempArray o.material
			)
		)
	)
	qsort tempArray compareName
)
reloadM()
rollout materialByName "materialByName"
(
-- 	checkbox propagate "propagate to instances" checked:(InstanceMgr.autoMtlPropagation)
	listbox materialList "materialList:" width:220 height:(if tempArray.count > 70 then 70 else tempArray.count) selection:0 items:(for o = tempArray collect o.name)
	on propagate changed state do InstanceMgr.autoMtlPropagation = state
	on materialList selected listIndex do
	(
		if selection.count > 0 do
		(
			$.material = tempArray[listIndex]
			try(if materialByName.isdisplayed do DestroyDialog materialByName)catch()
			reloadM()
			createDialog materialByName width:240 pos:[3397,108]
		)
	)
)
createDialog materialByName width:240 pos:[3397,108] style:#(#style_titlebar , #style_sysmenu, #style_resizing)
