--Corn
farming.register_plant(overproduced:corn", {
	description = "Corn Kernal",
	inventory_image = "overproduced_corn_seed.png",
	steps = 6
	minlight = 12
	maxlight = defauilt.LIGHT_MAX,
	fertility = {"grassland"},
	groups = {flammable = 4}
})

--Soybeans
farming.register_plant(overproduced:soybeans", {
	description = "Soybean Seed",
	inventory_image = "overproduced_soybean_seed.png",
	steps = 6
	minlight = 9
	maxlight = default.LIGHT_MAX,
	groups = {flammable = 4}
})

