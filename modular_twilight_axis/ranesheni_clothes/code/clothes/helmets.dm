/obj/item/clothing/head/roguetown/helmet/heavy/knight/raneshi_hmamluk
	name = "masked mamluk helmet"
	desc = "Helmet of a heavy rider from Empire with a face-shaped visor."
	icon = 'modular_twilight_axis/ranesheni_clothes/icons/obj/helmets.dmi'
	mob_overlay_icon = 'modular_twilight_axis/ranesheni_clothes/icons/mob/helmets.dmi'
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

/obj/item/clothing/head/roguetown/helmet/raneshi_jarhelmet
	name = "Raneshi jar helmet"
	desc = "a jar-shaped helmet used by Empire light warriors."
	icon = 'modular_twilight_axis/ranesheni_clothes/icons/obj/helmets.dmi'
	mob_overlay_icon = 'modular_twilight_axis/ranesheni_clothes/icons/mob/helmets.dmi'
	icon_state = "jar_helmet"
	item_state = "jar_helmet"
	smeltresult = /obj/item/ingot/steel
	body_parts_covered = HEAD|EARS|HAIR|NOSE
	max_integrity = ARMOR_INT_HELMET_STEEL + 20 //В стандартном шлеме юзается ARMOR_INT_HELMET_STEEL, дающий 300 очков ХП, но поскольку тут крафт 1 сталь 1 бронза, то 20 интегрити сверху так же вряд-ли сильно повлияют на баланс.

/obj/item/clothing/head/roguetown/helmet/raneshi_jarhelmet/attackby(obj/item/W, mob/living/user, params)
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

/obj/item/clothing/head/roguetown/helmet/raneshi_jarhelmet/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)
