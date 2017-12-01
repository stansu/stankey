xref_max_index = xrefs.getXRefFileCount()
sel_parent = selection[1]
for i = xref_max_index to 1 by -1 do
(
	this_xref = xrefs.getXrefFile i
	this_xref_parent = this_xref.parent
	if (this_xref_parent != undefined) and (this_xref_parent == sel_parent) do
	(
		new_xref = xrefs.addNewXRefFile (maxFilePath + (filenameFromPath this_xref.filename))
		new_dummy = dummy()
		if new_xref.tree.children[1].name == "isoSelectHelper" then
		(
			a = nodeLocalBoundingBox new_xref.tree.children[2]
		)else
		(
			a = nodeLocalBoundingBox new_xref.tree.children[1]
		)
		new_dummy.boxsize = a[2] - a[1]
		new_dummy.pos = new_xref.tree.children[1].pos
		new_xref.parent = new_dummy
		new_dummy.transform.controller = copy sel_parent.transform.controller
		new_dummy.pos.z = new_dummy.boxsize.z / 2
		new_dummy.name = uniqueName ((getFilenameFile new_xref.filename)+"_")
		select new_dummy
	)
	if this_xref.parent == undefined do delete this_xref
)