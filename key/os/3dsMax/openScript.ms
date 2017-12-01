try
(
	f = getOpenFileName caption:"Open A File:" types:"all|*.*|" filename:"D:\\stanKey\\key\\"
	if f != undefined do edit f
)
catch()