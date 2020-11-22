--API to build bushes

overproduced.register_bush = function(name, def)
	local mname = name:split(":")[1]
	local pname = name:split(":")[2]

	--Create defaults for def table
	if not def.bush_with_fruit then
		def.bush_with_fruit = "bush_leaves_with_" .. pname
	end
	if not def.bush_without_fruit then
		def.bush_without_fruit = pname .. "_bush_leaves"
	end
	if not def.bush_with_fruit_desc then
		def.bush_with_fruit_desc = string.upper(string.sub(pname, 1, 1)) .. string.sub(pname, -(string.len(pname) - 1)) .. " Bush Leaves with Berries"
	end
	if not def.bush_texture then
		def.bush_texture = mname .. "_" .. pname .. "_bush_leaves.png"
	end
	if not def.overlay_texture then
		def.overlay_texture = mname .. "_" .. pname .. "_overlay.png"
	end
	if not def.drop then
		def.drop = ""
	end
	
	--Registers bush with the crop on it	
	minetest.register_node(mname .. ":" .. def.bush_with_fruit, {
		description = def.bush_with_fruit_desc,
		drawtype = "allfaces_optional",
		tiles = {def.bush_texture^def.overlay_texture},
		paramtype = "light",
		groups = {snappy = 3, flammable = 2, leaves = 1, dig_immediate = 3},
		drop = def.drop,
		sounds = default.node_sound_leaves_defaults(),
		node_dig_prediction = mname .. ":" .. def.bush_without_fruit,

		after_dig_node = function(pos, oldnode, oldmetadata, digger)
			minetest.set_node(pos, {name = mname .. ":" .. def.bush_without_fruit})
			minetest.get_node_timer(pos):start(math.random(300, 1500))
		end,
	})

	minetest.register_node(mname .. ":" .. def.bush_without_fruit, {
		description = string.upper(string.sub(pname, 1, 1)) .. string.sub(pname, -(string.len(pname) - 1)) .. " Bush Leaves",
		drawtype = "allfaces_optional",
		tiles = {"default_blueberry_bush_leaves.png"},
		paramtype = "light",
		groups = {snappy = 3, flammable = 2, leaves = 1},
		drop = {
			max_items = 1,
			items = {
				{items = {"default:blueberry_bush_sapling"}, rarity = 5},
				{items = {"default:blueberry_bush_leaves"}}
			}
		},
		sounds = default.node_sound_leaves_defaults(),

		on_timer = function(pos, elapsed)
			if minetest.get_node_light(pos) < 11 then
				minetest.get_node_timer(pos):start(200)
			else
				minetest.set_node(pos, {name = "default:blueberry_bush_leaves_with_berries"})
			end
		end,

		after_place_node = after_place_leaves,
	})

	minetest.register_node("default:blueberry_bush_sapling", {
		description = ("Blueberry Bush Sapling"),
		drawtype = "plantlike",
		tiles = {"default_blueberry_bush_sapling.png"},
		inventory_image = "default_blueberry_bush_sapling.png",
		wield_image = "default_blueberry_bush_sapling.png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		on_timer = grow_sapling,
		selection_box = {
			type = "fixed",
			fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 2 / 16, 4 / 16}
		},
		groups = {snappy = 2, dig_immediate = 3, flammable = 2,
			attached_node = 1, sapling = 1},
		sounds = default.node_sound_leaves_defaults(),

		on_construct = function(pos)
			minetest.get_node_timer(pos):start(math.random(300, 1500))
		end,

		on_place = function(itemstack, placer, pointed_thing)
			itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
				"default:blueberry_bush_sapling",
				-- minp, maxp to be checked, relative to sapling pos
				{x = -1, y = 0, z = -1},
				{x = 1, y = 1, z = 1},
				-- maximum interval of interior volume check
				2)

			return itemstack
		end,
	})

end
