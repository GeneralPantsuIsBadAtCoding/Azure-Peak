/obj/item/clothing/gloves/roguetown/elven_gloves
	name = "woad elven gloves"
	desc = "The insides are lined with soft, living leaves and soil. They wick away moisture easily."
	icon = 'icons/roguetown/clothing/special/race_armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/race_armor.dmi'
	icon_state = "welfhand"
	item_state = "welfhand"
	armor = list("blunt" = 100, "slash" = 10, "stab" = 110, "piercing" = 20, "fire" = 0, "acid" = 0)//Resistant to blunt and stab, super weak to slash.
	prevent_crits = list(BCLASS_BLUNT, BCLASS_SMASH, BCLASS_PICK)
	resistance_flags = FIRE_PROOF
	blocksound = SOFTHIT
	max_integrity = 200
	anvilrepair = /datum/skill/craft/carpentry
