try
(
-- 	messagebox "Don't undo after group! Max will crash!"
	sl = selection[1].layer
	g = group $ select:on
	sl.addnode g
)
catch
(
	messagebox "Please check node's parent inside selection!"
)