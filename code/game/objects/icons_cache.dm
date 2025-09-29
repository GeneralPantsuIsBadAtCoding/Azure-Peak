// Pre-creates mutable appearances for icons during init and avoids rsc access during gameplay

// Global cache
GLOBAL_LIST_EMPTY(pregenerated_icon_cache)

SUBSYSTEM_DEF(iconcache)
	name = "Icon Cache"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_ICONCACHE

/datum/controller/subsystem/iconcache/Initialize()
	. = ..()
	message_admins("Icon Cache subsystem initialized")

/obj/item
	var/list/cached_appearances

/obj/item/proc/cache_key(tag, behind = FALSE, mirrored = FALSE, blood = FALSE, extra_index = "")
	return "[type]_[icon_state][extra_index][blood ? "_b" : ""]_[tag]_[behind ? "behind" : "front"]_[mirrored ? "mirrored" : "normal"]"

/obj/item/proc/pregenerate_all_appearances()
	cached_appearances = list()

	var/list/tags_to_generate = list()

	if(experimental_inhand)
		tags_to_generate += "gen"
		if(gripped_intents)
			tags_to_generate += "wielded"

	if(experimental_onhip && (slot_flags & ITEM_SLOT_BELT))
		tags_to_generate += "onbelt"
	if(experimental_onback && (slot_flags & ITEM_SLOT_BACK))
		tags_to_generate += "onback"

	if(!experimental_inhand && (slot_flags & (ITEM_SLOT_HANDS | ITEM_SLOT_BELT | ITEM_SLOT_BACK)))
		tags_to_generate += "gen"

	for(var/tag in tags_to_generate)
		var/list/prop = getonmobprop(tag)
		if(!prop)
			continue

		for(var/behind in list(FALSE, TRUE))
			for(var/mirrored in list(FALSE, TRUE))
				for(var/blood in list(FALSE, TRUE))
					var/cache_key = cache_key(tag, behind, mirrored, blood)
					if(!cached_appearances[cache_key])
						cached_appearances[cache_key] = generate_mutable_appearance(tag, prop, behind, mirrored, blood)

/obj/item/proc/generate_mutable_appearance(tag, prop, behind = FALSE, mirrored = FALSE, blood = FALSE)
	var/used_index = icon_state
	var/extra_index = get_extra_onmob_index()
	if(extra_index)
		used_index += extra_index
	if(blood)
		used_index += "_b"

	var/icon/generated_icon = generateonmob(tag, prop, behind, mirrored, used_index)
	if(!generated_icon)
		return null

	return mutable_appearance(generated_icon)

/obj/item/proc/generateonmob(tag, prop, behind = FALSE, mirrored = FALSE, used_index = null)
	if(!used_index)
		used_index = icon_state

	var/list/used_prop = prop
	var/UH = 64
	var/UW = 64
	var/used_mask = 'icons/roguetown/helpers/inhand_64.dmi'
	var/icon/returned = icon(used_mask, "blank")
	var/icon/blended
	var/skipoverlays = FALSE

	if(behind)
		if(isnull(has_behind_state))
			has_behind_state = check_state_in_icon(icon, "[used_index]_behind")
		if(has_behind_state)
			blended = icon("icon"=icon, "icon_state"="[used_index]_behind")
			skipoverlays = TRUE
		else
			blended = icon("icon"=icon, "icon_state"=used_index)
	else
		blended = icon("icon"=icon, "icon_state"=used_index)

	if(!blended)
		blended = getFlatIcon(src)

	if(!blended)
		return null

	if(!skipoverlays)
		for(var/V in overlays)
			var/image/IM = V
			var/icon/image_overlay = new(IM.icon, IM.icon_state)
			if(IM.color)
				image_overlay.Blend(IM.color, ICON_MULTIPLY)
			blended.Blend(image_overlay, ICON_OVERLAY)

	var/icon/holder
	if(blended.Height() == 32)
		UW = 32
		UH = 32
		used_mask = 'icons/roguetown/helpers/inhand.dmi'

	var/list/directions = list(
		list("north", "n", "northabove", WEST),
		list("south", "s", "southabove", EAST),
		list("east", "e", "eastabove", EAST),
		list("west", "w", "westabove", EAST)
	)

	for(var/list/dir_data in directions)
		var/direction = dir_data[1]
		var/tag_prefix = dir_data[2]
		var/above_key = dir_data[3]
		var/mirror_flip = dir_data[4]

		// Handle east/west mirroring logic
		var/actual_above_key = above_key
		var/actual_tag_prefix = tag_prefix
		if(direction == "east" && mirrored)
			actual_above_key = "westabove"
			actual_tag_prefix = "w"
		else if(direction == "west" && mirrored)
			actual_above_key = "eastabove"
			actual_tag_prefix = "e"

		// Check if we should render this direction
		var/render_this_dir = FALSE
		if(!behind)
			if(used_prop[actual_above_key] == 1)
				render_this_dir = TRUE
		else
			if(used_prop[actual_above_key] == 0)
				render_this_dir = TRUE

		if(!render_this_dir)
			continue

		// Create and process the icon for this direction
		holder = icon(blended)
		var/icon/masky = icon("icon"=used_mask, "icon_state"=direction)
		holder.Blend(masky, ICON_MULTIPLY)

		// Apply transforms
		if("[actual_tag_prefix]flip" in used_prop)
			holder.Flip(used_prop["[actual_tag_prefix]flip"])
		if("[actual_tag_prefix]turn" in used_prop)
			holder.Turn(used_prop["[actual_tag_prefix]turn"])

		// Calculate px position
		var/px = 0
		var/py = 0
		if("[actual_tag_prefix]x" in used_prop)
			px = used_prop["[actual_tag_prefix]x"]
			if(mirrored)
				if(direction == "north" || direction == "south")
					px *= -1
					var/biggu = (UH > 32)
					if(mirror_fix(used_prop["shrink"], biggu))
						px += mirror_fix(used_prop["shrink"], biggu)
				else
					px *= -1
		if("[actual_tag_prefix]y" in used_prop)
			py = used_prop["[actual_tag_prefix]y"]

		// Apply more transforms ffs
		var/ax = 0
		if("shrink" in used_prop)
			holder.Scale(UW*used_prop["shrink"], UH*used_prop["shrink"])
			ax = 32-(holder.Width()/2)
		px += ax
		py += ax

		// Apply mirroring flip
		if(mirrored)
			holder.Flip(mirror_flip)

		returned.Blend(holder, ICON_OVERLAY, x=px, y=py) // All icon blending is done during init

	return returned

/obj/item/proc/get_cached_appearance(tag, prop, behind = FALSE, mirrored = FALSE)
	// Initialize cache if needed
	if(!cached_appearances)
		cached_appearances = list()

	var/blood = HAS_BLOOD_DNA(src)
	var/cache_key = cache_key(tag, behind, mirrored, blood)

	var/mutable_appearance/cached = cached_appearances[cache_key]
	if(!cached)
		// Get properties on demand if not provided for some reason
		if(!prop)
			prop = getonmobprop(tag)

		if(prop)
			cached = generate_mutable_appearance(tag, prop, behind, mirrored, blood)
			if(cached)
				cached_appearances[cache_key] = cached

	return cached
