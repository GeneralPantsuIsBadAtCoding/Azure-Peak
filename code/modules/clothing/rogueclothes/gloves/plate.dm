/obj/item/clothing/gloves/roguetown/plate
	name = "plate gauntlets"
	desc = "Plate gauntlets made out of steel. Good all-around protection for the hands."
	icon_state = "gauntlets"
	armor = ARMOR_GLOVES_PLATE
	prevent_crits = list(BCLASS_CHOP, BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST)
	resistance_flags = FIRE_PROOF
	blocksound = PLATEHIT
	max_integrity = ARMOR_INT_SIDE_STEEL
	blade_dulling = DULLING_BASH
	break_sound = 'sound/foley/breaksound.ogg'
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel

	grid_width = 64
	grid_height = 32
	unarmed_bonus = 1.2

/obj/item/clothing/gloves/roguetown/plate/iron
	name = "iron plate gauntlets"
	desc = "Plate gauntlets made out of iron. Good all-around protection for the hands. Slightly less durable than its steel counterpart."
	icon_state = "igauntlets"
	smeltresult = /obj/item/ingot/iron
	max_integrity = ARMOR_INT_SIDE_IRON

/obj/item/clothing/gloves/roguetown/plate/aalloy
	name = "decrepit plate gauntlets"
	desc = "Frayed bronze mechanisms, connected to form the shells of hands. Too clumsy to properly knock a bow, too rigid to comfortably grip a sword; clench those fists any tighter, and the segments'll cut into flesh."
	icon_state = "agauntlets"
	max_integrity = ARMOR_INT_SIDE_DECREPIT
	color = "#bb9696"
	smeltresult = /obj/item/ingot/aaslag
	anvilrepair = null

/obj/item/clothing/gloves/roguetown/plate/paalloy
	name = "ancient plate gauntlets"
	desc = "Polished gilbranze mechanisms, meticulously interconnected to shroud splayed hands. 'Mercy' and 'innocence' are concepts paraded by the unenlightened; spill their blood without guilt, so that the world may yet be remade in Her image." 
	icon_state = "agauntlets"
	smeltresult = /obj/item/ingot/aaslag

/obj/item/clothing/gloves/roguetown/plate/graggar
	name = "vicious gauntlets"
	desc = "Plate gauntlets which carry the motive force of this world, violence."
	max_integrity = ARMOR_INT_SIDE_ANTAG
	icon_state = "graggarplategloves"

/obj/item/clothing/gloves/roguetown/plate/graggar/pickup(mob/living/user)
	if(!HAS_TRAIT(user, TRAIT_HORDE))
		to_chat(user, "<font color='red'>UNWORTHY HANDS TOUCHING THIS ARMOR, CEASE OR BE RENDED ASUNDER!</font>")
		user.adjust_fire_stacks(5)
		user.IgniteMob()
		user.Stun(40)
	..()

/obj/item/clothing/gloves/roguetown/plate/matthios
	name = "gilded gauntlets"
	desc = "Many a man his life hath sold,"
	icon_state = "matthiosgloves"
	max_integrity = ARMOR_INT_SIDE_ANTAG

/obj/item/clothing/gloves/roguetown/plate/matthios/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)

/obj/item/clothing/gloves/roguetown/plate/matthios/dropped(mob/living/carbon/human/user)
	. = ..()
	if(QDELETED(src))
		return
	qdel(src)


/obj/item/clothing/gloves/roguetown/plate/zizo
	name = "avantyne gauntlets"
	desc = "avantyne plate gauntlets. Called forth from the edge of what should be known. In Her name."
	icon_state = "zizogauntlets"
	max_integrity = ARMOR_INT_SIDE_ANTAG

/obj/item/clothing/gloves/roguetown/plate/zizo/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)

/obj/item/clothing/gloves/roguetown/plate/zizo/dropped(mob/living/carbon/human/user)
	. = ..()
	if(QDELETED(src))
		return
	qdel(src)
