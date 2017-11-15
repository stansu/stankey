plugin material stanMatRS
	name:"stan_redShift_material"
	classID:#(0x5c33c575, 0x3dfdd7dc)
	extends:Redshift_Material_Blender
	replaceUI:true
(
	parameters main rollout:params
	(
		normalMat type:#material ui:normalUI
		idMat type:#material ui:idUI
		renderInt type:#integer ui:renderUI default:1
		
		on normalMat set value do delegate.baseColor_map = value
		on renderInt Set value do 
		(
			case value of
			(
				(1): 
				(
					delegate.baseColor_map = normalMat
				)
				(2): 
				(
					delegate.baseColor_map = idMat
				)
			)
		)
	)
	rollout params "stan Render Switcher"
	(
		label vLabel "Normal Mtl" pos:[6,8] width:200 height:13
		materialButton normalUI "" pos:[70,4] width:200 height:21 
		label cLabel "ID Mtl" pos:[6,29] width:54 height:13
		materialButton idUI "" pos:[70,26] width:200 height:21 
		radiobuttons renderUI "" pos:[4,51] width:77 height:62 labels:#( "Normal", "ID") tooltip:"Choose one for render."
		
		on renderUI changed arg do
		(
			renderSceneDialog.close()
			case arg of
			(
				1: 
				(
					for i = (getClassInstances stanMatRS) do
					(
						i.renderInt=arg
-- 						i.alphaBo=on
					)
					if IsValidNode $LPM_Root do $LPM_Root.fileType = "jpg"
				)
				2: 
				(
					for i = (getClassInstances stanMatRS) do
					(
						i.renderInt=arg
					)
					if IsValidNode $LPM_Root do $LPM_Root.fileType = "png"
				)
			)
		)
	)
	on create do
	(
		normalMat = Redshift_Architectural()
		theOldMat = medit.GetCurMtl()
		a = undefined
		ans = false
		if (MatEditor.isOpen() and (superclassof theOldMat) == material) then
			ans=on
		if ans then normalMat = theOldMat
		fn randomColor = color (random 0 255) (random 0 255) (random 0 255)
		idMat = Redshift_Architectural()
		idMat.name=normalMat.name+ "_ID"
		idMat.additional_color = randomColor()
		idMat.diffuse_weight = 0.0
		idMat.reflectivity = 0.0
		idMat.refr_trans_weight = 0.0
		idMat.cutout_opacity_mapenable = on
		idMat.additional_color_mapenable = off
		delegate.baseColor_map = normalMat
		delegate.layerColor1_map = idMat
	)
)