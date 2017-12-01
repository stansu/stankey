--macroScript DDF category:"Bobo_s Tools"
(
global DDF_delete_double_faces_dialog	
try(destroyDialog DDF_delete_double_faces_dialog)catch()
rollout DDF_delete_double_faces_dialog "DDF"
(
	local del_array =#{}
	group "About..."
	(
		label ddfabout01 "DeleteDoubleFaces"
		label ddfabout02 "Version 5.0 - Nov 06, 2010"
		label ddfabout03 "(c)1998-2010 by Borislav Petrov"
		label ddfabout04 "http://www.scriptspot.com/bobo"
	)

	group "DoubleFaces Check"
	(
		button scan_faces "CHECK Selected Meshes" width:180 height:30 
		checkbutton chk_extract_faces ">EXTRACT DoubleFaces" width:180 checked:false highlightcolor:([128,255,128] as color) align:#center
		checkbutton chk_remove_faces ">DELETE DoubleFaces" width:180 checked:false highlightcolor:([255,128,128] as color) align:#center
		radiobuttons rad_remove_kind "Deletion Method:" labels:#("Add DeleteMesh Modifier","Collapse EMeshes only","Collapse All Meshes")
		checkbox chk_add_to_bottom "Mods to Stack Bottom" checked:true 
	)

	fn scan_for_double_faces c_node =
	(
		local st = timestamp()
		e_node = snapshotAsMesh c_node
		format "Checking Mesh %\n" txt 
		local numFaces =e_node.numfaces  
		format "% Faces in Mesh.\n" numFaces

		face_array = #()
		del_array = #{}
		progressStart "DoubleFaces Check:"
		local notCanceled = true
		for i = 1 to numFaces while notCanceled do
		(
			if not (progressUpdate (100.0*i/numFaces)) do notCanceled = false
			local theFace = getface e_node i
			local dd_found = false
			if (findItem face_array theFace) > 0 OR \
			(findItem face_array [theFace.x,theFace.z,theFace.y] ) > 0 OR \
			(findItem face_array [theFace.y,theFace.x,theFace.z] ) > 0 OR \
			(findItem face_array [theFace.y,theFace.z,theFace.x] ) > 0 OR \
			(findItem face_array [theFace.z,theFace.x,theFace.y] ) > 0 OR \
			(findItem face_array [theFace.z,theFace.y,theFace.x] ) > 0 do ( del_array[i]=true; dd_found = true )
			if not dd_found then append face_array theFace
		)--end i loop
		progressEnd ()
		delete e_node
		if notCanceled then
		(
			if del_array.numberset > 0 then 
			(
				format "% DoubleFaces Found!\n" del_array.numberset 
				delete_enabled = true
			)
			else 
			(
				format "No DoubleFaces Found!\n" 
				delete_enabled = false
			)
			format "DDF Scan Completed in % ms\n" (timestamp()-st)
			delete_enabled
		)
		else
		(
			format "DDF Scan Interrupted after % ms\n" (timestamp()-st)
			format "% DoubleFaces Found so far.\n" del_array.numberset 
			false
		)
	)--end check fn

	fn remove_double_faces e_node =
	(
		undo on
		(
			local ms = mesh_select ()
			local dm = deletemesh ()
			select e_node
			max modify mode
			if chk_add_to_bottom.checked then modPanel.setCurrentObject e_node.baseobject
			modPanel.addModToSelection ms
			subObjectLevel = 3
			setfaceselection e_node ms del_array 
			modPanel.addModToSelection dm
			
			format "% Faces Selected...\n" del_array.numberset
			format "DeleteMesh Modifier Applied.\n" txt 
			
			case rad_remove_kind.state of
			(
			2:	(
					n_mods = e_node.modifiers.count	
					if n_mods == 2 then 
					(
						collapsestack e_node
						format "Modifier Stack Collapsed.\n" 
					)
					else
						format "No Changes To Modifier Stack.\n" 
				)
				3:
				(
					collapsestack e_node
					format "Modifier Stack Collapsed.\n" 
				)
			)
		)--end undo	
	)--end on

	fn extract_double_faces c_node =
	(
		with undo "Extract DoubleFaces" on
		(
			local e_node = copy c_node
			convertToMesh e_node
			meshop.deleteFaces e_node (#{1..e_node.numfaces}-del_array) 
			e_node.name = ("DF_"+  c_node.name)
			format "DoubleFaces Extracted to EMesh %\n" e_node.name
		)--end undo
	)--end on

	on scan_faces pressed do
	(
		obj_array = selection as array
		for n = 1 to obj_array.count do
		(
			check_node = obj_array[n]
			select check_node
			if classof check_node == Editable_Mesh then 
			(
				scan_result = scan_for_double_faces check_node
				if scan_result then
				(
					if chk_extract_faces.checked then extract_double_faces check_node		
					if chk_remove_faces.checked then remove_double_faces check_node
				)
			)
		)--end n loop
		format "Ready. \n\n" 
		select obj_array	
	)
	
)--end rollout

createDialog DDF_delete_double_faces_dialog 200 300
)
