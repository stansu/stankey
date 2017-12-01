if selection.count != 0 then
(
	sourceObj = (pickobject message:"pick source visibility controller").visibility.controller
	for i = selection do
	(
		i.visibility = Bezier_Float()
		i.visibility.controller = sourceObj
	)
)else messagebox "please select some objects for instance visibility controller!"