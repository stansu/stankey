try
(
	a=shell()
	modPanel.addModToSelection (a) ui:on
	a.outerAmount = 0
	a.innerAmount = 20
	a.straightenCorners = on
)
catch()