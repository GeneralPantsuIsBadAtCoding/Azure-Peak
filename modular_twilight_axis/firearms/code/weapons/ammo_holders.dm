/obj/item/quiver/twilight_bullet
	name = "ammo bag"
	desc = "Небольшой мешочек, в котором можно хранить пули для огнестрельного оружия."
	icon = 'modular_twilight_axis/firearms/icons/ammo.dmi'
	icon_state = "pouch1"
	item_state = "pouch1"
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_NECK
	max_storage = 30
	var/ammo_type = /obj/item/ammo_casing/caseless/twilight_lead

/obj/item/quiver/twilight_bullet/update_icon()
	if(arrows.len)
		icon_state = "pouch1"
	else
		icon_state = "pouch0"

/obj/item/quiver/twilight_bullet/attack_turf(turf/T, mob/living/user)
	if(arrows.len >= max_storage)
		to_chat(user, span_warning("My [src.name] is full!"))
		return
	to_chat(user, span_notice("I begin to gather the ammunition..."))
	for(var/obj/item/ammo_casing/caseless/twilight_lead/arrow in T.contents)
		if(do_after(user, 5))
			if(!eatarrow(arrow))
				break

/obj/item/quiver/twilight_bullet/eatarrow(obj/A)
	if(A.type in typesof(ammo_type))
		if(arrows.len < max_storage)
			A.forceMove(src)
			arrows += A
			update_icon()
			return TRUE
		else
			return FALSE

/obj/item/quiver/twilight_bullet/attack_self(mob/living/user)
	..()

	if (!arrows.len)
		return
	to_chat(user, span_warning("I begin to take out the ammo from [src], one by one..."))
	for(var/obj/item/ammo_casing/caseless/arrow in arrows)
		if(!do_after(user, 0.5 SECONDS))
			return
		arrow.forceMove(user.loc)
		arrows -= arrow

	update_icon()

/obj/item/quiver/twilight_bullet/attackby(obj/A, loc, params)
	if(A.type in typesof(ammo_type))
		if(arrows.len < max_storage)
			if(ismob(loc))
				var/mob/M = loc
				M.doUnEquip(A, TRUE, src, TRUE, silent = TRUE)
			else
				A.forceMove(src)
			arrows += A
			update_icon()
		else
			to_chat(loc, span_warning("Full!"))
		return
	if(istype(A, /obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock))
		var/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/B = A
		if(arrows.len && !B.chambered && B.cocked)
			for(var/AR in arrows)
				if(istype(AR, /obj/item/ammo_casing/caseless/twilight_lead/runelock))
					arrows -= AR
					B.attackby(AR, loc, params)
					break
		return
	..()

/obj/item/quiver/twilight_bullet/runed/Initialize()
	. = ..()
	for(var/i in 1 to 6)
		var/obj/item/ammo_casing/caseless/twilight_lead/runelock/R = new()
		arrows += R
	update_icon()

/obj/item/quiver/twilight_bullet/blessed/Initialize()
	. = ..()
	for(var/i in 1 to 4)
		var/obj/item/ammo_casing/caseless/twilight_lead/runelock/blessed/R = new()
		arrows += R
	update_icon()

/obj/item/quiver/twilight_bullet/lead/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/ammo_casing/caseless/twilight_lead/B = new()
		arrows += B
	update_icon()

/obj/item/quiver/twilight_bullet/lead_ten/Initialize()
	. = ..()
	for(var/i in 1 to 10)
		var/obj/item/ammo_casing/caseless/twilight_lead/B = new()
		arrows += B
	update_icon()

/obj/item/quiver/twilight_bullet/silver/Initialize()
	. = ..()
	for(var/i in 1 to 10)
		var/obj/item/ammo_casing/caseless/twilight_lead/silver/B = new()
		arrows += B
	update_icon()

/obj/item/quiver/twilight_bullet/cannonball
	name = "cannonball bag"
	desc = "Небольшой мешочек, в котором можно хранить выстрелы для кулеврины."
	max_storage = 20
	ammo_type = /obj/item/ammo_casing/caseless/twilight_cannonball

/obj/item/quiver/twilight_bullet/cannonball/attack_turf(turf/T, mob/living/user)
	if(arrows.len >= max_storage)
		to_chat(user, span_warning("My [src.name] is full!"))
		return
	to_chat(user, span_notice("I begin to gather the ammunition..."))
	for(var/obj/item/ammo_casing/caseless/twilight_cannonball/arrow in T.contents)
		if(do_after(user, 5))
			if(!eatarrow(arrow))
				break

/obj/item/quiver/twilight_bullet/cannonball/lead/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/ammo_casing/caseless/twilight_cannonball/B = new()
		arrows += B
	update_icon()

/obj/item/quiver/twilight_bullet/cannonball/grapeshot/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/ammo_casing/caseless/twilight_cannonball/grapeshot/B = new()
		arrows += B
	update_icon()

/obj/item/quiver/twilight_bullet/cannonball/otavian_grapeshot/Initialize()
	. = ..()
	for(var/i in 1 to 10)
		var/obj/item/ammo_casing/caseless/twilight_cannonball/grapeshot/otavian/B = new()
		arrows += B
	update_icon()
