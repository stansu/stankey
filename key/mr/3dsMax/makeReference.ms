try
(
	local a
	a = #()
	maxops.clonenodes $ cloneType:#reference newNodes:&a
	max delete
	select a
)
catch()