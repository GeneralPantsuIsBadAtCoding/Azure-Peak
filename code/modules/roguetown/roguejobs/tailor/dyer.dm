var/global/list/colorlist = list(
	"Swan White"="#ffffff",
	"Chalk White" = "#f4ecde",
	"Cream" = "#fffdd0",
	"Light Grey" = "#999999",
	"Dunked in Water" = "#bbbbbb",
	"Mage Grey" = "#6c6c6c",
	"Sow's skin"="#CE929F",
	"Knight's Red"="#933030",
	"Royal Red"="#8b2323",
	"Red Ochre" = "#913831",
	"Maroon" = "#550000",
	"Mage Red" = "#b8252c",
	"Royal Orange" = "#df8405",
	"Madroot Red"="#AD4545",
	"Marigold Orange"="#E2A844",
	"Chestnut" = "#613613",
	"Dirt" = "#7c6d5c",
	"Peasant Brown" = "#685542",
	"Russet" = "#7f461b",
	"Yellow Weld" = "#f4c430",
	"Yarrow" = "#f0cb76",
	"Yellow Ochre" = "#cb9d06",
	"Mage Yellow" = "#c1b144",
	"Astrata's Yellow"="#FFFD8D",
	"Olive" = "#98bf64",
	"Royal Green" = "#264d26",
	"Forest Green" = "#428138",
	"Mage Green" = "#759259",
	"Bog Green"="#375B48",
	"Seafoam Green"="#49938B",
	"Royal Teal" = "#249589",
	"Cornflower Blue"="#749EE8",
	"Royal Blue" = "#173266",
	"Woad Blue"="#395480",
	"Mage Blue" = "#4756d8",
	"Periwinkle Blue" = "#8f99fb",
	"Lavender"="#865c9c",
	"Royal Purple"="#5E4687",
	"Orchil" = "#66023C",
	"Wine Rouge"="#752B55",
	"Royal Magenta" = "#962e5c",
	"Blacksteel Grey"="#404040",
	"Dark Grey" = "#505050",
	"Darkest Night" = "#414143"
	)


// DYE BIN

/obj/machinery/gear_painter
	name = "Dye Station"
	desc = "A station to give your apparel a fresh new color! Recommended to use with white items for best results."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "dyestation"
	density = TRUE
	anchored = TRUE
	var/atom/movable/inserted
	var/activecolor = "#FFFFFF"
	var/activecolor_detail = "#FFFFFF"
	var/activecolor_altdetail = "#FFFFFF"
	var/list/allowed_types = list(
			/obj/item/clothing,
			/obj/item/storage,
			/obj/item/bedroll,
			/obj/item/flowercrown
			)
	var/list/used_colors

/obj/machinery/gear_painter/Initialize()
	..()
	used_colors = colorlist

/obj/machinery/gear_painter/Destroy()
	if(inserted)
		inserted.forceMove(drop_location())
	return ..()

/obj/machinery/gear_painter/attackby(obj/item/I, mob/living/user)
	if(istype(I, /obj/item/book/rogue/swatchbook))
		var/obj/item/book/rogue/swatchbook/S = I
		if(!S.open)
			to_chat(user, span_info("The swatchbook expressly forbids the use of its cover color!"))
			return ..()
		if(S.swatchbookcolor == "#000000")
			to_chat(user, span_info("You haven't picked out a color!"))
			return ..()
		else
			to_chat(user, span_info("You mix the swatch's color in the dye bin."))
			activecolor = "[S.swatchbookcolor]"
			activecolor_detail = "[S.swatchbookcolor]"
			activecolor_altdetail = "[S.swatchbookcolor]"
			ui_interact(user)
			return ..()
	if(inserted)
		to_chat(user, span_warning("Something is already inside!"))
		return ..()
	if(!is_type_in_list(I, allowed_types))
		to_chat(user, span_warning("[I] cannot be dyed!"))
		return ..()
	if(!user.transferItemToLoc(I, src))
		to_chat(user, span_warning("[I] is stuck to your hand!"))
		return ..()

	user.visible_message(span_notice("[user] inserts [I] into [src]'s receptable."))

	inserted = I
	ui_interact(user)

/obj/machinery/gear_painter/AllowDrop()
	return FALSE

/obj/machinery/gear_painter/attack_hand(mob/living/user)
	ui_interact(user)

/obj/machinery/gear_painter/ui_interact(mob/user)
	if(!is_operational())
		return ..()
	user.set_machine(src)
	var/datum/browser/menu = new(user, "colormate","Dye Station", 400, 400, src)
	var/list/dat = list("<TITLE>Dye Bin</TITLE><BR>")
	if(!inserted)
		dat += "No item inserted."
		menu.set_content(dat.Join(""))
		menu.open()
		return

	var/obj/item/inserted_item = inserted

	dat += "Item inserted: [inserted]<HR>"
	dat += "<A href='?src=\ref[src];select=1'>Select new color.</A><BR>"
	dat += "Color: <font color='[activecolor]'>&#9899;</font>"
	dat += "<A href='?src=\ref[src];paint=1'>Apply new color</A> | "
	dat += "<A href='?src=\ref[src];clear=1'>Remove paintjob</A><BR><BR>"

	if(inserted_item.detail_color)
		dat += "<A href='?src=\ref[src];select_detail=1'>Select new detail color.</A><BR>"
		dat += "Detail Color: <font color='[activecolor_detail]'>&#9899;</font>"
		dat += "<A href='?src=\ref[src];paint_detail=1'>Apply new color</A> | "
		dat += "<A href='?src=\ref[src];clear_detail=1'>Remove paintjob</A><BR><BR>"

	if(inserted_item.altdetail_color)
		dat += "<A href='?src=\ref[src];select_altdetail=1'>Select new tertiary color.</A><BR>"
		dat += "Alt. Detail Color: <font color='[activecolor_altdetail]'>&#9899;</font>"
		dat += "<A href='?src=\ref[src];paint_altdetail=1'>Apply new color</A> | "
		dat += "<A href='?src=\ref[src];clear_altdetail=1'>Remove paintjob</A><BR><BR>"

	dat += "<A href='?src=\ref[src];eject=1'>Eject item.</A><BR><BR>"
	menu.set_content(dat.Join(""))
	menu.open()

/obj/machinery/gear_painter/Topic(href, href_list)
	if(!(. = ..()))
		return

	add_fingerprint(usr)

	if(href_list["close"])
		usr << browse(null, "window=colormate")
		return

	if(href_list["select"])
		if(HAS_TRAIT(usr, TRAIT_DYES))
			var/choice
			if(alert(usr, "Input Choice", "Primary Dye", "Color Wheel", "Color Preset") != "Color Wheel")
				choice = input(usr, "Choose your dye:", "Dyes", null) as null|anything in used_colors
				if(!choice)
					return
				activecolor = used_colors[choice]
			else
				activecolor = sanitize_hexcolor(color_pick_sanitized_lumi(usr, "Choose your dye:", "Dyes", choice ? choice : activecolor_detail, 0.2, 0.8), 6, TRUE)
				if(activecolor == "#000000")
					activecolor = "#FFFFFF"
			updateUsrDialog()
		else
			var/choice = input(usr,"Choose your dye:","Dyes",null) as null|anything in colorlist
			if(!choice)
				return
			activecolor = colorlist[choice]
			updateUsrDialog()

	if(href_list["select_detail"])
		if(HAS_TRAIT(usr, TRAIT_DYES))
			var/choice
			if(alert(usr, "Input Choice", "Primary Dye", "Color Wheel", "Color Preset") != "Color Wheel")
				choice = input(usr, "Choose your dye:", "Dyes", null) as null|anything in used_colors
				if(!choice)
					return
				activecolor = used_colors[choice]
			else
				activecolor = sanitize_hexcolor(color_pick_sanitized_lumi(usr, "Choose your dye:", "Dyes", choice ? choice : activecolor_detail, 0.2, 0.8), 6, TRUE)
				if(activecolor == "#000000")
					activecolor = "#FFFFFF"
			updateUsrDialog()
		else
			var/choice = input(usr,"Choose your dye:","Dyes",null) as null|anything in colorlist
			if(!choice)
				return
			activecolor = colorlist[choice]
			updateUsrDialog()

	if(href_list["select_altdetail"])
		if(HAS_TRAIT(usr, TRAIT_DYES))
			var/choice
			if(alert(usr, "Input Choice", "Primary Dye", "Color Wheel", "Color Preset") != "Color Wheel")
				choice = input(usr, "Choose your dye:", "Dyes", null) as null|anything in used_colors
				if(!choice)
					return
				activecolor = used_colors[choice]
			else
				activecolor = sanitize_hexcolor(color_pick_sanitized_lumi(usr, "Choose your dye:", "Dyes", choice ? choice : activecolor_detail, 0.2, 0.8), 6, TRUE)
				if(activecolor == "#000000")
					activecolor = "#FFFFFF"
			updateUsrDialog()
		else
			var/choice = input(usr,"Choose your dye:","Dyes",null) as null|anything in colorlist
			if(!choice)
				return
			activecolor = colorlist[choice]
			updateUsrDialog()

	if(href_list["paint"])
		if(!inserted)
			return
		inserted.add_atom_colour(activecolor, FIXED_COLOUR_PRIORITY)
		playsound(src, "bubbles", 50, 1)
		updateUsrDialog()

	if(href_list["paint_detail"])
		if(!inserted)
			return
		var/obj/item/inserted_item = inserted
		inserted_item.detail_color = activecolor_detail
		inserted_item.update_icon()
		if(inserted_item in GLOB.lordcolor) //Prevent a latejoining duke from changing this color
			GLOB.lordcolor -= inserted_item
		playsound(src, "bubbles", 50, 1)
		updateUsrDialog()

	if(href_list["paint_altdetail"])
		if(!inserted)
			return
		var/obj/item/inserted_item = inserted
		inserted_item.altdetail_color = activecolor_altdetail
		inserted_item.update_icon()
		if(inserted_item in GLOB.lordcolor)
			GLOB.lordcolor -= inserted_item
		playsound(src, "bubbles", 50, 1)
		updateUsrDialog()

	if(href_list["clear"])
		if(!inserted)
			return
		inserted.remove_atom_colour(FIXED_COLOUR_PRIORITY)
		playsound(src, "bubbles", 50, 1)
		updateUsrDialog()

	if(href_list["clear_detail"])
		if(!inserted)
			return
		var/obj/item/inserted_item = inserted
		inserted_item.detail_color = "#FFFFFF" //We don't initial() this in case it goes null
		inserted_item.update_icon()
		playsound(src, "bubbles", 50, 1)
		updateUsrDialog()

	if(href_list["clear_altdetail"])
		if(!inserted)
			return
		var/obj/item/inserted_item = inserted
		inserted_item.altdetail_color = "#FFFFFF"
		inserted_item.update_icon()
		playsound(src, "bubbles", 50, 1)
		updateUsrDialog()

	if(href_list["eject"])
		if(!inserted)
			return
		inserted.forceMove(drop_location())
		inserted = null
		updateUsrDialog()


// PAINTBRUSH

/obj/item/dye_brush
	icon = 'icons/roguetown/items/misc.dmi'
	name = "dye brush"
	desc = "A sizeable brush made of the finest mane-hairs. Thick dye adheres to it well."
	icon_state = "dbrush"
	w_class = WEIGHT_CLASS_SMALL
	dropshrink = 0.8
	grid_width = 32
	grid_height = 32

	var/dye = null

/obj/item/dye_brush/update_icon()
	if(dye)
		var/mutable_appearance/M = mutable_appearance('icons/roguetown/items/misc.dmi', "dbrush_colour")
		M.color = dye
		M.alpha = 150
		add_overlay(M)
	else
		cut_overlays()

/obj/item/dye_brush/examine(mob/user)
	. = ..()

	if(dye)
		. += span_notice("It is currently lathering <font color=[dye]>paint</font>.")
	else
		. += span_notice("Use in active hand to pick a paint.")

/obj/item/dye_brush/attack_self(mob/user)
	..()

	var/hexdye
	if(!dye)
		hexdye = sanitize_hexcolor(color_pick_sanitized_lumi(usr, "Choose your dye:", "Dyes", null, 0.08, 0.09), 6, TRUE)
		if (hexdye == "#000000")
			return
		dye = hexdye
		update_icon()
		return
	to_chat(user, span_warning("[src] is already carrying <font color=[dye]>dye</font>. I need to wash it."))

/obj/item/dye_brush/attack_turf(turf/T, mob/living/user)
	if(!iswallturf(T))
		return
	if(!dye)
		to_chat(user, span_warning("[src] has no dye!"))
		return
	if(T.color)
		to_chat(user, span_warning("[T] is already painted by a <font color=[T.color]>dye</font>!"))
		return

	if(!do_after(user, 6 SECONDS, TRUE, T))
		return
	user.visible_message(span_notice("[user] finishes <font color=[dye]>painting</font> [T]."), \
		span_notice("I finish <font color=[dye]>painting</font> [T].")
	)
	playsound(loc,"sound/foley/scrubbing[pick(1,2)].ogg", 60, TRUE)
	T.color = dye

	..()

/obj/item/dye_brush/attack_obj(obj/O, mob/living/user)
	if(!isstructure(O))
		return
	if(!dye)
		to_chat(user, span_warning("[src] has no dye!"))
		return
	if(O.color)
		to_chat(user, span_warning("[O] is already painted by a <font color=[O.color]>dye</font>!"))
		return

	if(!do_after(user, 3 SECONDS, TRUE, O))
		return
	user.visible_message(span_notice("[user] finishes <font color=[dye]>painting</font> [O]."), \
		span_notice("I finish <font color=[dye]>painting</font> [O].")
	)
	playsound(loc,"sound/foley/scrubbing[pick(1,2)].ogg", 60, TRUE)
	O.color = dye

	..()

/obj/item/dye_brush/wash_act(clean)
	if(!dye)
		return
	dye = null
	update_icon()

