local allbiomes = {"maple_forest", "mixed_forest", "grassland", "moss_mountain", "redwood_forest", "cherry_blossom_forest", "white_forest"} --all reasonably applicable biomes in FG, updated to 0.3.5

--Red Onion
overproduced.register_plant("overproduced:red_onion", {
	description = "Red Onion Seeds",
	harvest_description = "Red Onion",
	paramtype2 = "meshoptions",
	inventory_image = "overproduced_red_onion_seeds.png",
	steps = 5,
	minlight = 10,
	maxlight = minetest.LIGHT_MAX,
	fertility = allbiomes,
	groups = {flammable = 1},
	place_param2 = 1,
})
--
--Yellow Onion
overproduced.register_plant("overproduced:yellow_onion", {
	description = "Yellow Onion Seeds",
	harvest_description = "Yellow Onion",
	paramtype2 = "meshoptions",
	inventory_image = "overproduced_yellow_onion_seeds.png",
	steps = 12,
	minlight = 10,
	maxlight = minetest.LIGHT_MAX,
	fertility = allbiomes,
	groups = {flammable = 1},
	place_param2 = 1,
})

--White Onion
overproduced.register_plant("overproduced:white_onion", {
	description = "White Onion Seeds",
	harvest_description = "White Onion",
	paramtype2 = "meshoptions",
	inventory_image = "overproduced_white_onion_seeds.png",
	steps = 5,
	minlight = 10,
	maxlight = minetest.LIGHT_MAX,
	fertility = allbiomes,
	groups = {flammable = 1},
	place_param2 = 1,
})

--Tomato
overproduced.register_plant("overproduced:tomato", {
	description = "Tomato Seeds",
	harvest_description = "Tomato",
	paramtype2 = "meshoptions",
	inventory_image = "overproduced_tomato_seeds.png",
	steps = 5,
	minlight = 10,
	maxlight = minetest.LIGHT_MAX,
	fertility = allbiomes,
	groups = {flammable = 1},
	place_param2 = 1,
})

--[[
--Peanuts
--The seed is Raw peanuts, the crop is unshelled raw peanuts, they can be cooked via ffoods to create roasted peanuts and roasted unshelled peanuts which craft into roasted peanuts
overproduced.register_plant("overproduced:peanuts", {
	description = ("Raw Peanuts"),
	harvest_description = ("Unshelled Raw Peanuts"),
	paramtype2 = "meshoptions",
	inventory_image = "overproduced_raw_peanuts.png",
	steps = 5,
	minlight = 10,
	maxlight = minetest.LIGHT_MAX,
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
]]
--Garlic
overproduced.register_plant("overproduced:garlic", {
	description = "Garlic Cloves",
	harvest_description = "Garlic",
	paramtype2 = "meshoptions",
	inventory_image = "overproduced_garlic_cloves.png",
	steps = 5,
	minlight = 10,
	maxlight = minetest.LIGHT_MAX,
	fertility = allbiomes,
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
	inventory_image = "overproduced_honeydew_seeds.png",
	steps = 2,
	minlight = 5,
	maxlight = minetest.LIGHT_MAX,
	fertility = allbiomes,
	groups =  {flammable = 1},
	place_param2 = 1,
	melon_tiles = {"overproduced_honeydew.png"},
})

--[[Rainbow Carrots
overproduced.register_plant("overproduced:rainbow_carrots", {
	description = "Rainbow Carrot Seeds",
	harvest_description = "Rainbow Carrots",
	paramtype2 = "meshoptions",
	inventory_image = "overproduced_rainbow_carrots.png",
	steps = 3,
	minlight = 6,
	maxlight = minetest.LIGHT_MAX,
	fertility = {"grassland"},
	groups = {},
	place_param2 = 1,
})]]

--Habanero
overproduced.register_plant("overproduced:habanero", {
	description = "Habanero Seeds",
	harvest_description = "Habanero",
	paramtype2 = "meshoptions",
	inventory_image = "overproduced_habanero.png",
	steps = 5,
	minlight = 6,
	maxlight = minetest.LIGHT_MAX,
	fertility = allbiomes,
	groups = {},
	place_param2 = 1,
	seeddrop = false,
})

overproduced.register_plant("overproduced:potato", {
	description = "Potato",
	harvest_description = "Potato_1",
	paramtype2 = "meshoptions",
	inventory_image = "overproduced_potato.png",
	steps = 4,
	minlight = 4,
	maxlight = minetest.LIGHT_MAX,
	fertility = allbiomes,
	groups = {},
	place_param2 = 2,
	seeddrop = "seed_only",
})

--Cabbage
overproduced.register_plant("overproduced:cabbage", {
	description = "Cabbage Seeds",
	harvest_description = "Cabbage",
	paramtype2 = "meshoptions",
	inventory_image = "overproduced_cabbage_seeds.png",
	steps = 6,
	minlight = 10,
	maxlight = minetest.LIGHT_MAX,
	fertility = allbiomes,
	groups = {flammable = 1},
	place_param2 = 1,
})


overproduced.register_plant("overproduced:carrot", {
	description = "Carrot Seeds",
	harvest_description = "Carrot",
	paramtype2 = "meshoptions",
	inventory_image = "overproduced_carrot_seeds.png",
	steps = 5,
	minlight = 10,
	maxlight = minetest.LIGHT_MAX,
	fertility = allbiomes,
	groups = {flammable = 1},
	place_param2 = 1,
})

overproduced.register_plant("overproduced:eggplant", {
	description = "Eggplant Seeds",
	harvest_description = "Eggplant",
	paramtype2 = "meshoptions",
	inventory_image = "overproduced_eggplant_seeds.png",
	steps = 7,
	minlight = 10,
	maxlight = minetest.LIGHT_MAX,
	fertility = allbiomes,
	groups = {flammable = 1},
	place_param2 = 1,
})
