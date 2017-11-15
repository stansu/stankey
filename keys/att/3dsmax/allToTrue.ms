for i = $ do
(
	setUserPropBuffer i (substituteString (getUserPropBuffer i) "False" "True")
)
