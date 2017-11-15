fn compareName a b =
(
	a = toLower a.name
	b = toLower b.name
	case of
	(
		(a < b): -1
		(a > b): 1
		(a == b): 0
	)
)