if (querybox "Remove lookAt?") do
(
	for i = $ do
	(
		i[3].controller = Transform_Script()
		i[3].controller = prs()
		i[3][2][3].value = 0
	)
)
