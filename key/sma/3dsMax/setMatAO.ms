for i = scenematerials do
(
	try
	(
		i.opts_ao_on = on
		i.opts_ao_exact = On
		i.opts_ao_samples = 32
		i.opts_ao_dark = (color 0 0 0)
		i.opts_ao_distance = 250.0 / 25.4
	)catch()
)
