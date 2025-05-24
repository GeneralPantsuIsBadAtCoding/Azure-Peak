/* * * * * * * * * * * **
 *						*	-Cooking based on slapcrafting
 *		 NeuFood		*	-Uses defines to track nutrition
 *						*	-Meant to replace menu crafting completely for foods
 *						*
 * * * * * * * * * * * **/


/*	........   Templates / Base items   ................ */
/obj/item/reagent_containers // added vars used in neu cooking, might be used for other things too in the future. How it works is in each items attackby code.
	var/short_cooktime = 6 SECONDS
	var/long_cooktime = 10 SECONDS

/obj/item/reagent_containers/proc/update_cooktime(mob/user)
	if(user.mind)
		short_cooktime = (initial(short_cooktime) / get_cooktime_divisor(user.mind.get_skill_level(/datum/skill/craft/cooking)))
		long_cooktime = (initial(long_cooktime) / get_cooktime_divisor(user.mind.get_skill_level(/datum/skill/craft/cooking)))
	else
		short_cooktime = initial(short_cooktime)
		long_cooktime = initial(long_cooktime)

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
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_POOR)
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

/obj/item/kitchen/spoon/aalloy
	name = "decrepit spoon"
	icon_state = "aspoon"

/obj/item/kitchen/spoon/iron
	name = "iron spoon"
	icon_state = "spoon_iron"

/obj/item/kitchen/spoon/tin
	name = "pewter spoon"
	icon_state = "spoon_iron"

/obj/item/kitchen/spoon/gold
	name = "gold spoon"
	icon_state = "spoon_gold"
	sellprice = 10

/obj/item/kitchen/spoon/silver
	name = "silver spoon"
	icon_state = "spoon_silver"
	sellprice = 20

/obj/item/kitchen/fork
	name = "wooden fork"	
	icon = 'modular/Neu_Food/icons/cooking.dmi'
	icon_state = "fork_wooden"
	force = 0
	w_class = WEIGHT_CLASS_TINY

/obj/item/kitchen/fork/aalloy
	name = "decrepit fork"
	icon_state = "afork"

/obj/item/kitchen/fork/iron
	name = "iron fork"
	icon_state = "fork_iron"

/obj/item/kitchen/fork/tin
	name = "pewter fork"
	icon_state = "fork_iron"

/obj/item/kitchen/fork/gold
	name = "gold fork"
	icon_state = "fork_gold"
	sellprice = 10

/obj/item/kitchen/fork/silver
	name = "silver fork"
	icon_state = "fork_silver"
	sellprice = 20

/obj/item/kitchen/rollingpin
	icon = 'modular/Neu_Food/icons/cooking.dmi'
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	experimental_inhand = FALSE

	grid_width = 32
	grid_height = 64

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
	dropshrink = 1
	w_class = WEIGHT_CLASS_NORMAL
	volume = 33
	obj_flags = CAN_BE_HIT
	sellprice = 1
	drinksounds = list('sound/items/drink_cup (1).ogg','sound/items/drink_cup (2).ogg','sound/items/drink_cup (3).ogg','sound/items/drink_cup (4).ogg','sound/items/drink_cup (5).ogg')
	fillsounds = list('sound/items/fillcup.ogg')
	var/in_use // so you can't spam eating with spoon

/obj/item/reagent_containers/glass/bowl/aalloy
	name = "decrepit bowl"
	icon_state = "abowl"

/obj/item/reagent_containers/glass/bowl/iron
	name = "iron bowl"
	icon_state = "bowl_iron"

/obj/item/reagent_containers/glass/bowl/gold
	name = "gold bowl"
	icon_state = "bowl_gold"
	sellprice = 40

/obj/item/reagent_containers/glass/bowl/silver
	name = "silver bowl"
	icon_state = "bowl_silver"
	sellprice = 60

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
			if(reagents.has_reagent(/datum/reagent/consumable/soup/porridge/oatmeal, 10))
				var/mutable_appearance/filling = mutable_appearance('modular/Neu_Food/icons/cooking.dmi', "bowl_oatmeal")
				filling.color = mix_color_from_reagents(reagents.reagent_list)
				add_overlay(filling)
			if(reagents.has_reagent(/datum/reagent/consumable/soup/veggie/cabbage, 17) || reagents.has_reagent(/datum/reagent/consumable/soup/veggie/onion, 17) || reagents.has_reagent(/datum/reagent/consumable/soup/veggie/onion, 17))
				var/mutable_appearance/filling = mutable_appearance('modular/Neu_Food/icons/cooking.dmi', "bowl_full")
				filling.color = mix_color_from_reagents(reagents.reagent_list)
				icon_state = "bowl_steam"
				add_overlay(filling)
			if(reagents.has_reagent(/datum/reagent/consumable/soup/stew/chicken, 17) || reagents.has_reagent(/datum/reagent/consumable/soup/stew/meat, 17) || reagents.has_reagent(/datum/reagent/consumable/soup/stew/fish, 17 || reagents.has_reagent(/datum/reagent/consumable/soup/stew/rabbit, 17)))
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
	desc = "Let the lord have his snack; Twist the head until it cracks."
	icon = 'modular/Neu_Food/icons/cooking.dmi'
	icon_state = "peppermill"
	layer = CLOSED_BLASTDOOR_LAYER // obj layer + a little, small obj layering above convenient
	drop_sound = 'sound/foley/dropsound/gen_drop.ogg'
	list_reagents = list(/datum/reagent/consumable/blackpepper = 5)
	reagent_flags = TRANSPARENT


// You can name them whatever you want I just did _platter to help distinguish from _plated which uses full sprites
// Keep the list alphabetical if you add to it, for readability sake.
/datum/platter_sprites/
	var/list/check_sprite = list(
		/obj/item/reagent_containers/food/snacks/rogue/bun_grenz = "grenzbun_platter",
		/obj/item/reagent_containers/food/snacks/rogue/friedegg/tiberian = "omelette_platter",
		/obj/item/reagent_containers/food/snacks/rogue/frybirdtato = "frybirdtato_platter",
		/obj/item/reagent_containers/food/snacks/rogue/friedrat = "cookedrat_platter",
		/obj/item/reagent_containers/food/snacks/rogue/meat/poultry/baked = "roastchicken_platter",
		/obj/item/reagent_containers/food/snacks/rogue/peppersteak = "peppersteak_platter",
		/obj/item/reagent_containers/food/snacks/rogue/wienercabbage = "wienercabbage_platter",
		/obj/item/reagent_containers/food/snacks/rogue/wienerpotato = "wienerpotato_platter",
		/obj/item/reagent_containers/food/snacks/rogue/wienerpotatonions = "wpotonion_platter",
		)


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
	grid_width = 64
	grid_height = 32
	var/datum/platter_sprites/sprite_choice = new /datum/platter_sprites/

/obj/item/cooking/platter/aalloy
	name = "decrepit platter"
	desc = "A decrepit old platter. Aeon's grasp is upon its form."
	icon_state = "aplatter"

/obj/item/cooking/platter/copper
	name = "copper platter"
	desc = "A platter made from a sheet of copper. Known to impart a metallic taste when combined with acidic food."
	icon_state = "platter_copper"
	resistance_flags = FIRE_PROOF
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	sellprice = 5

/obj/item/cooking/platter/pewter
	name = "pewter platter"
	desc = "A tin plate that contains just a tinge of lead."
	icon_state = "platter_tin"
	resistance_flags = FIRE_PROOF
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	sellprice = 10

/obj/item/cooking/platter/silver
	name = "silver platter"
	desc = "A fancy silver plate often used by the nobility as a symbol of class."
	icon_state = "platter_silver"
	sellprice = 30
	smeltresult = /obj/item/ingot/silver

/obj/item/cooking/platter/gold
	name = "gold platter"
	desc = "A fancy gold plate often used by the nobility as a symbol of class."
	icon_state = "platter_gold"
	resistance_flags = FIRE_PROOF
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	sellprice = 25
	smeltresult = /obj/item/ingot/gold

/obj/item/tablecloth/silk
	name = "silk tablecloth"
	desc = "A fancy silk tablecloth, laid out for diplomatic feasts and other important events."
	icon = 'modular/Neu_Food/icons/cooking.dmi'
	icon_state = "tablecloth_silk"
	sellprice = 40
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/book/rogue/yeoldecookingmanual // new book with some tips to learn
	name = "Ye olde ways of cookinge"
	desc = "Penned by Svend Fatbeard, butler in the fourth generation"
	icon_state ="book8_0"
	base_icon_state = "book8"
	bookfile = "Neu_cooking.json"

/* * * * * * * * * * * * * * *	*
 *								*
 *		Powder & Salt			*
 *					 			*
 *								*
 * * * * * * * * * * * * * * * 	*/

// -------------- Flour -----------------
/obj/item/reagent_containers/powder/flour
	name = "flour"
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

/obj/item/reagent_containers/powder/flour/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	var/obj/item/reagent_containers/R = I
	update_cooktime(user)
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
		add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
		name = "wet flour"
		desc = "Destined for greatness, at your hands."
		R.reagents.remove_reagent(/datum/reagent/water, 10)
		water_added = TRUE
		color = "#d9d0cb"
	return TRUE

/obj/item/reagent_containers/powder/flour/attack_hand(mob/living/user)
	if(water_added)
		playsound(get_turf(user), 'modular/Neu_Food/sound/kneading_alt.ogg', 90, TRUE, -1)
		if(do_after(user, short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
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

/* -------------- RICE ----------------- */
/obj/item/reagent_containers/food/snacks/grown/rice
	list_reagents = list(/datum/reagent/floure = 1)
	volume = 1
	sellprice = 3
	var/water_added

/obj/item/reagent_containers/food/snacks/grown/rice/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	var/obj/item/reagent_containers/R = I
	update_cooktime(user)
	if(!istype(R) || (water_added))
		return ..()
	if(isturf(loc)&& (!found_table))
		to_chat(user, "<span class='notice'>Need a table...</span>")
		return ..()
	if(!R.reagents.has_reagent(/datum/reagent/water, 10))
		to_chat(user, "<span class='notice'>Needs more water to work it.</span>")
		return TRUE
	to_chat(user, "<span class='notice'>Adding water, now its time to hand wash it...</span>")
	playsound(get_turf(user), 'modular/Neu_Food/sound/splishy.ogg', 100, TRUE, -1)
	if(do_after(user,2 SECONDS, target = src))
		user.mind.adjust_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
		name = "wet rice"
		R.reagents.remove_reagent(/datum/reagent/water, 10)
		water_added = TRUE
		color = "#d9d0cb"
	return TRUE

/obj/item/reagent_containers/food/snacks/grown/rice/attack_hand(mob/living/user)
	if(water_added)
		playsound(get_turf(user), 'modular/Neu_Food/sound/kneading_alt.ogg', 90, TRUE, -1)
		if(do_after(user,3 SECONDS, target = src))
			user.mind.adjust_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
			new /obj/item/reagent_containers/food/snacks/rogue/ricewet(loc)
			qdel(src)
	else ..()

/* -------------- WET RICE ----------------- */
/obj/item/reagent_containers/food/snacks/rogue/ricewet
	name = "washed rice"
	desc = ""
	gender = PLURAL
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "rice"
	list_reagents = list(/datum/reagent/floure = 1)
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/preserved/rice_cooked
	volume = 1
	sellprice = 0

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
	mill_result = /obj/item/reagent_containers/powder/salt

/obj/item/reagent_containers/powder/mineral/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	new /obj/effect/decal/cleanable/food/flour(get_turf(src))
	..()
	qdel(src)

/obj/item/reagent_containers/powder/mineral/attackby(obj/item/I, mob/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	var/obj/item/reagent_containers/R = I
	update_cooktime(user)
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
			user.visible_message(span_info("[user] sifts the minerals..."))
			playsound(get_turf(user), 'modular/Neu_Food/sound/peppermill.ogg', 90, TRUE, -1)
			if(do_after(user,3 SECONDS, target = src))
				new /obj/item/reagent_containers/powder/coarse_salt(loc)
				qdel(src)
	else ..()

/*
NEW SYSTEM
What it does:
	- The platter stays intact, adds object on top of it. 
	- Examining the platter tells you what is on the platter
	- Adds food overlay to the platre
	- Can remove item with right click
	- Using it will eat the food on it
	- Use initial[name] to revert platter back to being its original name once the food is removed
*/
/*	..................   Food platter   ................... */
/obj/item/cooking/platter/attackby(obj/item/I, mob/user, params)

	if(istype(I, /obj/item/kitchen/fork))
		if(do_after(user, 0.5 SECONDS))
			attack(user, user, user.zone_selected)

	var/found_table = locate(/obj/structure/table) in (loc)
	if(istype(I, /obj/item/reagent_containers/food/snacks/))
		if(isturf(loc)&& (found_table))
			if (contents.len == 0)
				playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
				if(do_after(user,2 SECONDS, target = src))
					to_chat(user, span_info("I add \the [I.name] to \the [name]."))
					I.forceMove(src)
					var/obj/item/reagent_containers/food/snacks/S = I
					if(S?.faretype < FARE_LAVISH)
						S.faretype++ //Things are tastier on plates.
				update_icon()
			else
				to_chat(user, span_info("Something is already on this [initial(name)]! Remove it first."))
		else
			return ..()	


/obj/item/cooking/platter/attack(mob/living/M, mob/living/user, def_zone)
	if(contents.len > 0)
		if(istype(contents[1],  /obj/item/reagent_containers/food/snacks/))
			var/obj/item/reagent_containers/food/snacks/S = contents[1]
			S.attack(M,user,def_zone)
		update_icon()


/obj/item/cooking/platter/update_icon()
	if(contents.len >0)
		var/i
		var/has_sprite = FALSE
		// Checks the datum list for any sprite states.
		for(i = 1, i <= sprite_choice.check_sprite.len, i++ )
			if(sprite_choice.check_sprite[i] == contents[1].type) //Does this have to use type? Not sure but it works.
				contents[1].icon_state = sprite_choice.check_sprite[contents[1].type]
				has_sprite = TRUE
				break

		if (!has_sprite) // If we don't have a platter sprite shrink sprite down and move it up a bit on the platter
			var/matrix/M = new
			M.Scale(0.8,0.8)
			contents[1].transform = M
			contents[1].pixel_y = 3

		contents[1].vis_flags = VIS_INHERIT_ID | VIS_INHERIT_LAYER | VIS_INHERIT_PLANE
		vis_contents += contents[1]
		name = "platter of [contents[1].name]"
		desc = contents[1].desc
		//Need something better than this in future like a buff
		if(istype(contents[1],  /obj/item/reagent_containers/food/snacks/))
			var/obj/item/reagent_containers/food/snacks/S = contents[1]
			S.bonus_reagents = list(/datum/reagent/consumable/nutriment = 2)
	else
		vis_contents = 0
		name = initial(name)
		desc = initial(desc)


/obj/item/cooking/platter/attack_right(mob/user)
	if(user.get_active_held_item())
		to_chat(user, span_info("I can't do that with my hand full!"))
		return

	if(contents.len >0)
		if(do_after(user,2 SECONDS, target = src))
			contents[1].vis_flags = 0
			//No need to change scale since and pixel_y I think all food already resets that when you grab it
			contents[1].icon_state = initial(contents[1].icon_state)
			//sometimes food puts an item in its place!!
			if(istype(contents[1],  /obj/item/reagent_containers/food/snacks/))
				var/obj/item/reagent_containers/food/snacks/S = contents[1]
				S.bonus_reagents = list()
				if(S?.faretype > FARE_IMPOVERISHED)
					S.faretype-- //Less tasty off the plate.
			to_chat(user, span_info("I remove \the [contents[1].name] from \the [initial(name)]"))
			if(!usr.put_in_hands(contents[1]))
				var/atom/movable/S = contents[1]
				S.forceMove(get_turf(src))

	update_icon()






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
