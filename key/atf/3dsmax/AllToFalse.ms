for i = $ do
(
	setUserPropBuffer i (substituteString (getUserPropBuffer i) "True" "False")
)