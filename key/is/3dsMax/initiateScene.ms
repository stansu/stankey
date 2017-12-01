(
	max drawingaids
	HiddenDOSCommand "D:\\stanKey\\key\\sn\\3dsMax\\ahk\\snapSetting.ahk" donotwait:true startpath:"D:\\stanKey\\key\\sn\\3dsMax\\ahk\\"
	renderSceneDialog.close()
-- 	if classof renderers.current != CoronaRenderer do renderers.current = CoronaRenderer()
-- 	(
-- 		renderers.current.progressive_time_limit = 0.0
-- 		renderers.current.Progressive_rendering_max_passes = 5
-- 		renderers.current.Use_render_stamp = on
-- 		renderers.current.Render_stamp = "3D透視圖無法確定實際尺寸與顏色，請特別注意！ %pt %pp"
-- 	)
	viewSetting = NitrousGraphicsManager.GetActiveViewportSetting()
	viewSetting.ViewportViewSettingImpl.ShadowsEnabled = off
	viewSetting.SelectedEdgedFacesEnabled = off
	viewSetting.ViewportViewSettingImpl.AmbientOcclusionEnabled = off
)