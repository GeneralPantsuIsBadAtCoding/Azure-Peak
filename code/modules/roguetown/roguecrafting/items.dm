/datum/crafting_recipe/roguetown
	always_availible = TRUE
	skillcraft = /datum/skill/craft/crafting


/datum/crafting_recipe/roguetown/tneedle
	name = "sewing needle"
	result = /obj/item/needle/thorn
	reqs = list(/obj/item/natural/thorn = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/cloth
	name = "cloth"
	result = /obj/item/natural/cloth
	reqs = list(/obj/item/natural/fibers = 2)
	tools = list(/obj/item/needle)
	skillcraft = /datum/skill/misc/sewing
	verbage_simple = "sew"
	verbage = "sews"
	craftdiff = 0

/datum/crafting_recipe/roguetown/cloth5x
	name = "cloth 5x"
	result = list(
				/obj/item/natural/cloth,
				/obj/item/natural/cloth,
				/obj/item/natural/cloth,
				/obj/item/natural/cloth,
				/obj/item/natural/cloth,
				)
	reqs = list(/obj/item/natural/fibers = 10)
	tools = list(/obj/item/needle)
	skillcraft = /datum/skill/misc/sewing
	verbage_simple = "sew"
	verbage = "sews"
	craftdiff = 0

/datum/crafting_recipe/roguetown/clothbelt
	name = "cloth belt"
	result = /obj/item/storage/belt/rogue/leather/cloth
	reqs = list(/obj/item/natural/cloth = 1)
	craftdiff = 0
	verbage_simple = "tie"
	verbage = "ties"

/datum/crafting_recipe/roguetown/unclothbelt
	name = "untie cloth belt"
	result = /obj/item/natural/cloth
	reqs = list(/obj/item/storage/belt/rogue/leather/cloth = 1)
	craftdiff = 0
	verbage_simple = "untie"
	verbage = "unties"

/datum/crafting_recipe/roguetown/ropebelt
	name = "rope belt"
	result = /obj/item/storage/belt/rogue/leather/rope
	reqs = list(/obj/item/rope = 1)
	craftdiff = 0
	verbage_simple = "tie"
	verbage = "ties"

/datum/crafting_recipe/roguetown/unropebelt
	name = "untie rope belt"
	result = /obj/item/rope
	reqs = list(/obj/item/storage/belt/rogue/leather/rope = 1)
	craftdiff = 0
	verbage_simple = "untie"
	verbage = "unties"

/datum/crafting_recipe/roguetown/rope
	name = "rope"
	result = /obj/item/rope
	reqs = list(/obj/item/natural/fibers = 3)
	verbage_simple = "braid"
	verbage = "braids"

/datum/crafting_recipe/roguetown/net
	name = "net"
	result = /obj/item/net
	craftdiff = 2
	reqs = list(/obj/item/rope = 2,
				/obj/item/natural/stone = 3)
	verbage_simple = "braid"
	verbage = "braids"

/datum/crafting_recipe/roguetown/bowstring
	name = "fiber bowstring"
	result = /obj/item/natural/bowstring
	reqs = list(/obj/item/natural/fibers = 2)
	verbage_simple = "twist"
	verbage = "twists"

/datum/crafting_recipe/roguetown/bowpartial
	name = "unstrung bow"
	result = /obj/item/grown/log/tree/bowpartial
	reqs = list(/obj/item/grown/log/tree/small = 1)
	tools = /obj/item/rogueweapon/huntingknife
	verbage_simple = "carve"
	verbage = "carves"

/datum/crafting_recipe/roguetown/bow
	name = "wooden bow"
	result = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	reqs = list(/obj/item/natural/bowstring = 1, /obj/item/grown/log/tree/bowpartial = 1)
	verbage_simple = "string together"
	verbage = "strings together"
	craftdiff = 2

/datum/crafting_recipe/roguetown/recurvepartial
	name = "unstrung recurve bow"
	result = /obj/item/grown/log/tree/bowpartial/recurve
	reqs = list(
		/obj/item/grown/log/tree = 1,
		/obj/item/natural/bone = 2,
		/obj/item/reagent_containers/food/snacks/tallow = 1,
		/obj/item/natural/fibers = 2,
	)
	tools = /obj/item/rogueweapon/huntingknife
	verbage_simple = "carve"
	verbage = "carves"
	craftdiff = 3

/datum/crafting_recipe/roguetown/recurvebow
	name = "recurve bow"
	result = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
	reqs = list(
		/obj/item/natural/bowstring = 1,
		/obj/item/grown/log/tree/bowpartial/recurve = 1,
		)
	verbage_simple = "string together"
	verbage = "strings together"
	craftdiff = 3

/datum/crafting_recipe/roguetown/longbowpartial
	name = "unstrung long bow"
	result = /obj/item/grown/log/tree/bowpartial/longbow
	reqs = list(
		/obj/item/grown/log/tree = 1,
		/obj/item/natural/cloth = 1,
		/obj/item/reagent_containers/food/snacks/tallow = 1,
		/obj/item/natural/fibers = 2,
	)
	tools = /obj/item/rogueweapon/huntingknife
	verbage_simple = "carve"
	verbage = "carves"
	craftdiff = 4

/datum/crafting_recipe/roguetown/longbow
	name = "long bow"
	result = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/longbow
	reqs = list(
		/obj/item/natural/bowstring = 1,
		/obj/item/grown/log/tree/bowpartial/longbow = 1,
		)
	verbage_simple = "string together"
	verbage = "strings together"
	craftdiff = 5

/datum/crafting_recipe/roguetown/wickercloak
	name = "wickercloak"
	result = /obj/item/clothing/cloak/wickercloak
	reqs = list(/obj/item/natural/dirtclod = 1,
				/obj/item/grown/log/tree/stick = 5,
				/obj/item/natural/fibers = 3)
	craftdiff = 0

/datum/crafting_recipe/roguetown/torch
	name = "torch"
	result = /obj/item/flashlight/flare/torch
	reqs = list(/obj/item/grown/log/tree/stick = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/soap
	name = "soap (3x)"
	result = list(
				/obj/item/soap,
				/obj/item/soap,
				/obj/item/soap,
				)
	reqs = list(/obj/item/reagent_containers/food/snacks/tallow = 1)

/datum/crafting_recipe/roguetown/candle
	name = "candle (x3)"
	result = list(
				/obj/item/candle/yellow,
				/obj/item/candle/yellow,
				/obj/item/candle/yellow,
				)
	reqs = list(/obj/item/reagent_containers/food/snacks/tallow = 1)

/datum/crafting_recipe/roguetown/stoneaxe
	name = "stone axe"
	result = /obj/item/rogueweapon/stoneaxe
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/stone = 1)

/datum/crafting_recipe/roguetown/stonehammer
	name = "stone hammer"
	result = /obj/item/rogueweapon/hammer/stone
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/stone = 1)

/datum/crafting_recipe/roguetown/stonehoe
	name = "stone hoe"
	result = /obj/item/rogueweapon/hoe/stone
	reqs = list(/obj/item/grown/log/tree/small = 2,
				/obj/item/natural/fibers = 1,
				/obj/item/natural/stone = 1)

/datum/crafting_recipe/roguetown/stonetongs
	name = "stone tongs"
	result = /obj/item/rogueweapon/tongs/stone
	reqs = list(/obj/item/grown/log/tree/stick = 2,
				/obj/item/natural/stone = 1)

/datum/crafting_recipe/roguetown/stonepick
	name = "stone pick"
	result = /obj/item/rogueweapon/pick/stone
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/stone = 2)

/datum/crafting_recipe/roguetown/stoneknife
	name = "stone knife"
	result = /obj/item/rogueweapon/huntingknife/stoneknife
	reqs = list(/obj/item/grown/log/tree/stick = 1,
				/obj/item/natural/stone = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/stonespear
	name = "stone spear"
	result = /obj/item/rogueweapon/spear/stone
	reqs = list(/obj/item/rogueweapon/woodstaff = 1,
				/obj/item/natural/stone = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/stonesword
	name = "stone sword"
	result = /obj/item/rogueweapon/sword/stone
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/fibers = 1,
				/obj/item/natural/stone = 3)
	craftdiff = 1


/datum/crafting_recipe/roguetown/woodclub
	name = "wood club"
	result = /obj/item/rogueweapon/mace/woodclub/crafted
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/roguetown/billhook
	name = "improvised billhook"
	result = /obj/item/rogueweapon/spear/improvisedbillhook
	reqs = list(/obj/item/rogueweapon/sickle = 1,
				/obj/item/rope = 1,
				/obj/item/grown/log/tree/small = 1)
	tools = list(/obj/item/rogueweapon/hammer)
	craftdiff = 3

/datum/crafting_recipe/roguetown/goedendag
	name = "goedendag"
	result = /obj/item/rogueweapon/mace/goden
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/rope = 1,
				/obj/item/rogueweapon/hoe = 1)
	tools = list(/obj/item/rogueweapon/hammer)
	craftdiff = 3

/datum/crafting_recipe/roguetown/peasantwarflail
	name = "peasant war flail"
	result = /obj/item/rogueweapon/flail/peasantwarflail
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/rope = 1,
				/obj/item/rogueweapon/thresher = 1)
	tools = list(/obj/item/rogueweapon/hammer)
	craftdiff = 3

/obj/item/rogueweapon/mace/woodclub/crafted
	sellprice = 8

/datum/crafting_recipe/roguetown/woodstaff
	name = "wood staff"
	result = list(/obj/item/rogueweapon/woodstaff,
	/obj/item/rogueweapon/woodstaff,
	/obj/item/rogueweapon/woodstaff)
	reqs = list(/obj/item/grown/log/tree = 1)

/datum/crafting_recipe/roguetown/woodsword
	name = "wood sword"
	result = list(/obj/item/rogueweapon/mace/wsword,
					/obj/item/rogueweapon/mace/wsword)
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/woodshield
	name = "wooden shield"
	result = /obj/item/rogueweapon/shield/wood/crafted
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/hide = 1)
	skillcraft = /datum/skill/craft/carpentry

/datum/crafting_recipe/roguetown/spoon
	name = "spoon (x3)"
	result = list(/obj/item/kitchen/spoon,
				/obj/item/kitchen/spoon,
				/obj/item/kitchen/spoon)
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/roguetown/fork
	name = "fork (x3)"
	result = list(/obj/item/kitchen/fork,
				/obj/item/kitchen/fork,
				/obj/item/kitchen/fork)
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/roguetown/platter
	name = "platter (x2)"
	result = list(/obj/item/cooking/platter,
				/obj/item/cooking/platter)
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/roguetown/rollingpin
	name = "rollingpin"
	result = /obj/item/kitchen/rollingpin
	reqs = list(/obj/item/grown/log/tree/small = 1)

/obj/item/rogueweapon/shield/wood/crafted
	sellprice = 6

/datum/crafting_recipe/roguetown/woodbucket
	name = "wooden bucket"
	result = /obj/item/reagent_containers/glass/bucket/wooden
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/roguetown/woodcup
	name = "wooden cups (x3)"
	result = list(/obj/item/reagent_containers/glass/cup/wooden/crafted,
				/obj/item/reagent_containers/glass/cup/wooden/crafted,
				/obj/item/reagent_containers/glass/cup/wooden/crafted)
	reqs = list(/obj/item/grown/log/tree/small = 1)

/obj/item/reagent_containers/glass/cup/wooden/crafted
	sellprice = 3

/datum/crafting_recipe/roguetown/woodtray
	name = "wooden trays (x2)"
	result = list(/obj/item/storage/bag/tray,
				/obj/item/storage/bag/tray)
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/roguetown/woodbowl
	name = "wooden bowls (x3)"
	result = list(/obj/item/reagent_containers/glass/bowl,
				/obj/item/reagent_containers/glass/bowl,
				/obj/item/reagent_containers/glass/bowl)
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/roguetown/pot
	name = "stone pot"
	result = /obj/item/reagent_containers/glass/bucket/pot/stone
	reqs = list(/obj/item/natural/stone = 2)

/datum/crafting_recipe/roguetown/stonearrow
	name = "stone arrow"
	result = /obj/item/ammo_casing/caseless/rogue/arrow/stone
	reqs = list(/obj/item/grown/log/tree/stick = 1,
				/obj/item/natural/stone = 1)
	req_table = TRUE

/datum/crafting_recipe/roguetown/stonearrow_five
	name = "stone arrow (x5)"
	result = list(
				/obj/item/ammo_casing/caseless/rogue/arrow/stone,
				/obj/item/ammo_casing/caseless/rogue/arrow/stone,
				/obj/item/ammo_casing/caseless/rogue/arrow/stone,
				/obj/item/ammo_casing/caseless/rogue/arrow/stone,
				/obj/item/ammo_casing/caseless/rogue/arrow/stone
				)
	reqs = list(/obj/item/grown/log/tree/stick = 5,
				/obj/item/natural/stone = 5)
	req_table = TRUE

/datum/crafting_recipe/roguetown/poisonarrow
	name = "poisoned arrow"
	result = /obj/item/ammo_casing/caseless/rogue/arrow/poison
	reqs = list(
				/obj/item/ammo_casing/caseless/rogue/arrow/iron = 1,
				/datum/reagent/berrypoison = 5
				)
	req_table = TRUE

/datum/crafting_recipe/roguetown/poisonarrow_stone
	name = "poisoned stone arrow"
	result = /obj/item/ammo_casing/caseless/rogue/arrow/stone/poison
	reqs = list(
				/obj/item/ammo_casing/caseless/rogue/arrow/stone = 1,
				/datum/reagent/berrypoison = 5
				)
	req_table = TRUE

/*
/datum/crafting_recipe/roguetown/poisonbolt //Coded, but commented out pending balance discussion.
	name = "poisoned bolt"
	result = /obj/item/ammo_casing/caseless/rogue/bolt/poison
	reqs = list(/obj/item/ammo_casing/caseless/rogue/bolt = 1,
				/datum/reagent/berrypoison = 5)

	req_table = TRUE
*/
/datum/crafting_recipe/roguetown/poisonarrow_five //Arrows and bolts can be smithed in batches of five. Makes sense for them to be dipped in batches of five, too
	name = "poisoned arrow (x5)"
	result = list(
				/obj/item/ammo_casing/caseless/rogue/arrow/poison,
				/obj/item/ammo_casing/caseless/rogue/arrow/poison,
				/obj/item/ammo_casing/caseless/rogue/arrow/poison,
				/obj/item/ammo_casing/caseless/rogue/arrow/poison,
				/obj/item/ammo_casing/caseless/rogue/arrow/poison
				)
	reqs = list(
				/obj/item/ammo_casing/caseless/rogue/arrow/iron = 5,
				/datum/reagent/berrypoison = 25
				)

	req_table = TRUE

/*
/datum/crafting_recipe/roguetown/poisonbolt_five //Coded, but commented out pending balance discussion.
	name = "poisoned bolts (x5)"
	result = list(/obj/item/ammo_casing/caseless/rogue/bolt/poison = 5)
	reqs = list(/obj/item/ammo_casing/caseless/rogue/bolt = 5,
				/datum/reagent/berrypoison = 25)

	req_table = TRUE
*/
/datum/crafting_recipe/roguetown/poisonarrow_five_stone
	name = "poisoned stone arrow (x5)"
	result = list(
				/obj/item/ammo_casing/caseless/rogue/arrow/stone/poison,
				/obj/item/ammo_casing/caseless/rogue/arrow/stone/poison,
				/obj/item/ammo_casing/caseless/rogue/arrow/stone/poison,
				/obj/item/ammo_casing/caseless/rogue/arrow/stone/poison,
				/obj/item/ammo_casing/caseless/rogue/arrow/stone/poison
				)
	reqs = list(
				/obj/item/ammo_casing/caseless/rogue/arrow/stone = 5,
				/datum/reagent/berrypoison = 25
				)

	req_table = TRUE

//pyro arrow crafting, from stonekeep
/datum/crafting_recipe/roguetown/pyrobolt
	name = "pyroclastic bolt"
	result = /obj/item/ammo_casing/caseless/rogue/bolt/pyro
	reqs = list(/obj/item/ammo_casing/caseless/rogue/bolt = 1,
				/obj/item/reagent_containers/food/snacks/grown/rogue/fyritius = 1)
	req_table = TRUE
	craftdiff = 1
	skillcraft = /datum/skill/craft/engineering

/datum/crafting_recipe/roguetown/pyrobolt_five
	name = "pyroclastic bolt (x5)"
	result = list(
				/obj/item/ammo_casing/caseless/rogue/bolt/pyro,
				/obj/item/ammo_casing/caseless/rogue/bolt/pyro,
				/obj/item/ammo_casing/caseless/rogue/bolt/pyro,
				/obj/item/ammo_casing/caseless/rogue/bolt/pyro,
				/obj/item/ammo_casing/caseless/rogue/bolt/pyro
				)
	reqs = list(/obj/item/ammo_casing/caseless/rogue/bolt = 5,
				/obj/item/reagent_containers/food/snacks/grown/rogue/fyritius = 5)
	req_table = TRUE
	craftdiff = 1
	skillcraft = /datum/skill/craft/engineering

/datum/crafting_recipe/roguetown/pyroarrow
	name = "pyroclastic arrow"
	result = /obj/item/ammo_casing/caseless/rogue/arrow/pyro
	reqs = list(/obj/item/ammo_casing/caseless/rogue/arrow/iron = 1,
				/obj/item/reagent_containers/food/snacks/grown/rogue/fyritius = 1)
	req_table = TRUE
	craftdiff = 1
	skillcraft = /datum/skill/craft/engineering

/datum/crafting_recipe/roguetown/pyroarrow_five
	name = "pyroclastic arrow (x5)"
	result = list(
				/obj/item/ammo_casing/caseless/rogue/arrow/pyro,
				/obj/item/ammo_casing/caseless/rogue/arrow/pyro,
				/obj/item/ammo_casing/caseless/rogue/arrow/pyro,
				/obj/item/ammo_casing/caseless/rogue/arrow/pyro,
				/obj/item/ammo_casing/caseless/rogue/arrow/pyro
				)
	reqs = list(/obj/item/ammo_casing/caseless/rogue/arrow/iron = 5,
				/obj/item/reagent_containers/food/snacks/grown/rogue/fyritius = 5)
	req_table = TRUE
	craftdiff = 1
	skillcraft = /datum/skill/craft/engineering

/datum/crafting_recipe/roguetown/mortar
	name = "stone mortar"
	result = /obj/item/reagent_containers/glass/mortar
	reqs = list(/obj/item/natural/stone = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/pestle
	name = "stone pestle"
	result = /obj/item/pestle
	reqs = list(/obj/item/natural/stone = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/bag
	name = "bag"
	result = /obj/item/storage/roguebag/crafted
	reqs = list(/obj/item/natural/fibers = 1,
				/obj/item/natural/cloth = 1)
	tools = list(/obj/item/needle)
	skillcraft = /datum/skill/misc/sewing

/datum/crafting_recipe/roguetown/bagx5
	name = "bag x5"
	result = list(
				/obj/item/storage/roguebag/crafted,
				/obj/item/storage/roguebag/crafted,
				/obj/item/storage/roguebag/crafted,
				/obj/item/storage/roguebag/crafted,
				/obj/item/storage/roguebag/crafted,
				)
	reqs = list(/obj/item/natural/fibers = 5,
				/obj/item/natural/cloth = 5)
	tools = list(/obj/item/needle)
	skillcraft = /datum/skill/misc/sewing
	req_table = FALSE

/obj/item/storage/roguebag/crafted
	sellprice = 4


/datum/crafting_recipe/roguetown/bait
	name = "bait"
	result = /obj/item/bait
	reqs = list(/obj/item/storage/roguebag = 1,
				/obj/item/reagent_containers/food/snacks/grown/wheat = 2)
	subtype_reqs = TRUE

/datum/crafting_recipe/roguetown/sbaita
	name = "sweetbait (apple)"
	result = /obj/item/bait/sweet
	reqs = list(/obj/item/storage/roguebag = 1,
				/obj/item/reagent_containers/food/snacks/grown/apple = 2)
	subtype_reqs = TRUE

/datum/crafting_recipe/roguetown/sbait
	name = "sweetbait (berry)"
	result = /obj/item/bait/sweet
	reqs = list(/obj/item/storage/roguebag = 1,
				/obj/item/reagent_containers/food/snacks/grown/berries/rogue = 2)
	subtype_reqs = TRUE

/datum/crafting_recipe/roguetown/bloodbait
	name = "bloodbait"
	result = /obj/item/bait/bloody
	reqs = list(/obj/item/storage/roguebag = 1,
				/obj/item/reagent_containers/food/snacks/rogue/meat = 2)
	subtype_reqs = TRUE

/datum/crafting_recipe/roguetown/pipe
	name = "wood pipe"
	result = /obj/item/clothing/mask/cigarette/pipe/crafted
	reqs = list(/obj/item/grown/log/tree/small = 1)


/obj/item/clothing/mask/cigarette/pipe/crafted
	sellprice = 6

/datum/crafting_recipe/roguetown/rod
	name = "fishing rod"
	result = /obj/item/fishingrod/crafted
	reqs = list(/obj/item/grown/log/tree/small = 1,
		/obj/item/natural/fibers = 2)


/obj/item/fishingrod/crafted
	sellprice = 8

/datum/crafting_recipe/roguetown/woodspade
	name = "wood spade"
	result = /obj/item/rogueweapon/shovel/small
	reqs = list(/obj/item/grown/log/tree/small = 1,
			/obj/item/grown/log/tree/stick = 1)
/obj/item/rogueweapon/shovel/small/crafted
	sellprice = 5

/datum/crafting_recipe/roguetown/broom
	name = "broom"
	result = /obj/item/broom
	reqs = list(/obj/item/natural/fibers = 1,
			/obj/item/grown/log/tree/stick = 4)
	craftdiff = 1

/datum/crafting_recipe/roguetown/book_crafting_kit
	name = "book crafting kit"
	result = /obj/item/book_crafting_kit
	reqs = list(
			/obj/item/natural/hide = 2,
			/obj/item/natural/cloth = 1)
	tools = list(/obj/item/needle = 1)
	req_table = TRUE

/datum/crafting_recipe/roguetown/woodcross
	name = "wooden amulet"
	result = /obj/item/clothing/neck/roguetown/psicross/wood
	reqs = list(/obj/item/natural/fibers = 2,
				/obj/item/grown/log/tree/stick = 2)

/datum/crafting_recipe/roguetown/mantrap
	name = "mantrap"
	result = list(/obj/item/restraints/legcuffs/beartrap,
				/obj/item/restraints/legcuffs/beartrap)
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/fibers = 2,
				/obj/item/ingot/iron = 1)
	req_table = TRUE
	skillcraft = /datum/skill/craft/traps
	craftdiff = 1
	verbage_simple = "put together"
	verbage = "puts together"

/datum/crafting_recipe/roguetown/paperscroll
	name = "scroll of parchment"
	result = list(/obj/item/paper/scroll,
				  /obj/item/paper/scroll,
				  /obj/item/paper/scroll)
	reqs = list(/obj/item/grown/log/tree/small = 1,
	/datum/reagent/water = 48)
	structurecraft = /obj/machinery/tanningrack
	craftdiff = 1

/datum/crafting_recipe/roguetown/tribalrags
	name = "tribal rags"
	result = /obj/item/clothing/suit/roguetown/shirt/tribalrag
	reqs = list(/obj/item/natural/hide = 1,
				/obj/item/natural/fibers = 1)
	sellprice = 6
	tools = list(/obj/item/needle)
	skillcraft = /datum/skill/misc/sewing
	verbage_simple = "sew"
	verbage = "sews"
	craftdiff = 0

/datum/crafting_recipe/roguetown/skullmask
	name = "skull mask"
	result = /obj/item/clothing/mask/rogue/skullmask
	reqs = list(/obj/item/natural/bone = 3,
				/obj/item/natural/fibers = 1)
	sellprice = 10
	verbage_simple = "craft"
	verbage = "crafted"
	craftdiff = 0


/datum/crafting_recipe/roguetown/antlerhood
	name = "antlerhood"
	result = /obj/item/clothing/head/roguetown/antlerhood
	reqs = list(/obj/item/natural/hide = 1,
				/obj/item/natural/bone = 2)
	sellprice = 12
	tools = list(/obj/item/needle)
	skillcraft = /datum/skill/misc/sewing
	verbage_simple = "sew"
	verbage = "sews"
	craftdiff = 0

/datum/crafting_recipe/roguetown/bonespear
	name = "bone spear"
	result = /obj/item/rogueweapon/spear/bonespear
	reqs = list(/obj/item/rogueweapon/woodstaff = 1,
				/obj/item/natural/bone = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3


/datum/crafting_recipe/roguetown/boneaxe
	name = "bone axe"
	result = /obj/item/rogueweapon/stoneaxe/boneaxe
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/bone = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/prosthetic/woodleftarm
	name = "wood arm (L)"
	result = list(/obj/item/bodypart/l_arm/prosthetic/woodleft)
	reqs = list(/obj/item/grown/log/tree/small = 1)
	skillcraft = /datum/skill/craft/crafting
	craftdiff = 3

/datum/crafting_recipe/roguetown/prosthetic/woodrightarm
	name = "wood arm (R)"
	result = list(/obj/item/bodypart/r_arm/prosthetic/woodright)
	reqs = list(/obj/item/grown/log/tree/small = 1)
	skillcraft = /datum/skill/craft/crafting
	craftdiff = 3

/datum/crafting_recipe/roguetown/prosthetic/woodleftleft
	name = "wood leg (L)"
	result = list(/obj/item/bodypart/l_leg/prosthetic)
	reqs = list(/obj/item/grown/log/tree/small = 1)
	skillcraft = /datum/skill/craft/crafting
	craftdiff = 3

/datum/crafting_recipe/roguetown/prosthetic/woodrightleg
	name = "wood leg (R)"
	result = list(/obj/item/bodypart/r_leg/prosthetic)
	reqs = list(/obj/item/grown/log/tree/small = 1)
	skillcraft = /datum/skill/craft/crafting
	craftdiff = 3

/datum/crafting_recipe/roguetown/tarot_deck
	name = "tarot deck"
	result = list(/obj/item/toy/cards/deck/tarot)
	reqs = list(/obj/item/paper/scroll = 3,
				/obj/item/grown/log/tree/small = 1,
				/obj/item/ash = 1)
	skillcraft = /datum/skill/misc/reading
	tools = list(/obj/item/natural/feather)
	req_table = TRUE
	craftdiff = 2

// Woodcutting recipe
/datum/crafting_recipe/roguetown/lumberjacking
	skillcraft = /datum/skill/labor/lumberjacking
	tools = list(/obj/item/rogueweapon/huntingknife = 1)

/datum/crafting_recipe/roguetown/lumberjacking/cart_upgrade
	name = "woodcutters wheelbrace"
	result = /obj/item/cart_upgrade/level_1
	reqs = list(/obj/item/grown/log/tree/small = 2,
				/obj/item/natural/stone = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/lumberjacking/cart_upgrade2
	name = "reinforced woodcutters wheelbrace"
	result = /obj/item/cart_upgrade/level_2
	reqs = list(/obj/item/grown/log/tree/small = 4,
				/obj/item/cart_upgrade/level_1 = 1,
				/obj/item/ingot/iron = 1)
	craftdiff = 4


/datum/crafting_recipe/roguetown/heatershield
	name = "heater shield"
	result = /obj/item/rogueweapon/shield/heater/crafted
	reqs = list(/obj/item/grown/log/tree/small = 2,
				/obj/item/natural/hide/cured = 1)
	skillcraft = /datum/skill/craft/carpentry

/obj/item/rogueweapon/shield/heater/crafted
	sellprice = 6

/datum/crafting_recipe/roguetown/collar
	name = "collar"
	result = /obj/item/clothing/neck/roguetown/collar
	reqs = list(/obj/item/natural/hide/cured = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/bell_collar
	name = "bell Collar"
	result = /obj/item/clothing/neck/roguetown/collar/bell_collar
	reqs = list(
				/obj/item/natural/hide/cured = 1,
				/obj/item/jingle_bells = 1,
				)
	craftdiff = 0

/datum/crafting_recipe/roguetown/feldcollar
	name = "feldcollar"
	result = /obj/item/clothing/neck/roguetown/collar/feldcollar
	reqs = list(/obj/item/natural/cloth = 2)
	craftdiff = 0

/datum/crafting_recipe/roguetown/surgcollar
	name = "surgcollar"
	result = /obj/item/clothing/neck/roguetown/collar/surgcollar
	reqs = list(/obj/item/natural/cloth = 2)
	craftdiff = 0
	
// BOUQUETS & CROWNS

/datum/crafting_recipe/roguetown/bouquet_rosa
	name = "rosa bouquet"
	result = /obj/item/bouquet/rosa
	reqs = list(/obj/item/alch/rosa = 4,
				/obj/item/natural/fibers = 2,
				/obj/item/paper/scroll = 1)
	craftdiff = 0
	verbage_simple = "arranged"
	verbage = "arranges"

/datum/crafting_recipe/roguetown/bouquet_salvia
	name = "salvia bouquet"
	result = /obj/item/bouquet/salvia
	reqs = list(/obj/item/alch/salvia = 4,
				/obj/item/natural/fibers = 2,
				/obj/item/paper/scroll = 1)
	craftdiff = 0
	verbage_simple = "arranged"
	verbage = "arranges"

/datum/crafting_recipe/roguetown/bouquet_matricaria
	name = "matricaria bouquet"
	result = /obj/item/bouquet/matricaria
	reqs = list(/obj/item/alch/matricaria = 4,
				/obj/item/natural/fibers = 2,
				/obj/item/paper/scroll = 1)
	craftdiff = 0
	verbage_simple = "arranged"
	verbage = "arranges"

/datum/crafting_recipe/roguetown/bouquet_calendula
	name = "calendula bouquet"
	result = /obj/item/bouquet/calendula
	reqs = list(/obj/item/alch/calendula = 4,
				/obj/item/natural/fibers = 2,
				/obj/item/paper/scroll = 1)
	craftdiff = 0
	verbage_simple = "arranged"
	verbage = "arranges"

/datum/crafting_recipe/roguetown/flowercrown_rosa
	name = "rosa crown"
	result = /obj/item/flowercrown/rosa
	reqs = list(/obj/item/alch/rosa = 4,
				/obj/item/natural/fibers = 2)
	craftdiff = 0
	verbage_simple = "tied"
	verbage = "ties"

/datum/crafting_recipe/roguetown/flowercrown_salvia
	name = "salvia crown"
	result = /obj/item/flowercrown/salvia
	reqs = list(/obj/item/alch/salvia = 4,
				/obj/item/natural/fibers = 2)
	craftdiff = 0
	verbage_simple = "tied"
	verbage = "ties"

/datum/crafting_recipe/roguetown/candle/eora
	name = "eora's candle (x3)"
	result = list(
				/obj/item/candle/eora,
				/obj/item/candle/eora,
				/obj/item/candle/eora,
				)
	reqs = list(/obj/item/reagent_containers/food/snacks/tallow = 1,
				/obj/item/alch/rosa = 1,
				/datum/reagent/water/blessed = 25)

/datum/crafting_recipe/roguetown/slingcraft
	name = "sling"
	result = /obj/item/gun/ballistic/revolver/grenadelauncher/sling
	reqs = list(/obj/item/natural/fibers = 6)
	verbage_simple = "twist"
	verbage = "twists"
	craftdiff = 1 //you should make some ammo first!
	
/datum/crafting_recipe/roguetown/slingpouchcraft
	name = "sling bullet pouch"
	result = /obj/item/quiver/sling/
	reqs = list(/obj/item/natural/fibers = 1, /obj/item/natural/cloth = 1)
	verbage_simple = "craft"
	verbage = "crafts"
	craftdiff = 0

/datum/crafting_recipe/roguetown/stonebullets
	name = "stone sling bullets (x2)"
	result = list(
				/obj/item/ammo_casing/caseless/rogue/sling_bullet/stone,
				/obj/item/ammo_casing/caseless/rogue/sling_bullet/stone,
				)
	reqs = list(/obj/item/natural/stone = 1)
	verbage_simple = "smooth"
	verbage = "smooths"
	craftdiff = 0
	
/datum/crafting_recipe/roguetown/stonebullets10x
	name = "stone sling bullets (x10)"
	result = list(
				/obj/item/ammo_casing/caseless/rogue/sling_bullet/stone,
				/obj/item/ammo_casing/caseless/rogue/sling_bullet/stone,
				/obj/item/ammo_casing/caseless/rogue/sling_bullet/stone,
				/obj/item/ammo_casing/caseless/rogue/sling_bullet/stone,
				/obj/item/ammo_casing/caseless/rogue/sling_bullet/stone,
				/obj/item/ammo_casing/caseless/rogue/sling_bullet/stone,
				/obj/item/ammo_casing/caseless/rogue/sling_bullet/stone,
				/obj/item/ammo_casing/caseless/rogue/sling_bullet/stone,
				/obj/item/ammo_casing/caseless/rogue/sling_bullet/stone,
				/obj/item/ammo_casing/caseless/rogue/sling_bullet/stone,
				)
	reqs = list(/obj/item/natural/stone = 5)
	verbage_simple = "smooth"
	verbage = "smooths"
	craftdiff = 0

/datum/crafting_recipe/hair_dye
    name = "hair dye cream"
    result = /obj/item/hair_dye_cream
    reqs = list(
        /obj/item/reagent_containers/glass/bowl = 1,
        /obj/item/reagent_containers/food/snacks/grown/berries/rogue = 3
    )

/datum/crafting_recipe/d4
	name = "bone die (d4)"
	result = /obj/item/dice/d4
	reqs = list(/obj/item/natural/bone = 1)
	tools = /obj/item/rogueweapon/huntingknife
	craftdiff = 1

/datum/crafting_recipe/d6
	name = "bone die (d6)"
	result = /obj/item/dice/d6
	reqs = list(/obj/item/natural/bone = 1)
	tools = /obj/item/rogueweapon/huntingknife
	craftdiff = 1

/datum/crafting_recipe/d8
	name = "bone die (d8)"
	result = /obj/item/dice/d8
	reqs = list(/obj/item/natural/bone = 1)
	tools = /obj/item/rogueweapon/huntingknife
	craftdiff = 2

/datum/crafting_recipe/d10
	name = "bone die (d10)"
	result = /obj/item/dice/d10
	reqs = list(/obj/item/natural/bone = 1)
	tools = /obj/item/rogueweapon/huntingknife
	craftdiff = 2

/datum/crafting_recipe/d12
	name = "bone die (d12)"
	result = /obj/item/dice/d12
	reqs = list(/obj/item/natural/bone = 1)
	tools = /obj/item/rogueweapon/huntingknife
	craftdiff = 2

/datum/crafting_recipe/d20
	name = "bone die (d20)"
	result = /obj/item/dice/d20
	reqs = list(/obj/item/natural/bone = 1)
	tools = /obj/item/rogueweapon/huntingknife
	craftdiff = 3
