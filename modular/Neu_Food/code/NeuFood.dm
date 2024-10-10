/* * * * * * * * * * * **
 *						*	-Cooking based on slapcrafting
 *		 NeuFood		*	-Uses defines to track nutrition
 *						*	-Meant to replace menu crafting completely for foods
 *						*
 * * * * * * * * * * * **/

// CONTAINMENT ZONE - marked for death
/obj/item/reagent_containers/powder/flour/salt // salt being subtype of flour is terrible for so many reasons repath to  /obj/item/reagent_containers/powder/salt


/*	........   Templates / Base items   ................ */
/obj/item/reagent_containers // added vars used in neu cooking, might be used for other things too in the future. How it works is in each items attackby code.
	var/short_cooktime = FALSE  // based on cooking skill
	var/long_cooktime = FALSE

/obj/item/reagent_containers/food/snacks/rogue // base food type, for icons and cooktime, and to make it work with processes like pie making
	icon = 'modular/Neu_Food/icons/food.dmi'
	desc = ""
	slices_num = 0
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	foodtype = GRAIN
	drop_sound = 'sound/foley/dropsound/gen_drop.ogg'
	cooktime = 30 SECONDS
	var/process_step // used for pie making and other similar modular foods

/obj/item/reagent_containers/food/snacks/rogue/Initialize()
	. = ..()
	eatverb = pick("bite","chew","nibble","gobble","chomp")

/obj/item/reagent_containers/food/snacks/rogue/foodbase // root item for uncooked food thats disgusting when raw
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_POOR)
	bitesize = 3
	eat_effect = /datum/status_effect/debuff/uncookedfood

/obj/item/reagent_containers/food/snacks/rogue/foodbase/New() // disables the random placement on creation for this object MAYBE OBSOLETE?
	..()
	pixel_x = 0
	pixel_y = 0

/obj/item/reagent_containers/food/snacks/rogue/preserved // just convenient way to group food with long rotprocess
	bitesize = 3
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)
	rotprocess = SHELFLIFE_EXTREME

/obj/item/reagent_containers/food/snacks
	var/chopping_sound = FALSE // does it play a choppy sound when batch sliced?
	var/slice_sound = FALSE // does it play the slice sound when sliced?

/obj/item/reagent_containers/food/snacks/proc/changefood(path, mob/living/eater)
	if(!path || !eater)
		return
	var/turf/T = get_turf(eater)
	if(eater.dropItemToGround(src))
		qdel(src)
	var/obj/item/I = new path(T)
	eater.put_in_active_hand(I)

/obj/effect/decal/cleanable/food/mess // decal applied when throwing minced meat for example
	name = "mess"
	desc = ""
	color = "#ab9d9d"
	icon_state = "tomato_floor1"
	random_icon_states = list("tomato_floor1", "tomato_floor2", "tomato_floor3")

/obj/item/reagent_containers/food/snacks/attackby(obj/item/W, mob/user, params)
	if(user.used_intent.blade_class == slice_bclass && W.wlength == WLENGTH_SHORT)
		if(slice_bclass == BCLASS_CHOP)
			user.visible_message(span_notice("[user] chops [src]!"))
			slice(W, user)
			return 1
		else if(slice(W, user))
			return 1
	..()

/* added to proc
/obj/item/reagent_containers/food/snacks/proc/slice(obj/item/W, mob/user)
	if(slice_sound)
		playsound(get_turf(user), 'modular/Neu_Food/sound/slicing.ogg', 60, TRUE, -1) // added some choppy sound
	if(chopping_sound)
		playsound(get_turf(user), 'modular/Neu_Food/sound/chopping_block.ogg', 60, TRUE, -1) // added some choppy sound
*/
/*	........   Kitchen tools / items   ................ */
/obj/item/kitchen/spoon
	name = "wooden spoon"
	desc = "Traditional utensil for shoveling soup into your mouth, or to churn butter with."
	icon = 'modular/Neu_Food/icons/cooking.dmi'
	icon_state = "spoon"
	force = 0
	w_class = WEIGHT_CLASS_TINY

/obj/item/kitchen/ironspoon
	name = "iron spoon"
	desc = "Traditional utensil for shoveling soup into your mouth, now made with iron for that metallic taste!"
	icon = 'modular/Neu_Food/icons/cooking.dmi'
	icon_state = "spoon_iron"
	force = 0
	w_class = WEIGHT_CLASS_TINY

/obj/item/kitchen/fork
	name = "wooden fork"
	desc = "Traditional utensil for stabbing your food in order to shove it into your mouth."
	icon = 'modular/Neu_Food/icons/cooking.dmi'
	icon_state = "fork"
	force = 0
	w_class = WEIGHT_CLASS_TINY

/obj/item/kitchen/ironfork
	name = "iron fork"
	desc = "Traditional utensil for stabbing your food, now made with iron for extra stabbiness!"
	icon = 'modular/Neu_Food/icons/cooking.dmi'
	icon_state = "fork_iron"
	force = 0
	w_class = WEIGHT_CLASS_TINY

/obj/item/kitchen/rollingpin
	icon = 'modular/Neu_Food/icons/cooking.dmi'
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	experimental_inhand = FALSE

/obj/item/rogueweapon/huntingknife/cleaver
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	item_state = "cleav"
	experimental_inhand = FALSE
	experimental_onhip = FALSE
	experimental_onback = FALSE

/obj/item/reagent_containers/glass/bowl
	name = "wooden bowl"
	desc = "It is the empty space that makes the bowl useful."
	icon = 'modular/Neu_Food/icons/cooking.dmi'
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	icon_state = "bowl"
	force = 5
	throwforce = 5
	reagent_flags = OPENCONTAINER
	amount_per_transfer_from_this = 7
	possible_transfer_amounts = list(7)
	dropshrink = 0.8
	w_class = WEIGHT_CLASS_NORMAL
	volume = 33
	obj_flags = CAN_BE_HIT
	sellprice = 1
	drinksounds = list('sound/items/drink_cup (1).ogg','sound/items/drink_cup (2).ogg','sound/items/drink_cup (3).ogg','sound/items/drink_cup (4).ogg','sound/items/drink_cup (5).ogg')
	fillsounds = list('sound/items/fillcup.ogg')
	var/in_use // so you can't spam eating with spoon

/obj/item/reagent_containers/glass/bowl/iron
	icon_state = "bowl_iron"

/obj/item/reagent_containers/glass/bowl/update_icon()
	cut_overlays()
	if(reagents)
		if(reagents.total_volume > 0)
			if(reagents.total_volume <= 11)
				var/mutable_appearance/filling = mutable_appearance('modular/Neu_Food/icons/cooking.dmi', "bowl_low")
				filling.color = mix_color_from_reagents(reagents.reagent_list)
				add_overlay(filling)
		if(reagents.total_volume > 11)
			if(reagents.total_volume <= 22)
				var/mutable_appearance/filling = mutable_appearance('modular/Neu_Food/icons/cooking.dmi', "bowl_half")
				filling.color = mix_color_from_reagents(reagents.reagent_list)
				add_overlay(filling)
		if(reagents.total_volume > 22)
			if(reagents.has_reagent(/datum/reagent/consumable/soup/oatmeal, 10))
				var/mutable_appearance/filling = mutable_appearance('modular/Neu_Food/icons/cooking.dmi', "bowl_oatmeal")
				filling.color = mix_color_from_reagents(reagents.reagent_list)
				add_overlay(filling)
			if(reagents.has_reagent(/datum/reagent/consumable/soup/veggie/cabbage, 17) || reagents.has_reagent(/datum/reagent/consumable/soup/veggie/onion, 17) || reagents.has_reagent(/datum/reagent/consumable/soup/veggie/onion, 17))
				var/mutable_appearance/filling = mutable_appearance('modular/Neu_Food/icons/cooking.dmi', "bowl_full")
				filling.color = mix_color_from_reagents(reagents.reagent_list)
				icon_state = "bowl_steam"
				add_overlay(filling)
			if(reagents.has_reagent(/datum/reagent/consumable/soup/stew/chicken, 17) || reagents.has_reagent(/datum/reagent/consumable/soup/stew/meat, 17) || reagents.has_reagent(/datum/reagent/consumable/soup/stew/fish, 17))
				var/mutable_appearance/filling = mutable_appearance('modular/Neu_Food/icons/cooking.dmi', "bowl_stew")
				filling.color = mix_color_from_reagents(reagents.reagent_list)
				icon_state = "bowl_steam"
				add_overlay(filling)
			else
				var/mutable_appearance/filling = mutable_appearance('modular/Neu_Food/icons/cooking.dmi', "bowl_full")
				filling.color = mix_color_from_reagents(reagents.reagent_list)
				add_overlay(filling)
	else
		icon_state = "bowl"

/obj/item/reagent_containers/glass/bowl/on_reagent_change(changetype)
	..()
	update_icon()

/obj/item/reagent_containers/glass/bowl/attackby(obj/item/I, mob/user, params) // lets you eat with a spoon from a bowl
	if(istype(I, /obj/item/kitchen/spoon))
		if(reagents.total_volume > 0)
			beingeaten()
			if(do_after(user,1 SECONDS, target = src))
				playsound(src,'sound/misc/eat.ogg', rand(30,60), TRUE)
				visible_message(span_info("[user] eats from [src]."))
				addtimer(CALLBACK(reagents, TYPE_PROC_REF(/datum/reagents, trans_to), user, min(amount_per_transfer_from_this,5), TRUE, TRUE, FALSE, user, FALSE, INGEST), 5)
		return TRUE

/obj/item/reagent_containers/glass/bowl/proc/beingeaten()
	in_use = TRUE
	sleep(10)
	in_use = FALSE


/obj/item/reagent_containers/glass/cup
	icon = 'modular/Neu_Food/icons/cooking.dmi'
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	experimental_inhand = FALSE

/obj/item/reagent_containers/glass/bucket/pot
	icon = 'modular/Neu_Food/icons/cooking.dmi'
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	experimental_inhand = FALSE

/obj/item/cooking/pan
	icon = 'modular/Neu_Food/icons/cooking.dmi'
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	experimental_inhand = FALSE

/obj/item/reagent_containers/peppermill // new with some animated art
	name = "pepper mill"
	icon = 'modular/Neu_Food/icons/cooking.dmi'
	icon_state = "peppermill"
	layer = CLOSED_BLASTDOOR_LAYER // obj layer + a little, small obj layering above convenient
	drop_sound = 'sound/foley/dropsound/gen_drop.ogg'
	list_reagents = list(/datum/reagent/consumable/blackpepper = 5)
	reagent_flags = TRANSPARENT

/obj/item/cooking/platter
	name = "platter"
	desc = "For holding meals fit for kings."
	icon = 'modular/Neu_Food/icons/cooking.dmi'
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	icon_state = "platter"
	resistance_flags = NONE
	drop_sound = 'sound/foley/dropsound/gen_drop.ogg'
	experimental_inhand = FALSE


/obj/item/book/rogue/yeoldecookingmanual // new book with some tips to learn
	name = "Ye olde ways of cookinge"
	desc = "Penned by Svend Fatbeard, butler in the fourth generation"
	icon_state ="book8_0"
	base_icon_state = "book8"
	bookfile = "Neu_cooking.json"

/*	........   Reagents   ................ */// These are for the pot, if more vegetables are added and need to be integrated into the pot brewing you need to add them here
/datum/reagent/consumable/soup // so you get hydrated without the flavor system messing it up. Works like water with less hydration
	var/hydration = 6
/datum/reagent/consumable/soup/on_mob_life(mob/living/carbon/M)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!HAS_TRAIT(H, TRAIT_NOHUNGER))
			H.adjust_hydration(hydration)
		if(M.blood_volume < BLOOD_VOLUME_NORMAL)
			M.blood_volume = min(M.blood_volume+10, BLOOD_VOLUME_NORMAL)
	..()

/datum/reagent/consumable/soup/oatmeal
	name = "oatmeal"
	description = "Fitting for a peasant."
	reagent_state = LIQUID
	color = "#c38553"
	nutriment_factor = 15
	metabolization_rate = 0.5 // half as fast as normal, last twice as long
	taste_description = "oatmeal"
	taste_mult = 3
	hydration = 2

/datum/reagent/consumable/soup/veggie
	name = "vegetable soup"
	description = ""
	reagent_state = LIQUID
	nutriment_factor = 10
	taste_mult = 4
	hydration = 8

/datum/reagent/consumable/soup/veggie/potato
	color = "#869256"
	taste_description = "potato broth"

/datum/reagent/consumable/soup/veggie/onion
	color = "#a6b457"
	taste_description = "boiled onions"

/datum/reagent/consumable/soup/veggie/cabbage
	color = "#859e56"
	taste_description = "watery cabbage"

/datum/reagent/consumable/soup/stew
	name = "thick stew"
	description = "All manners of edible bits went into this."
	reagent_state = LIQUID
	nutriment_factor = 20
	taste_mult = 4

/datum/reagent/consumable/soup/stew/chicken
	color = "#baa21c"
	taste_description = "chicken"

/datum/reagent/consumable/soup/stew/meat
	color = "#80432a"
	taste_description = "meat stew"

/datum/reagent/consumable/soup/stew/fish
	color = "#c7816e"
	taste_description = "fish"

/datum/reagent/consumable/soup/stew/yucky
	color = "#9e559c"
	taste_description = "something rancid"


/* * * * * * * * * * * * * * *	*
 *								*
 *		Powder & Salt			*
 *					 			*
 *								*
 * * * * * * * * * * * * * * * 	*/

// -------------- POWDER (flour) -----------------
/obj/item/reagent_containers/powder/flour
	name = "powder"
	desc = "With this ambition, we build an empire."
	gender = PLURAL
	icon_state = "flour"
	list_reagents = list(/datum/reagent/floure = 1)
	volume = 1
	sellprice = 0
	var/water_added

/obj/item/reagent_containers/powder/flour/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	new /obj/effect/decal/cleanable/food/flour(get_turf(src))
	..()
	qdel(src)

/obj/item/reagent_containers/powder/flour/attackby(obj/item/I, mob/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	var/obj/item/reagent_containers/R = I
	if(user.mind)
		short_cooktime = (60 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*5))
		long_cooktime = (100 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*10))
	if(!istype(R) || (water_added))
		return ..()
	if(isturf(loc)&& (!found_table))
		to_chat(user, span_notice("Need a table..."))
		return ..()
	if(!R.reagents.has_reagent(/datum/reagent/water, 10))
		to_chat(user, span_notice("Needs more water to work it."))
		return TRUE
	to_chat(user, span_notice("Adding water, now its time to knead it..."))
	playsound(get_turf(user), 'modular/Neu_Food/sound/splishy.ogg', 100, TRUE, -1)
	if(do_after(user, short_cooktime, target = src))
		name = "wet powder"
		desc = "Destined for greatness, at your hands."
		R.reagents.remove_reagent(/datum/reagent/water, 10)
		water_added = TRUE
		color = "#d9d0cb"
	return TRUE

/obj/item/reagent_containers/powder/flour/attack_hand(mob/user)
	if(water_added)
		playsound(get_turf(user), 'modular/Neu_Food/sound/kneading_alt.ogg', 90, TRUE, -1)
		if(do_after(user, short_cooktime, target = src))
			new /obj/item/reagent_containers/food/snacks/rogue/dough_base(loc)
			qdel(src)
	else ..()


// -------------- SALT -----------------
/obj/item/reagent_containers/powder/salt
	name = "salt"
	desc = ""
	gender = PLURAL
	icon_state = "salt"
	list_reagents = list(/datum/reagent/floure = 1)
	volume = 1
	sellprice = 0

/obj/item/reagent_containers/powder/salt/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	new /obj/effect/decal/cleanable/food/flour(get_turf(src))
	..()
	qdel(src)

/obj/item/reagent_containers/powder/mineral
	name = "coarse minerals"
	desc = "ground up rock, could be made into mineral salts with more work."
	gender = PLURAL
	icon_state = "salt"
	list_reagents = list(/datum/reagent/floure = 1)
	volume = 1
	sellprice = 0
	var/water_added

/obj/item/reagent_containers/powder/coarse_salt
	name = "coarse salt"
	desc = "somewhat gritty, coarse salt. Could be ground down into finer salt."
	gender = PLURAL
	icon_state = "salt"
	list_reagents = list(/datum/reagent/floure = 1)
	volume = 1
	sellprice = 0
	color = "#999797"

/obj/item/reagent_containers/powder/mineral/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	new /obj/effect/decal/cleanable/food/flour(get_turf(src))
	..()
	qdel(src)

/obj/item/reagent_containers/powder/mineral/attackby(obj/item/I, mob/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	var/obj/item/reagent_containers/R = I
	if(user.mind)
		short_cooktime = (60 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*5))
		long_cooktime = (100 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*10))
	if(!istype(R) || (water_added))
		return ..()
	if(isturf(loc)&& (!found_table))
		to_chat(user, span_notice("Need a table..."))
		return ..()
	if(!R.reagents.has_reagent(/datum/reagent/water, 10))
		to_chat(user, span_notice("Needs more water to work it."))
		return TRUE
	to_chat(user, span_notice("Adding water, now its time to sift it..."))
	playsound(get_turf(user), 'modular/Neu_Food/sound/splishy.ogg', 100, TRUE, -1)
	if(do_after(user, short_cooktime, target = src))
		name = "prepared minerals"
		desc = "Still quite coarse, needs some sifting."
		R.reagents.remove_reagent(/datum/reagent/water, 10)
		water_added = TRUE
		color = "#666262"
	return TRUE

/obj/item/reagent_containers/powder/mineral/attackby(obj/item/I, mob/user, params)
	if(water_added)
		if(istype(I, /obj/item/natural/cloth))
			user.visible_message(span_info("[user] sifts the minerals...)"))
			playsound(get_turf(user), 'modular/Neu_Food/sound/peppermill.ogg', 90, TRUE, -1)
			if(do_after(user,3 SECONDS, target = src))
				new /obj/item/reagent_containers/powder/coarse_salt(loc)
				qdel(src)
	else ..()


/*	..................   Food platter   ................... */
/obj/item/cooking/platter/attackby(obj/item/I, mob/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat/poultry/baked))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				new /obj/item/reagent_containers/food/snacks/rogue/meat/poultry/baked/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to work on it."))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/peppersteak))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				new /obj/item/reagent_containers/food/snacks/rogue/peppersteak/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to work on it."))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/onionsteak))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				new /obj/item/reagent_containers/food/snacks/rogue/onionsteak/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to work on it."))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/friedegg/tiberian))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				new /obj/item/reagent_containers/food/snacks/rogue/friedegg/tiberian/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to work on it."))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/friedrat))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				new /obj/item/reagent_containers/food/snacks/rogue/friedrat/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to work on it."))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/hcakeslice))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				new /obj/item/reagent_containers/food/snacks/rogue/hcakeslice/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to work on it."))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/ccakeslice))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				new /obj/item/reagent_containers/food/snacks/rogue/ccakeslice/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to work on it."))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/bun_grenz))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				new /obj/item/reagent_containers/food/snacks/rogue/bun_grenz/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to work on it."))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/fryfish/carp))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				new /obj/item/reagent_containers/food/snacks/rogue/fryfish/carp/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to work on it."))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/fryfish/clownfish))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				new /obj/item/reagent_containers/food/snacks/rogue/fryfish/clownfish/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to work on it."))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/fryfish/angler))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				new /obj/item/reagent_containers/food/snacks/rogue/fryfish/angler/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to work on it."))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/fryfish/eel))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				new /obj/item/reagent_containers/food/snacks/rogue/fryfish/eel/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to work on it."))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/wienercabbage))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				new /obj/item/reagent_containers/food/snacks/rogue/wienercabbage/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to work on it."))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/wienerpotato))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				new /obj/item/reagent_containers/food/snacks/rogue/wienerpotato/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to work on it."))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/wieneronions))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				new /obj/item/reagent_containers/food/snacks/rogue/wieneronions/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to work on it."))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/wienerpotatonions))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				new /obj/item/reagent_containers/food/snacks/rogue/wienerpotatonions/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to work on it."))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/frybirdtato))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user,2 SECONDS, target = src))
				new /obj/item/reagent_containers/food/snacks/rogue/frybirdtato/plated(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to work on it."))
	else
		return ..()



/* * * * * * * * * * * **
 *						*
 *	 Food Rotting		*	- Just lists as it stands on 2024-07-16
 *						*
 * * * * * * * * * * * **/

/*	.................   Never spoils   ................... *//*

* Hardtack
* Toast
* Salted fish
* Frybread
* Unbitten handpies
* Biscuit
* Prezzel
* Cheese wheel/wedges
* Salo
* Copiette
* Salumoi
* Uncut pie
* Raw potato, onion, cabbage

/*	.................   Long shelflife   ................... */

* Uncut bread loaf
* Uncut raisin bread
* Uncut cake
* Pastry
* Bun
* Most plated dishes
* Most cooked veggies
* Cooked sausage
* Pie slice
* Bread slice

/*	.................   Decent shelflife   ................... */

* Fresh cheese
* Mixed dishes with meats
* Fried meats & eggs

/*	.................   Short shelflife   ................... */

* Raw meat
* Berries

/*	.................   Tiny shelflife   ................... */

* Minced meat

*/
