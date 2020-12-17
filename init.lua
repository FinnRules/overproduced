overproduced = {}
overproduced.path = minetest.get_modpath("overproduced")

dofile(overproduced.path .. "/functions.lua")
dofile(overproduced.path .. "/cropapi.lua")
dofile(overproduced.path .. "/melonapi.lua")
--dofile(overproduced.path .. "/mushroomapi.lua")

if (minetest.get_modpath("default") and minetest.get_modpath("farming")) ~= nil then
	minetest.log("[overproduced]: default loaded")
	overproduced.sound_plant = default.node_sound_leaves_defaults()
	overproduced.sound_seed = default.node_sound_dirt_defaults({
					dig = {name = "", gain = 0},
					dug = {name = "default_grass_footstep", gain = 0.2},
					place = {name = "default_place_node", gain = 0.25},
					})

	dofile(overproduced.path .. "/minetest_game/crops.lua")

end

--OP assumes if you have fmain you have ffarming
if (minetest.get_modpath("fmain")) ~= nil then
	minetest.log("[overproduced]: fmain loaded")
--	overproduced.sound_plant = ""
--	overproduced.sound_seed = ""

	dofile(overproduced.path .. "/finns_game/crops.lua")
end
