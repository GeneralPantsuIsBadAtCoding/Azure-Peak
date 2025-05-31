/* * * * * * * * * * * **
 *						*
 *		 NeuFood		*	- Basically add water to powder, then more powder
 *		 (Snacks)		*
 *						*
 * * * * * * * * * * * **/



/*	.................   Dough   ................... */
/obj/item/reagent_containers/food/snacks/rogue/dough_base
	name = "unfinished dough"
	desc = "With a little more ambition, you will conquer."
	icon_state = "dough_base"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/reagent_containers/food/snacks/rogue/dough_base/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	update_cooktime(user)
	if(istype(I, /obj/item/reagent_containers/powder/flour))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'modular/Neu_Food/sound/kneading.ogg', 100, TRUE, -1)
			to_chat(user, span_notice("Kneading in more powder..."))
			if(do_after(user,short_cooktime, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				new /obj/item/reagent_containers/food/snacks/rogue/dough(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to work it."))
	else
		return ..()

/obj/item/reagent_containers/food/snacks/rogue/dough
	name = "dough"
	desc = "The triumph of all bakers."
	icon_state = "dough"
	slices_num = 2
	slice_batch = TRUE
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/doughslice
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/bread
	w_class = WEIGHT_CLASS_NORMAL
	slice_sound = TRUE

/obj/item/reagent_containers/food/snacks/rogue/dough/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	update_cooktime(user)
	if(istype(I, /obj/item/reagent_containers/food/snacks/butterslice))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'modular/Neu_Food/sound/kneading_alt.ogg', 90, TRUE, -1)
			to_chat(user, span_notice("Kneading butter into the dough..."))
			if(do_after(user,long_cooktime, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				new /obj/item/reagent_containers/food/snacks/rogue/butterdough(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to roll it out!"))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/raisins))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'modular/Neu_Food/sound/kneading.ogg', 100, TRUE, -1)
			to_chat(user, span_notice("Kneading the dough and adding raisins..."))
			if(do_after(user,short_cooktime, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				new /obj/item/reagent_containers/food/snacks/rogue/rbread_half(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to roll it out!"))
	if(istype(I, /obj/item/kitchen/rollingpin))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'modular/Neu_Food/sound/rollingpin.ogg', 100, TRUE, -1)
			to_chat(user, span_notice("Rolling [src] into cracker dough."))
			if(do_after(user,long_cooktime, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				new /obj/item/reagent_containers/food/snacks/rogue/foodbase/hardtack_raw(loc)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to roll it out!"))
	else
		return ..()

/*	.................   Smalldough   ................... */
/obj/item/reagent_containers/food/snacks/rogue/doughslice
	name = "smalldough"
	icon_state = "doughslice"
	slices_num = 0
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/bun
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("dough" = 1)

/obj/item/reagent_containers/food/snacks/rogue/doughslice/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	update_cooktime(user)
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/cheese))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'modular/Neu_Food/sound/kneading_alt.ogg', 90, TRUE, -1)
			to_chat(user, span_notice("Adding fresh cheese..."))
			if(do_after(user,short_cooktime, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				new /obj/item/reagent_containers/food/snacks/rogue/foodbase/cheesebun_raw(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to roll it out!"))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/doughslice))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'modular/Neu_Food/sound/kneading.ogg', 100, TRUE, -1)
			to_chat(user, span_notice("Combining dough..."))
			if(do_after(user,short_cooktime, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				new /obj/item/reagent_containers/food/snacks/rogue/dough(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to roll it out!"))
	if(istype(I, /obj/item/clothing/neck/roguetown/psicross/astrata))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'modular/Neu_Food/sound/kneading_alt.ogg', 90, TRUE, -1)
			to_chat(user, span_notice("Pressing the shape of Astrata's cross into the bun..."))
			if(do_after(user,short_cooktime, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				new /obj/item/reagent_containers/food/snacks/rogue/foodbase/crossbun_raw(loc)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to roll it out!"))
	if(istype(I, /obj/item/clothing/neck/roguetown/psicross)) // This is gonna be messy cuz other are subtypes
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'modular/Neu_Food/sound/kneading_alt.ogg', 90, TRUE, -1)
			to_chat(user, span_notice("Pressing the shape of the psycross into the bun..."))
			if(do_after(user,short_cooktime, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				new /obj/item/reagent_containers/food/snacks/rogue/foodbase/psycrossbun_raw(loc)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to roll it out!"))
	else
		return ..()

/*	.................   Butterdough   ................... */
/obj/item/reagent_containers/food/snacks/rogue/butterdough
	name = "butterdough"
	desc = "What is a triumph, to a legacy?"
	icon_state = "butterdough"
	color = "#feffc1"
	slices_num = 2
	slice_batch = TRUE
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/butterdoughslice
	w_class = WEIGHT_CLASS_NORMAL
	slice_sound = TRUE

/obj/item/reagent_containers/food/snacks/rogue/butterdough/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	update_cooktime(user)
	if(istype(I, /obj/item/reagent_containers/food/snacks/egg))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, span_notice("Working egg into the dough, shaping it into a cake..."))
			playsound(get_turf(user), 'modular/Neu_Food/sound/eggbreak.ogg', 100, TRUE, -1)
			if(do_after(user,long_cooktime, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				new /obj/item/reagent_containers/food/snacks/rogue/cake_base(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to roll it out!"))
	else
		return ..()

/*	.................   Butterdough piece   ................... */
/obj/item/reagent_containers/food/snacks/rogue/butterdoughslice
	name = "butterdough piece"
	desc = "A slice of pedigree, to create lines of history."
	icon_state = "butterdoughslice"
	color = "#feffc1"
	slices_num = 0
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/frybread
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/pastry
	w_class = WEIGHT_CLASS_NORMAL

// Dough + rolling pin on table = flat dough. RT got some similar proc for this.
/obj/item/reagent_containers/food/snacks/rogue/butterdoughslice/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	update_cooktime(user)
	if(istype(I, /obj/item/kitchen/rollingpin))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'modular/Neu_Food/sound/rollingpin.ogg', 100, TRUE, -1)
			to_chat(user, span_notice("Flattening [src]..."))
			if(do_after(user,short_cooktime, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				new /obj/item/reagent_containers/food/snacks/rogue/piedough(loc)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to roll it out!"))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/raisins))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, span_notice("Adding raisins to the dough..."))
			if(do_after(user,short_cooktime, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				new /obj/item/reagent_containers/food/snacks/rogue/foodbase/biscuit_raw(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to roll it out!"))
	if(I.get_sharpness())
		if(!isdwarf(user))
			to_chat(user, span_warning("You lack knowledge of dwarven pastries!"))
			return
		else
			if(isturf(loc)&& (found_table))
				playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
				to_chat(user, span_notice("Cutting the dough in strips and making a prezzel..."))
				if(do_after(user,short_cooktime, target = src))
					add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
					new /obj/item/reagent_containers/food/snacks/rogue/foodbase/prezzel_raw(loc)
					qdel(src)
			else
				to_chat(user, span_warning("You need to put [src] on a table to cut it!"))
	else
		..()

/*	.................   Piedough   ................... */
/obj/item/reagent_containers/food/snacks/rogue/piedough
	name = "piedough"
	desc = "The beginning of greater things to come."
	icon_state = "piedough"
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/foodbase/piebottom
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/reagent_containers/food/snacks/rogue/piedough/attackby(obj/item/I, mob/living/user, params)
	update_cooktime(user)
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/truffles))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		to_chat(user, span_notice("Making a handpie..."))
		if(do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			var/obj/item/reagent_containers/food/snacks/rogue/foodbase/handpieraw/mushroom/handpie= new(get_turf(user))
			user.put_in_hands(handpie)
			qdel(I)
			qdel(src)
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat/mince))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		to_chat(user, span_notice("Making a handpie..."))
		if(do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			var/obj/item/reagent_containers/food/snacks/rogue/foodbase/handpieraw/mince/handpie= new(get_turf(user))
			user.put_in_hands(handpie)
			qdel(I)
			qdel(src)
	if(istype(I, /obj/item/reagent_containers/food/snacks/grown/berries/rogue/poison))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		to_chat(user, span_notice("Making a handpie..."))
		if(do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			var/obj/item/reagent_containers/food/snacks/rogue/foodbase/handpieraw/poison/handpie= new(get_turf(user))
			user.put_in_hands(handpie)
			qdel(I)
			qdel(src)
	else if(istype(I, /obj/item/reagent_containers/food/snacks/grown/berries/rogue))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		to_chat(user, span_notice("Making a handpie..."))
		if(do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			var/obj/item/reagent_containers/food/snacks/rogue/foodbase/handpieraw/berry/handpie= new(get_turf(user))
			user.put_in_hands(handpie)
			qdel(I)
			qdel(src)
	else
		return ..()


/*	.................   Hardtack   ................... */
/obj/item/reagent_containers/food/snacks/rogue/foodbase/hardtack_raw
	name = "raw hardtack"
	desc = "Doughy, soft, unacceptable."
	icon_state = "raw_tack"
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/crackerscooked
	w_class = WEIGHT_CLASS_NORMAL
	eat_effect = null

/obj/item/reagent_containers/food/snacks/rogue/crackerscooked
	name = "hardtack"
	desc = "Very, very hard and dry."
	icon_state = "tack6"
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	faretype = FARE_POOR
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("spelt" = 1)
	bitesize = 6
	rotprocess = null

/obj/item/reagent_containers/food/snacks/rogue/crackerscooked/On_Consume(mob/living/eater)
	..()
	if(bitecount == 1)
		icon_state = "tack5"
	if(bitecount == 2)
		icon_state = "tack4"
	if(bitecount == 3)
		icon_state = "tack3"
	if(bitecount == 4)
		icon_state = "tack2"
	if(bitecount == 5)
		icon_state = "tack1"


/*	.................   Bread   ................... */
/obj/item/reagent_containers/food/snacks/rogue/bread
	name = "bread loaf"
	desc = "One of the staple foods of the world, with the decline of magic, the loss of bread-duplication has led to mass famines around Grimoria."
	icon_state = "loaf6"
	slices_num = 6
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/breadslice
	list_reagents = list(/datum/reagent/consumable/nutriment = DOUGH_NUTRITION)
	faretype = FARE_POOR
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("bread" = 1)
	slice_batch = FALSE
	slice_sound = TRUE
	rotprocess = SHELFLIFE_EXTREME	

/obj/item/reagent_containers/food/snacks/rogue/bread/update_icon()
	if(slices_num)
		icon_state = "loaf[slices_num]"
	else
		icon_state = "loaf_slice"

/obj/item/reagent_containers/food/snacks/rogue/bread/On_Consume(mob/living/eater)
	..()
	if(slices_num)
		if(bitecount == 1)
			slices_num = 5
		if(bitecount == 2)
			slices_num = 4
		if(bitecount == 3)
			slices_num = 3
		if(bitecount == 4)
			slices_num = 2
		if(bitecount == 5)
			changefood(slice_path, eater)

/*	.................   Breadslice & Toast   ................... */
/obj/item/reagent_containers/food/snacks/rogue/breadslice
	name = "sliced bread"
	desc = "A bit of comfort to start your dae."
	icon_state = "loaf_slice"
	faretype = FARE_POOR
	w_class = WEIGHT_CLASS_NORMAL
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/breadslice/toast
	bitesize = 2
	rotprocess = SHELFLIFE_LONG
	dropshrink = 0.8

/obj/item/reagent_containers/food/snacks/rogue/breadslice/attackby(obj/item/I, mob/living/user, params)
	update_cooktime(user)
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat/salami/slice))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		if(do_after(user,short_cooktime, target = src))
			var/obj/item/reagent_containers/food/snacks/rogue/sandwich/salami/sammich= new(get_turf(user))
			user.put_in_hands(sammich)
			qdel(I)
			qdel(src)
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/cheddarslice))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		if(do_after(user,short_cooktime, target = src))
			var/obj/item/reagent_containers/food/snacks/rogue/sandwich/cheese/sammich= new(get_turf(user))
			user.put_in_hands(sammich)
			qdel(I)
			qdel(src)
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/friedegg))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		if(do_after(user,short_cooktime, target = src))
			var/obj/item/reagent_containers/food/snacks/rogue/sandwich/egg/sammich= new(get_turf(user))
			user.put_in_hands(sammich)
			qdel(I)
			qdel(src)
	if(istype(I, /obj/item/reagent_containers/food/snacks/fat/salo/slice))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		if(do_after(user,short_cooktime, target = src))
			var/obj/item/reagent_containers/food/snacks/rogue/sandwich/salo/sammich= new(get_turf(user))
			user.put_in_hands(sammich)
			qdel(I)
			qdel(src)
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat/bacon/fried))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		if(do_after(user,short_cooktime, target = src))
			user.mind.adjust_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
			var/obj/item/reagent_containers/food/snacks/rogue/sandwich/bacon/sammich= new(get_turf(user))
			user.put_in_hands(sammich)
			qdel(I)
			qdel(src)
	else
		return ..()

//this is a child so we can be used in sammies
/obj/item/reagent_containers/food/snacks/rogue/breadslice/toast
	name = "toast"
	icon_state = "toast"
	faretype = FARE_NEUTRAL
	tastes = list("crispy bread" = 1)
	mill_result = /obj/item/reagent_containers/food/snacks/rogue/toastcrumbs
	cooked_type = null
	bitesize = 2
	rotprocess = null

/obj/item/reagent_containers/food/snacks/rogue/breadslice/toast/attackby(obj/item/I, mob/user, params)
	update_cooktime(user)
	if(istype(I, /obj/item/reagent_containers/food/snacks/butterslice))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		if(do_after(user,short_cooktime, target = src))
			var/obj/item/reagent_containers/food/snacks/rogue/breadslice/toast/buttered/sammich= new(get_turf(user))
			user.put_in_hands(sammich)
			qdel(I)
			qdel(src)
	else
		return ..()

/obj/item/reagent_containers/food/snacks/rogue/breadslice/toast/buttered
	name = "buttered toast"
	icon_state = "toast_butter"
	faretype = FARE_NEUTRAL
	tastes = list("butter" = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)

/obj/item/reagent_containers/food/snacks/rogue/toastcrumbs
	name = "toast crumbs"
	desc = "Toast crumbs, perfect for adding a crunch to deep fried food."
	icon = 'modular/Neu_Food/icons/deep_fried.dmi'
	icon_state = "toastcrumbs"
	slices_num = 0
	list_reagents = list(/datum/reagent/consumable/nutriment = 6)
	w_class = WEIGHT_CLASS_TINY
	tastes = list("crunch" = 1)
	cooked_type = null
	foodtype = GRAIN
	bitesize = 1
	rotprocess = 30 MINUTES

// -------------- BREAD WITH FOOD ON IT (not american sandwich) -----------------
/obj/item/reagent_containers/food/snacks/rogue/sandwich
	desc = "A delightful piece of heaven, in every slice."
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_NUTRITIOUS)
	faretype = FARE_NEUTRAL
	rotprocess = 30 MINUTES
	eat_effect = /datum/status_effect/buff/foodbuff

/obj/item/reagent_containers/food/snacks/rogue/sandwich/salami
	tastes = list("salumoi" = 1,"bread" = 1)
	name = "salumoi bread"
	faretype = FARE_NEUTRAL
	icon_state = "bread_salami"
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/rogue/sandwich/cheese
	tastes = list("cheese" = 1,"bread" = 1)
	name = "cheese bread"
	faretype = FARE_NEUTRAL
	icon_state = "bread_cheese"
	foodtype = GRAIN | DAIRY

/obj/item/reagent_containers/food/snacks/rogue/sandwich/egg
	tastes = list("cheese" = 1,"egg" = 1)
	name = "egg toast"
	faretype = FARE_NEUTRAL
	icon_state = "bread_egg"
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/rogue/sandwich/salo
	tastes = list("salty fat" = 1)
	name = "salo bread"
	faretype = FARE_IMPOVERISHED
	icon_state = "bread_salo"
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/rogue/sandwich/bacon
	tastes = list("bacon" = 1)
	name = "bacon bread"
	icon_state = "bread_bacon"
	foodtype = GRAIN | MEAT


/*	.................   Bread bun   ................... */
/obj/item/reagent_containers/food/snacks/rogue/bun
	name = "bun"
	desc = "Portable, quaint and entirely consumable"
	icon_state = "bun"
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	faretype = FARE_POOR
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("bread" = 1)
	bitesize = 2
	rotprocess = SHELFLIFE_EXTREME

/obj/item/reagent_containers/food/snacks/rogue/bun/attackby(obj/item/I, mob/living/user, params)
	update_cooktime(user)
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		to_chat(user, span_notice("Pushing the wiener through the bun..."))
		if(do_after(user,short_cooktime, target = src))
			var/obj/item/reagent_containers/food/snacks/rogue/bun_grenz/hotdog= new(get_turf(user))
			user.put_in_hands(hotdog)
			qdel(I)
			qdel(src)
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/cheddarwedge))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 100, TRUE, -1)
		to_chat(user, "<span class='notice'>Stuffing the bun with cheese...</span>")
		if(do_after(user,short_cooktime, target = src))
			user.mind.adjust_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
			new /obj/item/reagent_containers/food/snacks/rogue/bun_raston(loc)
			qdel(I)
			qdel(src)
	else
		return ..()

/* 	.................   Crossbuns   ................... */
// Astrata variant
/obj/item/reagent_containers/food/snacks/rogue/foodbase/crossbun_raw
	name = "raw crossbun"
	desc = "A raw dough with the shape of Astrata's cross pressed onto it. In Her Lights."
	icon = 'modular/Neu_Food/icons/buns.dmi'
	icon_state = "crossbun_raw"
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/crossbun

// Psydon variant
/obj/item/reagent_containers/food/snacks/rogue/foodbase/psycrossbun_raw
	name = "raw psycrossbun"
	desc = "A raw dough with the shape of a Psycross pressed onto it. He ENDURES."
	icon = 'modular/Neu_Food/icons/buns.dmi'
	icon_state = "psycrossbun_raw"
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/psycrossbun

/obj/item/reagent_containers/food/snacks/rogue/crossbun
	name = "crossbun"
	desc = "Traditionally eaten for breakfast."
	icon = 'modular/Neu_Food/icons/buns.dmi'
	icon_state = "crossbun"
	faretype = FARE_NEUTRAL // Having nobles vomit from eating holy buns is not a good idea
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("bread" = 1)
	bitesize = 2
	rotprocess = SHELFLIFE_EXTREME

/obj/item/reagent_containers/food/snacks/rogue/psycrossbun
	name = "psycrossbun"
	desc = "The bun endures."
	icon = 'modular/Neu_Food/icons/buns.dmi'
	icon_state = "psycrossbun"
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	faretype = FARE_NEUTRAL // Having nobles vomit from eating holy buns is not a good idea
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("bread" = 1)
	bitesize = 2
	rotprocess = SHELFLIFE_EXTREME

/*	.................   Cheese bun   ................... */
/obj/item/reagent_containers/food/snacks/rogue/foodbase/cheesebun_raw
	name = "raw cheese bun"
	desc = "Portable, quaint and entirely consumable"
	icon_state = "cheesebun_raw"
	color = "#ecce61"
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/cheesebun
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | DAIRY

/obj/item/reagent_containers/food/snacks/rogue/cheesebun
	name = "fresh cheese bun"
	desc = "A treat from the Grenzelhoft kitchen."
	faretype = FARE_FINE
	icon_state = "cheesebun"
	list_reagents = list(/datum/reagent/consumable/nutriment = SMALLDOUGH_NUTRITION+FRESHCHEESE_NUTRITION)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("crispy bread and cream cheese" = 1)
	foodtype = GRAIN | DAIRY
	bitesize = 2
	rotprocess = SHELFLIFE_DECENT

/obj/item/reagent_containers/food/snacks/rogue/frybread
	name = "frybread"
	desc = "Flatbread fried at high heat with butter to give it a crispy outside. Staple of the elven kitchen."
	icon_state = "frybread"
	faretype = FARE_FINE
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	tastes = list("crispy bread with a soft inside" = 1)
	w_class = WEIGHT_CLASS_NORMAL
	bitesize = 3
	eat_effect = /datum/status_effect/buff/foodbuff

/*	.................   Pastry   ................... */
/obj/item/reagent_containers/food/snacks/rogue/pastry
	name = "pastry"
	desc = "Favored among children and sweetlovers."
	icon_state = "pastry"
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	tastes = list("crispy butterdough" = 1)
	faretype = FARE_FINE
	w_class = WEIGHT_CLASS_NORMAL
	bitesize = 3
	rotprocess = SHELFLIFE_EXTREME
	eat_effect = /datum/status_effect/buff/foodbuff

/*	.................   Biscuit   ................... */
/obj/item/reagent_containers/food/snacks/rogue/foodbase/biscuit_raw
	name = "uncooked raisin biscuit"
	icon_state = "biscuit_raw"
	color = "#ecce61"
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/biscuit
	w_class = WEIGHT_CLASS_NORMAL
	eat_effect = null

/obj/item/reagent_containers/food/snacks/rogue/biscuit
	name = "biscuit"
	desc = "A treat made for a wretched dog like you."
	icon_state = "biscuit"
	faretype = FARE_POOR
	filling_color = "#F0E68C"
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT+SNACK_POOR)
	w_class = WEIGHT_CLASS_NORMAL
	bitesize = 3
	tastes = list("crispy butterdough" = 1, "raisins" = 1)
	eat_effect = /datum/status_effect/buff/foodbuff

/obj/item/reagent_containers/food/snacks/rogue/cookie		//It's a biscuit.......
	name = "cookie of smiles"
	icon_state = "cookie"
	color = "#ecce61"
	w_class = WEIGHT_CLASS_NORMAL
	eat_effect = null

/*	.................   Prezzel   ................... */
/obj/item/reagent_containers/food/snacks/rogue/foodbase/prezzel_raw
	name = "uncooked prezzel"
	icon_state = "prezzel_raw"
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/prezzel
	w_class = WEIGHT_CLASS_NORMAL
	eat_effect = null

/obj/item/reagent_containers/food/snacks/rogue/prezzel
	name = "prezzel"
	desc = "The next best thing since sliced bread, naturally, made by a dwarf."
	icon_state = "prezzel"
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	faretype = FARE_FINE
	tastes = list("crispy butterdough" = 1)
	w_class = WEIGHT_CLASS_NORMAL
	bitesize = 3
	eat_effect = /datum/status_effect/buff/foodbuff


/*	.................   Raisin bread   ................... */
/obj/item/reagent_containers/food/snacks/rogue/rbread_half
	name = "half-done raisin dough"
	desc = "Add more raisins!"
	icon_state = "dough_raisin"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	w_class = WEIGHT_CLASS_NORMAL
	rotprocess = 30 MINUTES

/obj/item/reagent_containers/food/snacks/rogue/rbread_half/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	update_cooktime(user)
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/raisins))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, span_notice("Adding the last of the raisins, puffing up the dough for baking."))
			if(do_after(user,short_cooktime, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				new /obj/item/reagent_containers/food/snacks/rogue/rbreaduncooked(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to work it."))
	else
		return ..()

/obj/item/reagent_containers/food/snacks/rogue/rbreaduncooked
	name = "loaf of raisins"
	icon_state = "raisinbreaduncooked"
	slices_num = 0
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/raisinbread
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	w_class = WEIGHT_CLASS_NORMAL
	rotprocess = 30 MINUTES

/obj/item/reagent_containers/food/snacks/rogue/raisinbread
	name = "raisin loaf"
	desc = "Bread enhanced with sweet raisins for a perfect addition to any meal."
	icon_state = "raisinbread6"
	slices_num = 6
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/raisinbreadslice
	list_reagents = list(/datum/reagent/consumable/nutriment = MEAL_AVERAGE)
	faretype = FARE_NEUTRAL
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("bread" = 1,"dried fruit" = 1)
	slice_batch = FALSE
	slice_sound = TRUE
	rotprocess = SHELFLIFE_EXTREME
	eat_effect = /datum/status_effect/buff/foodbuff

/obj/item/reagent_containers/food/snacks/rogue/raisinbread/update_icon()
	if(slices_num)
		icon_state = "raisinbread[slices_num]"
	else
		icon_state = "raisinbread_slice"

/obj/item/reagent_containers/food/snacks/rogue/raisinbread/On_Consume(mob/living/eater)
	..()
	if(slices_num)
		if(bitecount == 1)
			slices_num = 5
		if(bitecount == 2)
			slices_num = 4
		if(bitecount == 3)
			slices_num = 3
		if(bitecount == 4)
			slices_num = 2
		if(bitecount == 5)
			changefood(slice_path, eater)

/obj/item/reagent_containers/food/snacks/rogue/raisinbreadslice
	name = "raisin loaf slice"
	icon_state = "raisinbread_slice"
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT-1)
	w_class = WEIGHT_CLASS_NORMAL
	faretype = FARE_NEUTRAL
	cooked_type = null
	tastes = list("spelt" = 1,"dried fruit" = 1)
	bitesize = 2
	rotprocess = SHELFLIFE_LONG
	eat_effect = /datum/status_effect/buff/foodbuff
	dropshrink = 0.8

/*	.................   Cake   ................... */
/obj/item/reagent_containers/food/snacks/rogue/cake_base
	name = "cake base"
	desc = "With this sweet thing, you shall make them sing."
	icon_state = "cake"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | DAIRY
	rotprocess = SHELFLIFE_LONG

/obj/item/reagent_containers/food/snacks/rogue/cake_base/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	update_cooktime(user)
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/cheese))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, span_notice("Spreading fresh cheese on the cake..."))
			if(do_after(user,long_cooktime, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				new /obj/item/reagent_containers/food/snacks/rogue/ccakeuncooked(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to work it."))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/spiderhoney))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, span_notice("Slathering the cake with delicious spider honey..."))
			if(do_after(user,long_cooktime, target = src))
				add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
				new /obj/item/reagent_containers/food/snacks/rogue/hcakeuncooked(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("You need to put [src] on a table to work it."))
	else
		return ..()

// -------------- SPIDER-HONEY CAKE (Zybantu) -----------------
/obj/item/reagent_containers/food/snacks/rogue/hcakeuncooked
	name = "unbaked cake"
	icon_state = "honeycakeuncook"
	slices_num = 0
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/hcake
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | DAIRY | SUGAR
	rotprocess = SHELFLIFE_DECENT

/obj/item/reagent_containers/food/snacks/rogue/hcake
	name = "ranesheni cake"
	desc = "Cake glazed with honey, in the famous ranesheni fashion, a delicious sweet treat."
	icon_state = "honeycake"
	slices_num = 8
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/hcakeslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 48)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("cake"=1, "delicious honeyfrosting"=1)
	foodtype = GRAIN | DAIRY | SUGAR
	faretype = FARE_LAVISH
	slice_batch = TRUE
	slice_sound = TRUE
	rotprocess = SHELFLIFE_LONG
	eat_effect = /datum/status_effect/buff/foodbuff
	bitesize = 16

/obj/item/reagent_containers/food/snacks/rogue/hcakeslice
	name = "ranesheni cake slice"
	icon_state = "honeycakeslice"
	slices_num = 0
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	faretype = FARE_FINE
	w_class = WEIGHT_CLASS_NORMAL
	cooked_type = null
	foodtype = GRAIN | DAIRY | SUGAR
	bitesize = 3
	eat_effect = /datum/status_effect/buff/foodbuff
	rotprocess = SHELFLIFE_LONG
	plateable = TRUE

/obj/item/reagent_containers/food/snacks/rogue/hcakeslice/plated
	icon_state = "honeycakeslice_plated"
	rotprocess = SHELFLIFE_EXTREME
	faretype = FARE_LAVISH
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1)
	trash = /obj/item/cooking/platter

// -------------- CHEESECAKE -----------------

/obj/item/reagent_containers/food/snacks/rogue/ccakeuncooked
	name = "unbaked cake of cheese"
	icon_state = "cheesecakeuncook"
	slices_num = 0
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/ccake
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	foodtype = GRAIN | DAIRY | SUGAR
	w_class = WEIGHT_CLASS_NORMAL
	rotprocess = SHELFLIFE_DECENT

/obj/item/reagent_containers/food/snacks/rogue/ccake
	name = "cheesecake"
	desc = "Humenity's favored creation."
	icon_state = "cheesecake"
	slices_num = 8
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/ccakeslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 48)
	faretype = FARE_FINE
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("cake"=1, "creamy cheese"=1)
	foodtype = GRAIN | DAIRY | SUGAR
	slice_batch = TRUE
	slice_sound = TRUE
	rotprocess = SHELFLIFE_LONG
	eat_effect = /datum/status_effect/buff/foodbuff
	bitesize = 16

/obj/item/reagent_containers/food/snacks/rogue/ccakeslice
	name = "cheesecake slice"
	icon_state = "cheesecake_slice"
	slices_num = 0
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	w_class = WEIGHT_CLASS_NORMAL
	faretype = FARE_FINE
	cooked_type = null
	foodtype = GRAIN | DAIRY | SUGAR
	bitesize = 2
	eat_effect = /datum/status_effect/buff/foodbuff
	rotprocess = SHELFLIFE_LONG
	plateable = TRUE

/obj/item/reagent_containers/food/snacks/rogue/ccakeslice/plated
	icon_state = "cheesecake_slice_plated"
	rotprocess = SHELFLIFE_EXTREME
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1)
	faretype = FARE_LAVISH
	trash = /obj/item/cooking/platter

/* maybe split up spider honey cake WIP
	desc = "A cake glazed with spider-honey, a favorite dish among the Dark Elf nobility in Grimoria. Symbol of authority, a delicious residue covers the sweet cake which causes playful stinging and numbness in the mouth."
*/
