--Red Onion
overproduced.register_plant("overproduced:red_onion", {
	description = ("Red Onion Seed"),
	harvest_description = ("Red Onion"),
	paramtype2 = "meshoptions",
	inventory_image = "overproduced_red_onion_seeds.png",
	steps = 12,
	minlight = 10,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland"},
	groups = {flammable = 1},
	place_param2 = 1,
})

--Yellow Onion
farming.register_plant("overproduced:yellow_onion", {
	description = ("Yellow Onion Seed"),
	harvest_description = ("Yellow Onion"),
	paramtype2 = "meshoptions",
	inventory_image = "overproduced_yellow_onion_seeds.png",
	steps = 12,
	minlight = 10,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland"},
	groups = {flammable = 1},
	place_param2 = 1,
})

--White Onion
farming.register_plant("overproduced:white_onion", {
	description = ("White Onion Seed"),
	harvest_description = ("White Onion"),
	paramtype2 = "meshoptions",
	inventory_image = "overproduced_white_onion_seeds.png",
	steps = 12,
	minlight = 10,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland"},
	groups = {flammable = 1},
	place_param2 = 1,
})

--Peanuts
--The seed is Raw peanuts, the crop is unshelled raw peanuts, they can be cooked via ffoods to create roasted peanuts and roasted unshelled peanuts which craft into roasted peanuts
farming.register_plant("overproduced:peanuts", {
	description = ("Raw Peanuts"),
	harvest_description = ("Unshelled Raw Peanuts"),
	paramtype2 = "meshoptions",
	inventory_image = "overproduced_raw_peanuts.png",
	steps = 5,
	minlight = 10,
	maxlight = default.MAX_LIGHT,
	fertility = {"grassland"},
	groups = {flammable = 2},
	place_param2 = 1,
})

minetest.register_craft({
	type = "shapeless",
	output = "overproduced:seed_peanuts",
	recipe = {"overproduced:peanuts"},
	replacements = {
		{"overproduced:peanuts", "overproduced:peanut_shells"}
	}
})

minetest.register_craftitem("overproduced:peanut_shells", {
	description = ("Peanut Shells"),
	inventory_image = "overproduced_peanut_shells.png",
})

--Garlic
overproduced.register_plant("overproduced:garlic", {
	description = ("Garlic Cloves"),
	harvest_description = ("Garlic"),
	paramtype2 = "meshoptions",
	inventory_image = "overproduced_garlic_cloves.png",
	steps = 5,
	minlight = 10,
	maxlight = default.MAX_LIGHT,
	fertility = {"grassland"},
	groups = {flammable = 1},
	place_param2 = 1,
	seeddrop = false,
})

minetest.register_craft({
	type = "shapeless",
	output = "overproduced:seed_garlic 2",
	recipe = {"overproduced:garlic"},
})

--Honeydew
overproduced.register_melon("overproduced:honeydew", {
	description = "Honeydew seeds",
	harvest_description = "Honeydew",
	paramtype2 = "meshoptions",
	inventory_image = "overproduced_honeydew.png",
	steps = 2,
	minlight = 5,
	maxlight = default.MAX_LIGHT,
	fertility = {"grassland"},
	groups =  {flammable = 1},
	place_param2 = 1,
	melon_tiles = {"overproduced_honeydew.png"},
})

--Rainbow Carrots
overproduced.register_plant("overproduced:rainbow_carrots", {
	description = "Rainbow Carrot Seeds",
	harvest_description = "Rainbow Carrots",
	paramtype2 = "meshoptions",
	inventory_image = "overproduced_rainbow_carrots.png",
	steps = 3,
	minlight = 6,
	maxlight = default.MAX_LIGHT,
	fertility = {"grassland"},
	groups = {},
	place_param2 = 1,
})

--Habanero
overproduced.register_plant("overproduced:habanero", {
	description = "Habanero Seeds",
	harvest_description = "Habanero",
	paramtype2 = "meshoptions",
	inventory_image = "overproduced_habanero.png",
	steps = 4,
	minlight = 6,
	maxlight = default.MAX_LIGHT,
	fertility = {"grassland"},
	groups = {},
	place_param2 = 1,
	seedrop = false,
})
