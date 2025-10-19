
/obj/machinery/anvil
	icon = 'icons/roguetown/misc/forge.dmi'
	name = "iron anvil"
	desc = "It's surface is marred by countless hammer strikes."
	icon_state = "anvil"
	var/hott = null
	var/obj/item/hingot
	max_integrity = 500
	density = TRUE
	damage_deflection = 25
	climbable = TRUE
	var/previous_material_quality = 0
	var/advance_multiplier = 1 //Lower for auto-striking
	var/datum/anvil_recipe/currecipe

/obj/machinery/anvil/crafted
	icon_state = "caveanvil"

/obj/machinery/anvil/examine(mob/user)
	. = ..()
	if(hingot && hott)
		. += span_warning("[hingot] is too hot to touch.")
	if(currecipe)
		. += span_info("Middle click anvil to clear the active recipe.")

/obj/machinery/anvil/attackby(obj/item/W, mob/living/user, params)
	if(istype(W, /obj/item/rogueweapon/tongs))
		var/obj/item/rogueweapon/tongs/T = W
		if(hingot)
			// Only use tongs for ingots (which can be hot)
			if(istype(hingot, /obj/item/ingot))
				if(T.hingot)
					if(currecipe && currecipe.needed_item && istype(T.hingot, currecipe.needed_item))
						currecipe.item_added(user)
						if(istype(T.hingot, /obj/item/ingot))
							var/obj/item/ingot/I = T.hingot
							currecipe.material_quality += I.quality
							previous_material_quality = I.quality
						else
							currecipe.material_quality += previous_material_quality
						currecipe.num_of_materials += 1
						qdel(T.hingot)
						T.hingot = null
						T.update_icon()
						update_icon()
						return
					return
				else
					// Pick up the ingot with tongs without clearing the recipe
					hingot.forceMove(T)
					T.hingot = hingot
					T.hott = hott // Transfer heat state
					hingot = null
					hott = null
					T.update_icon()
					update_icon()
					return
		else
			// Place ingot from tongs onto anvil
			if(T.hingot && istype(T.hingot, /obj/item/ingot))
				T.hingot.forceMove(src)
				hingot = T.hingot
				hott = T.hott
				T.hingot = null
				T.hott = null
				if(currecipe && !istype(hingot, currecipe.req_bar))
					currecipe = null
				if(hott)
					START_PROCESSING(SSmachines, src)
				T.update_icon()
				update_icon()
				return

	// Allow both ingots and blades to be placed on the anvil by hand
	if(istype(W, /obj/item/ingot) || istype(W, /obj/item/blade))
		if(!hingot)
			W.forceMove(src)
			hingot = W
			// Clear recipe when new item is placed
			currecipe = null
			// Only ingots can be hot, blades are always cold
			if(istype(W, /obj/item/ingot))
				hott = null
			else
				hott = null
			update_icon()
			return

	if(istype(W, /obj/item/rogueweapon/hammer))
		user.changeNext_move(CLICK_CD_FAST)
		var/obj/item/rogueweapon/hammer/hammer = W
		if(!hingot)
			return
		if(!currecipe)
			ui_interact(user)
			return
		advance_multiplier = 1
		user.doing = FALSE
		spawn(1)
			while(hingot && currecipe)
				// Blades don't need to be hot, only check for ingots
				if(!hott && istype(hingot, /obj/item/ingot))
					to_chat(user, span_warning("It's too cold."))
					return
				var/used_str = user.STASTR
				if(iscarbon(user))
					var/mob/living/carbon/carbon_user = user
					if(carbon_user.domhand)
						used_str = carbon_user.get_str_arms(carbon_user.used_hand)
					if(HAS_TRAIT(carbon_user, TRAIT_FORGEBLESSED))
						carbon_user.stamina_add(max(21 - (used_str * 3), 0)*advance_multiplier)
					else
						carbon_user.stamina_add(max(40 - (used_str * 3), 0)*advance_multiplier)
				var/total_chance = 7 * user.get_skill_level(currecipe.appro_skill) * user.STAPER/10 * hammer.quality
				var/breakthrough = 0
				if(prob((1 + total_chance)*advance_multiplier))
					user.flash_fullscreen("whiteflash")
					var/datum/effect_system/spark_spread/S = new()
					var/turf/front = get_turf(src)
					S.set_up(1, 1, front)
					S.start()
					breakthrough = 1
					currecipe.numberofbreakthroughs++

				if(!currecipe.advance(user, breakthrough, advance_multiplier))
					shake_camera(user, 1, 1)
					playsound(src,'sound/items/bsmithfail.ogg', 100, FALSE)
					break
				playsound(src,pick('sound/items/bsmith1.ogg','sound/items/bsmith2.ogg','sound/items/bsmith3.ogg','sound/items/bsmith4.ogg'), 100, FALSE)
				if(do_after(user, 20, target = src))
					advance_multiplier = 0.50
				else
					break
		return

	// Handle adding materials to current recipe
	if(hingot && currecipe && currecipe.needed_item && istype(W, currecipe.needed_item))
		currecipe.item_added(user)
		if(istype(W, /obj/item/ingot))
			var/obj/item/ingot/I = W
			currecipe.material_quality += I.quality
			previous_material_quality = I.quality
		else
			currecipe.material_quality += previous_material_quality
		currecipe.num_of_materials += 1
		qdel(W)
		return

	if(W.anvilrepair)
		user.visible_message(span_info("[user] places [W] on the anvil."))
		W.forceMove(src.loc)
		return
	..()

/obj/machinery/anvil/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Anvil", "Anvil")
		ui.open()

/obj/machinery/anvil/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/spritesheet/anvil_recipes)
	)

/obj/machinery/anvil/ui_data(mob/user)
	var/list/data = ..()

	data["hingot_type"] = hingot?.type
	return data

/obj/machinery/anvil/ui_static_data(mob/user)
	var/list/data = ..()

	var/list/recipes = list()
	var/datum/asset/spritesheet/spritesheet = get_asset_datum(/datum/asset/spritesheet/anvil_recipes)

	for(var/datum/anvil_recipe/R in GLOB.anvil_recipes)
		var/valid_recipe = FALSE

		if(hingot)
			if((R.req_bar && istype(hingot, R.req_bar)) || (R.req_blade && istype(hingot, R.req_blade)))
				valid_recipe = TRUE
		if(!hingot || valid_recipe || (!R.req_bar && !R.req_blade))
			UNTYPED_LIST_ADD(recipes, list(
				"name" = R.name,
				"category" = R.i_type,
				"req_bar" = R.req_bar,
				"req_blade" = R.req_blade,
				"ref" = REF(R),
				"icon" = spritesheet.icon_class_name(sanitize_css_class_name("recipe_[REF(R)]"))
			))
	data["recipes"] = recipes
	return data

/obj/machinery/anvil/ui_act(action, list/params, datum/tgui/ui)
	. = ..()
	if(.)
		return

	var/mob/user = ui.user

	switch(action)
		if("choose_recipe")
			var/datum/anvil_recipe/recipe = locate(params["ref"])
			if(!istype(recipe))
				return TRUE
			var/has_required_item = FALSE
			var/using_blade = FALSE
			
			// Check both bar and blade requirements
			if(recipe.req_bar && istype(hingot, recipe.req_bar))
				has_required_item = TRUE
			if(recipe.req_blade && istype(hingot, recipe.req_blade))
				has_required_item = TRUE
				using_blade = TRUE

			if(!has_required_item)
				return TRUE

			var/smith_exp = user.get_skill_level(recipe.appro_skill)
			if(smith_exp < recipe.craftdiff)
				if(alert(user, "This recipe needs [SSskills.level_names_plain[recipe.craftdiff]] skill.","IT'S TOO DIFFICULT!","CONFIRM","CANCEL") != "CONFIRM")
					return TRUE

			// Half to check this again because we alert()ed
			if(!has_required_item)
				return TRUE

			// Create the recipe and assign it to the ANVIL
			currecipe = new recipe.type(src, using_blade)

			var/quality_value = 1
			if(istype(hingot, /obj/item/ingot))
				var/obj/item/ingot/ingot_ref = hingot
				quality_value = ingot_ref.quality
			else if(istype(hingot, /obj/item/blade))
				var/obj/item/blade/blade_ref = hingot
				quality_value = blade_ref.quality

			currecipe.bar_health = 50 * (quality_value + 1)
			currecipe.max_progress = 100
			currecipe.material_quality += quality_value
			previous_material_quality = quality_value

			ui.close()
			return TRUE

/obj/machinery/anvil/attack_hand(mob/user, params)
	if(hingot)
		// Blades are never hot, so only check hott for ingots
		if(hott && istype(hingot, /obj/item/ingot))
			to_chat(user, span_warning("It's too hot."))
			return
		else
			var/obj/item/I = hingot
			hingot = null
			hott = null
			I.forceMove(user.loc)
			user.put_in_active_hand(I)
			update_icon()

/obj/machinery/anvil/MiddleClick(mob/user, params)
	. = ..()
	currecipe = null

/obj/machinery/anvil/process()
	if(hott)
		if(world.time > hott + 10 SECONDS)
			hott = null
			STOP_PROCESSING(SSmachines, src)
	else
		STOP_PROCESSING(SSmachines, src)
	update_icon()

/obj/machinery/anvil/update_icon()
	cut_overlays()
	if(hingot)
		var/obj/item/I = hingot
		I.pixel_x = 0
		I.pixel_y = 0
		var/mutable_appearance/M = new /mutable_appearance(I)
		if(hott)
			M.filters += filter(type="color", color = list(3,0,0,1, 0,2.7,0,0.4, 0,0,1,0, 0,0,0,1))
		M.transform *= 0.5
		M.pixel_y = 5
		M.pixel_x = 3
		add_overlay(M)
