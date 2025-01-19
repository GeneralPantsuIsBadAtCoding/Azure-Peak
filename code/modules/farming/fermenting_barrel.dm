/obj/structure/fermenting_barrel
	name = "barrel"
	desc = ""
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "barrel1"
	density = TRUE
	opacity = FALSE
	anchored = FALSE
	max_integrity = 300
	drag_slowdown = 2
	var/open = FALSE
	var/speed_multiplier = 1 //How fast it distills. Defaults to 100% (1.0). Lower is better.

/obj/structure/fermenting_barrel/Initialize()
	// Bluespace beakers, but without the portability or efficiency in circuits.
	create_reagents(900, DRAINABLE | AMOUNT_VISIBLE | REFILLABLE)
	icon_state = "barrel[rand(1,3)]"
	. = ..()

/obj/structure/fermenting_barrel/Destroy()
	chem_splash(loc, 2, list(reagents))
	qdel(reagents)
	..()

/obj/structure/fermenting_barrel/examine(mob/user)
	. = ..()
//	. += span_notice("It is currently [open?"open, letting you pour liquids in.":"closed, letting you draw liquids."]")

/obj/structure/fermenting_barrel/proc/makeWine(obj/item/reagent_containers/food/snacks/grown/fruit)
	if(fruit.reagents)
		fruit.reagents.remove_reagent(/datum/reagent/consumable/nutriment, fruit.reagents.total_volume)
		fruit.reagents.trans_to(src, fruit.reagents.total_volume)
	if(fruit.distill_reagent)
		reagents.add_reagent(fruit.distill_reagent, fruit.distill_amt)
	qdel(fruit)
	playsound(src, "bubbles", 100, TRUE)
	return TRUE

/obj/structure/fermenting_barrel/attackby(obj/item/I, mob/user, params)
	if(istype(I,/obj/item/reagent_containers/food/snacks/grown))
		if(try_ferment(I, user))
			return TRUE
	if(istype(I,/obj/item/reagent_containers/powder))
		var/obj/item/reagent_containers/powder/P = I
		P.reagents.trans_to(src, P.reagents.total_volume)
		qdel(P)
		playsound(src, "bubbles", 100, TRUE)
		return TRUE
	if(istype(I,/obj/item/storage/roguebag) && I.contents.len)
		var/success
		for(var/obj/item/reagent_containers/food/snacks/grown/bagged_fruit in I.contents)
			if(try_ferment(bagged_fruit, user, TRUE))
				success = TRUE
		if(success)
			to_chat(user, span_info("I dump the contents of [I] into [src]."))
			I.update_icon()
		else
			to_chat(user, span_warning("There's nothing in [I] that I can ferment."))
		return TRUE
	..()

/obj/structure/fermenting_barrel/proc/try_ferment(obj/item/reagent_containers/food/snacks/grown/fruit, mob/user, batch_process)
	if(!fruit.can_distill)
		if(!batch_process)
			to_chat(user, span_warning("I can't ferment this into anything."))
		return FALSE
	else if(!user.transferItemToLoc(fruit,src))
		if(!batch_process)
			to_chat(user, span_warning("[fruit] is stuck to my hand!"))
		return FALSE
	if(!batch_process)
		to_chat(user, span_info("I place [fruit] into [src]."))
	addtimer(CALLBACK(src, PROC_REF(makeWine), fruit), rand(1 MINUTES, 3 MINUTES))
	return TRUE

//obj/structure/fermenting_barrel/attack_hand(mob/user)
//	open = !open
//	if(open)
//		ENABLE_BITFIELD(reagents.flags, DRAINABLE)
//		ENABLE_BITFIELD(reagents.flags, REFILLABLE)
//		to_chat(user, span_notice("I open [src]."))
//	else
//		DISABLE_BITFIELD(reagents.flags, DRAINABLE)
//		DISABLE_BITFIELD(reagents.flags, REFILLABLE)
//		to_chat(user, span_notice("I close [src]."))
//	update_icon()

/obj/structure/fermenting_barrel/update_icon()
	if(open)
		icon_state = "barrel_open"
	else
		icon_state = "barrel"
	if(broken)
		icon_state = "barrel_destroyed"

/obj/structure/fermenting_barrel/random/water
	name = "water barrel"
	icon_state = "pbarrel1"

/obj/structure/fermenting_barrel/random/water/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/water, rand(0,900))

/obj/structure/fermenting_barrel/random/beer/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/beer, rand(0,900))

/obj/structure/fermenting_barrel/water
	name = "water barrel"
	icon_state = "pbarrel1"

/obj/structure/fermenting_barrel/water/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/water,900)

/obj/structure/fermenting_barrel/beer
	desc = "A barrel containing a generic housebrewed small-beer."

/obj/structure/fermenting_barrel/beer/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/beer,900)

/obj/item/roguebin/water/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/water,500)
	update_icon()

/obj/item/roguebin/water/gross/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/water/gross,500)
	update_icon()

/obj/structure/fermenting_barrel/zagul
	desc = "A barrel marked with a coastal zagul. An extremely cheap lager hailing from a local brewery."

/obj/structure/fermenting_barrel/zagul/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/beer/zagul,900)

/obj/structure/fermenting_barrel/blackgoat
	desc = "A barrel marked with the Black Goat Kriek emblem. A fruit-sour beer brewed with jackberries for a tangy taste."

/obj/structure/fermenting_barrel/blackgoat/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/beer/blackgoat,900)

/obj/structure/fermenting_barrel/hagwoodbitter
	desc = "A barrel marked with the Hagwood Bitters emblem. The least bitter thing to be exported from the Grenzelhoft occupied state of Zorn."

/obj/structure/fermenting_barrel/hagwoodbitter/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/beer/hagwoodbitter,900)
