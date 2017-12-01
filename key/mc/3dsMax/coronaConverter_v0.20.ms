

--macroScript CoronaMtlConverter
--category: "Corona Renderer"
(
	/* ########################################
	Version: v0.20
	Base frame inspired by Vray's scene converter.
	Written by Martin Geupel (http://www.racoon-artworks.de)
	VrayCompTex conversion provided by gover_gol (http://www.gg3dcg.ru)
	
	Copyright (C) 2014 Martin Geupel, All Rights Reserved
	Permission is hereby granted, free of charge, to any person obtaining a copy of this software (the "Software"), to use, copy, and/or distribute the software, 
	subject to the following conditions:

	- The above copyright notice and this permission notice shall be included in all copies of the Software.
	- You may not misrepresent the name of the Original Author or the name of the Software.
	- You can distribute the Software only free of charge, you may not sell and/or rent the Software.
	- You may add functionality and/or modify existent functionaly if it is then clearly marked and noted in this Header.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
	OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE 
	LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN 
	CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
	##########################################
	
	supported materials:
	- Standard
	- VrayMtl
	- VRayBlendMtl
	- VRayLightMtl
	- VRay2SidedMtl
	- VRayCarPaintMtl
	- VrayOverrideMtl
	- VRayFastSSS
	- VRayFastSSS2
	- Vray-specific maps
	- MR_ArchAndDesign
	- MR_Carpaint (basic)
	- fR_Advanced
	- fR_Architectural
	- DoubleSided 
	- Shellac
	- TopBottom
	- Autodesk Materials
	
	changelog:
	*v0.20---------------------------------------------------------------------------------------------
	- added 2 buttons for material energy conservation modes, primarily to convert old scenes to new energy conservation
	*v0.19---------------------------------------------------------------------------------------------
	- "convert glossy values (experimental)" is now ON by default
	*v0.18---------------------------------------------------------------------------------------------
	- changed "Corona" prefix to a variable that can be defined by the user, state and variable get saved in an ini file
	- updated VrayColor -> CoronaSolidTex conversion (output multiplier)
	*v0.17---------------------------------------------------------------------------------------------
	- fixed: autodesk mtls conversion failed when opacity map was used
	*v0.16---------------------------------------------------------------------------------------------
	- changed the way materials are collected and processed, huge speedup in scenes with thousands of objects using multimaterials
	- simple TopBottom material conversion added
	*v0.15---------------------------------------------------------------------------------------------
	- updated VrayDirt conversion: + radius texmap + inverse switch + same obj only + exclude/include lists
	- fixed a bug when trying to convert a selection of objects without materials
	- added a readme/warning to check materials after conversion
	- emission/self-illumination has been corrected to work with A6
	- added "show maps in viewport" functionality
	- corona prefix option now disabled by default
	- fixed: Vray fresnel ior lock ignored
	- switched to new refraction modes (prior glassmodes)
	- added checkbox for switching the renderer to corona
	- fixed displacement conversion (map amount has been removed)
	- removed VrayMultiSubTex conversion (works with corona now)
	- added proper VrayOverrideMtl conversion
	- added macroscript header, if you uncomment those 2 lines (remove "--") it will be installable as macroscript
	- added statistics about materials in the scene
	- fixed MR_ArchAndDesign diffuse level
	- fixed Vray Absorption: multiplier -> distance is now calculated inverse; absorption will be ignored if fog color == white
	- added Autodesk Materials conversion (Generic + all subsequent mats like Stone, Wood, ...)
	- added Autodesk Bitmap conversion; maps like autodesk tile, autodesk noise etc are not supported
	- added max displacement level functionality + disable displacement maps button
	- added material class -> default CoronaMtl converter
	*v0.14---------------------------------------------------------------------------------------------
	- added "VRayNormalMap" conversion
	- added "Normal Bump" conversion
	- removed VrayHDRI conversion since Corona can render them
	- changed VrayMtl conversion: sets CoronaMtl reflection ior to 999 if VrayMtl's reflection fresnel is deactivated
	- Vray2SidedMtl conversion sets "twosided (thin)" material mode in resulting CoronaMtl
	*v0.13---------------------------------------------------------------------------------------------
	- Changed Vray2SidedMtl conversion (better translucency: DiffuseColor of orig. mat)
	- Very basic temporary VrayFastSSS and VrayFastSSS2 conversion methods (returns CoronaMtl with sss overall color; will be replaced when Corona has proper SSS)
	- added optional VertexColor map 'conversion' (returns default medium gray coronaSolidTex)
	- added basic VrayOverrideMtl conversion (returns baseMaterial); thanks to Slazzo for the input!
	*v0.12---------------------------------------------------------------------------------------------
	- fixed Multi-Sub-Object material bug when submaterial number is set to 1
	*v0.11---------------------------------------------------------------------------------------------
	- added bitmap blur altering option
	*v0.10---------------------------------------------------------------------------------------------
	- normalbump map warning
	*v0.09---------------------------------------------------------------------------------------------
	- fR_Architectural was broken, fixed that
	*v0.085---------------------------------------------------------------------------------------------
	- fixed MR_ArchAndDesign and fR_Architectural Anisotropy.. again 
	*v0.08----------------------------------------------------------------------------------------------
	- Reset MatEditor to Corona Materials added
	- better fR_Architectural translucency conversion by Rawalanche (+ glassmode)
	- better MR_ArchAndDesign translucency conversion by Rawalanche (+ glassmode)   
	*v0.07----------------------------------------------------------------------------------------------
	- fixed Vray material error
	*v0.07----------------------------------------------------------------------------------------------
	- added VRayCarPaintMtl
	- added basic MR_Carpaint
	- added better VrayCompTex conversion by gover_gol
	- Clamped several levels spinners (important fix)
	- added inversion of negative bump values (important fix)
	- Fixed several FinalRender Material issues (important fix)
	- changed selection conversion methods to instancing (removed debug)
	- added advanced debug mode for internal use (off by default)
	*v0.06----------------------------------------------------------------------------------------------
	- added support for emission converting: standard material, MR_ArchAndDesign, fR_Advanced, fR_Architectural
	- Switched to new maxscript properties naming (valid for builds after 16th Sept 2012)
	- added "corona" prefix checkbox 
	- code clean-ups, little enhancements
	- fixed anisotropy conversion from (fr+Mr)arch materials
	*v0.05----------------------------------------------------------------------------------------------
	- converted maps keep original name
	- added mode for converting VrayBlend to multilayerd blend materials
	*v0.04----------------------------------------------------------------------------------------------
	- added fR_Advanced 
	- added fR_Architectural 
	- fixed ArchAndDesign problems: anisotropy spinner*10, use refractmap slot, removed alpha from reflectioncolor
	- added Debug conversion functions, will be removed or refinded later
	- Blend material works now
	- Shellac will be converted to Blend (zero mix)
	- DoubleSided will be converted to Blend (zero mix)
	*v0.03----------------------------------------------------------------------------------------------
	- restructured Material conversion functions
	- fixed: anisotropy angle map, translucency parameters
	- added a sorted list of material functions as a start point for other materials 
	
	######################################## */ 
	
	
	try(destroydialog ::CoronaConverter)catch()
	try(destroydialog ::CoronaMtlStats)catch()
	try(destroydialog ::convertClass)catch()
	
	-- depreciated, do not use, will be removed in future versions
	CorConvDEBUGmode = false  -- Set this to true if there are any problems with converted Materials and re-run converter with orig. Materials
	standardMatSpecToRefl = true
	VrayConvertGlossyValues = true
	vrayblendToMultilayerdBlend = true
	addCoronaPrefix = false
	AD_mats_found = false
	UserPrefixStr
	
	
	orig_mtls=#()
	new_mtls=#()
	
	-- depreciated, do not use, will be removed in future versions
	if CorConvDEBUGmode then print "DEBUG MODE ACTIVE"
	fn DebugCoronaMTL CoraMat origMtlClass =(
		maxVal
		minVal
		if (tmpProp = CoraMat.levelDiffuse) > (maxVal =1.0) OR (tmpProp < 0.0) then(print (CoraMat.name + ": levelDiffuse"+ " = " + (tmpProp as string) + " > " + (maxVal as string)  + " or < " + (minVal as string) + " - from " + (origMtlClass as string)) )else()
		if (tmpProp = CoraMat.texmapAmountDiffuse) > (maxVal =1.0) OR (tmpProp < (minVal = 0.0)) then(print (CoraMat.name + ": texmapAmountDiffuse"+ " = " + (tmpProp as string) + " > " + (maxVal as string) + " or < " + (minVal as string) + " - from " + (origMtlClass as string)) )else()
			
		if (tmpProp = CoraMat.levelReflect) > (maxVal =1.0) OR (tmpProp < (minVal = 0.0)) then(print (CoraMat.name + ": levelReflect"+ " = " + (tmpProp as string) + " > " + (maxVal as string)+ " or < " + (minVal as string) + " - from " + (origMtlClass as string)) )else()
		if (tmpProp = CoraMat.texmapAmountReflect) > (maxVal =1.0) OR (tmpProp < (minVal = 0.0)) then(print (CoraMat.name + ": texmapAmountReflect"+ " = " + (tmpProp as string) + " > " + (maxVal as string)+ " or < " + (minVal as string) + " - from " + (origMtlClass as string)) )else()
		if (tmpProp = CoraMat.fresnelIor) < (maxVal =1.0) then(print (CoraMat.name + ": fresnelIor"+ " = " + (tmpProp as string) + " < " + (maxVal as string) + " - from " + (origMtlClass as string)) )else()
		if (tmpProp = CoraMat.texmapAmountFresnelIor) > (maxVal =1.0) OR (tmpProp < (minVal = 0.0)) then(print (CoraMat.name + ": texmapAmountFresnelIor"+ " = " + (tmpProp as string) + " > " + (maxVal as string)+ " or < " + (minVal as string) + " - from " + (origMtlClass as string)) )else()
		if (tmpProp = CoraMat.reflectGlossiness) > (maxVal =1.0) OR (tmpProp < (minVal = 0.0)) then(print (CoraMat.name + ": reflectGlossiness"+ " = " + (tmpProp as string) + " > " + (maxVal as string)+ " or < " + (minVal as string) + " - from " + (origMtlClass as string)) )else()
		if (tmpProp = CoraMat.texmapAmountReflectGlossiness) > (maxVal =1.0) OR (tmpProp < (minVal = 0.0)) then(print (CoraMat.name + ": texmapAmountReflectGlossiness"+ " = " + (tmpProp as string) + " > " + (maxVal as string)+ " or < " + (minVal as string) + " - from " + (origMtlClass as string)) )else()
			
		if (tmpProp = CoraMat.levelRefract) > (maxVal =1.0) OR (tmpProp < (minVal = 0.0)) then(print (CoraMat.name + ": levelRefract"+ " = " + (tmpProp as string) + " > " + (maxVal as string)+ " or < " + (minVal as string) + " - from " + (origMtlClass as string)) )else()
		if (tmpProp = CoraMat.texmapAmountRefract) > (maxVal =1.0) OR (tmpProp < (minVal = 0.0)) then(print (CoraMat.name + ": texmapAmountRefract"+ " = " + (tmpProp as string) + " > " + (maxVal as string)+ " or < " + (minVal as string) + " - from " + (origMtlClass as string)) )else()
		if (tmpProp = CoraMat.ior) > (maxVal =10.0) then(print (CoraMat.name + ": ior"+ " = " + (tmpProp as string) + " > " + (maxVal as string) + " - from " + (origMtlClass as string)) )else()
		if (tmpProp = CoraMat.ior) < (maxVal =1.0) then(print (CoraMat.name + ": ior"+ " = " + (tmpProp as string) + " > " + (maxVal as string) + " - from " + (origMtlClass as string)) )else()
		if (tmpProp = CoraMat.texmapAmountIor) > (maxVal =1.0) OR (tmpProp < (minVal = 0.0)) then(print (CoraMat.name + ": texmapAmountIor"+ " = " + (tmpProp as string) + " > " + (maxVal as string)+ " or < " + (minVal as string) + " - from " + (origMtlClass as string)) )else()
		if (tmpProp = CoraMat.refractGlossiness) > (maxVal =1.0) OR (tmpProp < (minVal = 0.0)) then(print (CoraMat.name + ": refractGlossiness"+ " = " + (tmpProp as string) + " > " + (maxVal as string)+ " or < " + (minVal as string) + " - from " + (origMtlClass as string)) )else()
		if (tmpProp = CoraMat.texmapAmountRefractGlossiness) > (maxVal =1.0) OR (tmpProp < (minVal = 0.0)) then(print (CoraMat.name + ": texmapAmountRefractGlossiness"+ " = " + (tmpProp as string) + " > " + (maxVal as string)+ " or < " + (minVal as string) + " - from " + (origMtlClass as string)) )else()
			
		if (tmpProp = CoraMat.levelTranslucency) > (maxVal =1.0) OR (tmpProp < (minVal = 0.0)) then(print (CoraMat.name + ": levelTranslucency"+ " = " + (tmpProp as string) + " > " + (maxVal as string)+ " or < " + (minVal as string) + " - from " + (origMtlClass as string)) )else()
		if (tmpProp = CoraMat.texmapAmountTranslucency) > (maxVal =1.0) OR (tmpProp < (minVal = 0.0)) then(print (CoraMat.name + ": texmapAmountTranslucency"+ " = " + (tmpProp as string) + " > " + (maxVal as string)+ " or < " + (minVal as string) + " - from " + (origMtlClass as string)) )else()
		if (tmpProp = CoraMat.levelOpacity) > (maxVal =1.0) OR (tmpProp < (minVal = 0.0)) then(print (CoraMat.name + ": levelOpacity"+ " = " + (tmpProp as string) + " > " + (maxVal as string)+ " or < " + (minVal as string) + " - from " + (origMtlClass as string)) )else()
		if (tmpProp = CoraMat.texmapAmountOpacity) > (maxVal =1.0) OR (tmpProp < (minVal = 0.0)) then(print (CoraMat.name + ": texmapAmountOpacity"+ " = " + (tmpProp as string) + " > " + (maxVal as string)+ " or < " + (minVal as string) + " - from " + (origMtlClass as string)) )else()
		if (tmpProp = CoraMat.texmapAmountEmission) > (maxVal =1.0) OR (tmpProp < (minVal = 0.0)) then(print (CoraMat.name + ": texmapAmountEmission"+ " = " + (tmpProp as string) + " > " + (maxVal as string)+ " or < " + (minVal as string) + " - from " + (origMtlClass as string)) )else()
			
		if (tmpProp = CoraMat.texmapAmountBump) > (maxVal =99.0) OR (tmpProp < (minVal = 0.0)) then(print (CoraMat.name + ": texmapAmountBump"+ " = " + (tmpProp as string) + " > " + (maxVal as string)+ " or < " + (minVal as string) + " - from " + (origMtlClass as string)) )else()
			
		if (tmpProp = CoraMat.anisotropy) > (maxVal =1.0) OR (tmpProp < (minVal = -1.0)) then(print (CoraMat.name + ": anisotropy"+ " = " + (tmpProp as string) + " > " + (maxVal as string)+ " or < " + (minVal as string) + " - from " + (origMtlClass as string)) )else()
		if (tmpProp = CoraMat.texmapAmountAnisotropy) > (maxVal =1.0) then(print (CoraMat.name + ": texmapAmountAnisotropy"+ " = " + (tmpProp as string) + " > " + (maxVal as string) + " - from " + (origMtlClass as string)) )else()
		if (tmpProp = CoraMat.anisotropyRotation ) > (maxVal =360.0) OR (tmpProp < (minVal = 0.0)) then(print (CoraMat.name + ": anisotropyRotation "+ " = " + (tmpProp as string) + " > " + (maxVal as string)+ " or < " + (minVal as string) + " - from " + (origMtlClass as string)) )else()
		if (tmpProp = CoraMat.texmapAmountAnisotropyRotation) > (maxVal =1.0) OR (tmpProp < (minVal = 0.0)) then(print (CoraMat.name + ": texmapAmountAnisotropyRotation"+ " = " + (tmpProp as string) + " > " + (maxVal as string)+ " or < " + (minVal as string) + " - from " + (origMtlClass as string)) )else()
	)
	
	-- ############## Material Statistics ################
	rollout CoronaMtlStats "Statistics" width:210 height:176
	(
		label lblNumCrnMat "number of CoronaMtls containing..." pos:[8,8] width:200 height:16
		label lblNumReflect "Reflections:" pos:[16,24] width:200 height:16
		label lblNumRefract "Refractions:" pos:[16,40] width:200 height:16
		label lblNumSelfIllu "Self illumination:" pos:[16,56] width:96 height:16
		label lblNumTransl "Translucency:" pos:[16,72] width:96 height:16
		label lblNumOpacity "Opacity:" pos:[16,88] width:96 height:16
		label lblNumDisplace "Displacement:" pos:[16,104] width:96 height:16
		label lblNumCrnLight "number of CoronaLightMtls..." pos:[8,128] width:176 height:16
		label lblNumEmitting "emitting Light (direct):" pos:[16,144] width:144 height:16
		
		on CoronaMtlStats open do(
			local CrnMats = getclassinstances CoronaMtl 
			local numReflectiveCrn = 0
			local numTwoSided = 0
			local numCaustics = 0
			local numRefractiveCrn = 0
			local numSelfIlluCrn = 0
			local numTranslucentCrn = 0
			local numOpacityCrn = 0
			local numDisplacementCrn = 0
			local CrnLightMat = getclassinstances CoronaLightMtl
			local numEmittingLightMat = 0
			
			for mat in CrnMats do(
				--count reflective 
				if mat.levelReflect != 0 then(
					if mat.colorReflect != black then numReflectiveCrn += 1 else(
						if mat.texmapReflect != undefined AND mat.texmapOnReflect == true then numReflectiveCrn += 1
					)
				)
				
				--count refractive 
				if mat.levelRefract != 0 then(
					if mat.colorRefract != black then( 
						numRefractiveCrn += 1
						if mat.twosidedGlass then numTwoSided += 1
						if mat.useCaustics then numCaustics += 1
					)
					else(
						if mat.texmapRefract != undefined AND mat.texmapOnRefract == true then(
							numRefractiveCrn += 1
							if mat.twosidedGlass then numTwoSided += 1
							if mat.useCaustics then numCaustics += 1
						)
					)
				)
				
				--count selfillum 
				if mat.levelSelfIllum != 0 then(
					if mat.colorSelfIllum != black then numSelfIlluCrn += 1 else(
						if mat.texmapSelfIllum != undefined AND mat.texmapOnSelfIllum == true then numSelfIlluCrn += 1
					)
				)
				
				--count translucent 
				if mat.levelTranslucency != 0 then(
					if mat.colorTranslucency != black then numTranslucentCrn += 1 else(
						if mat.texmapTranslucency != undefined AND mat.texmapOnTranslucency == true then numTranslucentCrn += 1
					)
				)
				
				--count opacity 
				if mat.levelOpacity != 1.0 then numOpacityCrn += 1
				else(
					if mat.colorOpacity != white then numOpacityCrn += 1 else(
						if mat.texmapOpacity != undefined AND mat.texmapOnOpacity == true then numOpacityCrn += 1
					)
				)
				
				--count displacement 
				if mat.levelTranslucency != 0 then(
					if mat.texmapDisplace != undefined AND mat.texmapOnDisplace == true then numDisplacementCrn += 1
				)
			)
			
			for mat in CrnLightMat do if mat.emitLight then numEmittingLightMat += 1
			
			lblNumCrnMat.text = "number of CoronaMtls(" + CrnMats.count as string + ") containing..."
			lblNumReflect.text = "Reflections: " + numReflectiveCrn as string
			lblNumRefract.text = "Refractions: " + numRefractiveCrn as string  + "   Caustics(" + numCaustics as string + ") Thin(" + numTwoSided as string + ")"			
			lblNumSelfIllu.text = "Self illumination: " + numSelfIlluCrn as string 		
			lblNumTransl.text = "Translucency: " + numTranslucentCrn as string 	
			lblNumOpacity.text = "Opacity: " + numOpacityCrn as string 
			lblNumDisplace.text = "Displacement: " + numDisplacementCrn as string 
			lblNumCrnLight.text = "number of CoronaLightMtls(" + CrnLightMat.count as string + ") ..."
			lblNumEmitting.text = "emitting Light (direct): " + numEmittingLightMat as string 
		)
	)
	
	
	-- ############## Standard Material ################
	fn convertFrom_Standard origMtl = (
		r=CoronaMtl()
		r.name=(if addCoronaPrefix then UserPrefixStr else "") + origMtl.name
		
		--Diffuse
		r.levelDiffuse=1.0 --(Diffuse_level) : float
		r.colorDiffuse=origMtl.diffuse --(Diffuse_color) : RGB color
		r.texmapDiffuse=origMtl.diffuseMap --(Diffuse_texture) : texturemap
		if r.texmapDiffuse != undefined then(
			r.texmapOnDiffuse=origMtl.diffuseMapEnable --(usemap_diffuse) : boolean
			r.texmapAmountDiffuse=origMtl.diffuseMapAmount / 100.0 --(Diffuse_map_amount) : float
		)
		--Reflection
		if standardMatSpecToRefl AND origMtl.specularLevel != 0 then(
			r.levelReflect=1.0 --(reflect_level) : float
			r.colorReflect=origMtl.specular*origMtl.specularLevel*0.01 --(Reflection_color) : RGB color
			K=2.0^(origMtl.glossiness*0.01*10.0)
			tmpgloss = 1.0-(1.0/(K+1.0))^(1.0/3.5)
			r.reflectGlossiness=if tmpgloss < 1.0 then 1.0 else tmpgloss --(Reflection_blur) : texturemap
		)
		--Bumpmap
		r.texmapBump=origMtl.bumpMap --(bump_texmap) : texturemap
		if r.texmapBump != undefined then(
			r.texmapOnBump=origMtl.bumpMapEnable --(usemap_bump) : boolean
			r.texmapAmountBump= if origMtl.bumpMapAmount <  0.0 then -(origMtl.bumpMapAmount / 100.0) else (origMtl.bumpMapAmount / 100.0) --(Bump_map_amount) : float
		)
		--Opacity
		r.levelOpacity=1.0 --(opacity_level) : float
		r.colorOpacity=(color 255 255 255) --(Opacity_Color) : RGB color
		r.texmapOpacity=origMtl.opacityMap --(opacity_texmap) : texturemap
		if r.texmapOpacity != undefined then(
			r.texmapOnOpacity=origMtl.opacityMapEnable --(usemap_opacity) : boolean
			r.texmapAmountOpacity=origMtl.opacityMapAmount / 100.0 --(Opacity_map_amount) : float
		)
		--Emission
		
		--r.emissionOn = (if (origMtl.useSelfIllumColor AND origMtl.selfIllumColor != (color 0 0 0)) OR origMtl.selfIllumAmount != 0 then true else false)
		r.levelSelfIllum = if origMtl.useSelfIllumColor then 1.0 else (origMtl.selfIllumAmount /100.0) --(emission_level) : float
		r.colorSelfIllum =  if origMtl.useSelfIllumColor then origMtl.selfIllumColor else r.colorDiffuse --(Emission_color) : RGB color
		r.texmapSelfIllum = origMtl.selfillumMap --(Emission_texmap) : texturemap
		if r.texmapSelfIllum != undefined then(
			r.texmapOnSelfIllum = origMtl.selfillumMapEnable --(Emission_usemap) : boolean
			r.texmapAmountSelfIllum = origMtl.selfillumMapAmount / 100.0 --(Emission_mapamount) : float
		)
		else(
			if origMtl.useSelfIllumColor == false AND origMtl.selfIllumAmount != 0 then(
				r.colorSelfIllum = r.colorDiffuse
				if r.texmapOnDiffuse then(r.texmapSelfIllum = r.texmapDiffuse; r.texmapOnSelfIllum = true)
			)
		)
		
		--Displacement
		r.texmapDisplace=origMtl.displacementMap --(Displace_texmap) : texturemap
		if r.texmapDisplace != undefined then(
			r.texmapOnDisplace=origMtl.displacementMapEnable --(Use_Displace_map) : boolean
			--r.texmapAmountDisplace=origMtl.displacementMapAmount / 100.0 --(Displace_amount) : worldUnits
		)
		
		if CorConvDEBUGmode then(
			DebugCoronaMTL r (classof origMtl)
		)
		r
	)

	
	-- ############## Create Default Corona Material ################
	fn CreateDefaultCoronaMtl origMtl =(
		r=CoronaMtl()
		r.name=(if addCoronaPrefix then UserPrefixStr else "") + origMtl.name
		r
	)


	-- ############## Vray Material ################
	fn convertFrom_VrayMtl origMtl =(
		r=CoronaMtl()
		r.name=(if addCoronaPrefix then UserPrefixStr else "") + origMtl.name
		
		--Diffuse
		r.levelDiffuse=1.0 --(Diffuse_level) : float
		r.colorDiffuse = origMtl.diffuse --(Diffuse_color) : RGB color
		r.texmapDiffuse = origMtl.texmap_diffuse --(Diffuse_texture) : texturemap
		if r.texmapDiffuse != undefined then(
			r.texmapOnDiffuse = origMtl.texmap_diffuse_on --(usemap_diffuse) : boolean
			r.texmapAmountDiffuse = origMtl.texmap_diffuse_multiplier / 100.0 --(Diffuse_map_amount) : float
		)
		
		--Reflection
		r.levelReflect = 1.0 --(reflect_level) : float
		r.colorReflect = origMtl.reflection --(Reflection_color) : RGB color
		r.texmapReflect = origMtl.texmap_reflection --(reflection_texture) : texturemap
		if r.texmapReflect != undefined then(
			r.texmapOnReflect = origMtl.texmap_reflection_on --(usemap_reflect) : boolean
			r.texmapAmountReflect = origMtl.texmap_reflection_multiplier / 100.0 --(Reflect_map_amount) : float
		)
		
		if origMtl.reflection_lockIOR then(
			r.fresnelIor = if origMtl.refraction_ior < 1.0 then 1.0 else origMtl.refraction_ior
		)
		else(
			r.fresnelIor = if origMtl.reflection_ior < 1.0 then 1.0 else origMtl.reflection_ior--(reflect_fresnel) : float
		)
		if origMtl.reflection_fresnel == false then(
			r.fresnelIor = 999
		)
		r.texmapFresnelIor = origMtl.texmap_reflectionIOR --(Fresnel_IOR_texmap) : texturemap
		if r.texmapFresnelIor != undefined then(
			r.texmapOnFresnelIor = origMtl.texmap_reflectionIOR_on --(Use_Fresnel_IOR_map) : boolean
			r.texmapAmountFresnelIor = origMtl.texmap_reflectionIOR_multiplier --(Fresnel_IOR_amount) : float
		)
		r.reflectGlossiness = (if VrayConvertGlossyValues then(1.0 - sqrt(1.0 - origMtl.reflection_glossiness)) else(origMtl.reflection_glossiness) ) --(Reflection_bluriness) : float
		r.texmapReflectGlossiness = origMtl.texmap_reflectionGlossiness --(Reflection_blur) : texturemap
		if r.texmapReflectGlossiness != undefined then(
			r.texmapOnReflectGlossiness = origMtl.texmap_reflectionGlossiness_on --(reflect_blur_usemap) : boolean
			r.texmapAmountReflectGlossiness = origMtl.texmap_reflectionGlossiness_multiplier / 100.0 --(Reflect_map_glossiness_amount) : float
		)
		
		--Refraction
		r.levelRefract = 1.0 --(refract_level) : float
		r.colorRefract = origMtl.refraction --(Refraction_color) : RGB color
		r.texmapRefract = origMtl.texmap_refraction --(reflect_texmap) : texturemap
		if r.texmapRefract != undefined then(
			r.texmapOnRefract = origMtl.texmap_refraction_on --(usemap_refract) : boolean
			r.texmapAmountRefract = origMtl.texmap_refraction_multiplier / 100.0 --(Refract_map_amount) : float
		)
		r.ior = if origMtl.refraction_ior < 1.0 then 1.0 else(if origMtl.refraction_ior > 10.0 then 10.0 else origMtl.refraction_ior)--(Index_of_refraction) : float
		--r.texmapIor = origMtl.texmap_refractionIOR --(IOR_texmap) : texturemap      -- REFRACTION IOR LINKED TO REFL. IOR SLOT!
		if r.texmapIor != undefined then(
			r.texmapOnIor = origMtl.texmap_refractionIOR_on --(Use_IOR_map) : boolean
			r.texmapAmountIor = origMtl.texmap_refractionIOR_multiplier --(IOR_amount) : float
		)
		r.refractGlossiness = (if VrayConvertGlossyValues then(1.0 - sqrt(1.0 - origMtl.refraction_glossiness)) else(origMtl.refraction_glossiness)) --(Refraction_bluriness) : float
		r.texmapRefractGlossiness = origMtl.texmap_refractionGlossiness --(refract_blur) : texturemap
		if r.texmapRefractGlossiness != undefined then(
			r.texmapOnRefractGlossiness = origMtl.texmap_refractionGlossiness_on --(usemap_refract_blur) : boolean
			r.texmapAmountRefractGlossiness = origMtl.texmap_refractionGlossiness_multiplier / 100.0 --(Refract_map_glossiness_amount) : float
		)
		
		--Opacity
		r.levelOpacity = 1.0 --(opacity_level) : float
		r.colorOpacity = (color 255 255 255) --(Opacity_Color) : RGB color
		r.texmapOpacity = origMtl.texmap_opacity --(opacity_texmap) : texturemap
		if r.texmapOpacity != undefined then(
			r.texmapOnOpacity = origMtl.texmap_opacity_on --(usemap_opacity) : boolean
			r.texmapAmountOpacity = origMtl.texmap_opacity_multiplier / 100.0 --(Opacity_map_amount) : float
		)
		
		--Bumpmap
		r.texmapBump = origMtl.texmap_bump --(bump_texmap) : texturemap
		if r.texmapBump != undefined then(
			r.texmapOnBump = origMtl.texmap_bump_on --(usemap_bump) : boolean
			r.texmapAmountBump = if  origMtl.texmap_bump_multiplier < 0.0 then -(origMtl.texmap_bump_multiplier / 30.0) else origMtl.texmap_bump_multiplier / 30.0 --(Bump_map_amount) : float
		)
		
		--Absorption
		if origMtl.refraction_fogColor != white then(
			r.attenuation = 1.0/origMtl.refraction_fogMult --(Material_attenuation) : worldUnits
			r.attenuationTint = origMtl.refraction_fogColor --(Attenuation_tint) : RGB color
		)
		
		--Anisotropy
		r.anisotropy = origMtl.anisotropy --(Anisotropy) : float
		r.texmapAnisotropy = origMtl.texmap_anisotropy --(Texmap_anisotropy) : texturemap
		if r.texmapAnisotropy != undefined then(
			r.texmapOnAnisotropy = origMtl.texmap_anisotropy_on --(Use_anisotropy_map) : boolean
			r.texmapAmountAnisotropy = origMtl.texmap_anisotropy_multiplier / 100.0 --(Anisotropy_map_amount) : float
		)
		r.anisotropyRotation = origMtl.anisotropy_rotation --(Anisotropic_rotation) : float
		r.texmapAnisotropyRotation = origMtl.texmap_anisotropy_rotation --(Anisotropy_rotation_texture) : texturemap
		if r.texmapAnisotropyRotation != undefined then(
			r.texmapOnAnisotropyRotation = origMtl.texmap_anisotropy_rotation_on --(Use_aniso_rotation_map) : boolean
			r.texmapAmountAnisotropyRotation = origMtl.texmap_anisotropy_rotation_multiplier / 100.0 --(Aniso_rotation_map_amount) : float
		)
		
		--Displacement
		r.texmapDisplace = origMtl.texmap_displacement --(Displace_texmap) : texturemap
		if r.texmapDisplace != undefined then(
			r.texmapOnDisplace = origMtl.texmap_displacement_on --(Use_Displace_map) : boolean
			--r.texmapAmountDisplace = origMtl.texmap_displacement_multiplier / 100.0 --(Displace_amount) : worldUnits
		)
		
		if CorConvDEBUGmode then(
			DebugCoronaMTL r (classof origMtl)
		)
		r
	)

	
	-- ############## VRay Carpaint Material ################
	fn convertFrom_VRayCarPaintMtl origMtl =(
		cpbaseMtl=CoronaMtl()
		cpbaseMtl.name = (if addCoronaPrefix then UserPrefixStr else "") + origMtl.name
		if origMtl.coat_strength > 0.0 then(
			cpbaseMtl.name = (if addCoronaPrefix then UserPrefixStr else "") + (origMtl.name + "_Base")
			cpCoatMtl=CoronaMtl()
			cpCoatMtl.name = (if addCoronaPrefix then UserPrefixStr else "") + (origMtl.name + "_Coat")
			cpBlendMtl=Blend()
			cpBlendMtl.name = (if addCoronaPrefix then UserPrefixStr else "") + origMtl.name
		)
		
		--Base Diffuse
		cpbaseMtl.levelDiffuse = 1.0 --(Diffuse_level) : float
		cpbaseMtl.colorDiffuse = origMtl.base_color --(Diffuse_color) : RGB color
		cpbaseMtl.texmapDiffuse = origMtl.texmap_base_color --(Diffuse_texture) : texturemap
		if cpbaseMtl.texmapDiffuse != undefined then(
			cpbaseMtl.texmapOnDiffuse = origMtl.texmap_base_color_on --(usemap_diffuse) : boolean
			cpbaseMtl.texmapAmountDiffuse = origMtl.texmap_base_color_multiplier / 100.0 --(Diffuse_map_amount) : float
		)
		--Base Reflection
		cpbaseMtl.levelReflect = origMtl.base_reflection --(reflect_level) : float
		cpbaseMtl.colorReflect = origMtl.base_color --(Reflection_color) : RGB color
		cpbaseMtl.texmapReflect = origMtl.texmap_base_reflection --(reflection_texture) : texturemap
		if cpbaseMtl.texmapReflect != undefined then(
			cpbaseMtl.texmapOnReflect = origMtl.texmap_base_reflection_on --(usemap_reflect) : boolean
			cpbaseMtl.texmapAmountReflect = origMtl.texmap_base_reflection_multiplier / 100.0 --(Reflect_map_amount) : float
		)
		cpbaseMtl.fresnelIor = 50.0 --(reflect_fresnel) : float
		cpbaseMtl.reflectGlossiness = (if VrayConvertGlossyValues then(1.0 - sqrt(1.0 - origMtl.base_glossiness)) else(origMtl.base_glossiness) ) --(Reflection_bluriness) : float
		cpbaseMtl.texmapReflectGlossiness = origMtl.texmap_base_glossiness --(Reflection_blur) : texturemap
		if cpbaseMtl.texmapReflectGlossiness != undefined then(
			cpbaseMtl.texmapOnReflectGlossiness = origMtl.texmap_base_glossiness_on --(reflect_blur_usemap) : boolean
			cpbaseMtl.texmapAmountReflectGlossiness = origMtl.texmap_base_glossiness_multiplier / 100.0 --(Reflect_map_glossiness_amount) : float
		)
		--Base Bumpmap
		cpbaseMtl.texmapBump = origMtl.texmap_base_bump --(bump_texmap) : texturemap
		if cpbaseMtl.texmapBump != undefined then(
			cpbaseMtl.texmapOnBump = origMtl.texmap_base_bump_on --(usemap_bump) : boolean
			cpbaseMtl.texmapAmountBump = if origMtl.texmap_base_bump_multiplier < 0.0 then -(origMtl.texmap_base_bump_multiplier / 30.0) else origMtl.texmap_base_bump_multiplier / 30.0  --(Bump_map_amount) : float
		)
		
		
		if cpBlendMtl != undefined then(
			--Coat Diffuse
			cpCoatMtl.levelDiffuse = 1.0 --(Diffuse_level) : float
			cpCoatMtl.colorDiffuse = (color 0 0 0)  --(Diffuse_color) : RGB color
			--Coat Reflection
			cpCoatMtl.levelReflect = 1.0 --(reflect_level) : float
			cpCoatMtl.colorReflect = origMtl.coat_color --(Reflection_color) : RGB color
			cpCoatMtl.texmapReflect = origMtl.texmap_coat_color --(reflection_texture) : texturemap
			if cpCoatMtl.texmapReflect != undefined then(
				cpCoatMtl.texmapOnReflect = origMtl.texmap_coat_color_on --(usemap_reflect) : boolean
				cpCoatMtl.texmapAmountReflect = origMtl.texmap_coat_color_multiplier / 100.0 --(Reflect_map_amount) : float
			)
			cpCoatMtl.fresnelIor = 25.0 --(reflect_fresnel) : float
			cpCoatMtl.reflectGlossiness = (if VrayConvertGlossyValues then(1.0 - sqrt(1.0 - origMtl.coat_glossiness)) else(origMtl.coat_glossiness) ) --(Reflection_bluriness) : float
			cpCoatMtl.texmapReflectGlossiness = origMtl.texmap_coat_glossiness --(Reflection_blur) : texturemap
			if cpCoatMtl.texmapReflectGlossiness != undefined then(
				cpCoatMtl.texmapOnReflectGlossiness = origMtl.texmap_coat_glossiness_on --(reflect_blur_usemap) : boolean
				cpCoatMtl.texmapAmountReflectGlossiness = origMtl.texmap_coat_glossiness_multiplier / 100.0 --(Reflect_map_glossiness_amount) : float
			)
			--Coat Bumpmap
			cpCoatMtl.texmapBump = origMtl.texmap_coat_bump --(bump_texmap) : texturemap
			if cpCoatMtl.texmapBump != undefined then(
				cpCoatMtl.texmapOnBump = origMtl.texmap_coat_bump_on --(usemap_bump) : boolean
				cpCoatMtl.texmapAmountBump = if origMtl.texmap_coat_bump_multiplier < 0.0 then -(origMtl.texmap_coat_bump_multiplier / 30.0) else origMtl.texmap_coat_bump_multiplier / 30.0 --(Bump_map_amount) : float
			)
			
			cpBlendMtl.MAP1 = cpbaseMtl
			cpBlendMtl.MAP2 = cpCoatMtl
			cpBlendMtl.mixAmount = origMtl.coat_strength*100.0
			if origMtl.texmap_coat_strength != undefined then(
				cpBlendMtl.maskEnabled = origMtl.texmap_coat_strength_on 
				cpBlendMtl.Mask = origMtl.texmap_coat_strength
			)
			
			if CorConvDEBUGmode then(
				DebugCoronaMTL cpbaseMtl (classof origMtl)
			)
			if CorConvDEBUGmode then(
				DebugCoronaMTL cpCoatMtl (classof origMtl)
			)
			cpBlendMtl
		)
		else(
			if CorConvDEBUGmode then(
				DebugCoronaMTL cpbaseMtl (classof origMtl)
			)
			cpbaseMtl
		)
	)
	
	
	-- ############## MR Car_Paint_Material ################ 
	fn convertFrom_MRCarPaintMaterial origMtl =(
		cpbaseMtl=CoronaMtl()
		cpbaseMtl.name = (if addCoronaPrefix then UserPrefixStr else "") + (origMtl.name + "_Base")
		cpCoatMtl=CoronaMtl()
		cpCoatMtl.name = (if addCoronaPrefix then UserPrefixStr else "") + (origMtl.name + "_Coat")
		cpBlendMtl=Blend()
		cpBlendMtl.name = (if addCoronaPrefix then UserPrefixStr else "") + origMtl.name
		
		--Base Diffuse
		cpbaseMtl.levelDiffuse = 1.0 --(Diffuse_level) : float
		cpbaseMtl.colorDiffuse = (color 0 0 0)--(Diffuse_color) : RGB color
		cpbaseMtl.texmapDiffuse = falloff() --(Diffuse_texture) : texturemap
		cpbaseMtl.texmapOnDiffuse = true
		cpbaseMtl.texmapDiffuse.color1 = origMtl.base_color
		cpbaseMtl.texmapDiffuse.color2 = origMtl.edge_color
		cpbaseMtl.texmapDiffuse.MAP1 = origMtl.base_color_shader
		cpbaseMtl.texmapDiffuse.MAP2 = origMtl.edge_color_shader
		
		--Base Reflection
		cpbaseMtl.levelReflect = 1.0 --(reflect_level) : float
		cpbaseMtl.texmapReflect = cpbaseMtl.texmapDiffuse
		cpbaseMtl.fresnelIor = 2.5 --(reflect_fresnel) : float
		cpbaseMtl.reflectGlossiness = 0.3
		
		--Coat Diffuse
		cpCoatMtl.levelDiffuse = 1.0 --(Diffuse_level) : float
		cpCoatMtl.colorDiffuse = (color 0 0 0)  --(Diffuse_color) : RGB color
		--Coat Reflection
		cpCoatMtl.levelReflect = 1.0 --(reflect_level) : float
		cpCoatMtl.colorReflect = origMtl.reflection_color --(Reflection_color) : RGB color
		cpCoatMtl.fresnelIor = 2.5 --(reflect_fresnel) : float
		
		cpBlendMtl.MAP1 = cpbaseMtl
		cpBlendMtl.MAP2 = cpCoatMtl
		cpBlendMtl.mixAmount = 20.0
		
		if CorConvDEBUGmode then(
			DebugCoronaMTL cpbaseMtl (classof origMtl)
		)
		if CorConvDEBUGmode then(
			DebugCoronaMTL cpCoatMtl (classof origMtl)
		)
		cpBlendMtl
	)
	
	-- ############## MR_ArchAndDesign Material ################
	fn convertFrom_ArchAndDesign origMtl =(
		r=CoronaMtl()
		r.name=(if addCoronaPrefix then UserPrefixStr else "") + origMtl.name
		
		--Diffuse
		r.levelDiffuse = origMtl.diff_weight --(Diffuse_level) : float
		r.colorDiffuse = (color origMtl.diff_color.r origMtl.diff_color.g origMtl.diff_color.b)  -- is not converting rgba colors, therefore r,g,b seperation --(Diffuse_color) : RGB color
		r.texmapDiffuse = origMtl.diff_color_map --(Diffuse_texture) : texturemap
		if r.texmapDiffuse != undefined then(
			r.texmapOnDiffuse = origMtl.diff_color_map_on --(usemap_diffuse) : boolean
		)
		
		--Reflection
		r.levelReflect = origMtl.refl_weight --(reflect_level) : float
		r.colorReflect = (color origMtl.refl_color.r origMtl.refl_color.g origMtl.refl_color.b) --(Reflection_color) : RGB color
		r.texmapReflect = origMtl.refl_color_map --(reflection_texture) : texturemap
		if r.texmapReflect != undefined then(
			r.texmapOnReflect = origMtl.refl_color_map_on   --(usemap_reflect) : boolean
		)
		r.fresnelIor = if origMtl.refr_ior < 1.0 then 1.0 else origMtl.refr_ior  -- must use refraction ior since there is no seperate ior setting for reflection, maybe i'll add some "conversion" later --(reflect_fresnel) : float
		r.texmapFresnelIor = origMtl.refr_ior_map --(Fresnel_IOR_texmap) : texturemap
		if r.texmapFresnelIor != undefined then(
			r.texmapOnFresnelIor = (origMtl.refr_ior_map_on AND origMtl.refl_func_fresnel)  -- only active when global ior map on AND brdf radiobutton set to "by IOR"  --(Use_Fresnel_IOR_map) : boolean
		)
		r.reflectGlossiness = origMtl.refl_gloss   --(Reflection_bluriness) : float
		r.texmapReflectGlossiness = origMtl.refl_gloss_map --(Reflection_blur) : texturemap
		if r.texmapReflectGlossiness != undefined then(
			r.texmapOnReflectGlossiness = origMtl.refl_gloss_map_on --(reflect_blur_usemap) : boolean
		)
		
		--Refraction
		r.levelRefract = origMtl.refr_weight --(refract_level) : float
		r.colorRefract = (color origMtl.refr_color.r origMtl.refr_color.g origMtl.refr_color.b)  --(Refraction_color) : RGB color
		r.texmapRefract = origMtl.refr_color_map --(reflect_texmap) : texturemap
		if r.texmapRefract != undefined then(
			r.texmapOnRefract = origMtl.refr_color_map_on  --(usemap_refract) : boolean
		)
		r.ior = if origMtl.refr_ior < 1.0 then 1.0 else(if origMtl.refr_ior > 10.0 then 10.0 else origMtl.refr_ior) --(Index_of_refraction) : float
		r.texmapIor = origMtl.refr_ior_map --(IOR_texmap) : texturemap
		if r.texmapIor != undefined then(
			r.texmapOnIor = origMtl.refr_color_map_on --(Use_IOR_map) : boolean
		)
		r.refractGlossiness = origMtl.refr_gloss --(Refraction_bluriness) : float
		r.texmapRefractGlossiness = origMtl.refr_gloss_map --(refract_blur) : texturemap
		if r.texmapRefractGlossiness != undefined then(
			r.texmapOnRefractGlossiness = origMtl.refr_gloss_map_on --(usemap_refract_blur) : boolean
		)
		
		-- Glassmode
		if origMtl.opts_1sided == off then() else r.twosidedGlass = true
		
		--Translucency
		if origMtl.refr_trans_on == false then(
			r.levelTranslucency = 0.0
		)
		else(
			--r.levelTranslucency = origMtl.refr_transw
			r.levelTranslucency = origMtl.refr_weight
			r.levelRefract = (1- origMtl.refr_transw)
		)
		r.colorTranslucency = (color origMtl.refr_transc.r origMtl.refr_transc.g origMtl.refr_transc.b) --(Translucency_color) : RGB color
		r.texmapTranslucency = origMtl.refr_transc_map --(Translucency_texmap) : texturemap
		if r.texmapTranslucency != undefined then(
			r.texmapOnTranslucency = origMtl.refr_transc_map_on --(Translucency_usemap) : boolean
		)
		
		--Opacity
		r.levelOpacity = 1.0 --(opacity_level) : float
		r.colorOpacity = (color 255 255 255) --(Opacity_Color) : RGB color
		r.texmapOpacity = origMtl.cutout_map --(opacity_texmap) : texturemap
		if r.texmapOpacity != undefined then(
			r.texmapOnOpacity = origMtl.cutout_map_on --(usemap_opacity) : boolean
		)
		
		--Emission
		--r.emissionOn = origMtl.self_illum_on --: boolean
		if origMtl.self_illum_on then r.levelSelfIllum = origMtl.self_illum_int_arbitrary --(emission_level) : float
		r.colorSelfIllum = (color origMtl.self_illum_color_filter.r origMtl.self_illum_color_filter.g origMtl.self_illum_color_filter.b) --(Emission_color) : RGB color
		r.texmapSelfIllum = origMtl.self_illum_map --(Emission_texmap) : texturemap
		if r.texmapSelfIllum != undefined then(
			r.texmapOnSelfIllum = origMtl.self_illum_map_on --(Emission_usemap) : boolean
		)
		
		--Bumpmap
		r.texmapBump = origMtl.bump_map --(bump_texmap) : texturemap
		if r.texmapBump != undefined then(
			r.texmapOnBump = origMtl.bump_map_on --(usemap_bump) : boolean
			r.texmapAmountBump = if origMtl.bump_map_amt < 0.0 then -(origMtl.bump_map_amt * (1.0/0.3)) else origMtl.bump_map_amt * (1.0/0.3) -- this one will match MRs default of 0.3 bumpmap amount to fit coronas 1.0 --(Bump_map_amount) : float
		)
		
		--Absorption     -- Not sure if Refraction Distance advanced options ok here
		-- r.attenuation --(Material_attenuation) : worldUnits
		-- r.attenuationTint --(Attenuation_tint) : RGB color
		
		--RoundedCorners
		if origMtl.opts_round_corners_on then(r.roundedCornersRadius = origMtl.opts_round_corners_radius)else(r.roundedCornersRadius = 0.0)
		
		--Anisotropy
		r.anisotropy = if origMtl.anisotropy >= 1.0 then((origMtl.anisotropy-1.0)/9.0)else(origMtl.anisotropy-1.0)   --(Anisotropy) : float
		r.texmapAnisotropy = origMtl.anisotropy_map --(Texmap_anisotropy) : texturemap
		if r.texmapAnisotropy != undefined then(
			r.texmapOnAnisotropy = origMtl.anisotropy_map_on --(Use_anisotropy_map) : boolean
		)
		r.anisotropyRotation = origMtl.anisoangle --(Anisotropic_rotation) : float
		r.texmapAnisotropyRotation = origMtl.anisoangle_map --(Anisotropy_rotation_texture) : texturemap
		if r.texmapAnisotropyRotation != undefined then(
			r.texmapOnAnisotropyRotation = origMtl.anisoangle_map_on --(Use_aniso_rotation_map) : boolean
		)
		--Displacement
		r.texmapDisplace = origMtl.displacement_map --(Displace_texmap) : texturemap
		if r.texmapDisplace != undefined then(
			r.texmapOnDisplace = origMtl.displacement_map_on --(Use_Displace_map) : boolean
			--r.texmapAmountDisplace= origMtl.displacement_map_amt --(Displace_amount) : worldUnits
		)
		
		if CorConvDEBUGmode then(
			DebugCoronaMTL r (classof origMtl)
		)
		r
	)
	
	-- ############## fR Advanced Material ################
	fn convertFrom_fR_Advanced origMtl =(
		r=CoronaMtl()
		r.name=(if addCoronaPrefix then UserPrefixStr else "") + origMtl.name
		
		--Diffuse
		r.levelDiffuse = if origMtl.diffuseMultiplier > 100.0 then(1.0) else (origMtl.diffuseMultiplier / 100.0)  --(Diffuse_level) : float
		r.colorDiffuse = origMtl.diffuseColor --(Diffuse_color) : RGB color
		r.texmapDiffuse = origMtl.diffuseMap --(Diffuse_texture) : texturemap
		if r.texmapDiffuse != undefined then(
			r.texmapOnDiffuse = origMtl.useDiffuseMap --(usemap_diffuse) : boolean
			r.texmapAmountDiffuse = origMtl.diffuseMapAmount /100.0 --(Diffuse_map_amount) : float
		)
		
		--Reflection
		r.levelReflect = 1.0 --(reflect_level) : float
		r.colorReflect = origMtl.reflectFilter --(Reflection_color) : RGB color
		r.texmapReflect = origMtl.reflectMap --(reflection_texture) : texturemap
		if r.texmapReflect != undefined then(
			r.texmapOnReflect = origMtl.useReflectMap --(usemap_reflect) : boolean
			r.texmapAmountReflect = origMtl.reflectMapAmount / 100.0 --(Reflect_map_amount) : float
		)
		r.fresnelIor = if origMtl.reflectIOR < 1.0 then 1.0 else origMtl.reflectIOR --(reflect_fresnel) : float
		r.texmapFresnelIor = origMtl.reflectIORMap --(Fresnel_IOR_texmap) : texturemap
		if r.texmapFresnelIor != undefined then(
			r.texmapOnFresnelIor = origMtl.useReflectIORMap --(Use_Fresnel_IOR_map) : boolean
			r.texmapAmountFresnelIor = origMtl.reflectIORMapAmount / 100.0 --(Fresnel_IOR_amount) : float
		)
		r.reflectGlossiness = (1.0-(origMtl.reflectGlossy /100.0)) --(Reflection_bluriness) : float
		r.texmapReflectGlossiness = origMtl.reflectBlurryMap --(Reflection_blur) : texturemap			-- !! Might want to add a invert map here to match others engines 1-0 range !!
		if r.texmapReflectGlossiness != undefined then(
			r.texmapOnReflectGlossiness = origMtl.useReflectBlurryMap --(reflect_blur_usemap) : boolean
			r.texmapAmountReflectGlossiness = origMtl.reflectBlurryMapAmount / 100.0 --(Reflect_map_glossiness_amount) : float
		)
		
		--Refraction
		r.levelRefract = 1.0 --(refract_level) : float
		r.colorRefract = origMtl.refractFilter --(Refraction_color) : RGB color
		r.texmapRefract = origMtl.refractMap --(reflect_texmap) : texturemap
		if r.texmapRefract != undefined then(
			r.texmapOnRefract = origMtl.useRefractMap --(usemap_refract) : boolean
			r.texmapAmountRefract = origMtl.refractMapAmount / 100.0 --(Refract_map_amount) : float
		)
		r.ior = if origMtl.refractIOR < 1.0 then 1.0 else(if origMtl.refractIOR > 10.0 then 10.0 else origMtl.refractIOR) --(Index_of_refraction) : float
		r.texmapIor = origMtl.refractIORMap --(IOR_texmap) : texturemap
		if r.texmapIor != undefined then(
			r.texmapOnIor = origMtl.useRefractIORMap --(Use_IOR_map) : boolean
			r.texmapAmountIor = origMtl.refractIORMapAmount / 100.0 --(IOR_amount) : float
		)
		r.refractGlossiness = (1.0-(origMtl.refractGlossy /100.0))--(Refraction_bluriness) : float
		r.texmapRefractGlossiness = origMtl.refractBlurryMap --(refract_blur) : texturemap
		if r.texmapRefractGlossiness != undefined then(
			r.texmapOnRefractGlossiness = origMtl.useRefractBlurryMap --(usemap_refract_blur) : boolean
			r.texmapAmountRefractGlossiness = origMtl.refractBlurryMapAmount / 100.0 --(Refract_map_glossiness_amount) : float
		)
		
		--Opacity
		r.levelOpacity = 1.0 --(opacity_level) : float
		r.colorOpacity = (color 255 255 255) --(Opacity_Color) : RGB color
		r.texmapOpacity = origMtl.opacityMap--(opacity_texmap) : texturemap
		if r.texmapOpacity != undefined then(
			r.texmapOnOpacity = origMtl.useOpacityMap --(usemap_opacity) : boolean
			r.texmapAmountOpacity = origMtl.opacityMapAmount / 100.0 --(Opacity_map_amount) : float
		)
		
		--Emission
		--r.emissionOn = (if (origMtl.selfIllum != (color 0 0 0)) OR (origMtl.selfillumMap != undefined AND origMtl.useSelfIllumMap == true) then true else false) --: boolean 
		r.levelSelfIllum = origMtl.selfIllumMultiplier/100.0 --(emission_level) : float
		r.colorSelfIllum = origMtl.selfIllum --(Emission_color) : RGB color
		r.texmapSelfIllum = origMtl.selfillumMap --(Emission_texmap) : texturemap
		if r.texmapSelfIllum != undefined then(
			r.texmapOnSelfIllum = origMtl.useSelfIllumMap --(Emission_usemap) : boolean
			r.texmapAmountSelfIllum = origMtl.selfillumMapAmount/100.0 --(Emission_mapamount) : float
		)
		
		--Bumpmap
		r.texmapBump = origMtl.bumpMap --(bump_texmap) : texturemap
		if r.texmapBump != undefined then(
			r.texmapOnBump = origMtl.useBumpMap --(usemap_bump) : boolean
			r.texmapAmountBump = if origMtl.bumpMapAmount < 0.0 then -(origMtl.bumpMapAmount/30.0) else origMtl.bumpMapAmount/30.0 --(Bump_map_amount) : float
		)
		
		--Absorption
		if origMtl.useRefrAbsorption == true then(
			r.attenuation = origMtl.refrAbsorption --(Material_attenuation) : worldUnits
			r.attenuationTint = origMtl.refrAbsorpColor --(Attenuation_tint) : RGB color
		)
		
		--Anisotropy
		r.anisotropy = origMtl.Anisotropic/100.0--(Anisotropy) : float
		r.texmapAnisotropy = origMtl.anisoAmountReflectionMap --(Texmap_anisotropy) : texturemap
		if r.texmapAnisotropy != undefined then(
			r.texmapOnAnisotropy = origMtl.useAnisoAmountReflectionMap --(Use_anisotropy_map) : boolean
			r.texmapAmountAnisotropy = origMtl.anisoAmountReflectionMapAmount/100.0 --(Anisotropy_map_amount) : float
		)
		r.anisotropyRotation = origMtl.orientation --(Anisotropic_rotation) : float
		r.texmapAnisotropyRotation = origMtl.anisoOrientationReflectionMap --(Anisotropy_rotation_texture) : texturemap
		if r.texmapAnisotropyRotation != undefined then(
			r.texmapOnAnisotropyRotation = origMtl.useAnisoOrientationReflectionMap --(Use_aniso_rotation_map) : boolean
			r.texmapAmountAnisotropyRotation = origMtl.anisoOrientationReflectionMapAmount/100.0 --(Aniso_rotation_map_amount) : float
		)
		--Displacement
		r.texmapDisplace = origMtl.MTDMap --(Displace_texmap) : texturemap
		if r.texmapDisplace != undefined then(
			r.texmapOnDisplace = origMtl.useMTDMap --(Use_Displace_map) : boolean
			--r.texmapAmountDisplace = origMtl.MTDMapAmount / 100.0 --(Displace_amount) : worldUnits
		)
		
		if CorConvDEBUGmode then(
			DebugCoronaMTL r (classof origMtl)
		)
		r
	)
	
	
	-- ############## fR Architectural Material ################
	fn convertFrom_fR_Architectural origMtl =(
		r=CoronaMtl()
		r.name=(if addCoronaPrefix then UserPrefixStr else "") + origMtl.name
		
		--Diffuse
		r.levelDiffuse = if origMtl.diffuse_weight > 1.0 then(1.0) else(origMtl.diffuse_weight)--(Diffuse_level) : float
		r.colorDiffuse = origMtl.diffuse_color --(Diffuse_color) : RGB color
		r.texmapDiffuse = origMtl.diffcolor_map --(Diffuse_texture) : texturemap
		if r.texmapDiffuse != undefined then(
			r.texmapOnDiffuse = origMtl.use_diffcolor_map --(usemap_diffuse) : boolean
		)
		
		--Reflection
		r.levelReflect = origMtl.reflectivity --(reflect_level) : float
		r.colorReflect = (color origMtl.refl_color.r origMtl.refl_color.g origMtl.refl_color.b) --(Reflection_color) : RGB color
		r.texmapReflect = origMtl.reflcolor_map --(reflection_texture) : texturemap
		if r.texmapReflect != undefined then(
			r.texmapOnReflect = origMtl.use_reflcolor_map --(usemap_reflect) : boolean
		)
		r.fresnelIor = if origMtl.refr_ior < 1.0 then 1.0 else origMtl.refr_ior -- must use refraction ior since there is no seperate ior setting for reflection, maybe i'll add some "conversion" later --(reflect_fresnel) : float
		r.texmapFresnelIor = origMtl.ior_map --(Fresnel_IOR_texmap) : texturemap
		if r.texmapFresnelIor != undefined then(
			r.texmapOnFresnelIor = (origMtl.use_ior_map AND origMtl.brdf_fresnel)  -- only active when global ior map on AND brdf radiobutton set to "by IOR"  --(Use_Fresnel_IOR_map) : boolean
		)
		r.reflectGlossiness = origMtl.refl_gloss   --(Reflection_bluriness) : float
		r.texmapReflectGlossiness = origMtl.reflgloss_map --(Reflection_blur) : texturemap
		if r.texmapReflectGlossiness != undefined then(
			r.texmapOnReflectGlossiness = origMtl.use_reflgloss_map --(reflect_blur_usemap) : boolean
		)
		
		--Refraction
		r.levelRefract = origMtl.transparency --(refract_level) : float
		r.colorRefract = (color origMtl.refr_color.r origMtl.refr_color.g origMtl.refr_color.b)  --(Refraction_color) : RGB color
		r.texmapRefract = origMtl.refrcolor_map --(reflect_texmap) : texturemap
		if r.texmapRefract != undefined then(
			r.texmapOnRefract = origMtl.use_refrcolor_map  --(usemap_refract) : boolean
		)
		r.ior = if origMtl.refr_ior < 1.0 then 1.0 else(if origMtl.refr_ior > 10.0 then 10.0 else origMtl.refr_ior) --(Index_of_refraction) : float
		r.texmapIor = origMtl.ior_map --(IOR_texmap) : texturemap
		if r.texmapIor != undefined then(
			r.texmapOnIor = origMtl.use_ior_map --(Use_IOR_map) : boolean
		)
		r.refractGlossiness = origMtl.refr_gloss --(Refraction_bluriness) : float
		r.texmapRefractGlossiness = origMtl.refrgloss_map --(refract_blur) : texturemap
		if r.texmapRefractGlossiness != undefined then(
			r.texmapOnRefractGlossiness = origMtl.use_refrgloss_map --(usemap_refract_blur) : boolean
		)
		
		-- Glassmode
		r.twosidedGlass = if origMtl.thin_walled == 0 then false else true
		
		--Translucency
		if origMtl.refr_translucency == false then(
			r.levelTranslucency = 0.0
		)
		else(
			--r.levelTranslucency = origMtl.refr_transw
			r.levelTranslucency = origMtl.transparency
			r.levelRefract = (1- origMtl.refr_trans_weight)
		)
		r.colorTranslucency = (color origMtl.refr_trans_color.r origMtl.refr_trans_color.g origMtl.refr_trans_color.b) --(Translucency_color) : RGB color
		r.texmapTranslucency = origMtl.transcolor_map --(Translucency_texmap) : texturemap
		if r.texmapTranslucency != undefined then(
			r.texmapOnTranslucency = origMtl.use_transcolor_map --(Translucency_usemap) : boolean
		)
		
		--Opacity
		r.levelOpacity = 1.0 --(opacity_level) : float
		r.colorOpacity = (color 255 255 255) --(Opacity_Color) : RGB color
		r.texmapOpacity = origMtl.cutout_map--(opacity_texmap) : texturemap
		if r.texmapOpacity != undefined then(
			r.texmapOnOpacity = origMtl.use_cutout_map --(usemap_opacity) : boolean
		)
		
		--Emission
		--r.emissionOn = origMtl.self_illumination_on --: boolean
		if origMtl.self_illumination_on then r.levelSelfIllum = origMtl.self_illum_intensity --(emission_level) : float
		r.colorSelfIllum = (color origMtl.self_illum_filter.r origMtl.self_illum_filter.g origMtl.self_illum_filter.b) --(Emission_color) : RGB color
		r.texmapSelfIllum = origMtl.selfillum_map --(Emission_texmap) : texturemap
		if r.texmapSelfIllum != undefined then(
			r.texmapOnSelfIllum = origMtl.use_selfillum_map --(Emission_usemap) : boolean
		)
		
		--Bumpmap
		r.texmapBump = origMtl.bump_map --(bump_texmap) : texturemap
		if r.texmapBump != undefined then(
			r.texmapOnBump = origMtl.use_bump_map --(usemap_bump) : boolean
			r.texmapAmountBump = if origMtl.bump_map_amount < 0.0 then -(origMtl.bump_map_amount * (1.0/0.3)) else origMtl.bump_map_amount * (1.0/0.3) --(Bump_map_amount) : float
		)
 		--Absorption
		--r.attenuation = origMtl. --(Material_attenuation) : worldUnits
		--r.attenuationTint = origMtl. --(Attenuation_tint) : RGB color
		
		--RoundedCorners
		if origMtl.roundcorners_on then(r.roundedCornersRadius = origMtl.roundcorners_radius)else(r.roundedCornersRadius = 0.0)
		
		--Anisotropy
		r.anisotropy = if origMtl.anisotropy > 1.0 then((origMtl.anisotropy-1.0)/9.0)else(origMtl.anisotropy-1.0) --(Anisotropy) : float
		r.texmapAnisotropy = origMtl.anisotropy_map --(Texmap_anisotropy) : texturemap
		if r.texmapAnisotropy != undefined then(
			r.texmapOnAnisotropy = origMtl.use_anisotropy_map --(Use_anisotropy_map) : boolean
		)
		r.anisotropyRotation = origMtl.anisotropy_rotation --(Anisotropic_rotation) : float
		r.texmapAnisotropyRotation = origMtl.anisorot_map --(Anisotropy_rotation_texture) : texturemap
		if r.texmapAnisotropyRotation != undefined then(
			r.texmapOnAnisotropyRotation = origMtl.use_anisorot_map --(Use_aniso_rotation_map) : boolean
		)
		
		--Displacement
		r.texmapDisplace = origMtl.displacement_map --(Displace_texmap) : texturemap
		if r.texmapDisplace != undefined then(
			r.texmapOnDisplace = origMtl.use_displacement_map --(Use_Displace_map) : boolean
			--r.texmapAmountDisplace = origMtl.displacement_map_amount --(Displace_amount) : worldUnits
		)
		
		if CorConvDEBUGmode then(
			DebugCoronaMTL r (classof origMtl)
		)
		r
	)
	
	-- ############## Autodesk Materials ################
	fn convertFrom_AutodeskMtl origMtl =(
		AD_mats_found = true
		matName = origMtl.name
		if origMtl.definitionID != "Generic" then(
			origMtl = origMtl.ConvertToGeneric 
		)
		r=CoronaMtl()
		r.name=(if addCoronaPrefix then UserPrefixStr else "") + matName
		
		--Diffuse
		r.colorDiffuse = origMtl.Generic_Color as color  
		r.texmapDiffuse = origMtl.Generic_Image --(Diffuse_texture) : texturemap
		if r.texmapDiffuse != undefined then(
			r.texmapOnDiffuse = true --(usemap_diffuse) : boolean
			r.texmapAmountDiffuse = origMtl.Generic_Image_Fade / 100.0
		)
		
		--Reflection
		if origMtl.Reflectivity_Enable then(
			r.levelReflect = origMtl.Reflectivity_Direct / 100.0--(reflect_level) : float
			if origMtl.Reflectivity_Direct_Option == 1 then r.texmapReflect = origMtl.Reflectivity_Direct_Map --(reflection_texture) : texturemap
			if r.texmapReflect != undefined then(
				r.texmapOnReflect = true   --(usemap_reflect) : boolean
			)
			r.fresnelIor = 20.0
		)
		r.reflectGlossiness = origMtl.Generic_Glossiness / 100.0   --(Reflection_bluriness) : float
		
		--Refraction
		if origMtl.Transparency_Enable then(
			r.levelRefract = origMtl.Transparency_Amount / 100.0 --(refract_level) : float
			r.colorRefract = white  --(Refraction_color) : RGB color
			r.texmapRefract = origMtl.Transparency_Image --(reflect_texmap) : texturemap
			if r.texmapRefract != undefined then(
				r.texmapOnRefract = true  --(usemap_refract) : boolean
				r.texmapAmountRefract = origMtl.Transparency_Image_Fade / 100.0
			)
			r.ior = origMtl.Transparency_Refraction
		)
		
		--Opacity
		if origMtl.Cutouts_Enable then(
			r.levelOpacity = 1.0 --(opacity_level) : float
			r.colorOpacity = (color 255 255 255) --(Opacity_Color) : RGB color
			r.texmapOpacity = origMtl.Cutouts_Image --(opacity_texmap) : texturemap
			if r.texmapOpacity != undefined then(
				r.texmapOnOpacity = origMtl.Cutouts_Enable   --cutout_map_on --(usemap_opacity) : boolean
			)
		)
		
		--Emission
		if origMtl.Self_Illumination_Enable then(
			r.levelSelfIllum = origMtl.Self_Illumination_Luminance / 100.0 --(emission_level) : float
			r.colorSelfIllum = origMtl.Self_Illumination_Filter_Color
			if origMtl.Self_Illumination_Filter_Color_Option == 1 then r.texmapSelfIllum = origMtl.Self_Illumination_Filter_Color_Map --(Emission_texmap) : texturemap
			if r.texmapSelfIllum != undefined then(
				r.texmapOnSelfIllum = true --(Emission_usemap) : boolean
			)
		)
		
		--Bumpmap
		if origMtl.Bump_Enable then(
			r.texmapBump = origMtl.Bump_Image --(bump_texmap) : texturemap
			if r.texmapBump != undefined then(
				r.texmapOnBump = true--(usemap_bump) : boolean
				r.texmapAmountBump = if abs (origMtl.bump_amount * 0.01 * 0.3) <= 0.3 then (origMtl.bump_amount * 0.01 * 0.3) else (if origMtl.bump_amount < 0 then -0.3 else 0.3)  -- clamp bump to 0.3 max
			)
		)
		
		r
	)
	
	
	-- ############## VrayBlend Material ################
	fn convertFrom_VrayBlendMtl origMtl =(
		if vrayblendToMultilayerdBlend then(
			r = blend()
			r.map1 = origMtl.baseMtl
			tmpNum = 1
			for i = 1 to origMtl.coatMtl.count do(
				if origMtl.coatMtl[i] != undefined then(
					tmpNum +=1
					if tmpNum > 2 then(
						r = blend map1:r map2:origMtl.coatMtl[i]
						r.mixAmount = origMtl.Blend[i].r/2.55
						if origMtl.texmap_blend[i] != undefined AND origMtl.texmap_blend_multiplier[i] != 0 then(
							r.Mask = origMtl.texmap_blend[i]
						)
					)
					else(
						r.map2 = origMtl.coatMtl[i]
						r.mixAmount = origMtl.Blend[i].r/2.55
						if origMtl.texmap_blend[i] != undefined AND origMtl.texmap_blend_multiplier[i] != 0 then(
							r.Mask = origMtl.texmap_blend[i]
						)
					)
				)
			)
		)
		else(
			r=(getSubMtl origMtl 1)
		)
		
		r
	)

	
	-- ############## VrayLight Material ################
	fn convertFrom_VrayLightMtl origMtl = (
		r=CoronaLightMtl()
		r.name=(if addCoronaPrefix then UserPrefixStr else "") + origMtl.name
		
		r.color = origMtl.color 
		r.multiplier = origMtl.multiplier
		r.emitLight = origMtl.directLight_on
		if origMtl.texmap != undefined then(
			r.texmapOn = origMtl.texmap_on
			r.texmap = origMtl.texmap
		)
		if origMtl.opacity_texmap != undefined then(
			r.opacityTexmapOn = origMtl.opacity_texmap_on
			r.opacityTexmap = origMtl.opacity_texmap
		)
		
		
		if CorConvDEBUGmode then(
			DebugCoronaMTL r (classof origMtl)
		)
		r
	)

	
	-- ############## Vray2Sided Material ################
	fn convertFrom_Vray2sidedMtl origMtl = (
		-- currently just taking 2sided mats slot 1 and setting translucency in material from 2sided options
		r=origMtl.frontMtl	
		try(
			r.twosidedGlass = true
			r.levelTranslucency = (origMtl.Translucency.r + origMtl.Translucency.g + origMtl.Translucency.b)/3/255
			
			if origMtl.texmap_translucency != undefined then(
				r.colorTranslucency = origMtl.Translucency  -- translucency color from 2sided transl.
				r.texmapTranslucency = origMtl.texmap_translucency
				r.texmapOnTranslucency = true
			)
			else(
				r.colorTranslucency = r.colorDiffuse  -- translucency color from diffuse
				
				if r.texmapDiffuse != undefined then(
					r.texmapTranslucency = r.texmapDiffuse 
					r.texmapOnTranslucency = true
				)
			)
			
		)catch()
		
		r
	)
	
	
	-- ############## VRayFastSSS2 Material ################
	fn convertFrom_VRayFastSSS origMtl = (
		r=CoronaMtl()
		r.name=(if addCoronaPrefix then UserPrefixStr else "") + origMtl.name
		
		r.colorDiffuse = origMtl.shallow_color
		
		r
	)
	
	
	-- ############## VRayFastSSS2 Material ################
	fn convertFrom_VRayFastSSS2 origMtl = (
		r=CoronaMtl()
		r.name=(if addCoronaPrefix then UserPrefixStr else "") + origMtl.name
		
		r.colorDiffuse = origMtl.overall_color
		r.levelReflect = origMtl.specular_amount
		r.colorReflect = origMtl.specular_color
		
		r
	)
	
	
	-- ############## VrayOverrideMtl Material ################
	fn convertFrom_VrayOverrideMtl origMtl = (
		r=CoronaRaySwitchMtl()
		r.name=(if addCoronaPrefix then UserPrefixStr else "") + origMtl.name
		
		r.directMtl = origMtl.baseMtl
		if origMtl.giMtl != undefined then r.baseMtl = origMtl.giMtl else r.baseMtl = r.directMtl
		r.reflectMtl = origMtl.reflectMtl
		r.refractMtl = origMtl.refractMtl
		
		r
	)
	
	
	-- ############## Shellac Material ################
	fn convertFrom_Shellac origMtl = (
		r=Blend()
		r.name=origMtl.name
		
		r.map1 = origMtl.shellacMtl1
		r.map2 = origMtl.shellacMtl2
		
		r
	)

	
	-- ############## DoubleSided Material ################
	fn convertFrom_DoubleSided origMtl = (
		r=Blend()
		r.name=origMtl.name
		
		r.map1 = origMtl.material1
		r.map2 = origMtl.material2
		
		r
	)
	
	-- ############## TopBottom Material ################
	fn convertFrom_TopBottom origMtl = (
		origMtl.topMaterial
	)
	
	
	
	fn ReplaceUnsupportedMaps blurInput: =(
		/*
		VRayColor
		VrayDirt
		VraySky
		VrayColor
		VRayCompTex
		VRayEdgesTex
		VRayGLSLTex
		VRayHDRI
		VRayMultiSubTex
		VRaySoftbox
		Normal_Bump
		VRayNormalMap
		Autodesk_Map
		*/
		-- Try expressions are important since not every user has vray/these maps installed
		
		if blurInput != unsupplied then(
			try(  -- Blur altering function
				for mp in (getClassInstances Bitmaptexture) do(
					if mp.coords.blur > blurInput then mp.coords.blur = blurInput
					--print blurInput
				)
			)catch()
		)
			
		try(
			for mp in (getClassInstances VRayColor) do(
				replaceInstances mp (CoronaSolidTex color:mp.color name:mp.name multiplier:mp.rgb_multiplier)
			)
		)catch()
		
		try(
			for mp in (getClassInstances VrayDirt) do(
				replaceInstances mp (
					crnAO = CoronaAo colorOccluded:mp.occluded_color colorUnoccluded:mp.unoccluded_color \
					maxDistance:mp.radius invert:mp.invert_normal texmapDistance:mp.texmap_radius texmapOccluded:mp.texmap_occluded_color \ 
					texmapUnoccluded:mp.texmap_unoccluded_color name:mp.name excludeMode:0
					
					if mp.includeList != undefined and mp.includeList.count != 0 then(
						crnAO.includeMod = true
						crnAO.excludeList = mp.includeList
						crnAO.excludeMode = 1
					)
					if mp.excludeList != undefined and mp.excludeList.count != 0 then(
						crnAO.includeMod = false
						crnAO.excludeList = mp.excludeList
						crnAO.excludeMode = 1
					)
					if mp.consider_same_object_only then crnAO.excludeMode = 3
					
					crnAO
				)
			)
		)catch()
		
		try(
			for mp in (getClassInstances Normal_Bump) do(
				replaceInstances mp (CoronaNormalTex multiplier:mp.mult_spin normalMap:mp.normal_map )
			)
		)catch()
		
		try(
			for mp in (getClassInstances VrayNormalMap) do(
				replaceInstances mp (CoronaNormalTex multiplier:1.0 normalMap:mp.normal_map )
			)
		)catch()
		
		try(
			for mp in (getClassInstances VraySky) do(
				replaceInstances mp (coronasky name:mp.name)
			)
		)catch()
		
		try(
			for mp in (getClassInstances VRayCompTex) do(  -- by: gover_gol (www.gg3dcg.ru)
				temp_CompositeTexturemap = CompositeTexturemap name:#(mp.name) mapList: #(mp.sourceA,mp.sourceB)
				temp_CompositeTexturemap.mapList = #(mp.sourceA,mp.sourceB)
				--temp_CompositeTexturemap.mapEnabled = #(true,true)
				temp_CompositeTexturemap.blendMode = case mp.operator of(
					0:#(0, 2)
					1:#(0, 3)
					2:#(0, 19)
					3:#(0, 5)
					4:(
						temp_CompositeTexturemap.mapList[2] = Color_Correction map:mp.sourceB rewireMode:2 
						#(0, 10)
					)
					5:#(0, 4)
					6:#(0, 8)
					default:#(0, 2)
				)
				replaceInstances mp temp_CompositeTexturemap
			)
			
			--for mp in (getClassInstances VRayCompTex) do(
			--	replaceInstances mp mp.sourceA
			--)
		)catch()
		
		try(
			for mp in (getClassInstances VRayEdgesTex) do(
				replaceInstances mp (CoronaWireTex edgeColor:mp.edgesColor widthMethod:(abs (mp.widthType-1)) worldWidth:mp.thickness screenWidth:mp.pixelWidth name:mp.name)
			)
		)catch()
		
		try(
			for mp in (getClassInstances VRayGLSLTex) do(
				replaceInstances mp (CoronaSolidTex color:(color 127 127 127) name:mp.name)
			)
		)catch()
		
		try(
			for mp in (getClassInstances VRaySoftbox) do(
				replaceInstances mp (CoronaSolidTex color:(color 255 255 255) name:mp.name)
			)
		)catch()
		
		try(
			for mp in (getClassInstances Autodesk_Map) do(
				btmp = Bitmaptexture bitmap:mp.Parameters_Source
				
				btmp.coords.realWorldScale = true
				btmp.coords.U_Tiling = mp.Scale_Width / 100
				btmp.coords.V_Tiling = mp.Scale_Height / 100
				
				btmp.coords.U_Tile = mp.Repeat_Horizontal
				btmp.coords.V_Tile = mp.Repeat_Vertical
				
				btmp.coords.mapChannel = mp.Advanced_Parameters_Map_Channel
				replaceInstances mp btmp
			)
		)catch()
	)
	
	

	
	
	fn createCoronaMtl orig_mtl =(
		if ((superclassof orig_mtl)!=material) then return orig_mtl  -- check if this is a material; if not, just return the value
		
		local i=findItem orig_mtls orig_mtl -- check if we have already converted this material
		if i>0 then return new_mtls[i]  --if yes, just return the already converted one	
		
		-- recurse into sub-materials, if any
		local sub_count=getNumSubMtls orig_mtl
		if sub_count >= 1 then (
			for i=1 to sub_count do (
				setSubMtl orig_mtl i (createCoronaMtl (getSubMtl orig_mtl i))
			)
		)
		
		cls=classof orig_mtl
		local new_mtl=case cls of (
			StandardMaterial: convertFrom_Standard orig_mtl
			VRayMtl: convertFrom_VrayMtl orig_mtl
			VRayBlendMtl: convertFrom_VrayBlendMtl orig_mtl
			VRayLightMtl: convertFrom_VrayLightMtl orig_mtl
			VRay2SidedMtl: convertFrom_Vray2sidedMtl orig_mtl
			VRayCarPaintMtl: convertFrom_VRayCarPaintMtl orig_mtl
			VrayOverrideMtl: convertFrom_VrayOverrideMtl orig_mtl
			Arch___Design__mi: convertFrom_ArchAndDesign orig_mtl
			Car_Paint_Material__mi: convertFrom_MRCarPaintMaterial orig_mtl
			fR_Advanced: convertFrom_fR_Advanced orig_mtl
			fR_Architectural: convertFrom_fR_Architectural orig_mtl
			Shellac: convertFrom_Shellac orig_mtl
			DoubleSided: convertFrom_DoubleSided orig_mtl
			TopBottom: convertFrom_TopBottom orig_mtl
			Autodesk_Material:convertFrom_AutodeskMtl orig_mtl
			
			VRayFastSSS: convertFrom_VRayFastSSS orig_mtl -- temporary until Corona supports proper SSS
			VRayFastSSS2: convertFrom_VRayFastSSS2 orig_mtl -- temporary until Corona supports proper SSS
			
			--following materials will be replaced with default gray corona mat, will be supported later
			RaytraceMaterial: CreateDefaultCoronaMtl orig_mtl
			Architectural: CreateDefaultCoronaMtl orig_mtl
			fR_Metal: CreateDefaultCoronaMtl orig_mtl
			fR_Glass: CreateDefaultCoronaMtl orig_mtl
			
			default: orig_mtl
		)
		
		if new_mtl!=orig_mtl then ( 		-- if converted, add to the list of converted materials
			append orig_mtls orig_mtl
			append new_mtls new_mtl
		)
		new_mtl
	)

	
-- 	fn replaceMtlNode node =(
-- 		if isValidNode node then (
-- 			local m=createCoronaMtl node.material
-- 			node.material=m
-- 		)
-- 		for i=1 to node.children.count do (
-- 			replaceMtlNode node.children[i]
-- 		)
-- 	)


-- 	fn mtlsToCorona = (
-- 		format "Converting scene materials...\n"
-- 		replaceMtlNode rootNode
-- 		format "Converting Material Editor materials...\n"
-- 		for i=1 to 24 do (
-- 			local m=createCoronaMtl meditmaterials[i]
-- 			meditmaterials[i]=m
-- 		)
-- 	)
	
	fn mtlsToCorona = (
		format "Converting scene materials...\n"
		for c in material.classes do( --where c.creatable 
			for i in getclassinstances c do(
				replaceInstances i (createCoronaMtl i)
			)
		)
		format "Converting Material Editor materials...\n"
		for i=1 to 24 do (
			local m=createCoronaMtl meditmaterials[i]
			meditmaterials[i]=m
		)
	)
	
	fn showMapsInVP mode =(
		for o in (getclassinstances CoronaMtl) do(
			try(showTextureMap o o.texmapDiffuse mode)catch()
		)
	)
	
	fn SetMaxDisplacementLevel amnt =(
		for o in (getclassinstances CoronaMtl) do(
			o.displacementMaximum = amnt
		)
	)
	
	fn DisableDisplacementTex =(
		for o in (getclassinstances CoronaMtl) do(
			o.texmapOnDisplace = false
		)
	)
	
	fn collectMaterialClasses =(
		myString = "" as stringstream 
		showclass "*:material*" to:myString
		
		rawClass = filterstring (myString as string) "\n"
		rawClass = for elem in rawClass collect (filterstring elem ": ")[1] 
		sort rawClass
		rawClass
	)
	
	fn setEnergyConservationMode mode =(
		for mat in (getclassinstances CoronaMtl) do(
			if (hasproperty mat "legacyEnergyConservation") then(
				mat.legacyEnergyConservation = mode  -- true = legacy, false = standard
			)
		)
	)
	
	rollout convertClass "Convert by class" width:180 height:480(
		label lblDesc "Convert any material class to a default gray CoronaMtl. You can select several classes at once." pos:[4,4] width:170 height:60
		multilistbox mlb "" pos:[4,50] width:170 height:30 items:(collectMaterialClasses())
		button convertClasses  "Convert to Default CoronaMtl" pos:[4,450]width:170
			
		on convertClasses pressed do(
			for cls in mlb.selection do(
				for mtl in (getclassinstances (execute mlb.items[cls])) where classof mtl != CoronaMtl do(
					try(replaceInstances mtl (CoronaMtl name:mtl.name))catch("Unknown Error occured!")
				)
			)
		)
	)

	local lastPos = [8,8]

	rollout CoronaConverter "Corona Material Converter" width:466 height:396 (
		groupBox grpStd "standard Materials" pos:(lastPos += [0,0]) width:184 height:40
		checkbox chkReflstandardMat "convert specular to reflection" pos:(lastPos += [8,18]) width:168 height:16 checked:standardMatSpecToRefl
		
		groupBox grpVray "Vray Materials" pos:(lastPos += [-8,26]) width:184 height:82
		checkbox chkConvVrayGloss "convert glossy values (experimental)" pos:(lastPos += [8,16]) width:168 height:32 checked:VrayConvertGlossyValues
		checkbox chkVrBltoMLBl "convert VrayBlend to multilayerd Blend Materials" pos:(lastPos += [0,32]) width:168 height:32 checked:vrayblendToMultilayerdBlend
		
		groupBox grpConv "Convert..." pos:(lastPos += [-8,38]) width:184 height:251
		radiobuttons rdoMode "" pos:(lastPos += [8,18])  width:82 height:48 labels:#("all materials + maps", "selected obj. materials (debug)", "selected MatEditor slot (debug)")
		checkbox chkCorPrefix "add prefix to converted Mtls" pos:(lastPos += [0,52]) width:168 height:16 checked:addCoronaPrefix
		edittext edtPrefix "" pos:(lastPos += [14,18]) width:140 height:17
		checkbox chkBitmapBlur "alter bitmap blur if greater..." pos:(lastPos += [-14,20]) width:168 height:16 checked:false
		spinner spnBitmapBlur "" pos:(lastPos += [18,18]) width:50 height:32 range:[0.01,100.0,1.0] enabled:false
		checkbox chkDisplLevel "max displacement lvl" pos:(lastPos += [-18,20]) width:116 height:16 checked:false
		spinner spnDisplLevel "" pos:(lastPos + [116,0]) width:56 height:32 range:[0.01,100.0,5.0] enabled:false type:#worldunits
		checkbox chkSwitchRen "switch renderer to Corona" pos:(lastPos += [0,20]) width:168 height:16 checked:false
		--checkbox chkShowMaps "show maps in viewport (slow)" pos:(lastPos += [0,20]) width:168 height:16 checked:false
		
		button btnStartConverting "START CONVERSION" pos:(lastPos += [0,44]) width:168 height:32
		
		groupBox grpTools "Tools" pos:[202,8] width:256 height:113 -- +16
		button btnResetMtlEdit "Reset MatEdit to CoronaMtls" pos:(grpTools.pos + [8,16]) width:160 height:23
		button btnStatistics "Statistics" pos:(grpTools.pos + [168,16]) width:80 height:23
		button btnShowMapsInVP "show maps in VP (slow)" pos:(grpTools.pos + [8,39]) width:120 height:23
		button btnUnShowMapsInVP "UN-show maps in VP" pos:(grpTools.pos + [128,39]) width:120 height:23
		button btnDisableDisplace "disable Displacement maps" pos:(grpTools.pos + [8,62]) width:140 height:23
		button btnConvertClass "convert by class" pos:(grpTools.pos + [148,62]) width:100 height:23
		label lblEnergyCons "Energy conservation:" pos:(grpTools.pos + [13,88])
		button btnEnergyConsNrm "to new mode" pos:(grpTools.pos + [120,85]) width:74
		button btnEnergyConsLgc "to legacy" pos:(grpTools.pos + [194,85]) width:54
		
		groupBox grpReaddMe "Readme:" pos:[202,124] width:256 height:265
		label lblDesc "" pos:(grpReaddMe.pos + [10,20]) width:240 height:240
		hyperlink spdDebg "Performance debugging wiki" address:"http://corona-renderer.com/wiki/performance_debugging" visitedColor:(color 150 170 210) color:(color 150 170 210) pos:(grpReaddMe.pos + [64,228])
		hyperlink convThread "Corona Forum thread" address:"http://corona-renderer.com/forum/index.php/topic,126.0.html" visitedColor:(color 150 170 210) color:(color 150 170 210) pos:(grpReaddMe.pos + [146,241])
		
		
		on btnResetMtlEdit pressed do(
			for i = 1 to 24 do(
				meditmaterials[i] = CoronaMtl name:((formattedPrint i format:".2d") + " - CoronaMtl")
			)
		)
		
		on btnStatistics pressed do(
			CreateDialog CoronaMtlStats
		)
		
		on btnEnergyConsNrm pressed do(
			setEnergyConservationMode false
		)
		
		on btnEnergyConsLgc pressed do(
			setEnergyConservationMode true
		)
		
		on chkReflstandardMat changed state do(
			standardMatSpecToRefl = state
		)
		
		on chkConvVrayGloss changed state do(
			VrayConvertGlossyValues = state
		)
		
		on chkVrBltoMLBl changed state do(
			vrayblendToMultilayerdBlend = state
		)
		
		on chkCorPrefix changed state do(
			addCoronaPrefix = state
		)
		
		on chkBitmapBlur changed state do(
			spnBitmapBlur.enabled = state
		)
		
		on chkDisplLevel changed state do(
			spnDisplLevel.enabled = state
		)
		
		on btnShowMapsInVP pressed do(
			showMapsInVP true
		)
		
		on btnUnShowMapsInVP pressed do(
			showMapsInVP false
		)
		
		on btnDisableDisplace pressed do(
			DisableDisplacementTex()
		)
		
		on btnConvertClass pressed do(
			createDialog convertClass
		)
		
		on edtPrefix changed txt do(
			UserPrefixStr = txt
		)
		
		on btnStartConverting pressed do(
			orig_mtls=#()
			new_mtls=#()
			
			case rdoMode.state of(
				1:(
					mtlsToCorona()
					format "Replace unsupported maps...\n"
					if chkBitmapBlur.checked then(
						ReplaceUnsupportedMaps blurInput:spnBitmapBlur.value
					)
					else(
						ReplaceUnsupportedMaps() 
					)
					if chkSwitchRen.checked then renderers.current = CoronaRenderer()
					if chkDisplLevel.checked then SetMaxDisplacementLevel spnDisplLevel.value
					format "Done.\n"
				)
				2:(
					for obj in selection do(
						if isValidNode obj and obj.material != undefined then (
							local m=createCoronaMtl obj.material
							replaceInstances obj.material m
						)
					)
				)
				3:(
					local m=createCoronaMtl meditmaterials[activeMeditSlot]
					replaceinstances (meditmaterials[activeMeditSlot]) m
				)
			)
			
			orig_mtls=#()
			new_mtls=#()
			
			if AD_mats_found then(
				messageBox "Autodesk Materials were used in this scene and have been converted, it is STRONGLY recommended to check all those materials before rendering!" title:"Warning"
				AD_mats_found = false
			)
		)
		
		on CoronaConverter open do(
			UserPrefixStr = getinisetting "$plugcfg\\CoronaMatConverter.ini" "UserPrefix" "userString" as string
			if UserPrefixStr == "" then UserPrefixStr = "CRN."
			edtPrefix.text = UserPrefixStr
			addCoronaPrefix = getinisetting "$plugcfg\\CoronaMatConverter.ini" "UserPrefix" "checked" as string
			if addCoronaPrefix == "true" then addCoronaPrefix = True else addCoronaPrefix = False
			chkCorPrefix.checked = addCoronaPrefix
			
			lblDesc.text += "This tool is intended for users already familiar with Corona Materials. "
			lblDesc.text += "Checking the results for problematic materials is strongly recommended to prevent slow renderings!\n\n"
			lblDesc.text += "* check albedo (amount of energy reflected by \n    material) with the new albedo Renderelement\n"
			lblDesc.text += "* check glass mtls for \"Thin\" or \"Caustics\" modes\n"
			lblDesc.text += "* few settings (like Absorption, Displacement, ...)\n   can not be converted conveniently to corona, \n   you will have to redo those.\n"
			lblDesc.text += "* some maps or plugins may not be supported by\n   corona, not all of them can be converted.\n"
			lblDesc.text += "* disable bitmap paging in the common\n   rendersettings\n"
			lblDesc.text += "* set system gamma in CoronaNormalTex maps!\n"
			lblDesc.text += "* read the \n"
			lblDesc.text += "* grab latest script version:"
		)
		
		on CoronaConverter close do(
			setinisetting "$plugcfg\\CoronaMatConverter.ini" "UserPrefix" "userString" edtPrefix.text
			setinisetting "$plugcfg\\CoronaMatConverter.ini" "UserPrefix" "checked" (chkCorPrefix.checked as string)
		)
	)
	
	createDialog CoronaConverter
)


/*
	--Diffuse
	r.levelDiffuse --(Diffuse_level) : float
	r.colorDiffuse --(Diffuse_color) : RGB color
	r.texmapDiffuse --(Diffuse_texture) : texturemap
	if r.texmapDiffuse != undefined then(
		r.texmapOnDiffuse --(usemap_diffuse) : boolean
		r.texmapAmountDiffuse --(Diffuse_map_amount) : float
	)

	--Reflection
	r.levelReflect --(reflect_level) : float
	r.colorReflect --(Reflection_color) : RGB color
	r.texmapReflect --(reflection_texture) : texturemap
	if r.texmapReflect != undefined then(
		r.texmapOnReflect --(usemap_reflect) : boolean
		r.texmapAmountReflect --(Reflect_map_amount) : float
	)
	r.fresnelIor --(reflect_fresnel) : float
	r.texmapFresnelIor --(Fresnel_IOR_texmap) : texturemap
	if r.texmapFresnelIor != undefined then(
		r.texmapOnFresnelIor --(Use_Fresnel_IOR_map) : boolean
		r.texmapAmountFresnelIor --(Fresnel_IOR_amount) : float
	)
	r.reflectGlossiness --(Reflection_bluriness) : float
	r.texmapReflectGlossiness --(Reflection_blur) : texturemap
	if r.texmapReflectGlossiness != undefined then(
		r.texmapOnReflectGlossiness --(reflect_blur_usemap) : boolean
		r.texmapAmountReflectGlossiness --(Reflect_map_glossiness_amount) : float
	)

	--Refraction
	r.levelRefract --(refract_level) : float
	r.colorRefract --(Refraction_color) : RGB color
	r.texmapRefract --(reflect_texmap) : texturemap
	if r.texmapRefract != undefined then(
		r.texmapOnRefract --(usemap_refract) : boolean
		r.texmapAmountRefract --(Refract_map_amount) : float
	)
	r.ior --(Index_of_refraction) : float
	r.texmapIor --(IOR_texmap) : texturemap
	if r.texmapIor != undefined then(
		r.texmapOnIor --(Use_IOR_map) : boolean
		r.texmapAmountIor --(IOR_amount) : float
	)
	r.refractGlossiness --(Refraction_bluriness) : float
	r.texmapRefractGlossiness --(refract_blur) : texturemap
	if r.texmapRefractGlossiness != undefined then(
		r.texmapOnRefractGlossiness --(usemap_refract_blur) : boolean
		r.texmapAmountRefractGlossiness --(Refract_map_glossiness_amount) : float
	)
	r.glassMode --(Glass_mode) : integer

	--Translucency
	r.levelTranslucency --(Translucency_color) : float
	r.colorTranslucency --(Translucency_color) : RGB color
	r.texmapTranslucency --(Translucency_texmap) : texturemap
	if r.texmapTranslucency != undefined then(
		r.texmapOnTranslucency --(Translucency_usemap) : boolean
		r.texmapAmountTranslucency --(Translucency_mapamount) : float
	)
	
	--Opacity
	r.levelOpacity --(opacity_level) : float
	r.colorOpacity --(Opacity_Color) : RGB color
	r.texmapOpacity --(opacity_texmap) : texturemap
	if r.texmapOpacity != undefined then(
		r.texmapOnOpacity --(usemap_opacity) : boolean
		r.texmapAmountOpacity --(Opacity_map_amount) : float
	)
	
	--Emission
	r.levelSelfIllum --(emission_level) : float
	r.colorSelfIllum --(Emission_color) : RGB color
	r.texmapSelfIllum --(Emission_texmap) : texturemap
	if r.texmapSelfIllum != undefined then(
		r.texmapOnSelfIllum --(Emission_usemap) : boolean
		r.texmapAmountSelfIllum --(Emission_mapamount) : float
	)
	
	--Bumpmap
	r.texmapBump --(bump_texmap) : texturemap
	if r.texmapBump != undefined then(
		r.texmapOnBump --(usemap_bump) : boolean
		r.texmapAmountBump --(Bump_map_amount) : float
	)
	
	--Absorption
	r.attenuation --(Material_attenuation) : worldUnits
	r.attenuationTint --(Attenuation_tint) : RGB color

	--RoundedCorners
	r.roundedCornersRadius --(Rounded_corners_radius) : worldUnits
	r.roundedCornersSamples --(Rounded_corners_samples) : integer

	--BRDF
	r.brdf --(BRDF) : integer
	r.castsShadows --(Casts_shadows) : boolean
	r.directlyVisible --(Directly_visible) : boolean

	--Anisotropy
	r.anisotropy --(Anisotropy) : float
	r.texmapAnisotropy --(Texmap_anisotropy) : texturemap
	if r.texmapAnisotropy != undefined then(
		r.texmapOnAnisotropy --(Use_anisotropy_map) : boolean
		r.texmapAmountAnisotropy --(Anisotropy_map_amount) : float
	)
	r.anisotropyRotation --(Anisotropic_rotation) : float
	r.texmapAnisotropyRotation --(Anisotropy_rotation_texture) : texturemap
	if r.texmapAnisotropyRotation != undefined then(
		r.texmapOnAnisotropyRotation --(Use_aniso_rotation_map) : boolean
		r.texmapAmountAnisotropyRotation --(Aniso_rotation_map_amount) : float
	)
	
	--Displacement
	r.texmapDisplace --(Displace_texmap) : texturemap
	if r.texmapDisplace != undefined then(
		r.texmapOnDisplace --(Use_Displace_map) : boolean
		r.texmapAmountDisplace --(Displace_amount) : worldUnits
	)
*/
