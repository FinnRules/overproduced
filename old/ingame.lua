--Orange tree spawning

minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		fill_ratio = 0.0003,
		biomes = {"grassland", "grassland_dunes", "deciduous_forest",
			"coniferous_forest", "coniferous_forest_dunes",
			"floatland_grassland", "floatland_coniferous_forest"},
		y_min = 1,
		y_max = 100,
		decoration ="overproduced:orange_sapling",
})
