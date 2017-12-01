tempArray = #()
for o in geometry do
(
	if findItem tempArray o.material == 0 then
	(
		append tempArray o.material
		o.gbufferchannel = findItem tempArray o.material
	) else
	(
		o.gbufferchannel = findItem tempArray o.material
	)
)
