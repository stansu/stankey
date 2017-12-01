(
	LC = LayerManager.count
	S = undefined
	for i = 0 to (LC-1) do
	(
		CL = LayerManager.getLayer i
		if S == undefined do S = CL.backfacecull
		CL.backfacecull = not S
	)
)