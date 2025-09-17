/proc/get_cached_food_flat_icon(obj/item/reagent_containers/food/snacks/food_type)
	var/cache_key = "[food_type]"
	if(!GLOB.cached_food_flat_icons[cache_key])
		var/image/dummy = image(initial(food_type.icon), null, initial(food_type.icon_state), initial(food_type.layer))
		GLOB.cached_food_flat_icons[cache_key] = "<img src='data:image/png;base64, [icon2base64(getFlatIcon(dummy))]'>"
	return GLOB.cached_food_flat_icons[cache_key]

/proc/get_cached_drink_flat_icon(drink_quality)
	var/obj/item/reagent_containers/glass/icon_type
	if(drink_quality <= 0)
		icon_type = /obj/item/reagent_containers/glass/cup/wooden
	else if(drink_quality <= 1)
		icon_type = /obj/item/reagent_containers/glass/cup
	else if(drink_quality <= 2)
		icon_type = /obj/item/reagent_containers/glass/bottle
	else if(drink_quality <= 3)
		icon_type = /obj/item/reagent_containers/glass/cup/silver
	else
		icon_type = /obj/item/reagent_containers/glass/cup/golden

	var/cache_key = "[icon_type]"
	if(!GLOB.cached_drink_flat_icons[cache_key])
		var/image/dummy = image(initial(icon_type.icon), null, initial(icon_type.icon_state), initial(icon_type.layer))
		GLOB.cached_drink_flat_icons[cache_key] = "<img src='data:image/png;base64, [icon2base64(getFlatIcon(dummy))]'>"
	return GLOB.cached_drink_flat_icons[cache_key]

/datum/preferences/proc/validate_culinary_preferences()
	if(!culinary_preferences)
		culinary_preferences = list()

	if(!culinary_preferences[CULINARY_FAVOURITE_FOOD])
		culinary_preferences[CULINARY_FAVOURITE_FOOD] = get_default_food()

	if(!culinary_preferences[CULINARY_FAVOURITE_DRINK])
		culinary_preferences[CULINARY_FAVOURITE_DRINK] = get_default_drink()

	if(!culinary_preferences[CULINARY_HATED_FOOD])
		culinary_preferences[CULINARY_HATED_FOOD] = get_default_hated_food()

	if(!culinary_preferences[CULINARY_HATED_DRINK])
		culinary_preferences[CULINARY_HATED_DRINK] = get_default_hated_drink()

	if(culinary_preferences[CULINARY_FAVOURITE_FOOD] == culinary_preferences[CULINARY_HATED_FOOD])
		culinary_preferences[CULINARY_HATED_FOOD] = get_default_hated_food()
	if(culinary_preferences[CULINARY_FAVOURITE_DRINK] == culinary_preferences[CULINARY_HATED_DRINK])
		culinary_preferences[CULINARY_HATED_DRINK] = get_default_hated_drink()

/datum/preferences/proc/reset_culinary_preferences()
	culinary_preferences = list()
	culinary_preferences[CULINARY_FAVOURITE_FOOD] = get_default_food()
	culinary_preferences[CULINARY_FAVOURITE_DRINK] = get_default_drink()
	culinary_preferences[CULINARY_HATED_FOOD] = get_default_hated_food()
	culinary_preferences[CULINARY_HATED_DRINK] = get_default_hated_drink()

/datum/preferences/proc/get_default_food()
	return /obj/item/reagent_containers/food/snacks/rogue/bread

/datum/preferences/proc/get_default_hated_food()
	return /obj/item/reagent_containers/food/snacks/badrecipe

/datum/preferences/proc/get_default_drink()
	return /datum/reagent/consumable/ethanol/beer

/datum/preferences/proc/get_default_hated_drink()
	return //datum/container_craft/cooking/tea/badidea

/datum/preferences/proc/handle_culinary_topic(mob/user, href_list)
	switch(href_list["preference"])
		if("choose_food")
			show_food_selection_ui(user, CULINARY_FAVOURITE_FOOD)
		if("choose_drink")
			show_drink_selection_ui(user, CULINARY_FAVOURITE_DRINK)
		if("choose_hated_food")
			show_food_selection_ui(user, CULINARY_HATED_FOOD)
		if("choose_hated_drink")
			show_drink_selection_ui(user, CULINARY_HATED_DRINK)
		if("confirm_food")
			var/food_type = text2path(href_list["food_type"])
			var/preference_type = href_list["preference_type"]
			if(ispath(food_type, /obj/item/reagent_containers/food/snacks))
				var/opposite_preference = (preference_type == CULINARY_FAVOURITE_FOOD) ? CULINARY_HATED_FOOD : CULINARY_FAVOURITE_FOOD
				if(culinary_preferences[opposite_preference] == food_type)
					to_chat(user, span_warning("You can't set the same item as both favorite and hated!"))
				else
					culinary_preferences[preference_type] = food_type
					user << browse(null, "window=food_selection")
					show_culinary_ui(user)
		if("confirm_drink")
			var/drink_type = text2path(href_list["drink_type"])
			var/preference_type = href_list["preference_type"]
			if(ispath(drink_type, /datum/reagent/consumable))
				var/opposite_preference = (preference_type == CULINARY_FAVOURITE_DRINK) ? CULINARY_HATED_DRINK : CULINARY_FAVOURITE_DRINK
				if(culinary_preferences[opposite_preference] == drink_type)
					to_chat(user, span_warning("You can't set the same drink as both favorite and hated!"))
				else
					culinary_preferences[preference_type] = drink_type
					user << browse(null, "window=drink_selection")
					show_culinary_ui(user)

/datum/preferences/proc/print_culinary_page(mob/user)
	var/list/dat = list()

	var/current_food = culinary_preferences[CULINARY_FAVOURITE_FOOD]
	var/current_drink = culinary_preferences[CULINARY_FAVOURITE_DRINK]
	var/current_hated_food = culinary_preferences[CULINARY_HATED_FOOD]
	var/current_hated_drink = culinary_preferences[CULINARY_HATED_DRINK]

	var/food_name = "None"
	var/food_icon
	if(current_food)
		var/obj/item/food_instance = current_food
		food_name = capitalize(initial(food_instance.name))
		food_icon = get_cached_food_flat_icon(current_food)

	var/drink_name = "None"
	var/drink_icon
	if(current_drink)
		var/datum/reagent/consumable/drink_instance = current_drink
		drink_name = capitalize(initial(drink_instance.name))
		var/drink_quality = initial(drink_instance.quality)
		drink_icon = get_cached_drink_flat_icon(drink_quality)

	var/hated_food_name = "None"
	var/hated_food_icon
	if(current_hated_food)
		var/obj/item/hated_food_instance = current_hated_food
		hated_food_name = capitalize(initial(hated_food_instance.name))
		hated_food_icon = get_cached_food_flat_icon(current_hated_food)

	var/hated_drink_name = "None"
	var/hated_drink_icon
	if(current_hated_drink)
		var/datum/reagent/consumable/hated_drink_instance = current_hated_drink
		hated_drink_name = capitalize(initial(hated_drink_instance.name))
		var/hated_drink_quality = initial(hated_drink_instance.quality)
		hated_drink_icon = get_cached_drink_flat_icon(hated_drink_quality)

	dat += "<style>"
	dat += ".culinary-item { display: flex; align-items: center; margin-bottom: 5px; }"
	dat += ".culinary-icon { vertical-align: middle; }"
	dat += ".culinary-text { vertical-align: middle; line-height: 32px; }"
	dat += "</style>"

	dat += "<div class='culinary-item'><b>Favourite Food:</b> <span class='culinary-icon'>[food_icon]</span> <span class='culinary-text'><a href='byond://?_src_=prefs;preference=choose_food;preference_type=[CULINARY_FAVOURITE_FOOD];task=change_culinary_preferences'>[encode_special_chars(food_name)]</a></span></div>"
	dat += "<div class='culinary-item'><b>Favourite Drink:</b> <span class='culinary-icon'>[drink_icon]</span> <span class='culinary-text'><a href='byond://?_src_=prefs;preference=choose_drink;preference_type=[CULINARY_FAVOURITE_DRINK];task=change_culinary_preferences'>[encode_special_chars(drink_name)]</a></span></div>"
	dat += "<div class='culinary-item'><b>Hated Food:</b> <span class='culinary-icon'>[hated_food_icon]</span> <span class='culinary-text'><a href='byond://?_src_=prefs;preference=choose_hated_food;preference_type=[CULINARY_HATED_FOOD];task=change_culinary_preferences'>[encode_special_chars(hated_food_name)]</a></span></div>"
	dat += "<div class='culinary-item'><b>Hated Drink:</b> <span class='culinary-icon'>[hated_drink_icon]</span> <span class='culinary-text'><a href='byond://?_src_=prefs;preference=choose_hated_drink;preference_type=[CULINARY_HATED_DRINK];task=change_culinary_preferences'>[encode_special_chars(hated_drink_name)]</a></span></div>"

	return dat

/datum/preferences/proc/show_food_selection_ui(mob/user, preference_type)
	var/list/dat = list()
	dat += "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">"
	dat += "<style>"
	dat += ".food-item { display: flex; align-items: center; margin-bottom: 5px; }"
	dat += ".food-icon { vertical-align: middle; }"
	dat += ".food-text { vertical-align: middle; line-height: 32px; }"
	dat += "</style>"

	for(var/list/food_data in GLOB.food_with_faretypes)
		var/food_type = food_data["type"]
		var/food_name = food_data["name"]
		var/food_faretype = food_data["faretype"]

		var/display_name = capitalize(food_name)
		var/food_icon = get_cached_food_flat_icon(food_type)
		dat += "<div class='food-item'><span class='food-icon'>[food_icon]</span> <span class='food-text'><a href='byond://?_src_=prefs;preference=confirm_food;food_type=[food_type];preference_type=[preference_type];task=change_culinary_preferences'>[encode_special_chars(display_name)]</a> (Quality: [food_faretype])</span></div>"

	var/title = (preference_type == CULINARY_FAVOURITE_FOOD) ? "Select Favourite Food" : "Select Hated Food"
	var/datum/browser/popup = new(user, "food_selection", "<div align='center'>[title]</div>", 400, 600)
	popup.set_content(dat.Join())
	popup.open(FALSE)

/datum/preferences/proc/show_drink_selection_ui(mob/user, preference_type)
	var/list/dat = list()
	dat += "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">"
	dat += "<style>"
	dat += ".drink-item { display: flex; align-items: center; margin-bottom: 5px; }"
	dat += ".drink-icon { vertical-align: middle; }"
	dat += ".drink-text { vertical-align: middle; line-height: 32px; }"
	dat += "</style>"

	for(var/list/drink_data in GLOB.drink_with_qualities)
		var/drink_type = drink_data["type"]
		var/drink_name = drink_data["name"]
		var/drink_quality = drink_data["quality"]

		var/display_name = capitalize(drink_name)
		var/drink_icon = get_cached_drink_flat_icon(drink_quality)
		dat += "<div class='drink-item'><span class='drink-icon'>[drink_icon]</span> <span class='drink-text'><a href='byond://?_src_=prefs;preference=confirm_drink;drink_type=[drink_type];preference_type=[preference_type];task=change_culinary_preferences'>[encode_special_chars(display_name)]</a> (Quality: [drink_quality])</span></div>"

	var/title = (preference_type == CULINARY_FAVOURITE_DRINK) ? "Select Favourite Drink" : "Select Hated Drink"
	var/datum/browser/popup = new(user, "drink_selection", "<div align='center'>[title]</div>", 400, 600)
	popup.set_content(dat.Join())
	popup.open(FALSE)

/datum/preferences/proc/show_culinary_ui(mob/user)
	var/list/dat = list()
	dat += "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">"
	dat += print_culinary_page(user)
	var/datum/browser/popup = new(user, "culinary_customization", "<div align='center'>Culinary Preferences</div>", 345, 215)
	popup.set_content(dat.Join())
	popup.open(FALSE)

/datum/preferences/proc/apply_culinary_preferences(mob/living/carbon/human/character)
	if(!culinary_preferences)
		return

	character.culinary_preferences = culinary_preferences.Copy()

/proc/encode_special_chars(text)
	. = text
	. = replacetext(., "ü", "&uuml;")
	. = replacetext(., "Ü", "&Uuml;")
	. = replacetext(., "ö", "&ouml;")
	. = replacetext(., "Ö", "&Ouml;")
	. = replacetext(., "ä", "&auml;")
	. = replacetext(., "Ä", "&Auml;")
	. = replacetext(., "ß", "&szlig;")
	return .
