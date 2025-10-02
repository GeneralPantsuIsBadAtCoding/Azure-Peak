/datum/examine_panel
	/// Mob that the examine panel belongs to.
	var/mob/living/carbon/human/holder
	/// The screen containing the appearance of the mob
	var/atom/movable/screen/map_view/examine_panel_screen/examine_panel_screen

/datum/examine_panel/New(mob/holder_mob)
	holder = holder_mob

/datum/examine_panel/Destroy(force)
	holder = null
	qdel(examine_panel_screen)
	return ..()

/datum/examine_panel/ui_state(mob/user)
	return GLOB.always_state

/datum/examine_panel/ui_close(mob/user)
	// user.client?.clear_map(examine_panel_screen.assigned_map)

/atom/movable/screen/map_view/examine_panel_screen
	name = "examine panel screen"

/datum/examine_panel/ui_interact(mob/user, datum/tgui/ui)
/*	if(!examine_panel_screen)
		examine_panel_screen = new
		examine_panel_screen.name = "screen"
		examine_panel_screen.assigned_map = "examine_panel_[REF(holder)]_map"
		examine_panel_screen.del_on_map_removal = FALSE
		examine_panel_screen.screen_loc = "[examine_panel_screen.assigned_map]:1,1"

	var/mutable_appearance/current_mob_appearance = new(holder)
	current_mob_appearance.setDir(SOUTH)
	current_mob_appearance.transform = matrix() // We reset their rotation, in case they're lying down.

	// In case they're pixel-shifted, we bring 'em back!
	current_mob_appearance.pixel_x = 0
	current_mob_appearance.pixel_y = 0

	examine_panel_screen.cut_overlays()
	examine_panel_screen.add_overlay(current_mob_appearance) */

	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ExaminePanel")
		ui.open()
	//	examine_panel_screen.display_to(user, ui.window)

/datum/examine_panel/ui_data(mob/user)

	var/flavor_text
	var/flavor_text_nsfw
	var/obscured
	var/ooc_notes = ""
	var/ooc_notes_nsfw
	var/headshot = ""
	var/list/img_gallery = list()

	// Now we handle silicon and/or human, order doesn't matter as both obviously can't fire.
	// If other variants of mob/living need to be handled at some point, put them here.

	if(ishuman(holder))
		var/mob/living/carbon/human/holder_human = holder
		obscured = (holder_human.wear_mask && (holder_human.wear_mask.flags_inv & HIDEFACE)) || (holder_human.head && (holder_human.head.flags_inv & HIDEFACE))
		flavor_text = obscured ? "Obscured" : holder.flavortext
		flavor_text_nsfw = obscured ? "Obscured" : holder.nsfwflavortext
		ooc_notes += holder.ooc_notes
		ooc_notes_nsfw += holder.erpprefs
		if(!obscured)
			headshot += holder.headshot_link
			img_gallery = holder.img_gallery

		ooc_notes = html_encode(ooc_notes)
		ooc_notes = replacetext(parsemarkdown_basic(ooc_notes), "\n", "<br>")
		ooc_notes_nsfw = html_encode(ooc_notes_nsfw)
		ooc_notes_nsfw = replacetext(parsemarkdown_basic(ooc_notes_nsfw), "\n", "<br>")
		flavor_text = html_encode(flavor_text)
		flavor_text = replacetext(parsemarkdown_basic(flavor_text), "\n", "<br>")
		flavor_text_nsfw = html_encode(flavor_text_nsfw)
		flavor_text_nsfw = replacetext(parsemarkdown_basic(flavor_text_nsfw), "\n", "<br>")

	var/list/data = list(
		// Identity
		"character_name" = obscured ? "Unknown" : holder.name,
		"headshot" = headshot,
		"obscured" = obscured ? TRUE : FALSE,
		// Descriptions
		"flavor_text" = flavor_text,
		"ooc_notes" = ooc_notes,
		// Descriptions, but requiring manual input to see
		"flavor_text_nsfw" = flavor_text_nsfw,
		"ooc_notes_nsfw" = ooc_notes_nsfw,
		"img_gallery" = img_gallery,
	)
	return data


