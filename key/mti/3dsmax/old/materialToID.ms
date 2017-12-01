for o in geometry do
(
	if o.material != undefined do
	(
		appendIfUnique tempArray o.material
		o.gbufferchannel = findItem tempArray o.material
	)
)