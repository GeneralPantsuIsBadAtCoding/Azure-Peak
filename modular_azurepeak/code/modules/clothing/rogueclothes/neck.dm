/obj/item/clothing/neck/roguetown/blacksteel
	name = "blacksteel gorget"
	desc = "made of blacksteel and protect the neck"
	icon = 'modular_azurepeak/icons/clothing/bs_armor.dmi'
	mob_overlay_icon = 'modular_azurepeak/icons/clothing/onmob/bs_armor.dmi'
	icon_state = "bsgorget"
	item_state = "bsgorget"
	slot_flags = ITEM_SLOT_NECK
	blocksound = SOFTHIT
	body_parts_covered = NECK
	body_parts_inherent = NECK
	armor = ARMOR_GORGET
	prevent_crits = list(BCLASS_CUT, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST, BCLASS_SMASH)
	sewrepair = TRUE
	sellprice = 90
	max_integrity = ARMOR_INT_SIDE_BLACKSTEEL
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/blacksteel
