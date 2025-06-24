/* .............   RICE   ................ */
/obj/item/reagent_containers/food/snacks/rogue/preserved/rice_cooked
	name = "cooked rice"
	desc = "Plain cooked rice, a staple food in many cultures."
	icon = 'modular/Neu_Food/icons/cooked/cooked_rice.dmi'
	icon_state = "rice"
	faretype = FARE_POOR
	bitesize = 3
	bonus_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	rotprocess = SHELFLIFE_LONG

/obj/item/reagent_containers/food/snacks/rogue/preserved/rice_cooked/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	update_cooktime(user)
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat/steak/fried))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			to_chat(user, "Preparing a serving of rice and beef...")
			if(do_after(user,short_cooktime, target = src))
				user.adjust_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				new /obj/item/reagent_containers/food/snacks/rogue/ricebeef(loc)
				qdel(I)
				qdel(src)
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat/fatty/roast))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			to_chat(user, "Preparing a serving of rice and pork...")
			if(do_after(user,short_cooktime, target = src))
				user.adjust_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				new /obj/item/reagent_containers/food/snacks/rogue/ricepork(loc)
				qdel(I)
				qdel(src)
	else
		return ..()



/*	.................   Rice & pork  ................... */
/obj/item/reagent_containers/food/snacks/rogue/ricepork
	name = "rice and pork"
	tastes = list("rice" = 1, "pork" = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = MEAL_MEAGRE)
	desc = "Rice mixed with fatty pork."
	icon = 'modular/Neu_Food/icons/cooked/cooked_rice.dmi'
	icon_state = "ricepork"
	faretype = FARE_FINE
	rotprocess = SHELFLIFE_LONG
	eat_effect = /datum/status_effect/buff/foodbuff

/obj/item/reagent_containers/food/snacks/rogue/ricepork/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(!experimental_inhand)
		return
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/veg/cucumber_sliced))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			if(do_after(user,3 SECONDS, target = src))
				user.adjust_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				new /obj/item/reagent_containers/food/snacks/rogue/riceporkcuc(loc)
				qdel(I)
				qdel(src)
	else
		return ..()

/*	.................   Rice & pork & cucumbers ................... */
/obj/item/reagent_containers/food/snacks/rogue/riceporkcuc
	name = "rice and pork meal"
	tastes = list("rice" = 1, "pork" = 1, "fresh cucumber")
	list_reagents = list(/datum/reagent/consumable/nutriment = MEAL_MEAGRE)
	desc = "Rice mixed with fatty pork and fresh cucumbers."
	icon = 'modular/Neu_Food/icons/cooked/cooked_rice.dmi'
	icon_state = "riceporkmeal"
	faretype = FARE_LAVISH
	rotprocess = SHELFLIFE_LONG
	eat_effect = /datum/status_effect/buff/foodbuff

/*	.................   Rice & beef ................... */
/obj/item/reagent_containers/food/snacks/rogue/ricebeef
	name = "rice and beef"
	tastes = list("rice" = 1, "steak" = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = MEAL_MEAGRE)
	desc = "Rice mixed with beef steak."
	icon = 'modular/Neu_Food/icons/cooked/cooked_rice.dmi'
	icon_state = "ricebeef"
	faretype = FARE_FINE
	rotprocess = SHELFLIFE_LONG
	eat_effect = /datum/status_effect/buff/foodbuff

/obj/item/reagent_containers/food/snacks/rogue/ricebeef/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(!experimental_inhand)
		return
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/preserved/carrot_baked))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			if(do_after(user,3 SECONDS, target = src))
				user.adjust_experience(/datum/skill/craft/cooking, user.STAINT * 0.8)
				new /obj/item/reagent_containers/food/snacks/rogue/ricebeefcar(loc)
				qdel(I)
				qdel(src)
	else
		return ..()

/*	.................   Rice & beef & carrots ................... */
/obj/item/reagent_containers/food/snacks/rogue/ricebeefcar
	name = "rice and beef meal"
	tastes = list("rice" = 1, "steak" = 1, "carrot")
	list_reagents = list(/datum/reagent/consumable/nutriment = MEAL_MEAGRE)
	desc = "Rice mixed with beef steak and carrots."
	icon = 'modular/Neu_Food/icons/cooked/cooked_rice.dmi'
	icon_state = "ricebeefmeal"
	faretype = FARE_LAVISH
	rotprocess = SHELFLIFE_LONG
	eat_effect = /datum/status_effect/buff/foodbuff
