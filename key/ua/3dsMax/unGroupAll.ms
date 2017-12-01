try
(
	local a, groupFlag
	a = selection as array
	groupFlag = on
	while groupFlag
	do
	(
		groupFlag = actionMan.executeAction 0 "40141"
	)
)
catch()