fn findMaxDistance inputArray =
(
	inputArrayCount = inputArray.count
	outputArray = #(undefined, undefined, 0.0)
	for i = 1 to inputArrayCount do
	(
		for j = (i + 1) to inputArrayCount do
		(
			if (distance inputArray[i] inputArray[j]) > outputArray[3] do
			(
				outputArray[1] = inputArray[i]
				outputArray[2] = inputArray[j]
				outputArray[3] = (distance inputArray[i] inputArray[j])
			)
		)
	)
	outputArray
)