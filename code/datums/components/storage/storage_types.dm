/datum/component/storage/concrete/roguetown
	grid = TRUE

/datum/component/storage/concrete/roguetown/satchel
	screen_max_rows = 4
	max_w_class = WEIGHT_CLASS_NORMAL

/datum/component/storage/concrete/roguetown/backpack
	screen_max_rows = 7
	screen_max_columns = 5
	max_w_class = WEIGHT_CLASS_NORMAL
	not_while_equipped = TRUE

/datum/component/storage/concrete/roguetown/surgery_bag
	screen_max_rows = 5
	screen_max_columns = 5
	max_w_class = WEIGHT_CLASS_NORMAL

/datum/component/storage/concrete/roguetown/surgery_bag/New(datum/P, ...)
	. = ..()
	can_hold = typecacheof(list(
	/obj/item/rogueweapon/surgery, 
	/obj/item/needle, 
	/obj/item/natural/worms/leech, 
	/obj/item/reagent_containers/lux,
	/obj/item/natural/bundle/cloth, 
	/obj/item/natural/cloth))

/datum/component/storage/concrete/roguetown/messkit
	screen_max_rows = 3
	screen_max_columns = 3
	max_w_class = WEIGHT_CLASS_HUGE
	not_while_equipped = TRUE

/datum/component/storage/concrete/roguetown/messkit/New(datum/P, ...)
	. = ..()
	can_hold = typecacheof(list(/obj/item/cooking, /obj/item/reagent_containers/food/snacks, /obj/item/reagent_containers/, /obj/item/kitchen))

/datum/component/storage/concrete/roguetown/belt
	screen_max_rows = 3
	screen_max_columns = 2
	max_w_class = WEIGHT_CLASS_SMALL

/datum/component/storage/concrete/roguetown/coin_pouch
	screen_max_rows = 4
	screen_max_columns = 1
	max_w_class = WEIGHT_CLASS_NORMAL
	not_while_equipped = FALSE

/datum/component/storage/concrete/roguetown/keyring
	screen_max_rows = 4
	screen_max_columns = 5
	max_w_class = WEIGHT_CLASS_SMALL
	allow_dump_out = TRUE
	click_gather = TRUE
	attack_hand_interact = FALSE
	insert_preposition = "on"
	rustle_sound = 'sound/items/gems (1).ogg'

/datum/component/storage/concrete/roguetown/keyring/New(datum/P, ...)
	. = ..()
	can_hold = typecacheof(list(/obj/item/roguekey))

/datum/component/storage/concrete/roguetown/belt/knife_belt
	screen_max_rows = 3		//Lets you hold a regular knife + keys basically.
	screen_max_columns = 1

/datum/component/storage/concrete/roguetown/belt/cloth
	screen_max_columns = 1

/datum/component/storage/concrete/roguetown/belt/assassin
	max_w_class = WEIGHT_CLASS_NORMAL

/datum/component/storage/concrete/roguetown/cloak
	max_w_class = WEIGHT_CLASS_NORMAL
	screen_max_rows = 2
	screen_max_columns = 2

/datum/component/storage/concrete/roguetown/cloak/lord
	max_w_class = WEIGHT_CLASS_BULKY

/datum/component/storage/concrete/roguetown/mailmaster
	max_w_class = WEIGHT_CLASS_HUGE
	screen_max_rows = 10
	screen_max_columns = 10

/datum/component/storage/concrete/roguetown/bin
	max_w_class = WEIGHT_CLASS_HUGE
	screen_max_rows = 8
	screen_max_columns = 4

/datum/component/storage/concrete/roguetown/sack
	max_w_class = WEIGHT_CLASS_HUGE
	screen_max_rows = 5
	screen_max_columns = 4
	click_gather = TRUE
	dump_time = 0
	allow_quick_gather = TRUE
	allow_quick_empty = TRUE
	insert_preposition = "in"

/datum/component/storage/concrete/roguetown/sack/bag
	dump_time = 10
	not_while_equipped = TRUE
	click_gather = FALSE
	allow_quick_gather = FALSE
	allow_quick_empty = FALSE

/datum/component/storage/concrete/grid/meatsack // our rucksack is different from
// Vanderlin so we use a separate one for meatsack
	max_w_class = WEIGHT_CLASS_NORMAL
	screen_max_rows = 5
	screen_max_columns = 4
	click_gather = TRUE
	collection_mode = COLLECT_EVERYTHING
	dump_time = 0
	allow_quick_gather = TRUE
	allow_quick_empty = TRUE
	allow_dump_out = TRUE
	insert_preposition = "in"

/datum/component/storage/concrete/grid/meatsack/New(datum/P, ...)
	. = ..()
	set_holdable(list(
		/obj/item/reagent_containers/food/snacks/rogue/meat,
		/obj/item/reagent_containers/food/snacks/fat,
		/obj/item/natural/fur,
		/obj/item/natural/hide,
		/obj/item/alch/sinew,
		/obj/item/alch/viscera,
		/obj/item/alch/bone,
		/obj/item/natural/head // this only works for animal heads
		))

/datum/component/storage/concrete/grid/magebag
	max_w_class = WEIGHT_CLASS_NORMAL
	click_gather = TRUE
	collection_mode = COLLECT_EVERYTHING
	dump_time = 0
	allow_quick_gather = TRUE
	allow_quick_empty = TRUE
	allow_dump_out = TRUE
	screen_max_rows = 8
	screen_max_columns = 5

/datum/component/storage/concrete/grid/magebag/New(datum/P, ...)
	. = ..()
	set_holdable(list(
		/obj/item/magic/infernalash,
		/obj/item/magic/hellhoundfang,
		/obj/item/magic/infernalash,
		/obj/item/magic/abyssalflame,
		/obj/item/magic/fairydust,
		/obj/item/magic/iridescentscale,
		/obj/item/magic/heartwoodcore,
		/obj/item/magic/sylvanessence,
		/obj/item/magic/elementalmote,
		/obj/item/magic/elementalshard,
		/obj/item/magic/elementalfragment,
		/obj/item/magic/elementalrelic,
		/obj/item/magic/obsidian,
		/obj/item/magic/leyline,
		/obj/item/reagent_containers/food/snacks/grown/manabloom,
		/obj/item/magic/manacrystal,
		/obj/item/ash,
		))

/datum/component/storage/concrete/roguetown/saddle
	screen_max_rows = 4
	screen_max_columns = 4
	max_w_class = WEIGHT_CLASS_NORMAL

/datum/component/storage/tray
	insert_preposition = "on"
	max_w_class = WEIGHT_CLASS_NORMAL

/datum/component/storage/concrete/grid/headhook
	max_w_class = WEIGHT_CLASS_NORMAL
	screen_max_rows = 6
	screen_max_columns = 4
	click_gather = TRUE
	collection_mode = COLLECT_EVERYTHING
	dump_time = 0
	allow_quick_gather = TRUE
	allow_quick_empty = TRUE
	allow_dump_out = TRUE
	insert_preposition = "in"

/datum/component/storage/concrete/grid/headhook/New(datum/P, ...)
	. = ..()
	set_holdable(
		typecacheof(list(/obj/item/natural/head,
		/obj/item/bodypart/head)
	))

/datum/component/storage/concrete/grid/headhook/bronze
	screen_max_rows = 8
	screen_max_columns = 6
