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
	desc = "Decrepit old chain gauntlets. Aeon's grasp is upon them."
	icon_state = "acgloves"
	smeltresult = /obj/item/ingot/aalloy
	max_integrity = ARMOR_INT_SIDE_DECREPIT

/obj/item/clothing/gloves/roguetown/chain/paalloy
	name = "ancient chain gauntlets"
	desc = "Chain gauntlets formed out of ancient alloys. Aeon's grasp is lifted from them."
	icon_state = "acgloves"
	smeltresult = /obj/item/ingot/aaslag

/obj/item/clothing/gloves/roguetown/chain/psydon
	name = "psydonian chain wrapped gloves"
	desc = "Blacksteel-bound gauntlets. These ritualistic restraints, when left to dangle-and-sway, assist in the deflection of unpredictable blows."
	icon_state = "psydongloveschain"
	item_state = "psydongloveschains"

/obj/item/clothing/gloves/roguetown/chain/iron
	icon_state = "icgloves"
	desc = "Gauntlets made of interlinked iron rings. They offer decent protection against common weaponries, except for arrows."
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/iron
	max_integrity = ARMOR_INT_SIDE_IRON
