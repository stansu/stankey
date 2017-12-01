(
	local sp1s, cb1s, cb2s, cb3s
	curMtl = medit.GetCurMtl()
	if curMtl != undefined then
	(
		for i = geometry do
		(
			if i.material == curMtl do
			(
				sp1s = i.gbufferchannel
				cb1s = i.renderByLayer
				cb2s = i.castShadows
				cb3s = i.receiveShadows
				exit
			)
		)
		rollout changeID "changeID"
		(
			spinner sp1 "set ID to..." range:[0,65535,sp1s] type:#integer fieldwidth:40
			checkbox cb1 "renderByLayer" checked:(if cb1s then on else off)
			checkbox cb2 "castShadows" checked:(if cb2s then on else off)
			checkbox cb3 "receiveShadows" checked:(if cb3s then on else off)
			button bt1 "Change!"
			on cb1 changed theState do
			(
				print cb1.triState
				print cb2.triState
				if cb1.triState == 1 then
				(
					cb2.triState = 2
					cb3.triState = 2
				)
				else
				(
					cb2.triState = 1
					cb3.triState = 1
				)
			)
			on bt1 pressed do
			(
				DestroyDialog changeID
				if (messageBox ("Change ID that material is <" + curMtl.name + ">?")) == ok do
				(
					for i = geometry do
					(
						if i.material == curMtl do
						(
							if cb2.triState == 1 then i.castShadows = on else i.castShadows = off
							if cb3.triState == 1 then i.receiveShadows = on else i.receiveShadows = off
							if cb1.triState == 1 then i.renderByLayer = on else i.renderByLayer = off
							i.gbufferchannel = sp1.value
						)
					)
				)
			)
		)
		CreateDialog changeID
	)
	else
	messagebox "Please select material in editor!"
)