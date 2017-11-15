plugin material stanMat
	name:"stan_material"
	classID:#(0xfccefb, 0x22e63c7)
	extends:blend
	replaceUI:true
(
	parameters main rollout:params
	(
		normalMat type:#material ui:normalUI
		idMat type:#material ui:idUI
		renderInt type:#integer ui:renderUI default:1
		alphaBo type:#boolean ui:alphaUI default:on
		
		on normalMat set value do delegate.map1=value
		on renderInt Set value do 
		(
			case value of
			(
				(1): 
				(
					delegate.map1=normalMat
				)
				(2): 
				(
					delegate.map1=idMat
				)
			)
		)
		on alphaBo Set value do 
		(
			case value of
			(
				(on):
				(
					if isProperty idMat "alphaMode" do idMat.alphaMode = 1
				)
				(off):
				(
					if isProperty idMat "alphaMode" do idMat.alphaMode = 2
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
		checkbox alphaUI "Alpha solid" pos:[100,51]
		
		on renderUI changed arg do
		(
			renderSceneDialog.close()
			case arg of
			(
				1: 
				(
					for i = (getClassInstances stanMat) do
					(
						i.renderInt=arg
						i.alphaBo=on
					)
					if IsValidNode $LPM_Root do $LPM_Root.fileType = "jpg"
					if classof renderers.current == CoronaRenderer do
					(
						renderers.current.Use_render_stamp = on
						renderers.current.Use_3dsmax_environment = off
						renderers.current.Override_direct_bg_color___ON = on
					)
				)
				2: 
				(
					for i = (getClassInstances stanMat) do
					(
						i.renderInt=arg
					)
					if IsValidNode $LPM_Root do $LPM_Root.fileType = "png"
					if classof renderers.current == CoronaRenderer do
					(
						renderers.current.Use_render_stamp = off
						renderers.current.Use_3dsmax_environment = on
						renderers.current.Override_direct_bg_color___ON = off
					)
				)
			)
		)
		on alphaUI changed arg do
		(
			for i = (getClassInstances stanMat) do
			(
				if i != this do
				(
					i.alphaBo = off
				)
			)
		)
	)
	on create do
	(
		normalMat=coronamtl()
		theOldMat=medit.GetCurMtl()
		a = undefined
		ans=false
		if(MatEditor.isOpen() and (superclassof theOldMat) == material) then
			ans=on
		if ans then normalMat=theOldMat
		fn randomColor = color (random 0 255) (random 0 255) (random 0 255)
		idMat=coronamtl()
		idMat.name=normalMat.name+ "_ID"
		idMat.colorSelfIllum = randomColor()
		idMat.levelDiffuse = 0.0
		idMat.levelReflect = 0.0
		idMat.levelTranslucency = 0.0
		idMat.levelSelfIllum = 1.0
		idMat.texmapOnOpacity = on
		idMat.texmapOnSelfIllum = off
		delegate.map1=normalMat
		delegate.map2=idMat
	)
)