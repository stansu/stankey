if selection.count != 0 then
(
	if querybox "unique visibility controller?" do
	(
		for i = selection do
		(
			i.visibility.controller = copy i.visibility.controller
		)
	)
)else messagebox "please select some objects for unique visibility controller!"