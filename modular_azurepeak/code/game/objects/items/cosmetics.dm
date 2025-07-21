/obj/item/azure_lipstick
	gender = PLURAL
	name = "red lipstick"
	desc = "A blend of wax, pigment, and oil meant to be applied to the lips."
	icon = 'modular_azurepeak/icons/obj/items/cosmetics.dmi'
	icon_state = "lipstick"
	w_class = WEIGHT_CLASS_TINY
	var/colour = "red"

/obj/item/azure_lipstick/purple
	name = "purple lipstick"
	colour = "purple"

/obj/item/azure_lipstick/jade
	name = "jade lipstick"
	colour = "lime"

/obj/item/azure_lipstick/black
	name = "black lipstick"
	colour = "black"

/obj/item/azure_lipstick/Initialize()
	. = ..()
	update_icon()

/obj/item/azure_lipstick/update_icon()
	cut_overlays()
	var/mutable_appearance/colored_overlay = mutable_appearance(icon, "lipstick_color")
	colored_overlay.color = colour
	add_overlay(colored_overlay)

/obj/item/azure_lipstick/attack(mob/M, mob/user)
	if(!ismob(M))
		return

	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.is_mouth_covered())
			to_chat(user, span_warning("Remove [ H == user ? "your" : "[H.p_their()]" ] mask!"))
			return
		if(H == user)
			if(H.lip_style)	//if you already have lipstick on
				to_chat(user, span_notice("I wipe off the lipstick with [src]."))
				H.lip_style = null
				H.update_body()
				return
			
			user.visible_message(span_notice("[user] does [user.p_their()] lips with \the [src]."), \
								 span_notice("I take a moment to apply \the [src]. Perfect!"))
			if(H.getorganslot(ORGAN_SLOT_SNOUT))
				H.lip_style = "lipstick_nosides"
			else
				H.lip_style = "lipstick"
			H.lip_color = colour
			H.update_body()
		else
			if(H.lip_style) // if they already have lipstick on
				user.visible_message(span_warning("[user] begins to wipe [H]'s lipstick off with \the [src]."), \
								 	 span_notice("I begin to wipe off [H]'s lipstick..."))
				if(do_after(user, 10, target = H))
					user.visible_message(span_notice("[user] wipes [H]'s lipstick off with \the [src]."), \
										 span_notice("I wipe off [H]'s lipstick."))
					H.lip_style = null
					H.update_body()
				return
			
			user.visible_message(span_warning("[user] begins to do [H]'s lips with \the [src]."), \
								 span_notice("I begin to apply \the [src] on [H]'s lips..."))
			if(do_after(user, 20, target = H))
				user.visible_message(span_notice("[user] does [H]'s lips with \the [src]."), \
									 span_notice("I apply \the [src] on [H]'s lips."))
				if(H.getorganslot(ORGAN_SLOT_SNOUT))
					H.lip_style = "lipstick_nosides"
				else
					H.lip_style = "lipstick"
				H.lip_color = colour
				H.update_body()
	else
		to_chat(user, span_warning("Where are the lips on that?"))
