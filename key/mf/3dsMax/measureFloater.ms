(
	fn openMeasureFloater =
	(
		local result = false --flag for success/failure
		local oldPannel = getCommandPanelTaskMode() --remember the old command panel tab
		UtilityPanel.OpenUtility measure --open Utility tab and enable Measure Utility
--		local theMeasureUtil = windows.getChildHWND #max "Measure" --grab the Measure's rollout handle
--		if theMeasureUtil.count > 0 do --if it was found,
		(
			local theButton = windows.getChildHWND #max "New Floater" --get the New Floater button's handle
			if theButton.count > 0 do --if this succeeded too, then send messages to click it
			(
				Windows.sendMessage theButton[1] 0x201 0 0 --Left Mouse Button Down
				Windows.sendMessage theButton[1] 0x202 0 0 --Left Mouse Button Up
				result = true --raise the flag for success
			)
		)
		setCommandPanelTaskMode oldPannel --switch back to the previous command panel tab
		result --return result
	)
	openMeasureFloater()
)