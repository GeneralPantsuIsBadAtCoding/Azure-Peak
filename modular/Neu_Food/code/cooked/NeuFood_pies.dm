/* * * * * * * * * * * **
 *						*
 *		 NeuFood		*
 *		 (Pies)		 	*
 *						*
 * * * * * * * * * * * **/



/*	........   Pie making   ................ */
/obj/item/reagent_containers/food/snacks/rogue/foodbase/piebottom
	name = "pie bottom"
	desc = "The foundation of the fantastical.."
	icon_state = "piebottom"
	w_class = WEIGHT_CLASS_NORMAL
	eat_effect = /datum/status_effect/debuff/uncookedfood
	process_step = 1
	var/applepie
	var/fishy
	var/meaty
	var/potpie
	var/berrypie
	var/poisoning
	var/crabby
	var/substitute //There may be a better way to do this

/obj/item/reagent_containers/food/snacks/rogue/foodbase/piebottom/update_icon()
	. = ..()
	var/mutable_appearance/piebottom = mutable_appearance(icon, "pieuncooked")
	var/mutable_appearance/roofeat = mutable_appearance(icon, "meatpie_raw")
	var/mutable_appearance/roofish = mutable_appearance(icon, "fishpie_raw")
	if (process_step == 2 && applepie)
		var/mutable_appearance/apple1 = mutable_appearance(icon, "fill_apple1")
		add_overlay(apple1)
//	if (process_step == 2 && potpie)  TESTING DOING POTPIE ANOTHER WAY
//		var/mutable_appearance/pot1 = mutable_appearance(icon, "fill_egg1")
//		add_overlay(pot1)
	if (process_step == 2 && meaty)
		var/mutable_appearance/meat1 = mutable_appearance(icon, "fill_meat1")
		add_overlay(meat1)
	if (process_step == 2 && fishy)
		var/mutable_appearance/fish1 = mutable_appearance(icon, "fill_fish1")
		add_overlay(fish1)
	if (process_step == 2 && berrypie)
		var/mutable_appearance/berry1 = mutable_appearance(icon, "fill_berry1")
		add_overlay(berry1)
	if (process_step == 2 && crabby)
		var/mutable_appearance/crabby1 = mutable_appearance(icon, "fill_crab1")
		add_overlay(crabby1)
	if (process_step == 3 && applepie)
		var/mutable_appearance/apple2 = mutable_appearance(icon, "fill_apple2")
		add_overlay(apple2)
//	if (process_step == 3 && potpie)
//		var/mutable_appearance/pot2 = mutable_appearance(icon, "fill_egg2")
//		add_overlay(pot2)
	if (process_step == 3 && meaty)
		var/mutable_appearance/meat2 = mutable_appearance(icon, "fill_meat2")
		add_overlay(meat2)
	if (process_step == 3 && fishy)
		var/mutable_appearance/fish2 = mutable_appearance(icon, "fill_fish2")
		add_overlay(fish2)
	if (process_step == 3 && berrypie)
		var/mutable_appearance/berry2 = mutable_appearance(icon, "fill_berry2")
		add_overlay(berry2)
	if (process_step == 3 && crabby)
		var/mutable_appearance/crabby2 = mutable_appearance(icon, "fill_crab2")
		add_overlay(crabby2)
	if (process_step == 4 && applepie)
		var/mutable_appearance/apple3 = mutable_appearance(icon, "fill_apple3")
		add_overlay(apple3)
//	if (process_step == 4 && potpie)
//		var/mutable_appearance/pot3 = mutable_appearance(icon, "fill_egg3")
//		add_overlay(pot3)
	if (process_step == 4 && meaty)
		var/mutable_appearance/meat3 = mutable_appearance(icon, "fill_meat3")
		add_overlay(meat3)
	if (process_step == 4 && fishy)
		var/mutable_appearance/fish3 = mutable_appearance(icon, "fill_fish3")
		add_overlay(fish3)
	if (process_step == 4 && berrypie)
		var/mutable_appearance/berry3 = mutable_appearance(icon, "fill_berry3")
		add_overlay(berry3)
	if (process_step == 4 && crabby)
		var/mutable_appearance/crabby3 = mutable_appearance(icon, "fill_crab3")
		add_overlay(crabby3)
	else if (process_step == 5)
		cut_overlays()
		add_overlay(piebottom)
		if (fishy)
			cut_overlays()
			fishy = FALSE
			add_overlay(roofish)
		if (meaty)
			cut_overlays()
			meaty = FALSE
			add_overlay(roofeat)


/obj/item/reagent_containers/food/snacks/rogue/foodbase/piebottom/attackby(obj/item/I, mob/living/user, params)
	if(user.mind)
		short_cooktime = (6 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 0.5 SECONDS))
		long_cooktime = (10 SECONDS - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 1 SECONDS))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish))
		if (process_step > 4)
			return
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 30, TRUE, -1)
		if(process_step == 1 && do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			to_chat(user, span_notice("Starting on a fish pie..."))
			name = "unfinished fish pie"
			process_step += 1
			fishy = TRUE
			update_icon()
			qdel(I)
			return
		if(fishy && process_step == 2 && do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			to_chat(user, span_notice("Adding filling to the fish pie. Needs more."))
			process_step += 1
			update_icon()
			qdel(I)
			return
		if(fishy && process_step == 3 && do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			to_chat(user, span_notice("Filling the fish pie to the brim. Still lacks a pie roof."))
			process_step += 1
			update_icon()
			qdel(I)
			return

	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat/mince/beef))
		if (process_step > 4)
			return
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 30, TRUE, -1)
		if(process_step == 1 && do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			to_chat(user, span_notice("Starting on a meat pie..."))
			name = "unfinished meat pie"
			process_step += 1
			meaty = TRUE
			update_icon()
			qdel(I)
			return
		if(meaty && process_step == 2 && do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			to_chat(user, span_notice("Adding filling to the meat pie. Needs more."))
			process_step += 1
			update_icon()
			qdel(I)
			return
		if(meaty && process_step == 3 && do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			to_chat(user, span_notice("Filling the meat pie to the brim. Still lacks a pie roof."))
			process_step += 1
			update_icon()
			qdel(I)
			return

	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/cheddarwedge) || istype(I, /obj/item/reagent_containers/food/snacks/rogue/veg/potato_sliced)  || istype(I, /obj/item/reagent_containers/food/snacks/rogue/cheese) )
		if (process_step > 4)
			return
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 30, TRUE, -1)
		if(process_step == 1 && do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			to_chat(user, span_notice("Starting on a pot pie..."))
			name = "unfinished pot pie"
			process_step += 1
			potpie = TRUE
			var/mutable_appearance/pot1 = mutable_appearance(icon, "fill_pot1")
			add_overlay(pot1)
			qdel(I)
			return
		if(potpie && process_step == 2 && do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			to_chat(user, span_notice("Adding filling to the pot pie. Needs more."))
			process_step += 1
			var/mutable_appearance/pot2 = mutable_appearance(icon, "fill_pot2")
			add_overlay(pot2)
			qdel(I)
			return
		if(potpie && process_step == 3 && do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			to_chat(user, span_notice("Filling the pot pie to the brim. Still lacks a pie roof."))
			process_step += 1
			var/mutable_appearance/pot3 = mutable_appearance(icon, "fill_pot3")
			add_overlay(pot3)
			qdel(I)
			return

	if(istype(I, /obj/item/reagent_containers/food/snacks/egg) )
		if (process_step > 4)
			return
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 30, TRUE, -1)
		if(process_step == 1 && do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			to_chat(user, span_notice("Starting on a pot pie..."))
			name = "unfinished pot pie"
			process_step += 1
			potpie = TRUE
			var/mutable_appearance/egg1 = mutable_appearance(icon, "fill_egg1")
			add_overlay(egg1)
			qdel(I)
			return
		if(potpie && process_step == 2 && do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			to_chat(user, span_notice("Adding filling to the pot pie. Needs more."))
			process_step += 1
			var/mutable_appearance/egg2 = mutable_appearance(icon, "fill_egg2")
			add_overlay(egg2)
			qdel(I)
			return
		if(potpie && process_step == 3 && do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			to_chat(user, span_notice("Filling the pot pie to the brim. Still lacks a pie roof."))
			process_step += 1
			var/mutable_appearance/egg3 = mutable_appearance(icon, "fill_egg3")
			add_overlay(egg3)
			qdel(I)
			return

	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat/bacon) || istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat/mince/poultry) || istype(I, /obj/item/reagent_containers/food/snacks/fat) )
		if (process_step > 4)
			return
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 30, TRUE, -1)
		if(process_step == 1 && do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			to_chat(user, span_notice("Starting on a pot pie..."))
			name = "unfinished pot pie"
			process_step += 1
			potpie = TRUE
			var/mutable_appearance/animal1 = mutable_appearance(icon, "fill_fish1")
			add_overlay(animal1)
			qdel(I)
			return
		if(potpie && process_step == 2 && do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			to_chat(user, span_notice("Adding filling to the pot pie. Needs more."))
			process_step += 1
			var/mutable_appearance/animal2 = mutable_appearance(icon, "fill_fish2")
			add_overlay(animal2)
			qdel(I)
			return
		if(potpie && process_step == 3 && do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			to_chat(user, span_notice("Filling the pot pie to the brim. Still lacks a pie roof."))
			process_step += 1
			var/mutable_appearance/animal3 = mutable_appearance(icon, "fill_fish3")
			add_overlay(animal3)
			qdel(I)
			return


		var/mutable_appearance/animal1 = mutable_appearance(icon, "fill_fish1")
		add_overlay(animal1)




	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat/crab))
		if (process_step > 4)
			return
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 30, TRUE, -1)
		if(process_step == 1 && do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			to_chat(user, span_notice("Starting on a crab pie... You consider that shredded cabbage could be used as filler for one of the remaining ingredients. "))
			name = "unfinished crab pie"
			process_step += 1
			crabby = TRUE
			update_icon()
			qdel(I)
			return
		if(crabby && process_step == 2 && do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			to_chat(user, span_notice("Adding filling to the crab pie. Needs more."))
			process_step += 1
			update_icon()
			qdel(I)
			return
		if(crabby && process_step == 3 && do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			to_chat(user, span_notice("Filling the crab pie to the brim. Still lacks a pie roof."))
			process_step += 1
			update_icon()
			qdel(I)
			return

	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/veg/cabbage_sliced))
		if (process_step > 4 || process_step == 1)
			return
		if (substitute == TRUE)
			to_chat(user, span_notice("There is too much cabbage in this pie already."))
			return
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 30, TRUE, -1)
		if(crabby && process_step >= 2 && process_step <= 3 && do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			to_chat(user, span_notice("Substituting cabbage for crab meat in the crab pie..."))
			process_step += 1
			substitute = TRUE
			update_icon()
			qdel(I)
			return
		

	if(istype(I, /obj/item/reagent_containers/food/snacks/grown/apple))
		if (process_step > 4)
			return
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 30, TRUE, -1)
		if(process_step == 1 && do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			to_chat(user, span_notice("Starting on an apple pie..."))
			name = "unfinished apple pie"
			process_step += 1
			applepie = TRUE
			update_icon()
			qdel(I)
			return
		if(applepie && process_step == 2 && do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			to_chat(user, span_notice("Adding filling to the apple pie. Needs more."))
			process_step += 1
			update_icon()
			qdel(I)
			return
		if(applepie && process_step == 3 && do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			to_chat(user, span_notice("Filling the apple pie to the brim. Still lacks a pie roof."))
			process_step += 1
			update_icon()
			qdel(I)
			return

	if(istype(I, /obj/item/reagent_containers/food/snacks/grown/berries/rogue/poison))
		if (process_step > 4)
			return
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 30, TRUE, -1)
		if(process_step == 1 && do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			to_chat(user, span_notice("Starting on a berry pie..."))
			name = "unfinished berrypie"
			process_step += 1
			berrypie = TRUE
			poisoning = TRUE
			update_icon()
			qdel(I)
			return
		if(berrypie && process_step == 2 && do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			to_chat(user, span_notice("Adding filling to the berry pie. Needs more."))
			process_step += 1
			poisoning = TRUE
			update_icon()
			qdel(I)
			return
		if(berrypie && process_step == 3 && do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			to_chat(user, span_notice("Filling the berry pie to the brim. Still lacks a pie roof."))
			process_step += 1
			poisoning = TRUE
			update_icon()
			qdel(I)
			return

	else if(istype(I, /obj/item/reagent_containers/food/snacks/grown/berries/rogue))
		if (process_step > 4)
			return
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 30, TRUE, -1)
		if(process_step == 1 && do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			to_chat(user, span_notice("Starting on a berry pie..."))
			name = "unfinished berrypie"
			process_step += 1
			berrypie = TRUE
			update_icon()
			qdel(I)
			return
		if(berrypie && process_step == 2 && do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			to_chat(user, span_notice("Adding filling to the berry pie. Needs more."))
			process_step += 1
			update_icon()
			qdel(I)
			return
		if(berrypie && process_step == 3 && do_after(user,short_cooktime, target = src))
			add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
			to_chat(user, span_notice("Filling the berry pie to the brim. Still lacks a pie roof."))
			process_step += 1
			update_icon()
			qdel(I)
			return

	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/piedough))
		playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
		if(fishy && process_step == 4 && do_after(user,short_cooktime, target = src))
			name = "uncooked fish pie"
			icon_state = "fishpie_raw"
			cooked_type = /obj/item/reagent_containers/food/snacks/rogue/pie/cooked/meat/fish
			filling_color = "#d44197"
			process_step += 1
			update_icon()
			qdel(I)
		else if(meaty && process_step == 4 && do_after(user,short_cooktime, target = src))
			name = "uncooked meat pie"
			icon_state = "meatpie_raw"
			cooked_type = /obj/item/reagent_containers/food/snacks/rogue/pie/cooked/meat/meat
			filling_color = "#b43628"
			process_step += 1
			update_icon()
			qdel(I)
		else if(potpie && process_step == 4 && do_after(user,short_cooktime, target = src))
			name = "uncooked pot pie"
			filling_color = "#755430"
			cooked_type = /obj/item/reagent_containers/food/snacks/rogue/pie/cooked/pot
			process_step += 1
			update_icon()
			qdel(I)
		else if(applepie && process_step == 4 && do_after(user,short_cooktime, target = src))
			name = "uncooked apple pie"
			filling_color = "#947a4b"
			cooked_type = /obj/item/reagent_containers/food/snacks/rogue/pie/cooked/apple
			process_step += 1
			update_icon()
			qdel(I)
		else if(poisoning && process_step == 4 && do_after(user,short_cooktime, target = src))
			name = "uncooked berry pie"
			filling_color = "#4a62cf"
			cooked_type = /obj/item/reagent_containers/food/snacks/rogue/pie/cooked/poison
			process_step += 1
			update_icon()
			qdel(I)
		else if(berrypie && process_step == 4 && do_after(user,short_cooktime, target = src))
			name = "uncooked berry pie"
			filling_color = "#4a62cf"
			cooked_type = /obj/item/reagent_containers/food/snacks/rogue/pie/cooked/berry
			process_step += 1
			update_icon()
			qdel(I)
		else if(crabby && process_step == 4 && do_after(user,short_cooktime, target = src))
			name = "uncooked crab pie"
			filling_color = "#f1e0cb"
			cooked_type = /obj/item/reagent_containers/food/snacks/rogue/pie/cooked/crab
			process_step += 1
			update_icon()
			qdel(I)
	else
		return ..()
	return ..()


/*	........   Pie templates   ................ */
/obj/item/reagent_containers/food/snacks/rogue/pie
	name = "pie"
	desc = ""
	color = "#e7e2df"
	dropshrink = 0.8
	var/stunning = FALSE

/obj/item/reagent_containers/food/snacks/rogue/pie/cooked
	icon_state = "pie"
	list_reagents = list(/datum/reagent/consumable/nutriment = MEAL_FILLING)
	slice_path = /obj/item/reagent_containers/food/snacks/rogue/pieslice
	slices_num = 5
	slice_batch = TRUE
	faretype = FARE_LAVISH //an entire pie! all to yourself!
	portable = FALSE
	warming = 10 MINUTES
	eat_effect = null
	foodtype = GRAIN | DAIRY
	chopping_sound = TRUE
	eat_effect = /datum/status_effect/buff/foodbuff
	dropshrink = 0.8

/obj/item/reagent_containers/food/snacks/rogue/pie/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(!.) //if we're not being caught
		splat(hit_atom)

/obj/item/reagent_containers/food/snacks/rogue/pie/proc/splat(atom/movable/hit_atom)
	if(isliving(loc)) //someone caught us!
		return
	var/turf/T = get_turf(hit_atom)
	new/obj/effect/decal/cleanable/food/pie_smudge(T)
	if(reagents && reagents.total_volume)
		reagents.reaction(hit_atom, TOUCH)
	if(isliving(hit_atom))
		var/mob/living/L = hit_atom
		if(stunning)
			L.Paralyze(20) //splat!
		L.adjust_blurriness(1)
		L.visible_message(span_warning("[L] is hit by [src]!"), span_danger("I'm hit by [src]!"))
	if(is_type_in_typecache(hit_atom, GLOB.creamable))
		hit_atom.AddComponent(/datum/component/creamed, src)
	qdel(src)

/obj/item/reagent_containers/food/snacks/rogue/pie/CheckParts(list/parts_list)
	..()
	for(var/obj/item/reagent_containers/food/snacks/M in parts_list)
		filling_color = M.filling_color
		update_snack_overlays(M)
		color = M.filling_color
		if(M.reagents)
			M.reagents.remove_reagent(/datum/reagent/consumable/nutriment, M.reagents.total_volume)
			M.reagents.trans_to(src, M.reagents.total_volume)
		qdel(M)

/obj/item/reagent_containers/food/snacks/rogue/pieslice
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	tastes = list("pie" = 1)
	name = "pie slice"
	desc = ""
	icon_state = "slice"
	filling_color = "#FFFFFF"
	faretype = FARE_FINE
	portable = FALSE
	foodtype = GRAIN | DAIRY
	warming = 5 MINUTES
	bitesize = 3
	eat_effect = /datum/status_effect/buff/foodbuff
	color = "#e7e2df"
	rotprocess = SHELFLIFE_LONG

// -------------- MEAT PIE -----------------
/obj/item/reagent_containers/food/snacks/rogue/pie/cooked/meat // bae item
	name = "meat pie"
	desc = "A delicious, homemade pie made with minced meat. Still needs to be sliced."
	eat_effect = /datum/status_effect/buff/foodbuff
	foodtype = GRAIN | DAIRY | MEAT

/obj/item/reagent_containers/food/snacks/rogue/pie/cooked/meat/meat
	icon_state = "meatpie"
	tastes = list("succulent meat and crispy butterdough" = 1)
	filling_color = "#b43628"

// -------------- FISH PIE -----------------
/obj/item/reagent_containers/food/snacks/rogue/pie/cooked/meat/fish
	name = "fish pie"
	desc = "A delicious, homemade pie made with fresh fish. Still needs to be sliced."
	icon_state = "fishpie"
	tastes = list("baked fish and crispy butterdough" = 1)
	filling_color = "#d44197"


// -------------- POT PIE -----------------
/obj/item/reagent_containers/food/snacks/rogue/pie/cooked/pot
	name = "pot pie"
	desc = "A delicious, homemade pie. Still needs to be sliced."
	list_reagents = list(/datum/reagent/consumable/nutriment = MEAL_GOOD)
	tastes = list("succulent filling and crispy butterdough" = 1)
	filling_color = "#755430"
	foodtype = GRAIN | DAIRY | MEAT

// -------------- BERRY PIE -----------------
/obj/item/reagent_containers/food/snacks/rogue/pie/cooked/berry
	name = "berry pie"
	desc = "A delicious, homemade pie made with wild berries. Still needs to be sliced."
	list_reagents = list(/datum/reagent/consumable/nutriment = MEAL_GOOD)
	slices_num = 4
	tastes = list("crispy butterdough" = 1, "sweet berries" = 1)
	filling_color = "#4a62cf"

// -------------- POISON PIE -----------------
/obj/item/reagent_containers/food/snacks/rogue/pie/cooked/poison
	name = "berry pie"
	desc = "A delicious, homemade pie made with wild berries. Still needs to be sliced."
	slices_num = 4
	list_reagents = list(/datum/reagent/consumable/nutriment = MEAL_GOOD, /datum/reagent/berrypoison = 12)
	tastes = list("crispy butterdough" = 1, "bitter berries" =1)
	filling_color = "#4a62cf"

// -------------- APPLE PIE -----------------
/obj/item/reagent_containers/food/snacks/rogue/pie/cooked/apple
	name = "apple pie"
	desc = "A delicious, homemade pie made with the sliced apples. Still needs to be cut."
	slices_num = 4
	list_reagents = list(/datum/reagent/consumable/nutriment = MEAL_GOOD)
	tastes = list("baked apples and crispy butterdough" = 1)
	filling_color = "#947a4b"

// -------------- CRAB PIE -----------------
/obj/item/reagent_containers/food/snacks/rogue/pie/cooked/crab
	name = "crab pie"
	desc = "A delicious, homemade pie made with the inside of a crustacean. Still needs to be sliced."
	slices_num = 4
	list_reagents = list(/datum/reagent/consumable/nutriment = MEAL_GOOD)
	tastes = list("crispy butterdough" = 1, "rich crab meat" = 1)
	filling_color = "#f1e0cb"

// -------------- HANDPIE (dwarven pie on the go, good shelflife until bitten, made from pie dough and mince, truffles or jacksberries) -----------------
/obj/item/reagent_containers/food/snacks/rogue/foodbase/handpieraw
	name = "raw handpie"
	desc = "The dwarven take on pies, called pierogi in their dialect. A fistfull of food to stand the test of time."
	icon_state = "handpie_raw"
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/handpie
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/handpie
	w_class = WEIGHT_CLASS_NORMAL
	dropshrink = 0.8

/obj/item/reagent_containers/food/snacks/rogue/foodbase/handpieraw/mushroom
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_POOR)
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | VEGETABLES
	tastes = list("meat" = 1)

/obj/item/reagent_containers/food/snacks/rogue/foodbase/handpieraw/mince
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | MEAT
	tastes = list("mushrooms" = 1)

/obj/item/reagent_containers/food/snacks/rogue/foodbase/handpieraw/berry
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | FRUIT
	tastes = list("berry" = 1)

/obj/item/reagent_containers/food/snacks/rogue/foodbase/handpieraw/poison
	list_reagents = list(/datum/reagent/berrypoison = 5)
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | FRUIT
	tastes = list("bitter berry" = 1)

/obj/item/reagent_containers/food/snacks/rogue/handpie
	name = "handpie"
	desc = "The dwarven take on pies, called pierogi in their dialect. A fistfull of food to stand the test of time."
	icon_state = "handpie"
	eat_effect = /datum/status_effect/buff/foodbuff
	bitesize = 4
	faretype = FARE_FINE
	bonus_reagents = list(/datum/reagent/consumable/nutriment = BUTTERDOUGHSLICE_NUTRITION+MINCE_NUTRITION)
	tastes = list("crispy dough" = 1)
	rotprocess = null
	dropshrink = 0.8

/obj/item/reagent_containers/food/snacks/rogue/handpie/On_Consume(mob/living/eater)
	..()
	icon_state = "handpie[bitecount]"
	if(bitecount == 1)
		rotprocess = SHELFLIFE_DECENT
		addtimer(CALLBACK(src, PROC_REF(begin_rotting)), 20, TIMER_CLIENT_TIME)
