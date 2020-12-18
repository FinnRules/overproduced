overproduced.place_seed = function(itemstack, placer, pointed_thing, plantname)
	local pt = pointed_thing
	-- check if pointing at a node
	if not pt then
		return itemstack
	end
	if pt.type ~= "node" then
		return itemstack
	end

	local under = minetest.get_node(pt.under)
	local above = minetest.get_node(pt.above)

	local player_name = placer and placer:get_player_name() or ""

	if minetest.is_protected(pt.under, player_name) then
		minetest.record_protection_violation(pt.under, player_name)
		return
	end
	if minetest.is_protected(pt.above, player_name) then
		minetest.record_protection_violation(pt.above, player_name)
		return
	end

	-- return if any of the nodes is not registered
	if not minetest.registered_nodes[under.name] then
		return itemstack
	end
	if not minetest.registered_nodes[above.name] then
		return itemstack
	end

	-- check if pointing at the top of the node
	if pt.above.y ~= pt.under.y+1 then
		return itemstack
	end

	-- check if you can replace the node above the pointed node
	if not minetest.registered_nodes[above.name].buildable_to then
		return itemstack
	end

	-- check if pointing at soil
	if minetest.get_item_group(under.name, "soil") < 2 then
		return itemstack
	end

	-- add the node and remove 1 item from the itemstack
	minetest.log("action", player_name .. " places node " .. plantname .. " at " ..
		minetest.pos_to_string(pt.above))
	minetest.add_node(pt.above, {name = plantname, param2 = 1})
	overproduced.tick(pt.above)
	if not minetest.is_creative_enabled(player_name) then
		itemstack:take_item()
	end
	return itemstack
end

overproduced.grow_plant = function(pos, elapsed)
	local node = minetest.get_node(pos)
	local name = node.name
	local def = minetest.registered_nodes[name]

	if not def.next_plant then
		-- disable timer for fully grown plant
		return
	end

	-- grow seed
	if minetest.get_item_group(node.name, "seed") and def.fertility then
		local soil_node = minetest.get_node_or_nil({x = pos.x, y = pos.y - 1, z = pos.z})
		if not soil_node then
			overproduced.tick_again(pos)
			return
		end
		-- omitted is a check for light, we assume seeds can germinate in the dark.
		for _, v in pairs(def.fertility) do
			if minetest.get_item_group(soil_node.name, v) ~= 0 then
				local placenode = {name = def.next_plant}
				if def.place_param2 then
					placenode.param2 = def.place_param2
				end
				minetest.swap_node(pos, placenode)
				if minetest.registered_nodes[def.next_plant].next_plant then
					overproduced.tick(pos)
					return
				end
			end
		end

		return
	end

	-- check if on wet soil
	local below = minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z})
	if minetest.get_item_group(below.name, "soil") < 3 then
		overproduced.tick_again(pos)
		return
	end

	-- check light
	local light = minetest.get_node_light(pos)
	if not light or light < def.minlight or light > def.maxlight then
		overproduced.tick_again(pos)
		return
	end

	-- grow
	local placenode = {name = def.next_plant}
	if def.place_param2 then
		placenode.param2 = def.place_param2
	end
	minetest.swap_node(pos, placenode)

	-- new timer needed?
	if minetest.registered_nodes[def.next_plant].next_plant then
		overproduced.tick(pos)
	end
	return
end

overproduced.tick = function(pos)
	minetest.get_node_timer(pos):start(math.random(166, 286))
end
-- how often a growth failure tick is retried (e.g. too dark)
overproduced.tick_again = function(pos)
	minetest.get_node_timer(pos):start(math.random(40, 80))
end
