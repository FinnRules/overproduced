minetest.register_node("overproduced:orange_tree", {
		tiles = {
			"overproduced_orange_tree_top.png",
			"overproduced_orange_tree_top.png",
			"overproduced_orange_tree.png",
			"overproduced_orange_tree.png",
			"overproduced_orange_tree.png",
			"overproduced_orange_tree.png"
		},
		description = "Orange Tree Trunk",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
		sounds = default.node_sound_wood_defaults(),

		on_place = minetest.rotate_node
})





minetest.register_node("overproduced:orange_leaves", {
        description = "Orange Tree Leaves",
        drawtype = "allfaces_optional",
        waving = 1,
        tiles = {"overproduced_orange_leaves_fruit.png"},
        paramtype = "light",
        is_ground_content = false,
        groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
        drop = {
                max_items = 1,
                items = {
                        {
		                items = {'overproduced:orange_sapling'},
                                rarity = 15,
                        },
			{
				items = {'overproduced:orange'},
				rarity = 3,

			},
                        {
                                -- player will get leaves only if he get no saplings,
                                -- this is because max_items is 1
				rarity = 2,
                                items = {'overproduced:orange_leaves'},
                        }
                }
        },
        sounds = default.node_sound_leaves_defaults(),

        after_place_node = default.after_place_leaves,
})

minetest.register_node("overproduced:orange_sapling", {
    description = "Orange Tree Sapling",
    drawtype = "plantlike",
    waving = 1,
    tiles = {"overproduced_orange_sapling.png"},
    inventory_image = "overproduced_orange_sapling.png",
    wield_image = "overproduced_orange_sapling.png",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    buildable_to = true,
    groups = {snappy = 3, flora = 1, attached_node = 1, grass = 1, flammable = 1},
    sounds = default.node_sound_leaves_defaults(),
    selection_box = {
        type = "fixed",
        fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -5 / 16, 6 / 16},
    },
	drop = {
        max_items = 1,
        items = {
            {items = {'overproduced:orange_sapling'}}
        }
    }
})

minetest.register_node("overproduced:blueberry_bush", {
    description = "Blueberry Bush",
    drawtype = "plantlike",
    waving = 1,
    tiles = {"overproduced_blueberry_bush.png"},
    inventory_image = "overproduced_blueberry_bush.png",
    wield_image = "overproduced_blueberry_bush.png",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    buildable_to = true,
    groups = {snappy = 3, flora = 1, attached_node = 1, grass = 1, flammable = 1},
    sounds = default.node_sound_leaves_defaults(),
    selection_box = {
        type = "fixed",
        fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -5 / 16, 6 / 16},
    },
        drop = {
        max_items = 1,
        items = {
            {items = {'overproduced:blueberry_bush'}}
        }
    }
})
minetest.register_node("overproduced:blueberry_bush_leaves", {
        description = "Blueberry Bush Leaves",
        drawtype = "allfaces_optional",
        waving = 1,
        tiles = {"overproduced_blueberry_bush_leaves_fruit.png"},
        paramtype = "light",
        is_ground_content = false,
        groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
        drop = {
                max_items = 1,
                items = {
--                        {
  --                              items = {'overproduced:orange_sapling'},
    --                   	        rarity = 15,
      --                  },
                        {
                                items = {'overproduced:blueberry'},
                                rarity = 3,

                        },
                        {
                                -- player will get leaves only if he get no saplings,
                                -- this is because max_items is 1
                                rarity = 2,
                                items = {'overproduced:blueberry_bush_leaves'},
                        }
                }
        },
        sounds = default.node_sound_leaves_defaults(),

        after_place_node = default.after_place_leaves,
})


minetest.register_node("overproduced:strawberry_bush", {
    description = "Strawberry Bush",
    drawtype = "plantlike",
    waving = 1,
    tiles = {"overproduced_blueberry_bush.png"},
    inventory_image = "overproduced_blueberry_bush.png",
    wield_image = "overproduced_blueberry_bush.png",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    buildable_to = true,
    groups = {snappy = 3, flora = 1, attached_node = 1, grass = 1, flammable = 1},
    sounds = default.node_sound_leaves_defaults(),
    selection_box = {
        type = "fixed",
        fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -5 / 16, 6 / 16},
    },
        drop = {
        max_items = 1,
        items = {
            {items = {'overproduced:strawberry_bush'}}
        }
    }
})


minetest.register_node("overproduced:strawberry_bush_leaves", {
        description = "Strawberry Bush Leaves",
        drawtype = "allfaces_optional",
        waving = 1,
        tiles = {"overproduced_strawberry_bush_leaves_fruit.png"},
        paramtype = "light",
        is_ground_content = false,
        groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
        drop = {
                max_items = 1,
                items = {
--                        {
  --                              items = {'overproduced:orange_sapling'},
    --                                  rarity = 15,
      --                  },
                        {
                                items = {'overproduced:strawberry'},
                                rarity = 3,

                        },
                        {
                                -- player will get leaves only if he get no saplings,
                                -- this is because max_items is 1
                                rarity = 2,
                                items = {'overproduced:strawberry_bush_leaves'},
                        }
                }
        },
        sounds = default.node_sound_leaves_defaults(),

        after_place_node = default.after_place_leaves,

})
