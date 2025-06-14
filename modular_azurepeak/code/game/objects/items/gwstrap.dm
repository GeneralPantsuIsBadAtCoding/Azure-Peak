/obj/item/gwstrap
	name = "greatweapon strap"
	desc = ""
	icon_state = "gws0"
	item_state = "gwstrap"
	icon = 'modular_azurepeak/icons/obj/items/gwstrap.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	equip_delay_self = 5 SECONDS
	unequip_delay_self = 5 SECONDS
	resistance_flags = NONE
	max_integrity = 0
	sellprice = 15
	experimental_onback = FALSE
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	equip_sound = 'sound/blank.ogg'
	bloody_icon_state = "bodyblood"
	strip_delay = 20
	var/atom/movable/weps = null
	sewrepair = TRUE

/obj/item/gwstrap/attackby(obj/item/A, mob/living/carbon/user, params)
	if(istype(A, /obj/item/rogueweapon) && A.w_class >= WEIGHT_CLASS_BULKY)
		if(weps == null)
			for(var/obj/item/gwstrap/I in user.get_equipped_items(TRUE))
				to_chat(loc, span_warning("I work the latches of my strap to holster [A]."))
				if(do_after(user, 50, target = user))
					user.transferItemToLoc(A, weps)
					weps = A
					update_icon()
					getonmobprop("onback")
					LAZYSET(I.onprop, "onback", getonmobprop("onback"))
					user.update_inv_back()
					name = "greatweapon strap ([A.name])"
		else
			to_chat(loc, span_warning("The holster already holds a weapon!"))
		return
	. = ..()

/obj/item/gwstrap/attack_right(mob/user)
	if(weps != null)
		if(!user.get_active_held_item())
			to_chat(loc, span_warning("I work the latches of my strap to unholster [weps]."))
			if(do_after(user, 50, target = user))
				user.put_in_active_hand(weps, user.active_hand_index)
				name = "greatweapon strap"
				weps = null
				update_icon()
				user.update_inv_back()
				return TRUE

/obj/item/gwstrap/update_icon()
	if(weps != null)
		worn_x_dimension = 64
		worn_y_dimension = 64
		icon = weps.icon
		icon_state = weps.icon_state
		experimental_onback = TRUE
		
	else
		icon = initial(icon)
		icon_state = initial(icon_state)
		worn_x_dimension = initial(worn_x_dimension)
		worn_y_dimension = initial(worn_y_dimension)
		experimental_onback = FALSE

/obj/item/gwstrap/examine(mob/user)
	. = ..()
	if(weps != null)
		. += span_notice("A [weps] is attached the holster.")

/obj/item/gwstrap/getonmobprop(tag)
	. = ..()
	if(weps != null)
		if(istype(weps, /obj/item/rogueweapon/estoc) || istype(weps, /obj/item/rogueweapon/greatsword))
			if(tag)
				switch(tag)
					if("onback")
						return list("shrink" = 0.6,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
		else
			if(tag)
				switch(tag)
					if("onback")
						return list("shrink" = 0.7,"sx" = 1,"sy" = -1,"nx" = 1,"ny" = -1,"wx" = 4,"wy" = -1,"ex" = -1,"ey" = -1,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)

/obj/item/gwstrap/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_DROPPED, PROC_REF(on_drop))
	RegisterSignal(src, COMSIG_ITEM_PICKUP, PROC_REF(on_drop))

/obj/item/gwstrap/proc/on_drop(datum/source, mob/user)
	if(weps != null)
		name = "greatweapon strap"
		var/atom/movable/I = weps
		weps = null
		update_icon()
		user.dropItemToGround(I)
		user.dropItemToGround(src)
