if selection.count != 0 then
(
	sourceObj = (pickobject message:"pick source visibility controller").visibility.controller
	for i = selection do
	(
-- 		if superclassof i == GeometryClass do
		(
			i.visibility = Bezier_Float()
			i.visibility.controller = copy sourceObj
		)
	)
)else messagebox "please select some objects for copy visibility controller!"