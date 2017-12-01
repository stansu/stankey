(
	if selection.count == 1 then
	(
		temp = $
		tempSource = getUserPropBuffer temp
		tempFinal = substituteString tempSource "\"" ""
		tempFinal = substituteString tempFinal "#" ""
		tempFinal = substituteString tempFinal "(" ""
		tempFinal = substituteString tempFinal ")" ""
		setUserPropBuffer temp tempFinal
		rollout editProps temp.name
		(
			edittext ss text:tempFinal height: 200 width:350
			on ss changed txt do
			(
				setUserPropBuffer temp txt
			)
		)
		createDialog editProps height:212 width:400
	)else messagebox "please select an object!"
)