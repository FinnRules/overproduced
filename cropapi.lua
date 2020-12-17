--Creates a table
overproduced.registered_plants = {}

-- Register plants
overproduced.register_plant = function(name, def)
	--creates two local variables
	--mname is the mod name, pname is the plant name
	local mname = name:split(":")[1]
	local pname = name:split(":")[2]

	-- Check def table
	--Sets default values if nothing is specified for options in the table
	if not def.description then
		def.description = "Seed"
	end
	if not def.harvest_description then
		def.harvest_description = pname:gsub("^%l", string.upper)
	end
	if not def.inventory_image then
		def.inventory_image = "unknown_item.png"
	end
	if not def.steps then
		return nil
	end
	if not def.minlight then
		def.minlight = 1
	end
	if not def.maxlight then
		def.maxlight = 14 -- change this to default.MAX_LIGHT
	end
	if not def.fertility then
		def.fertility = {} --defaults to no fertility
	end
	--custom parameter
--	if def.seeddrop ~= false then
--		def.seeddrop = true
--	end
--	print(pname .. " after" .. def.seeddrop)
	--something here
	--custom drop
	--melon api

--	print(def)
	overproduced.registered_plants[pname] = def

	-- Register seed
	--creates a variable named modname:seed_plantname
	local lbm_nodes = {mname .. ":seed_" .. pname}
	local g = {seed = 1, snappy = 3, attached_node = 1, flammable = 2}
	--what does this do?
	for k, v in pairs(def.fertility) do
		g[v] = 1
	end
	minetest.register_node(":" .. mname .. ":seed_" .. pname, {
		description = def.description,
		tiles = {def.inventory_image},
		inventory_image = def.inventory_image,
		wield_image = def.inventory_image,
		drawtype = "signlike",
		groups = g,
		paramtype = "light",
		paramtype2 = "wallmounted",
		place_param2 = def.place_param2 or nil, -- this isn't actually used for placement
		walkable = false,
		sunlight_propagates = true,
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
		},
		fertility = def.fertility,
		sounds = overproduced.sound_seed,

		on_place = function(itemstack, placer, pointed_thing)
			local under = pointed_thing.under
			local node = minetest.get_node(under)
			local udef = minetest.registered_nodes[node.name]
			if udef and udef.on_rightclick and
					not (placer and placer:is_player() and
					placer:get_player_control().sneak) then
				return udef.on_rightclick(under, node, placer, itemstack,
					pointed_thing) or itemstack
			end

			return overproduced.place_seed(itemstack, placer, pointed_thing, mname .. ":seed_" .. pname)
		end,
		next_plant = mname .. ":" .. pname .. "_1",
		on_timer = overproduced.grow_plant,
		minlight = def.minlight,
		maxlight = def.maxlight,
	})

	-- Register harvest
	if def.seeddrop ~= "seed_only" then
		minetest.register_craftitem(":" .. mname .. ":" .. pname, {
			description = def.harvest_description,
			inventory_image = mname .. "_" .. pname .. ".png",
			groups = def.groups or {flammable = 2},
		})
	end
	-- Register growing steps
	for i = 1, def.steps do
		local base_rarity = 1
		if def.steps ~= 1 then
			base_rarity =  8 - (i - 1) * 7 / (def.steps - 1)
		end
		local drop = {}

		--If seeddrop is true then the conventional drop table is used
		if def.seeddrop == "seed_only" then
			drop = {
				items = {
					{items = {mname .. ":seed_" .. pname}, rarity = base_rarity},
					{items = {mname .. ":seed_" .. pname}, rarity = base_rarity},
					{items = {mname .. ":seed_" .. pname}, rarity = base_rarity * 2},
				}
			}
		elseif def.seeddrop ~= false then
			drop = {
				items = {
					{items = {mname .. ":" .. pname}, rarity = base_rarity},
					{items = {mname .. ":" .. pname}, rarity = base_rarity * 2},
					{items = {mname .. ":seed_" .. pname}, rarity = base_rarity},
					{items = {mname .. ":seed_" .. pname}, rarity = base_rarity * 2},
				}
			}
		else
			drop = {
				items = {
					{items = {mname .. ":" .. pname}, rarity = base_rarity},
					{items = {mname .. ":" .. pname}, rarity = base_rarity * 2 },
				}
			}
		end

		local nodegroups = {snappy = 3, flammable = 2, plant = 1, not_in_creative_inventory = 1, attached_node = 1}
		nodegroups[pname] = i

		local next_plant = nil

		if i < def.steps then
			next_plant = mname .. ":" .. pname .. "_" .. (i + 1)
			lbm_nodes[#lbm_nodes + 1] = mname .. ":" .. pname .. "_" .. i
		end
		minetest.register_node(":" .. mname .. ":" .. pname .. "_" .. i, {
			drawtype = "plantlike",
			waving = 1,
			tiles = {mname .. "_" .. pname .. "_" .. i .. ".png"},
			paramtype = "light",
			paramtype2 = def.paramtype2 or nil,
			place_param2 = def.place_param2 or nil,
			walkable = false,
			buildable_to = true,
			drop = drop,
			selection_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
			},
			groups = nodegroups,
			sounds = overproduced.sound_plant,
			next_plant = next_plant,
			on_timer = overproduced.grow_plant,
			minlight = def.minlight,
			maxlight = def.maxlight,
		})
	end

	-- replacement LBM for pre-nodetimer plants
	minetest.register_lbm({
		name = ":" .. mname .. ":start_nodetimer_" .. pname,
		nodenames = lbm_nodes,
		action = function(pos, node)
			overproduced.tick_again(pos)
		end,
	})

	-- Return
	local r = {
		seed = mname .. ":seed_" .. pname,
		harvest = mname .. ":" .. pname
	}
	return r
end

