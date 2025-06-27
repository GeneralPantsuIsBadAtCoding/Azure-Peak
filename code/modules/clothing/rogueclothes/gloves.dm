
/obj/item/clothing/gloves/roguetown
	slot_flags = ITEM_SLOT_GLOVES
	body_parts_covered = HANDS
	body_parts_inherent = HANDS
	sleeved = 'icons/roguetown/clothing/onmob/gloves.dmi'
	icon = 'icons/roguetown/clothing/gloves.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/gloves.dmi'
	bloody_icon_state = "bloodyhands"
	sleevetype = "shirt"
	max_heat_protection_temperature = 361
	experimental_inhand = FALSE

/obj/item/clothing/gloves/roguetown/leather
	name = "leather gloves"
	desc = ""
	icon_state = "leather_gloves"
	armor = ARMOR_GLOVES_LEATHER
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_BLUNT)
	max_integrity = 100
	resistance_flags = FIRE_PROOF
	blocksound = SOFTHIT
	blade_dulling = DULLING_BASHCHOP
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	anvilrepair = null
	sewrepair = TRUE
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/gloves/roguetown/leather/black
	color = CLOTHING_BLACK

/obj/item/clothing/gloves/roguetown/fingerless
	name = "fingerless gloves"
	desc = "Cloth gloves to absorb palm sweat while leaving the fingers free for fine manipulation."
	icon_state = "fingerless_gloves"
	resistance_flags = FIRE_PROOF
	blocksound = SOFTHIT
	blade_dulling = DULLING_BASHCHOP
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	anvilrepair = null
	sewrepair = TRUE

/obj/item/clothing/gloves/roguetown/fingerless/shadowgloves
	name = "fingerless gloves"
	desc = "Cloth gloves to absorb palm sweat while leaving the fingers free for fine manipulation."
	icon_state = "shadowgloves"
	allowed_race = NON_DWARVEN_RACE_TYPES

/obj/item/clothing/gloves/roguetown/angle
	name = "heavy leather gloves"
	desc = ""
	icon_state = "angle"
	armor = ARMOR_GLOVES_LEATHER_GOOD
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_BLUNT, BCLASS_TWIST)
	resistance_flags = FIRE_PROOF
	blocksound = SOFTHIT
	max_integrity = 300
	sellprice = 12
	blade_dulling = DULLING_BASHCHOP
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	anvilrepair = null
	sewrepair = TRUE
	salvage_result = /obj/item/natural/fur

/obj/item/clothing/gloves/roguetown/fingerless_leather
	name = "fingerless leather gloves"
	desc = "A pair of protective gloves favored by lockshimmers, laborers, and smokers for maintaining \
	manual dexterity over regular gloves."
	icon_state = "roguegloves"
	armor = ARMOR_GLOVES_LEATHER_GOOD
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_BLUNT)
	resistance_flags = FIRE_PROOF
	blocksound = SOFTHIT
	max_integrity = 80
	blade_dulling = DULLING_BASHCHOP
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	anvilrepair = null
	sewrepair = TRUE
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/gloves/roguetown/chain
	name = "chain gauntlets"
	desc = ""
	icon_state = "cgloves"
	armor = ARMOR_GLOVES_CHAIN
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_BLUNT)
	resistance_flags = FIRE_PROOF
	blocksound = CHAINHIT
	max_integrity = 250
	blade_dulling = DULLING_BASHCHOP
	break_sound = 'sound/foley/breaksound.ogg'
	drop_sound = 'sound/foley/dropsound/chain_drop.ogg'
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/gloves/roguetown/chain/aalloy
	name = "decrepit chain gauntlets"
	desc = "Decrepit old chain gauntlets. Aeon's grasp is upon them."
	icon_state = "acgloves"
	smeltresult = /obj/item/ingot/aalloy
	max_integrity = 125

/obj/item/clothing/gloves/roguetown/chain/paalloy
	name = "ancient chain gauntlets"
	desc = "Chain gauntlets formed out of ancient alloys. Aeon's grasp is lifted from them."
	icon_state = "acgloves"
	smeltresult = /obj/item/ingot/aaslag

/obj/item/clothing/gloves/roguetown/chain/psydon
	name = "psydonian gloves"
	desc = "Blacksteel-bound gauntlets. These ritualistic restraints, when left to dangle-and-sway, assist in the deflection of unpredictable blows."
	icon_state = "psydongloveschain"
	item_state = "psydongloveschains"

/obj/item/clothing/gloves/roguetown/chain/iron
	icon_state = "icgloves"
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/iron
	max_integrity = 200

/obj/item/clothing/gloves/roguetown/otavan
	name = "otavan leather gloves"
	desc = "A pair of heavy Otavan leather gloves, commonly used by fencers, renowned for their quality."
	icon_state = "fencergloves"
	item_state = "fencergloves"
	armor = ARMOR_GLOVES_CHAIN
	prevent_crits = list(BCLASS_CHOP, BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST)
	resistance_flags = FIRE_PROOF
	blocksound = SOFTHIT
	max_integrity = 250
	blade_dulling = DULLING_BASHCHOP
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	anvilrepair = null
	sewrepair = TRUE
	allowed_race = NON_DWARVEN_RACE_TYPES

/obj/item/clothing/gloves/roguetown/otavan/inqgloves
	name = "inquisitorial leather gloves"
	desc = "Masterfully crafted leather gloves, psycross included."
	icon_state = "inqgloves"
	item_state = "inqgloves"
	salvage_result = /obj/item/natural/hide/cured

//rogtodo sprites for this
/obj/item/clothing/gloves/roguetown/plate
	name = "plate gauntlets"
	desc = ""
	icon_state = "gauntlets"
	armor = ARMOR_GLOVES_PLATE
	prevent_crits = list(BCLASS_CHOP, BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST)
	resistance_flags = FIRE_PROOF
	blocksound = PLATEHIT
	max_integrity = 300
	blade_dulling = DULLING_BASH
	break_sound = 'sound/foley/breaksound.ogg'
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel

	grid_width = 64
	grid_height = 32

/obj/item/clothing/gloves/roguetown/plate/aalloy
	name = "decrepit plate gauntlets"
	desc = "Decrepit old plate gauntlets. Aeon's grasp is upon them."
	icon_state = "agauntlets"
	smeltresult = /obj/item/ingot/aalloy
	max_integrity = 150

/obj/item/clothing/gloves/roguetown/plate/paalloy
	name = "ancient plate gauntlets"
	desc = "Ancient plate gauntlets. Aeon's grasp lifed from them."
	icon_state = "agauntlets"
	smeltresult = /obj/item/ingot/aaslag

/obj/item/clothing/gloves/roguetown/plate/graggar
	name = "vicious gauntlets"
	desc = "Plate gauntlets which carry the motive force of this world, violence."
	max_integrity = 500
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
	max_integrity = 500

/obj/item/clothing/gloves/roguetown/plate/matthios/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)

/obj/item/clothing/gloves/roguetown/plate/matthios/dropped(mob/living/carbon/human/user)
	. = ..()
	if(QDELETED(src))
		return
	qdel(src)


/obj/item/clothing/gloves/roguetown/plate/zizo
	name = "darksteel gauntlets"
	desc = "darksteel plate gauntlets. Called forth from the edge of what should be known. In Her name."
	icon_state = "zizogauntlets"
	max_integrity = 500

/obj/item/clothing/gloves/roguetown/plate/zizo/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)

/obj/item/clothing/gloves/roguetown/plate/zizo/dropped(mob/living/carbon/human/user)
	. = ..()
	if(QDELETED(src))
		return
	qdel(src)


/obj/item/clothing/gloves/roguetown/angle/grenzelgloves
	name = "grenzelhoft gloves"
	desc = ""
	icon_state = "grenzelgloves"
	item_state = "grenzelgloves"
	sleeved = 'icons/roguetown/clothing/onmob/helpers/stonekeep_merc.dmi'
	armor = ARMOR_GLOVES_LEATHER
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT)
	max_integrity = 100
	resistance_flags = FIRE_PROOF
	blocksound = SOFTHIT
	blade_dulling = DULLING_BASHCHOP
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	anvilrepair = null
	sewrepair = TRUE
	salvage_result = null

/obj/item/clothing/gloves/roguetown/angle/grenzelgloves/blacksmith
	name = "forge gauntlets"

//---------------- BLACKSTEEL ---------------------

/obj/item/clothing/gloves/roguetown/blacksteel/modern/plategloves
	name = "blacksteel plate gauntlets"
	desc = "A set of plate gauntlets forged of blacksteel, using a modern design."
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	icon_state = "bplategloves"
	item_state = "bplategloves"
	armor = ARMOR_PLATE_BSTEEL
	prevent_crits = list(BCLASS_CHOP, BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST)
	resistance_flags = FIRE_PROOF
	blocksound = PLATEHIT
	max_integrity = 400
	blade_dulling = DULLING_BASH
	break_sound = 'sound/foley/breaksound.ogg'
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/blacksteel

/obj/item/clothing/gloves/roguetown/blacksteel/plategloves
	name = "ancient blacksteel plate gauntlets"
	desc = "A set of plate gauntlets forged of blacksteel."
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	icon_state = "bkgloves"
	item_state = "bkgloves"
	armor = ARMOR_PLATE_BSTEEL
	prevent_crits = list(BCLASS_CHOP, BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST)
	resistance_flags = FIRE_PROOF
	blocksound = PLATEHIT
	max_integrity = 400
	blade_dulling = DULLING_BASH
	break_sound = 'sound/foley/breaksound.ogg'
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/blacksteel

/obj/item/clothing/gloves/roguetown/angle/pontifex
	name = "rune-scrybed wrappings"
	desc = "Paper and cloth bandages enscrybed with powerful naledian runes. They do an ample job of protecting their user's hands in combat."
	icon_state = "clothwraps"
	item_state = "clothwraps"

//------------ BLACKSTEEL END ---------------------

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

//eastern content

/obj/item/clothing/gloves/roguetown/eastgloves1
	name = "black gloves"
	desc = "Sleek gloves typically used by swordsmen."
	icon_state = "eastgloves1"
	item_state = "eastgloves1"
	armor = ARMOR_GLOVES_LEATHER
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT)
	resistance_flags = null
	blocksound = SOFTHIT
	blade_dulling = DULLING_BASHCHOP
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	anvilrepair = null
	sewrepair = TRUE

/obj/item/clothing/gloves/roguetown/eastgloves2
	name = "stylish gloves"
	desc = "Unusual gloves worn by foreign gangs."
	icon_state = "eastgloves2"
	item_state = "eastgloves2"
	armor = ARMOR_GLOVES_LEATHER
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT)
	resistance_flags = null
	blocksound = SOFTHIT
	blade_dulling = DULLING_BASHCHOP
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	anvilrepair = null
	sewrepair = TRUE
