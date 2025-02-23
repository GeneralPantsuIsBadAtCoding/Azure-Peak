/obj/item/reagent_containers/food/snacks/grown
	icon = 'icons/roguetown/items/produce.dmi'
	dried_type = null
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL
	var/can_distill = FALSE //If FALSE, this object cannot be distilled into an alcohol.
	var/distill_reagent //If NULL and this object can be distilled, it uses a generic fruit_wine reagent and adjusts its variables.
	var/distill_amt = 12
	var/list/pipe_reagents = list()
	var/seed
	var/bitesize_mod = 0


/obj/item/reagent_containers/food/snacks/grown/Initialize(mapload)
	. = ..()
	if(!tastes)
		tastes = list("[name]" = 1)
	pixel_x = rand(-5, 5)
	pixel_y = rand(-5, 5)

/obj/item/reagent_containers/food/snacks/grown/attackby(obj/item/weapon, mob/user, params)
	if(weapon && isturf(loc))
		var/turf/location = get_turf(src)
		if(seed && (user.used_intent.blade_class == BCLASS_BLUNT) && (!user.used_intent.noaa))
			playsound(src,'sound/items/seedextract.ogg', 100, FALSE)
			if(prob(5))
				user.visible_message(span_warning("[user] fails to extract the seeds."))
				qdel(src)
				return
			user.visible_message(span_info("[user] extracts the seeds."))
			new seed(location)
			if(prob(90))
				new seed(location)
			if(prob(23))
				new seed(location)
			if(prob(6))
				new seed(location)
			qdel(src)
			return
	return ..()


/obj/item/reagent_containers/food/snacks/grown/wheat
	seed = /obj/item/seeds/wheat
	name = "wheat grain"
	desc = ""
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "wheat"
	gender = PLURAL
	filling_color = "#F0E68C"
	bitesize_mod = 2
	foodtype = GRAIN
	tastes = list("wheat" = 1)
	can_distill = TRUE
	distill_reagent = /datum/reagent/consumable/ethanol/beer
	distill_amt = 24
	grind_results = list(/datum/reagent/floure = 10)
	mill_result = /obj/item/reagent_containers/powder/flour

/obj/item/reagent_containers/food/snacks/grown/oat
	seed = /obj/item/seeds/wheat/oat
	name = "oat grain"
	desc = ""
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "oat"
	gender = PLURAL
	filling_color = "#556B2F"
	bitesize_mod = 2
	foodtype = GRAIN
	tastes = list("oat" = 1)
	can_distill = TRUE
	distill_reagent = /datum/reagent/consumable/ethanol/ale
	distill_amt = 24
	grind_results = list(/datum/reagent/floure = 10)
	mill_result = /obj/item/reagent_containers/powder/flour

/obj/item/reagent_containers/food/snacks/grown/apple
	seed = /obj/item/seeds/apple
	name = "apple"
	desc = ""
	icon_state = "apple"
	filling_color = "#FF4500"
	bitesize = 3
	foodtype = FRUIT
	tastes = list("apple" = 1)
	trash = /obj/item/trash/applecore
	faretype = FARE_POOR
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	slot_flags = ITEM_SLOT_HEAD
	worn_x_dimension = 64
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)
	worn_y_dimension = 64
	rotprocess = 20 MINUTES
	can_distill = TRUE
	distill_reagent = /datum/reagent/consumable/ethanol/beer/cider
	var/equippedloc = null
	var/list/bitten_names = list()

/obj/item/reagent_containers/food/snacks/grown/apple/On_Consume(mob/living/eater)
	..()
	if(ishuman(eater))
		var/mob/living/carbon/human/H = eater
		if(!(H.real_name in bitten_names))
			bitten_names += H.real_name

/obj/item/reagent_containers/food/snacks/grown/apple/blockproj(mob/living/carbon/human/H)
	testing("APPLEHITBEGIN")
	if(prob(98))
		H.visible_message(span_notice("[H] is saved by the apple!"))
		H.dropItemToGround(H.head)
		return 1
	else
		H.dropItemToGround(H.head)
		return 0

/obj/item/reagent_containers/food/snacks/grown/apple/equipped(mob/M)
	..()
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.head == src)
			testing("equipped applz")
			equippedloc = H.loc
			START_PROCESSING(SSobj, src)

/obj/item/reagent_containers/food/snacks/grown/apple/process()
	. = ..()
	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		if(H.head == src)
			if(equippedloc != H.loc)
				H.dropItemToGround(H.head)

/obj/item/reagent_containers/food/snacks/grown/berries/rogue
	seed = /obj/item/seeds/berryrogue
	name = "jacksberries"
	desc = ""
	icon_state = "berries"
	tastes = list("berry" = 1)
	bitesize = 5
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/water = 5)
	faretype = FARE_NEUTRAL
	dropshrink = 0.75
	var/color_index = "good"
	can_distill = TRUE
	distill_reagent = /datum/reagent/consumable/ethanol/beer/jackberrywine
	rotprocess = 15 MINUTES

/obj/item/reagent_containers/food/snacks/grown/berries/rogue/Initialize()
	if(GLOB.berrycolors[color_index])
		filling_color = GLOB.berrycolors[color_index]
	else
		var/newcolor = pick(BERRYCOLORS)
		if(newcolor in GLOB.berrycolors)
			GLOB.berrycolors[color_index] = pick(BERRYCOLORS)
		else
			GLOB.berrycolors[color_index] = newcolor
		filling_color = GLOB.berrycolors[color_index]
	update_icon()
	..()

/obj/item/reagent_containers/food/snacks/grown/berries/rogue/On_Consume(mob/living/eater)
	..()
	update_icon()

/obj/item/reagent_containers/food/snacks/grown/berries/rogue/update_icon()
	cut_overlays()
	var/used_state = "berriesc5"
	if(bitecount == 1)
		used_state = "berriesc4"
	if(bitecount == 2)
		used_state = "berriesc3"
	if(bitecount == 3)
		used_state = "berriesc2"
	if(bitecount == 4)
		used_state = "berriesc1"
	var/image/item_overlay = image(used_state)
	item_overlay.color = filling_color
	add_overlay(item_overlay)

/obj/item/reagent_containers/food/snacks/grown/berries/rogue/poison
	seed = /obj/item/seeds/berryrogue/poison
	icon_state = "berries"
	tastes = list("berry" = 1)
	list_reagents = list(/datum/reagent/berrypoison = 5, /datum/reagent/consumable/nutriment = 3, /datum/reagent/water = 5)
	grind_results = list(/datum/reagent/berrypoison = 5)
	color_index = "bad"

//pyroclastic flowers - stonekeep port
/obj/item/reagent_containers/food/snacks/grown/rogue/fyritius
	name = "fyritius flower"
	seed = /obj/item/seeds/fyritius
	desc = "A delicate orange flower that radiates warmth."
	icon_state = "fyritius"
	filling_color = "#ff5e00"
	tastes = list("tastes like a burning coal and fire" = 1)
	bitesize = 1
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/toxin/fyritiusnectar = 5)
	dropshrink = 0.8
	rotprocess = null
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 1
	throw_range = 3

/obj/item/reagent_containers/food/snacks/grown/rogue/fyritius/attack(mob/living/carbon/human/M, mob/user)
	if(M == user)
		return ..() //Eat it
	if(user.zone_selected == BODY_ZONE_PRECISE_MOUTH)
		return ..() //Make THEM eat it.
	if(!M.get_bleed_rate())
		to_chat(user, span_warning("There is no blood to wick into the flower bud."))
		return
	var/success = FALSE
	//Logic from funny_attack_effects
	var/datum/antagonist/werewolf/Were = M.mind.has_antag_datum(/datum/antagonist/werewolf/)
	var/datum/antagonist/vampirelord/Vamp = M.mind.has_antag_datum(/datum/antagonist/vampirelord/)
	if(Were && Were.transformed == TRUE)
		user.visible_message(span_notice("[user] brings [src] to soak up the ichor of [M]'s wounds."))
		if(do_after(user, 5 SECONDS, target = M))
			user.visible_message(span_notice("[user] draws the ichor of Dendor's Curse from [M]'s open wounds into [src]."), \
								 span_notice("I have captured the ferocity of Dendor's Curse inside [src]."))
			success = TRUE
	else if(Vamp)
		user.visible_message(span_notice("[user] brings [src] to soak up the petrified blood of [M]'s wounds."))
		if(do_after(user, 5 SECONDS, target = M))
			user.visible_message(span_notice("[user] captures the petrified blood from [M]'s open wounds into [src]."), \
								 span_notice("I have captured the quizzical properties of the petrified blood inside [src]."))
			success = TRUE
	else
		to_chat(user, span_warning("Their blood is not robust enough to hold to the warmth of [src]."))
	if(success)
		changefood(/obj/item/reagent_containers/food/snacks/grown/rogue/fyritius/bloodied, user)


/obj/item/reagent_containers/food/snacks/grown/rogue/fyritius/bloodied
	name = "bloodied fyritius flower"
	desc = "A once delicate orange flower, now soaked with gruesome accursed blood that slowly burns it away."
	icon_state = "fyritius_blood"
	filling_color = "#ff3300"
	tastes = list("tastes like a burning coal and fire and blood" = 1)
	bitesize = 1
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/toxin/fyritiusnectar = 5)
	rotprocess = 10 MINUTES

/obj/item/reagent_containers/food/snacks/grown/rogue/fyritius/bloodied/become_rotten()
	visible_message(span_danger("[src] burns into ash!"))
	new /obj/item/ash(get_turf(src))
	qdel(src)
	return TRUE

/obj/item/reagent_containers/food/snacks/grown/rogue/sweetleaf
	seed = /obj/item/seeds/sweetleaf
	name = "swampweed"
	desc = "A 'foggy' pipe weed."
	icon_state = "swampweed"
	filling_color = "#008000"
	bitesize_mod = 1
	foodtype = VEGETABLES
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/berrypoison = 5)
	tastes = list("sweet" = 1,"bitterness" = 1)
	eat_effect = /datum/status_effect/debuff/badmeal
	rotprocess = 15 MINUTES

/obj/item/reagent_containers/food/snacks/grown/rogue/pipeweed
	seed = /obj/item/seeds/pipeweed
	name = "westleach leaf"
	desc = "A generic kind of pipe weed."
	icon_state = "westleach"
	filling_color = "#008000"
	bitesize_mod = 1
	foodtype = VEGETABLES
	tastes = list("sweet" = 1,"bitterness" = 1)
	list_reagents = list(/datum/reagent/drug/nicotine = 2, /datum/reagent/consumable/nutriment = 1, /datum/reagent/berrypoison = 5)
	grind_results = list(/datum/reagent/drug/nicotine = 5)
	eat_effect = /datum/status_effect/debuff/badmeal
	rotprocess = 15 MINUTES

/obj/item/reagent_containers/food/snacks/grown/rogue/pipeweeddry
	seed = null
	name = "westleach leaf"
	desc = "A dried leaf."
	icon_state = "westleachd"
	dry = TRUE
	pipe_reagents = list(/datum/reagent/drug/nicotine = 30)
	eat_effect = /datum/status_effect/debuff/badmeal
	list_reagents = list(/datum/reagent/drug/nicotine = 5, /datum/reagent/consumable/nutriment = 1)
	grind_results = list(/datum/reagent/drug/nicotine = 10)

/obj/item/reagent_containers/food/snacks/grown/rogue/sweetleafdry
	seed = null
	name = "swampweed"
	desc = "It's dried."
	icon_state = "swampweedd"
	dry = TRUE
	pipe_reagents = list(/datum/reagent/drug/space_drugs = 30)
	list_reagents = list(/datum/reagent/drug/space_drugs = 2,/datum/reagent/consumable/nutriment = 1)
	grind_results = list(/datum/reagent/drug/space_drugs = 5)
	eat_effect = /datum/status_effect/debuff/badmeal

/obj/item/reagent_containers/food/snacks/grown/onion/rogue
	name = "onion"
	desc = ""
	icon_state = "onion"
	slices_num = 1
	tastes = list("spicy sweetness" = 1)
	bitesize = 2
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	can_distill = TRUE
	distill_reagent = /datum/reagent/consumable/ethanol/beer/onion
	rotprocess = null
	seed = /obj/item/seeds/onion

/obj/item/reagent_containers/food/snacks/grown/cabbage/rogue
	name = "cabbage"
	desc = ""
	icon_state = "cabbage"
	tastes = list("blandness" = 1)
	bitesize = 10
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	can_distill = TRUE
	distill_reagent = /datum/reagent/consumable/ethanol/beer/fireleaf
	rotprocess = SHELFLIFE_LONG
	seed = /obj/item/seeds/cabbage

/obj/item/reagent_containers/food/snacks/grown/potato/rogue
	name = "potato"
	desc = ""
	icon_state = "potato"
	eat_effect = /datum/status_effect/debuff/uncookedfood
	tastes = list("starchy dirt" = 1)
	bitesize = 2
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	can_distill = TRUE
	distill_reagent = /datum/reagent/consumable/ethanol/beer/voddena
	rotprocess = null
	seed = /obj/item/seeds/potato

/obj/item/reagent_containers/food/snacks/grown/garlick/rogue
	name = "garlick bulb"
	desc = ""
	icon_state = "garlick"
	eat_effect = /datum/status_effect/debuff/uncookedfood
	tastes = list("pungent umami" = 1)
	bitesize = 2
	list_reagents = list(/datum/reagent/consumable/nutriment = 1) //add a reagent that harms vampires later
	can_distill = FALSE
	rotprocess = null
	seed = /obj/item/seeds/garlick

// poppies, from vanderlin
/obj/item/reagent_containers/food/snacks/grown/rogue/poppy
	name = "poppy"
	desc = "For their crimson beauty and the sedating effect of their crushed seeds, these flowers are considered a symbol of Eora."
	icon_state = "poppy"
	seed = /obj/item/seeds/poppy
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 1
	throw_range = 3
	list_reagents = list(/datum/reagent/consumable/nutriment = 0)
	dropshrink = 0.5
	rotprocess = null
