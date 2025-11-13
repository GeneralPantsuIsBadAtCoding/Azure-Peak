/obj/item/clothing/head/roguetown/helmet/sallet/visored/grenzelhoft
	name = "visored sallet with Grenzelhoft hat"
	desc = "A steel helmet which protects the ears, nose, and eyes. This helmet with a Grenzelhoft hat"
	icon = 'modular_twilight_axis/icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'modular_twilight_axis/icons/roguetown/clothing/onmob/head.dmi'
	icon_state = "sallet_visorgrenzelhoft"
	adjustable = CAN_CADJUST
	flags_inv = HIDEFACE|HIDESNOUT|HIDEHAIR
	flags_cover = HEADCOVERSEYES
	body_parts_covered = HEAD|EARS|HAIR|NOSE|EYES
	block2add = FOV_BEHIND
	smelt_bar_num = 2

/obj/item/clothing/head/roguetown/helmet/bascinet/etruscan/grenzelhoft
	name = "\improper Etruscan bascinet with Grenzelhoft hat"
	desc = "A steel bascinet helmet with a straight visor, or \"klappvisier\", which can greatly reduce visibility. Though it was first developed in Etrusca, it is also widely used in Grenzelhoft. This helmet with a Grenzelhoft hat"
	icon = 'modular_twilight_axis/icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'modular_twilight_axis/icons/roguetown/clothing/onmob/head.dmi'
	icon_state = "klappvisiergrenzelhoft"
	item_state = "klappvisiergrenzelhoft"
	adjustable = CAN_CADJUST
	emote_environment = 3
	body_parts_covered = FULL_HEAD
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel
	smelt_bar_num = 2

/obj/item/clothing/head/roguetown/helmet/sallet/grenzelhoft
	name = "sallet with Grenzelhoft hat"
	icon = 'modular_twilight_axis/icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'modular_twilight_axis/icons/roguetown/clothing/onmob/head.dmi'
	icon_state = "sallad_grenzelhoft"
	desc = "A steel helmet which protects the ears. This helmet with a Grenzelhoft hat"
	smeltresult = /obj/item/ingot/steel
	body_parts_covered = HEAD|HAIR|EARS

/obj/item/clothing/head/roguetown/helmet/raneshi_jarhelmet
	name = "Raneshi jar helmet"
	desc = "a jar-shaped helmet used by Empire light warriors."
	icon = 'modular_twilight_axis/icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'modular_twilight_axis/icons/roguetown/clothing/onmob/32х48/helmets.dmi'
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
