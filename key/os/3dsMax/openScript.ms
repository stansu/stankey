try
(
	f = getOpenFileName caption:"Open A File:" types:"all|*.*|" filename:"c:\\stankey-master\\key\\"
	if f != undefined do edit f
)
catch()
