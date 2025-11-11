/obj/item/clothing/head/roguetown/helmet/heavy/knight/armet/grenzelhoft
	name = "armet with Grenzelhoft hat"
	desc = "Holy lamb, sacrificial hero, blessed idiot - Psydon endures. Will you endure alongside Him, as a knight of humenity, or crumble before temptation? This helmet with a Grenzelhoft hat"
	icon = 'modular_twilight_axis/icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'modular_twilight_axis/icons/roguetown/clothing/onmob/head.dmi'
	icon_state = "armetgrenzelhoft"

/obj/item/clothing/head/roguetown/helmet/heavy/knight/raneshi_hmamluk
	name = "masked mamluk helmet"
	desc = "Helmet of a heavy rider from Empire with a face-shaped visor."
	icon = 'modular_twilight_axis/icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'modular_twilight_axis/icons/roguetown/clothing/onmob/32х48/helmets.dmi'
	icon_state = "face_helmet"
	item_state = "face_helmet"
	max_integrity = ARMOR_INT_HELMET_HEAVY_STEEL + 20 //В стандартном шлеме юзается ARMOR_INT_HELMET_HEAVY_STEEL, дающий 400 очков ХП, но поскольку тут крафт 2 стали 1 бронза, то 20 интегрити сверху вряд-ли сильно повлияют на баланс.

/obj/item/clothing/head/roguetown/helmet/heavy/knight/raneshi_hmamluk/ComponentInitialize()
	AddComponent(/datum/component/adjustable_clothing, (HEAD|EARS|HAIR), (HIDEEARS|HIDEHAIR), null, 'sound/items/visor.ogg', null, UPD_HEAD)

/obj/item/clothing/head/roguetown/helmet/heavy/knight/raneshi_hmamluk/attackby(obj/item/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/natural/cloth) && !detail_tag)
		var/choice = input(user, "Choose a color.", "Orle") as anything in colorlist
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		user.transferItemToLoc(W, src, FALSE, FALSE)
		detail_color = colorlist[choice]
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/heavy/knight/raneshi_hmamluk/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/roguetown/helmet/heavy/knight/raneshi_hmamluk/raneshi_vmamluk
	name = "hound masked mamluk helmet"
	desc = "Helmet of a heavy rider from Empire with a face-shaped visor."
	icon_state = "hound_helmet"
	item_state = "hound_helmet"

/obj/item/clothing/head/roguetown/helmet/heavy/ravoxhelm/oldrw
	name = "plumed ravox helmet"
	desc = "A helmet with a great, red plume. They will know, in time, that you are the true justiciar of the Vale."
	icon_state = "ravoxhelm"
	item_state = "ravoxhelm"
	icon = 'modular_twilight_axis/icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'modular_twilight_axis/icons/roguetown/clothing/onmob/head.dmi'
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDESNOUT
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel
	smelt_bar_num = 2
	adjustable = CAN_CADJUST

/obj/item/clothing/head/roguetown/helmet/heavy/ravoxhelm/oldrw/ComponentInitialize()
	AddComponent(/datum/component/adjustable_clothing, (HEAD|EARS|HAIR), (HIDEEARS|HIDEHAIR), null, 'sound/items/visor.ogg', null, UPD_HEAD)	//Standard helmet

/obj/item/clothing/head/roguetown/helmet/heavy/necran/oldrw
	name = "hooded necra helmet"
	desc = "Grim as the faces who wear it. For their duty is sacred, as they know the one truth of this lyfe. They're to perish, just as you are."
	icon_state = "necrahelm_hooded"
	item_state = "necrahelm_hooded"
	icon = 'modular_twilight_axis/icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'modular_twilight_axis/icons/roguetown/clothing/onmob/head.dmi'
	adjustable = CAN_CADJUST

/obj/item/clothing/head/roguetown/helmet/heavy/necran/oldrw/ComponentInitialize()
	AddComponent(/datum/component/adjustable_clothing, (HEAD|EARS|HAIR), (HIDEEARS|HIDEHAIR), null, 'sound/items/visor.ogg', null, UPD_HEAD)	//Standard helmet

/obj/item/clothing/head/roguetown/helmet/heavy/astratan/oldrw
	name = "plumed astrata helmet"
	desc = "A helmet with a great, black plume. Order shall guide your hand. Strike sure. Strike true. For none may question your intent."
	icon_state = "astratahelm_plume"
	item_state = "astratahelm_plume"
	icon = 'modular_twilight_axis/icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'modular_twilight_axis/icons/roguetown/clothing/onmob/head.dmi'
	adjustable = CAN_CADJUST

/obj/item/clothing/head/roguetown/helmet/heavy/astratan/oldrw/ComponentInitialize()
	AddComponent(/datum/component/adjustable_clothing, (HEAD|EARS|HAIR), (HIDEEARS|HIDEHAIR), null, 'sound/items/visor.ogg', null, UPD_HEAD)	//Standard helmet
