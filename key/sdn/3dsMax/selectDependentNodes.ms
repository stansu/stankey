if selection.count == 1 then
(
	select (refs.dependentNodes $.baseobject)
	if selection.count == 1 do messageBox "No dependent node!"
)
else messageBox "Please select one node!"