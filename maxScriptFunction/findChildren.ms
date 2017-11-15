fn findChildren inputNode outputArray =
(
	inputNodeChildren = inputNode.children
	iChildrenCount = inputNode.children.count
	for i = inputNodeChildren do
	(
		append outputArray i
		if iChildrenCount != 0 do findChildren i outputArray
	)
)