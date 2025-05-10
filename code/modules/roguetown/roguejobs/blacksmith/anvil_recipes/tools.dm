/datum/anvil_recipe/tools
	i_type = "Utilities"
	craftdiff = 1

// --------- Copper -----------
/datum/anvil_recipe/tools/sickle/copper
	name = "Copper Sickle (+Stick)"
	req_bar = /obj/item/ingot/copper
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/sickle/copper
	i_type = "Tools"

/datum/anvil_recipe/tools/pick/copper
	name = "Copper Pick (+Stick)"
	req_bar = /obj/item/ingot/copper
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/pick/copper
	i_type = "Tools"

/datum/anvil_recipe/tools/pitchfork/copper
	name = "Copper Pitchfork (+Stick x2)"
	req_bar = /obj/item/ingot/copper
	additional_items = list(/obj/item/grown/log/tree/stick, /obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/pitchfork/copper
	i_type = "Tools"

/datum/anvil_recipe/tools/lamptern/copper
	name = "Copper Lamptern"
	req_bar = /obj/item/ingot/copper
	created_item = /obj/item/flashlight/flare/torch/lantern/copper

/datum/anvil_recipe/tools/hammer/copper
	name = "Copper Hammer (+Stick)"
	req_bar = /obj/item/ingot/copper
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/hammer/copper
	i_type = "Tools"


// --------- IRON -----------

/datum/anvil_recipe/tools/iron/blowrod
	name = "Glass Blowing Rod"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/blowrod
	craftdiff = 0

/datum/anvil_recipe/tools/surgery/surgerytools
	name = "Surgeon's Bag (+1 Iron, +1 Cured Leather)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron, /obj/item/natural/hide/cured)
	created_item = /obj/item/storage/belt/rogue/surgery_bag/full

/datum/anvil_recipe/tools/iron/torch
	name = "Torches x5 (+1 Coal)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/rogueore/coal)
	created_item = /obj/item/flashlight/flare/torch/metal
	createditem_num = 5
	craftdiff = 0

/datum/anvil_recipe/tools/iron/shaft
	name = "Metal Shaft x2 (+1 Iron)"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/shaft/metal
	createditem_num = 2
	craftdiff = 1

/datum/anvil_recipe/tools/iron/pan
	name = "Frypan"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/cooking/pan
	craftdiff = 0

/datum/anvil_recipe/tools/iron/keyring
	name = "Keyrings x3"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/storage/keyring
	createditem_num = 3
	craftdiff = 0

/datum/anvil_recipe/tools/ironsewingneedle
	name = "Sewing Needles x3"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/needle
	createditem_num = 3 // They can be refilled with fiber now
	craftdiff = 0

/* Movning under Engineering
/datum/anvil_recipe/tools/iron/lockpicks
	name = "Lockpicks x3"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/lockpick
	createditem_num = 3
	craftdiff = 2

/datum/anvil_recipe/tools/iron/lockpickring
	name = "Lockpickrings x3"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/lockpickring
	createditem_num = 3
	craftdiff = 0
*/

/datum/anvil_recipe/tools/iron/shovel
	name = "Shovel (+2 Sticks)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick,/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/shovel
	i_type = "Tools"

/datum/anvil_recipe/tools/iron/hammer
	name = "Hammer (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/hammer/iron
	i_type = "Tools"

/datum/anvil_recipe/tools/iron/handsaw
	name = "Handsaw (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/handsaw

/datum/anvil_recipe/tools/iron/chisel
	name = "Chisel"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/chisel

/datum/anvil_recipe/tools/iron/tongs
	name = "Tongs"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/tongs
	i_type = "Tools"

/datum/anvil_recipe/tools/iron/sickle
	name = "Iron Sickle (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/sickle
	i_type = "Tools"

/datum/anvil_recipe/tools/iron/pick
	name = "Iron Pickaxe (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/pick
	i_type = "Tools"

/datum/anvil_recipe/tools/iron/hoe
	name = "Iron Hoe (+2 Sticks)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick,/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/hoe
	i_type = "Tools"

/datum/anvil_recipe/tools/iron/pitchfork
	name = "Iron Pitchfork (+2 Sticks)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick,/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/pitchfork
	i_type = "Tools"

/datum/anvil_recipe/tools/iron/lamptern
	name = "Lamptern x3"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/flashlight/flare/torch/lantern
	createditem_num = 3

/datum/anvil_recipe/tools/iron/cups
	name = "Cups x3"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/reagent_containers/glass/cup
	createditem_num = 3
	craftdiff = 0

/datum/anvil_recipe/tools/iron/thresher
	name = "Thresher (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/thresher
	i_type = "Tools"

/datum/anvil_recipe/tools/scissors
	name = "Scissors"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/huntingknife/scissors
	i_type = "Tools"

// --------- Steel -----------

/datum/anvil_recipe/tools/steel/hammer
	name = "Claw hammer (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/hammer/steel

/datum/anvil_recipe/tools/steel/pick
	name = "Pickaxe (+1 Stick)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/pick/steel
	i_type = "Tools"

/datum/anvil_recipe/tools/steel/cups
	name = "Goblets x3"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/reagent_containers/glass/cup/steel
	createditem_num = 3

/datum/anvil_recipe/tools/steel/chefknife
	name = "Chef's Knife"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/huntingknife/chefknife
	createditem_num = 1

/datum/anvil_recipe/tools/steel/cleaver
	name = "Cleaver"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/huntingknife/cleaver
	createditem_num = 1

/datum/anvil_recipe/tools/steelscissors
	name = "Scissors"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/huntingknife/scissors/steel
	i_type = "Tools"


// --------- SILVER -----------

/datum/anvil_recipe/tools/silver/cups
	name = "Goblets x3"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/reagent_containers/glass/cup/silver
	createditem_num = 3
	craftdiff = 2

// --------- GOLD RECIPES-----------

/datum/anvil_recipe/tools/gold/cups
	name = "Goblets x3"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/reagent_containers/glass/cup/golden
	createditem_num = 3
	craftdiff = 2

// --------- BRONZE RECIPES -----------

// --------- COOKING RECIPES -----------
/datum/anvil_recipe/tools/iron/pot
	name = "Cooking Pot (Iron)"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/reagent_containers/glass/bucket/pot

/datum/anvil_recipe/tools/pote/copper
	name = "Cooking Pot (Copper)"
	req_bar = /obj/item/ingot/copper
	created_item = /obj/item/reagent_containers/glass/bucket/pot/copper

/datum/anvil_recipe/tools/platter
	name = "Platters (Copper) x3"
	req_bar = /obj/item/ingot/copper
	created_item = /obj/item/cooking/platter/copper
	createditem_num = 3
	craftdiff = 1

/datum/anvil_recipe/tools/platter/tin
	name = "Platters (Tin) x3"
	req_bar = /obj/item/ingot/tin
	created_item = /obj/item/cooking/platter/pewter
	createditem_num = 3
	craftdiff = 1

/datum/anvil_recipe/tools/platter/gold
	name = "Platters (Gold) x3"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/cooking/platter/gold
	createditem_num = 3
	craftdiff = 2

/datum/anvil_recipe/tools/platter/silver
	name = "Platters (Silver) x3"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/cooking/platter/silver
	createditem_num = 3
	craftdiff = 2

/datum/anvil_recipe/tools/spoon
	name = "Iron Spoon x3"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/kitchen/spoon/iron
	createditem_num = 3
	craftdiff = 1

/datum/anvil_recipe/tools/spoon/tin
	name = "Tin Spoon x3"
	req_bar = /obj/item/ingot/tin
	created_item = /obj/item/kitchen/spoon/tin
	createditem_num = 3
	craftdiff = 1

/datum/anvil_recipe/tools/fork
	name = "Iron Fork x3"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/kitchen/fork/iron
	createditem_num = 3
	craftdiff = 1

/datum/anvil_recipe/tools/fork/tin
	name = "Tin Fork x3"
	req_bar = /obj/item/ingot/tin
	created_item = /obj/item/kitchen/fork/tin
	createditem_num = 3
	craftdiff = 1

/datum/anvil_recipe/tools/iron/bowl
	name = "Iron Bowl"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/reagent_containers/glass/bowl/iron
	craftdiff = 1
