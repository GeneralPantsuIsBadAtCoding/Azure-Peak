/obj/item/clothing/gloves/roguetown/chain
	name = "chain gauntlets"
	desc = "Gauntlets made of interlinked steel rings. They offer decent protection against common weaponries, except for arrows."
	icon_state = "cgloves"
	armor = ARMOR_GLOVES_CHAIN
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_BLUNT)
	resistance_flags = FIRE_PROOF
	blocksound = CHAINHIT
	max_integrity = ARMOR_INT_SIDE_STEEL
	blade_dulling = DULLING_BASHCHOP
	break_sound = 'sound/foley/breaksound.ogg'
	drop_sound = 'sound/foley/dropsound/chain_drop.ogg'
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	unarmed_bonus = 1.15

/obj/item/clothing/gloves/roguetown/chain/aalloy
	name = "decrepit chain gauntlets"
	desc = "Frayed bronze rings, interlinked together to form sagging mittens. Fingers, talons, claws; they're all the same, when smothered beneath maille and left to rot away."
	icon_state = "acgloves"
	max_integrity = ARMOR_INT_SIDE_DECREPIT
	color = "#bb9696"
	smeltresult = /obj/item/ingot/aaslag
	anvilrepair = null

/obj/item/clothing/gloves/roguetown/chain/paalloy
	name = "ancient chain gauntlets"
	desc = "Polished gilbranze rings, delicately daisy-chained together into mittens. The filament is ruptured, and it will never heal; Zizo's ascension made sure of that. By the hands of Her disciples, the final obstacle preventing this world's salvation shall be dismantled - lyfe."
	icon_state = "acgloves"
	smeltresult = /obj/item/ingot/aaslag

/obj/item/clothing/gloves/roguetown/chain/psydon
	name = "psydonian gloves"
	desc = "Blacksteel-bound gauntlets. These ritualistic restraints, when left to dangle-and-sway, assist in the deflection of unpredictable blows."
	icon_state = "psydongloveschain"
	item_state = "psydongloveschains"
	smeltresult = null	//So you can't melt down your start gear for blacksteel brigadines etc.

/obj/item/clothing/gloves/roguetown/chain/iron
	icon_state = "icgloves"
	desc = "Gauntlets made of interlinked iron rings. They offer decent protection against common weaponries, except for arrows."
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/iron
	max_integrity = ARMOR_INT_SIDE_IRON
