(
	q = yesNoCancelBox  "YES for all map on\nNO for all map off\n" title:"toggle all coronaMtl texmapDiffuse"
	if q != #cancel do
	(
		if q == #yes then
		(
			for i = (getClassInstances coronamtl) do
			(
				if i.texmapDiffuse != undefined do
				(
					showTextureMap i i.texmapDiffuse on
				)
			)
		)
		else
		(
			for i = (getClassInstances coronamtl) do
			(
				if i.texmapDiffuse != undefined do
				(
					showTextureMap i i.texmapDiffuse off
				)
			)
		)
	)
)