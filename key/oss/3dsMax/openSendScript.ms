try
(
	f = getOpenFileName caption:"Open A File:" types:"all|*.*|" filename:(getFilenamePath rendOutputFilename)
	edit f
)
catch()