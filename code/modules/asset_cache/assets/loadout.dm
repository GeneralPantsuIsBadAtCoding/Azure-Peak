/datum/asset/spritesheet/loadout_icons
	name = "loadout_icons"

/datum/asset/spritesheet/loadout_icons/create_spritesheets()
	for(var/key in GLOB.loadout_items_by_name)
		var/datum/loadout_item/item = GLOB.loadout_items_by_name[key]
		var/atom/movable/typepath = item.path
		if(ispath(typepath, /obj/item/enchantingkit/bat))
			var/obj/item/enchantingkit/kit_typepath = typepath
			typepath = kit_typepath.result_item
		var/icon = typepath::icon
		var/icon_state = typepath::icon_state

		

		if(!icon || !icon_state)
			continue

		Insert("[sanitize_css_class_name("loadout_[REF(item)]")]", icon, icon_state)
