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
