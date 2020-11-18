--Creates a table
overproduced.registered_plants = {}

-- Register plants
overproduced.register_melon = function(name, def)
	--creates two local variables
	--mname is the mod name, pname is the plant name
	local mname = name:split(":")[1]
	local pname = name:split(":")[2]

	-- Check def table
	--Sets default values if nothing is specified for options in the table
	if not def.description then
		def.description = S("Seed")
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
--	if not def.seeddrop then
--		def.seeddrop = true
--	end
	if not def.melon_tiles then
		def.melon_tiles = "unknown_item.png"
	end
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
		sounds = default.node_sound_dirt_defaults({
			dig = {name = "", gain = 0},
			dug = {name = "default_grass_footstep", gain = 0.2},
			place = {name = "default_place_node", gain = 0.25},
		}),

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

			return farming.place_seed(itemstack, placer, pointed_thing, mname .. ":seed_" .. pname)
		end,
		next_plant = mname .. ":" .. pname .. "_1",
		on_timer = farming.grow_plant,
		minlight = def.minlight,
		maxlight = def.maxlight,
	})

	-- Register harvest
	minetest.register_node(mname .. ":" .. pname, {
		description = def.harvest_description,
		tiles = def.melon_tiles,
		groups = {oddly_breakable_by_hand = 1},
	})

	-- Register growing steps
	for i = 1, def.steps do
		local base_rarity = 1
		if def.steps ~= 1 then
			base_rarity =  8 - (i - 1) * 7 / (def.steps - 1)
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
			drop = {},
			selection_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
			},
			groups = nodegroups,
			sounds = default.node_sound_leaves_defaults(),
			next_plant = next_plant,
			on_timer = farming.grow_plant,
			minlight = def.minlight,
			maxlight = def.maxlight,
		})
	end

	-- replacement LBM for pre-nodetimer plants
	minetest.register_lbm({
		name = ":" .. mname .. ":start_nodetimer_" .. pname,
		nodenames = lbm_nodes,
		action = function(pos, node)
			tick_again(pos)
		end,
	})
	--ABM for growing melons
	minetest.register_abm({
		nodenames = {mname .. ":" .. pname .. "_" .. def.steps},	
		interval = def.interval or 180, --default is every 3 mins
		chance = def.chance or 2, --default is 50% chance
		action = function(pos, node)

			--table of vectors to be checked
			local near = {{x = pos.x - 1, y = pos.y, z = pos.z}, {x = pos.x + 1, y = pos.y, z = pos.z}, {x = pos.x, y = pos.y, z = pos.z - 1}, {x = pos.x, y = pos.y, z = pos.z + 1}}
			print("\nI'm a melon at (" .. pos.x .. ", " .. pos.z .. ")")--debug
			
			local function checkNear()
				for k, v in pairs(near) do
					print("Nearby " .. minetest.get_node(near[k]).name)
					if minetest.get_node(near[k]).name == mname .. ":" .. pname then
						print("Melon detected")
						return false
					end
				
				end
				return true
			end			
			if checkNear() then
				local place = math.random(1,4)
				print("place = " .. place)
				if minetest.get_node(near[place]).name ~= "air" then
					print("Obstruction Detected")
				
				elseif minetest.registered_nodes[minetest.get_node({x = near[place].x, y = near[place].y - 1, z = near[place].z}).name].drawtype ~= "normal" then
					print("No solid ground to place on")

				else
					print("Placing melon")
					minetest.set_node(near[place], {name = mname .. ":" .. pname})
					
				end
				
	
			end
--			local pos = {x = pos.x, y = pos.y + 1, z = pos.z}
--			minetest.set_node(pos, {name = mname .. ":" .. pname})
		end
	})
	-- Return
	local r = {
		seed = mname .. ":seed_" .. pname,
		harvest = mname .. ":" .. pname
	}
	return r
end
