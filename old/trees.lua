local ABM_TIME = 10.0

function grow_tree(pos, trunk, leaves, fruit) --atm fruit is unused functionality
	local height = math.random(4, 5)
	for  i=2,(height + 1),1 do
		for f=0,math.random(5,6),1 do
			local locatx
			local locatz
			local type
			if i == (height + 1) then
				locatx = 0
				locatz = 0
				type = leaves
			elseif i == 2 then
				locatx = math.random(-1,1)
				locatz = math.random(-1,1)
				type = fruit
			else
				locatx = math.random(-1,1)
				locatz = math.random(-1,1)
				type = leaves
			end

			minetest.set_node({x=pos.x + locatx, y=pos.y + i, z=pos.z + locatz}, {name=type})
			minetest.set_node({x=pos.x + locatx - 1, y=pos.y + i, z=pos.z + locatz}, {name=type})
			minetest.set_node({x=pos.x + locatx + 1, y=pos.y + i, z=pos.z + locatz}, {name=type})
			minetest.set_node({x=pos.x + locatx, y=pos.y + i, z=pos.z + locatz - 1}, {name=type})
			minetest.set_node({x=pos.x + locatx, y=pos.y + i, z=pos.z + locatz + 1}, {name=type})
		end
	end
	for i=0,height,1 do
		minetest.set_node({x=pos.x, y=pos.y + i, z=pos.z}, {name=trunk})
	end

end

function grow_bush(pos, base, leaves, fruit) --fruit unused current
	local function leaf(leavestype)
		if math.random() <= .90 then
			return leavestype
		else
			return "air"
		end
	end
	minetest.set_node({x=pos.x - 1, y=pos.y, z=pos.z}, {name=leaf(leaves)})
	minetest.set_node({x=pos.x - 1, y=pos.y, z=pos.z + 1}, {name=leaf(leaves)})
	minetest.set_node({x=pos.x - 1, y=pos.y, z=pos.z - 1}, {name=leaf(leaves)})
	minetest.set_node({x=pos.x - 1, y=pos.y + 1, z=pos.z}, {name=leaf(leaves)})
        minetest.set_node({x=pos.x - 1, y=pos.y + 1, z=pos.z + 1}, {name=leaf(leaves)})
        minetest.set_node({x=pos.x - 1, y=pos.y + 1, z=pos.z - 1}, {name=leaf(leaves)})
	minetest.set_node({x=pos.x, y=pos.y, z=pos.z + 1}, {name=leaf(leaves)})
	minetest.set_node({x=pos.x, y=pos.y, z=pos.z - 1}, {name=leaf(leaves)})
        minetest.set_node({x=pos.x, y=pos.y + 1, z=pos.z + 1}, {name=leaf(leaves)})
        minetest.set_node({x=pos.x, y=pos.y + 1, z=pos.z - 1}, {name=leaf(leaves)})
	minetest.set_node({x=pos.x, y=pos.y + 1, z=pos.z}, {name=leaves})--guarenteed to spawn
	minetest.set_node({x=pos.x + 1, y=pos.y, z=pos.z + 1}, {name=leaf(leaves)})
        minetest.set_node({x=pos.x + 1, y=pos.y, z=pos.z - 1}, {name=leaf(leaves)})
	minetest.set_node({x=pos.x + 1, y=pos.y, z=pos.z}, {name=leaf(leaves)})
	minetest.set_node({x=pos.x + 1, y=pos.y + 1, z=pos.z + 1}, {name=leaf(leaves)})
        minetest.set_node({x=pos.x + 1, y=pos.y + 1, z=pos.z - 1}, {name=leaf(leaves)})
        minetest.set_node({x=pos.x + 1, y=pos.y + 1, z=pos.z}, {name=leaf(leaves)})
--	minetest.set_node({x=pos.x, y=pos.y + 2, z=pos.z}, {name=leaf(leaves)})
	minetest.set_node({x=pos.x, y=pos.y, z=pos.z}, {name=base})

end

minetest.register_abm({
    nodenames = {"overproduced:orange_sapling"},
    interval = ABM_TIME,
    chance = 1,
    action = function(pos)
        grow_tree(pos, "overproduced:orange_tree", "overproduced:orange_leaves", "overproduced:orange_leaves")
    end
})

minetest.register_abm({
	nodenames = {"overproduced:blueberry_bush"},
	interval = ABM_TIME,
	chance = 1,
	action = function(pos)
		grow_bush(pos, "overproduced:blueberry_bush", "overproduced:blueberry_bush_leaves", "default:dirt")
	end
})

minetest.register_abm({
	nodenames = {"overproduced:strawberry_bush"},
	interval = ABM_TIME,
	chance = 1,
	action = function(pos)
		grow_bush(pos, "overproduced:strawberry_bush", "overproduced:strawberry_bush_leaves", "default:dirt")
	end
})
