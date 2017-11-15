fn findHighestParent inputNode =
(
	if inputNode.parent != undefined do
	(
		inputNode = inputNode.parent
		findHighestParent inputNode
	)
	inputNode
)