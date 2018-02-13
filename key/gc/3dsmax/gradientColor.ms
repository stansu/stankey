if compareName == undefined do filein "c:\\stankey-master\\maxScriptFunction\\compareName.ms"
if compareName == undefined do filein "c:\\stankey-master\\maxScriptFunction\\compareNameRandom.ms"
try(if gradientColor.isdisplayed do DestroyDialog gradientColor)catch()
tempArray = #()
rollout gradientColor "gradientColor"
(
	label label1 "Source gradient:"
	mapbutton mapbutton1 tooltip:"Select gradient ramp"
	spinner spinner1 "steps:" range:[2,256,3] type:#integer
	radioButtons rb1 "sort:" labels:#("smooth", "random") columns:2 offsets:#([30,-16], [0,-16])
	MultiListBox listbox1 "Colors:"
	colorpicker colorpicker1 "Double click item" color:[0,0,0]
	button button2 "Put color to selection"
	fn refreshList arg =
	(
		startColor = mapbutton1.map.Gradient_Ramp[2].color
		endColor = mapbutton1.map.Gradient_Ramp[3].color
		append tempArray (startColor as string)
		division = arg
		for i = 1 to division do
		(
			pos = (1.0/(division+1))*i
			tempColor = (endColor*pos)+(startColor*(1-pos))
			tempColor.x = tempColor.x as integer
			tempColor.y = tempColor.y as integer
			tempColor.z = tempColor.z as integer
			append tempArray (tempColor as string)
		)
		append tempArray (endColor as string)
		if rb1.state == 2 do qsort tempArray compareNameRandom
		listbox1.items = tempArray
		tempArray = #()
	)
	on gradientColor open do
	(
		mapbutton1.map = (getClassInstances Gradient_Ramp)[1]
		try (refreshList (spinner1.value-2))catch()
	)
	on mapbutton1 picked texmap do
	(
		mapbutton1.map = texmap
		if classof mapbutton1.map != Gradient_Ramp then
		(
			messagebox "Please select source gradient ramp!"
		)else
		(
			refreshList 1
		)
	)
	on spinner1 changed arg do
	(
		if classof mapbutton1.map != Gradient_Ramp then
		(
			messagebox "Please select source gradient ramp!"
		)else
		(
			refreshList (arg-2)
		)
	)
	on rb1 changed arg do
	(
		if classof mapbutton1.map != Gradient_Ramp then
		(
			messagebox "Please select source gradient ramp!"
		)else
		(
			refreshList (spinner1.value-2)
		)
	)	
	on listbox1 doubleClicked item do
	(
		colorpicker1.color = (execute listbox1.items[item]) as color
	)
	on button2 pressed do
	(
		selectionCount = selection.count
		if selectionCount > 0 then
		(
			tempObjs = selection as array
			qsort tempObjs compareName
			for i = 0 to selectionCount do
			(
				try
				(
					tempObjs[i+1].wirecolor = (execute listbox1.items[(mod i listbox1.items.count)+1]) as color
				)catch()
			)
		)else messagebox "Please select some objects!"
	)
)
createDialog gradientColor width:195 --pos:mouse.screenpos
