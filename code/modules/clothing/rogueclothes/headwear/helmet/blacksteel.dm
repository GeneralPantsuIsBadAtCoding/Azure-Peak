
/obj/item/clothing/head/roguetown/helmet/blacksteel/modern/armet
	name = "blacksteel armet"
	desc = "An armet forged of durable blacksteel, utilizing a modern design."
	body_parts_covered = FULL_HEAD
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	icon_state = "bplatehelm"
	item_state = "bplatehelm"
	flags_inv = HIDEEARS|HIDEFACE|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	armor = ARMOR_PLATE_BSTEEL
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_SMASH, BCLASS_TWIST, BCLASS_PICK)
	block2add = FOV_BEHIND
	max_integrity = ARMOR_INT_HELMET_BLACKSTEEL
	smeltresult = /obj/item/ingot/blacksteel
	smelt_bar_num = 2

/obj/item/clothing/head/roguetown/helmet/blacksteel/bucket
	name = "blacksteel bucket helm"
	desc = "A bucket helmet forged of durable blacksteel. None shall pass.."
	body_parts_covered = FULL_HEAD
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	icon_state = "bkhelm"
	item_state = "bkhelm"
	flags_inv = HIDEEARS|HIDEFACE|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	armor = ARMOR_PLATE_BSTEEL
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_SMASH, BCLASS_TWIST, BCLASS_PICK)
	block2add = FOV_BEHIND
	max_integrity = ARMOR_INT_HELMET_BLACKSTEEL
	smeltresult = /obj/item/ingot/blacksteel
	smelt_bar_num = 2

