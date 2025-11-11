/datum/preferences
	var/current_loadout_category = "Всё"

// Обрабатывает вещи в списке лодаута игрока и удаляет те, название которых было изменено или они были удалены.
// Иначе лодаут будет ломаться. Мб это как то адекватнее можно починить, но я хз.
/datum/preferences/proc/clean_loadout(mob/user)
	var/list/valid_items = list()
	var/has_invalid_items = FALSE

	for(var/item_name in selected_loadout_items)
		if(GLOB.loadout_items_by_name[item_name])
			valid_items.Add(item_name)
		else
			has_invalid_items = TRUE

	if(has_invalid_items)
		selected_loadout_items = valid_items
		to_chat(user, "Твой лодаут был очищен из-за изменений в предметах.")

/// Обрабатывает размер лодаута и сбрасывает его, если превышает лимит
/datum/preferences/proc/handle_loadout_size(mob/user)
	if(selected_loadout_items.len <= get_loadout_size(user))
		return
	selected_loadout_items = list()
	to_chat(user, "Размер твоего лодаута был изменён и его пришлось сбросить!")

/// Возвращает размер лодаута для указанного ника игрока
/datum/preferences/proc/get_loadout_size(mob/user)

	var/loadout_size = 2
	var/modifiers = 0
	if(check_patreon_lvl(user.ckey))
		modifiers = 4

	return modifiers ? max(loadout_size + modifiers, 1) : loadout_size

/// Добавляет предмет лодаута
/datum/preferences/proc/add_loadout_item(item_name)
	selected_loadout_items.Add(item_name)

/// Убирает предмет лодаута
/datum/preferences/proc/remove_loadout_item(item_name)
	selected_loadout_items.RemoveAll(item_name)

//

/client/verb/boosty()
	set name = "boosty"
	set desc = ""
	set category = "OOC"
	var/boostyurl = CONFIG_GET(string/boostyurl)
	if(boostyurl)
		if(alert("This will open the boosty in your browser. Are you sure?",,"Yes","No")!="Yes")
			return
		src << link(boostyurl)
	else
		to_chat(src, span_danger("The forum URL is not set in the server configuration."))
	return

/datum/config_entry/string/boostyurl
	config_entry_value = ""


/datum/loadout_panel
	/// Mob that the examine panel belongs to.
	var/mob/living/carbon/human/holder
	

/datum/loadout_panel/New(mob/holder_mob)
	if(holder_mob)
		holder = holder_mob

/datum/loadout_panel/ui_state(mob/user)
	return GLOB.always_state

/datum/loadout_panel/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "LoadoutPanel")
		ui.open()

/datum/loadout_panel/ui_data(mob/user)
	var/list/data = list()
	var/list/categories = list()
	var/datum/preferences/user_prefs = user.client.prefs
	var/list/selected_loadout_items = user_prefs.selected_loadout_items

	for(var/cat_name in GLOB.loadout_items_by_category)
		var/list/items_in_cat = GLOB.loadout_items_by_category[cat_name]
		if(!categories[cat_name])
			categories[cat_name] = list()
		for(var/datum/loadout_item/item in items_in_cat)
			if(!item.ckeywhitelist || item.donator_ckey_check(user.ckey))
				var/icon = item.path::icon
				var/icon_state = item.path::icon_state
				var/selected = FALSE

				if(ispath(item.path, /obj/item/enchantingkit))
					var/obj/item/enchantingkit/kit_typepath = item.path
					var/obj/result_item = kit_typepath.result_item
					icon = result_item::icon
					icon_state = result_item::icon_state
				
				if(item.name in selected_loadout_items)
					selected = TRUE

				categories[cat_name][item.name] += list(
					name = item.name,
					path = item.path,
					icon = icon,
					icon_state = icon_state,
					isDonatorItem = item.donatitem,
					isSelected = selected
				)
	data["categories"] = categories
	data["isDonator"] = check_patreon_lvl(user.ckey)
	data["curLoadoutSlots"] = selected_loadout_items.len
	data["maxLoadoutSlots"] = user_prefs.get_loadout_size(user)

	return data

/datum/loadout_panel/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()

	var/mob/user = ui.user
	var/datum/preferences/user_prefs = user.client.prefs

	switch(action)
		if("add")
			if(user_prefs.selected_loadout_items.len >= user_prefs.get_loadout_size(user))
				to_chat(user, "Лимит исчерпан!")
				return TRUE
			user_prefs.add_loadout_item(params["item"])
			return TRUE

		if("remove")
			user_prefs.remove_loadout_item(params["item"])
			return TRUE

		if("clear")
			user_prefs.selected_loadout_items = list()
			to_chat(user, "Лодаут очищен!")
			return TRUE

		if("boosty")
			user << link(CONFIG_GET(string/boostyurl))
			return TRUE


/datum/loadout_panel/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/spritesheet/loadout_icons)
	)
