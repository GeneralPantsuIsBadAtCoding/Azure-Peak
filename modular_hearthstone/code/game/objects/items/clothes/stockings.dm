/obj/item/clothing/under/roguetown/tights/stockings
	name = "stockings"
	desc = "A legwear made just for the pure aesthetics. Popular in courts and brothels alike."
	icon = 'modular_hearthstone/icons/obj/items/clothes/stockings.dmi'
	mob_overlay_icon = 'modular_hearthstone/icons/obj/items/clothes/on_mob/stockings.dmi'
	icon_state = "stockings"
	r_sleeve_status = SLEEVE_NOMOD
	l_sleeve_status = SLEEVE_NOMOD
	body_parts_covered = null
	flags_inv = null

/obj/item/clothing/under/roguetown/tights/stockings/random/Initialize()
	. = ..()
	color = pick("#e6e5e5", CLOTHING_BLACK, CLOTHING_BLUE, "#6F0000", "#664357")

/obj/item/clothing/under/roguetown/tights/stockings/white
	color = "#e6e5e5"

/obj/item/clothing/under/roguetown/tights/stockings/black
	color = CLOTHING_BLACK

/obj/item/clothing/under/roguetown/tights/stockings/blue
	color = CLOTHING_BLUE

/obj/item/clothing/under/roguetown/tights/stockings/red
	color = "#6F0000"

/obj/item/clothing/under/roguetown/tights/stockings/purple
	color = "#664357"

//Silk variants

/obj/item/clothing/under/roguetown/tights/stockings/silk
	name = "silk stockings"
	desc = "A legwear made just for the pure aesthetics. Made out of thin silk. Popular among nobles."
	icon_state = "silk"

/obj/item/clothing/under/roguetown/tights/stockings/silk/random/Initialize()
	. = ..()
	color = pick("#e6e5e5", CLOTHING_BLACK, CLOTHING_BLUE, "#6F0000", "#664357")

/obj/item/clothing/under/roguetown/tights/stockings/silk/white
	color = "#e6e5e5"

/obj/item/clothing/under/roguetown/tights/stockings/silk/black
	color = CLOTHING_BLACK

/obj/item/clothing/under/roguetown/tights/stockings/silk/blue
	color = CLOTHING_BLUE

/obj/item/clothing/under/roguetown/tights/stockings/silk/red
	color = "#6F0000"

/obj/item/clothing/under/roguetown/tights/stockings/silk/purple
	color = "#664357"

//Fishnets

/obj/item/clothing/under/roguetown/tights/stockings/fishnet
	name = "fishnet stockings"
	desc = "A legwear popular among wenches."
	icon_state = "fishnet"

/obj/item/clothing/under/roguetown/tights/stockings/fishnet/random/Initialize()
	. = ..()
	color = pick("#e6e5e5", CLOTHING_BLACK, CLOTHING_BLUE, "#6F0000", "#664357")

/obj/item/clothing/under/roguetown/tights/stockings/fishnet/white
	color = "#e6e5e5"

/obj/item/clothing/under/roguetown/tights/stockings/fishnet/black
	color = CLOTHING_BLACK

/obj/item/clothing/under/roguetown/tights/stockings/fishnet/blue
	color = CLOTHING_BLUE

/obj/item/clothing/under/roguetown/tights/stockings/fishnet/red
	color = "#6F0000"

/obj/item/clothing/under/roguetown/tights/stockings/fishnet/purple
	color = "#664357"

//CRAFTING

/datum/crafting_recipe/roguetown/sewing/stockings_white
	name = "white stockings"
	result = list(/obj/item/clothing/under/roguetown/tights/stockings/white)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/stockings_black
	name = "black stockings"
	result = list(/obj/item/clothing/under/roguetown/tights/stockings/black)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/stockings_blue
	name = "blue stockings"
	result = list(/obj/item/clothing/under/roguetown/tights/stockings/blue)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/stockings_red
	name = "red stockings"
	result = list(/obj/item/clothing/under/roguetown/tights/stockings/red)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/stockings_purple
	name = "purple stockings"
	result = list(/obj/item/clothing/under/roguetown/tights/stockings/purple)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

//Silk

/datum/crafting_recipe/roguetown/sewing/stockings_white_silk
	name = "white silk stockings"
	result = list(/obj/item/clothing/under/roguetown/tights/stockings/silk/white)
	reqs = list(/obj/item/natural/silk = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 5

/datum/crafting_recipe/roguetown/sewing/stockings_black_silk
	name = "black silk stockings"
	result = list(/obj/item/clothing/under/roguetown/tights/stockings/silk/black)
	reqs = list(/obj/item/natural/silk = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 5

/datum/crafting_recipe/roguetown/sewing/stockings_blue_silk
	name = "blue silk stockings"
	result = list(/obj/item/clothing/under/roguetown/tights/stockings/silk/blue)
	reqs = list(/obj/item/natural/silk = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 5

/datum/crafting_recipe/roguetown/sewing/stockings_red_silk
	name = "red silk stockings"
	result = list(/obj/item/clothing/under/roguetown/tights/stockings/silk/red)
	reqs = list(/obj/item/natural/silk = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 5

/datum/crafting_recipe/roguetown/sewing/stockings_purple_silk
	name = "purple silk stockings"
	result = list(/obj/item/clothing/under/roguetown/tights/stockings/silk/purple)
	reqs = list(/obj/item/natural/silk = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 5

//Fishnets

/datum/crafting_recipe/roguetown/sewing/stockings_white_fishnet
	name = "white fishnet stockings"
	result = list(/obj/item/clothing/under/roguetown/tights/stockings/fishnet/white)
	reqs = list(/obj/item/natural/fibers = 2)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/stockings_black_fishnet
	name = "black fishnet stockings"
	result = list(/obj/item/clothing/under/roguetown/tights/stockings/fishnet/black)
	reqs = list(/obj/item/natural/fibers = 2)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/stockings_blue_fishnet
	name = "blue fishnet stockings"
	result = list(/obj/item/clothing/under/roguetown/tights/stockings/fishnet/blue)
	reqs = list(/obj/item/natural/fibers = 2)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/stockings_red_fishnet
	name = "red fishnet stockings"
	result = list(/obj/item/clothing/under/roguetown/tights/stockings/fishnet/red)
	reqs = list(/obj/item/natural/fibers = 2)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/stockings_purple_fishnet
	name = "purple fishnet stockings"
	result = list(/obj/item/clothing/under/roguetown/tights/stockings/fishnet/purple)
	reqs = list(/obj/item/natural/fibers = 2)
	craftdiff = 3

//SUPPLY

/datum/supply_pack/rogue/wardrobe/suits/stockings_white
	name = "White Stockings"
	cost = 10
	contains = list(
					/obj/item/clothing/under/roguetown/tights/stockings/white,
					/obj/item/clothing/under/roguetown/tights/stockings/white,
				)

/datum/supply_pack/rogue/wardrobe/suits/stockings_black
	name = "Black Stockings"
	cost = 10
	contains = list(
					/obj/item/clothing/under/roguetown/tights/stockings/black,
					/obj/item/clothing/under/roguetown/tights/stockings/black,
				)

/datum/supply_pack/rogue/wardrobe/suits/stockings_blue
	name = "Blue Stockings"
	cost = 10
	contains = list(
					/obj/item/clothing/under/roguetown/tights/stockings/blue,
					/obj/item/clothing/under/roguetown/tights/stockings/blue,
				)

/datum/supply_pack/rogue/wardrobe/suits/stockings_red
	name = "Red Stockings"
	cost = 10
	contains = list(
					/obj/item/clothing/under/roguetown/tights/stockings/red,
					/obj/item/clothing/under/roguetown/tights/stockings/red,
				)
/datum/supply_pack/rogue/wardrobe/suits/stockings_purple
	name = "Purple Stockings"
	cost = 10
	contains = list(
					/obj/item/clothing/under/roguetown/tights/stockings/purple,
					/obj/item/clothing/under/roguetown/tights/stockings/purple,
				)

//Silk

/datum/supply_pack/rogue/wardrobe/suits/stockings_white_silk
	name = "White Silk Stockings"
	cost = 30
	contains = list(
					/obj/item/clothing/under/roguetown/tights/stockings/silk/white,
					/obj/item/clothing/under/roguetown/tights/stockings/silk/white,
				)

/datum/supply_pack/rogue/wardrobe/suits/stockings_black_silk
	name = "Black Silk Stockings"
	cost = 30
	contains = list(
					/obj/item/clothing/under/roguetown/tights/stockings/silk/black,
					/obj/item/clothing/under/roguetown/tights/stockings/silk/black,
				)

/datum/supply_pack/rogue/wardrobe/suits/stockings_blue_silk
	name = "Blue Silk Stockings"
	cost = 30
	contains = list(
					/obj/item/clothing/under/roguetown/tights/stockings/silk/blue,
					/obj/item/clothing/under/roguetown/tights/stockings/silk/blue,
				)

/datum/supply_pack/rogue/wardrobe/suits/stockings_red_silk
	name = "Red Silk Stockings"
	cost = 30
	contains = list(
					/obj/item/clothing/under/roguetown/tights/stockings/silk/red,
					/obj/item/clothing/under/roguetown/tights/stockings/silk/red,
				)
/datum/supply_pack/rogue/wardrobe/suits/stockings_purple_silk
	name = "Purple Silk Stockings"
	cost = 30
	contains = list(
					/obj/item/clothing/under/roguetown/tights/stockings/silk/purple,
					/obj/item/clothing/under/roguetown/tights/stockings/silk/purple,
				)

//Fishnets

/datum/supply_pack/rogue/wardrobe/suits/stockings_white_fishnet
	name = "White Fishnet Stockings"
	cost = 5
	contains = list(
					/obj/item/clothing/under/roguetown/tights/stockings/fishnet/white,
					/obj/item/clothing/under/roguetown/tights/stockings/fishnet/white,
				)

/datum/supply_pack/rogue/wardrobe/suits/stockings_black_fishnet
	name = "Black Fishnet Stockings"
	cost = 5
	contains = list(
					/obj/item/clothing/under/roguetown/tights/stockings/fishnet/black,
					/obj/item/clothing/under/roguetown/tights/stockings/fishnet/black,
				)

/datum/supply_pack/rogue/wardrobe/suits/stockings_blue_fishnet
	name = "Blue Fishnet Stockings"
	cost = 5
	contains = list(
					/obj/item/clothing/under/roguetown/tights/stockings/fishnet/blue,
					/obj/item/clothing/under/roguetown/tights/stockings/fishnet/blue,
				)

/datum/supply_pack/rogue/wardrobe/suits/stockings_red_fishnet
	name = "Red Fishnet Stockings"
	cost = 5
	contains = list(
					/obj/item/clothing/under/roguetown/tights/stockings/fishnet/red,
					/obj/item/clothing/under/roguetown/tights/stockings/fishnet/red,
				)
/datum/supply_pack/rogue/wardrobe/suits/stockings_purple_fishnet
	name = "Purple Fishnet Stockings"
	cost = 5
	contains = list(
					/obj/item/clothing/under/roguetown/tights/stockings/fishnet/purple,
					/obj/item/clothing/under/roguetown/tights/stockings/fishnet/purple,
				)
