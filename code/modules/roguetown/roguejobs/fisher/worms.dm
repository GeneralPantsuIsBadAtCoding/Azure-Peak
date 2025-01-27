/obj/item
	var/baitpenalty = 100 // Using this as bait will incurr a penalty to fishing chance. 100 makes it useless as bait. Lower values are better, but Never make it past 10.
	var/isbait = FALSE	// Is the item in question bait to be used?
	var/list/fishloot = null

/obj/item/natural/worms
	name = "worm"
	desc = "The favorite bait of the courageous fishermen who venture these dark waters."
	icon_state = "worm1"
	throwforce = 10
	baitpenalty = 10
	isbait = TRUE
	color = "#985544"
	w_class = WEIGHT_CLASS_TINY
	fishloot = list(
		/obj/item/reagent_containers/food/snacks/fish/carp = 200,
		/obj/item/reagent_containers/food/snacks/fish/eel = 100,
		/obj/item/reagent_containers/food/snacks/fish/angler = 20,
		/obj/item/grown/log/tree/stick = 3,
		/obj/item/storage/belt/rogue/pouch/coins/poor = 1,
		/obj/item/natural/cloth = 1,
		/obj/item/ammo_casing/caseless/rogue/arrow = 1,
		/obj/item/clothing/ring/gold = 1,
		/obj/item/reagent_containers/food/snacks/smallrat = 1, //That's not a fish...?
		/obj/item/reagent_containers/glass/bottle/rogue/wine = 1,
		/obj/item/reagent_containers/glass/bottle/rogue = 1,
	)
	drop_sound = 'sound/foley/dropsound/food_drop.ogg'
	var/amt = 1

/obj/item/natural/worms/grubs
	name = "grub"
	desc = "Bait for the desperate, or the daring."
	baitpenalty = 5
	isbait = TRUE
	color = null
	fishloot = list(
		/obj/item/reagent_containers/food/snacks/fish/carp = 100,
		/obj/item/reagent_containers/food/snacks/fish/angler = 20,
		/obj/item/reagent_containers/food/snacks/fish/clownfish = 20,
		/obj/item/grown/log/tree/stick = 3,
		/obj/item/storage/belt/rogue/pouch/coins/poor = 1,
		/obj/item/natural/cloth = 1,
		/obj/item/ammo_casing/caseless/rogue/arrow = 1,
		/obj/item/clothing/ring/gold = 1,
		/obj/item/reagent_containers/food/snacks/smallrat = 1, //That's not a fish...?
		/obj/item/reagent_containers/glass/bottle/rogue/wine = 1,
		/obj/item/reagent_containers/glass/bottle/rogue = 1,
	)

/obj/item/natural/worms/grubs/attack_right(mob/user)
	return

/obj/item/natural/worms/Initialize()
	. = ..()
	dir = rand(0,8)
