cls
d:
cd %1
for /R %%G in (*.png) do (
	identify -channel a -format "%%[standard-deviation]\n" "%%G" > temp.txt
	for /f %%i in (temp.txt) do (
		if %%i == 0 del "%%G"
	)
)
del temp.txt