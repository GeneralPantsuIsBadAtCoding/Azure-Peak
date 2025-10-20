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

/// Отображает заголовок лодаута
/datum/preferences/proc/get_loadout_header(mob/user)
	var/list/content = list()
	content.Add("<div>")
	content.Add("<span>Выберите предметы для вашего персонажа.</span>")
	content.Add("<span>Вы их сможете забрать, когда нажмете правой кнопкой мыши по статуе или дереву.</span>")

	if(check_patreon_lvl(user.ckey))
		content.Add("<span>")
		content.Add("Спасибо за поддержку проекта!")
		content.Add("</span>")
	else
		content.Add("<span>")
		content.Add("Если нужно больше слотов и уникальный вещей - поддержите проект!")
		content.Add("<br><a class='boosty' href='?_src_=prefs;boosty=1'> Boosty </a>")
		content.Add("</span>")

	content.Add("<span> [selected_loadout_items.len] / [get_loadout_size(user)]. </span>")
	content.Add("</div>")
	content.Add("<hr style='width: 100%; border: 1px solid #7b5346;'>")
	return content.Join()

/// Отображает таблицу лодаута
/datum/preferences/proc/get_loadout_items_table(mob/user)
	var/list/content = list()

	content.Add("<table>")

	content.Add("<tr>")
	content.Add("<th class='action'>Action</th>")
	content.Add("<th class='align-left'>Name</th>")
	content.Add("</tr>")

	for(var/key in GLOB.loadout_items_by_name)
		var/datum/loadout_item/item = GLOB.loadout_items_by_name[key]

		if(item.donatitem && !check_patreon_lvl(user.ckey))
			continue

		var/taken = FALSE
		for(var/selected_item in selected_loadout_items)
			if(selected_item == key)
				taken = TRUE

		content.Add("<tr>")

		if(taken)
			content.Add("<td>")
			content.Add("<a class='remove' href='?_src_=prefs;preference=loadout_items;task=remove;item=[key]'>")
			content.Add("REMOVE")
			content.Add("</a>")
			content.Add("</td>")
		else
			content.Add("<td>")
			content.Add("<a class='take' href='?_src_=prefs;preference=loadout_items;task=add;item=[key]'>")
			content.Add("TAKE")
			content.Add("</a>")
			content.Add("</td>")

		content.Add("<td class='align-left'>[key]</td>")

		content.Add("</tr>")

	content.Add("</table>")

	return content.Join()

/datum/preferences/proc/get_non_supporter_info()
	var/list/content = list()
	content.Add("<div>")
	content.Add("<h1> Беда! </h1>")
	content.Add("<span>")
	content.Add("Проект нуждается в финансовой поддержке для оплаты хостинга.")
	content.Add("<br>")
	content.Add("Вы можете поддержать его:")
	content.Add("</span>")

	// К сожалению я не осилил открытие ссылки в браузере. Надеюсь, что кто-то справится.
	// content.Add("<span>")
	// content.Add("<a class='boosty' href='?_src_=prefs;preference=open_link;link=[boosty_link]'> Boosty </a>")
	// content.Add("</span>")

	content.Add("<div class='tooltip'>")
	content.Add("<span class='boosty'> Boosty </span>")
	content.Add("<span class='tooltip-text'> Ищите ссылку на дискорд-сервере! </span>")
	content.Add("</div>")

	content.Add("</div>")
	return content.Join()

/// Возвращает содержимое окна лодаута
/datum/preferences/proc/get_loadout_window_page_content(mob/user)
	var/list/page_content = list()

	page_content.Add(get_loadout_header(user))
	page_content.Add(get_loadout_items_table(user))

	return page_content.Join()


/// Отображает окно лодаута
/datum/preferences/proc/show_loadout_window(mob/user)
	var/datum/browser/loadout_window = new(
		user,
		"Loadout",
		"<div align='center'> Loadout </div>",
		650,
		700
	)

	loadout_window.add_stylesheet("loadout_window", 'html/browser/loadout_window.css')
	loadout_window.set_content(get_loadout_window_page_content(user))
	loadout_window.open(FALSE)

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

