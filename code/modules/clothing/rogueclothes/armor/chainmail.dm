//LIGHT ARMOR//
/obj/item/clothing/suit/roguetown/armor/chainmail
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	name = "haubergeon"
	desc = "A steel maille shirt. Arrows and small daggers go right through the gaps in this."
	body_parts_covered = COVERAGE_ALL_BUT_LEGS
	icon_state = "haubergeon"
	armor = ARMOR_MAILLE
	max_integrity = ARMOR_INT_CHEST_MEDIUM_STEEL
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT)
	blocksound = CHAINHIT
	drop_sound = 'sound/foley/dropsound/chain_drop.ogg'
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	armor_class = ARMOR_CLASS_LIGHT //Experimental change; leave unlisted for now? Offers a weight-class advantage over the otherwise-superior hauberk. We'll see how it goes.

/obj/item/clothing/suit/roguetown/armor/chainmail/iron
	icon_state = "ihaubergeon"
	name = "iron haubergeon"
	desc = "A chain vest made of heavy iron rings. Better than nothing."
	max_integrity = ARMOR_INT_CHEST_MEDIUM_IRON
	smeltresult = /obj/item/ingot/iron

/obj/item/clothing/suit/roguetown/armor/chainmail/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle)

/obj/item/clothing/suit/roguetown/armor/chainmail/aalloy
	name = "decrepit haubergeon"
	desc = "Frayed bronze rings and rotting leather, woven together to form a short maille-atekon. There's a breach along the rings, where the leather is wet with blackness: the aftermath of a mortal wound, delivered centuries ago."
	icon_state = "ancientchain"
	max_integrity = ARMOR_INT_CHEST_MEDIUM_DECREPIT
	color = "#bb9696"
	smeltresult = /obj/item/ingot/aaslag
	anvilrepair = null

/obj/item/clothing/suit/roguetown/armor/chainmail/paalloy
	name = "ancient haubergeon"
	desc = "Polished gilbranze rings and silk, woven together to form a short maille-atekon. The death of a million brought forth the ascension of Zizo; and if a million more must perish to complete Her works, then let it be done."
	icon_state = "ancientchain"
	smeltresult = /obj/item/ingot/aaslag

//MEDIUM ARMOR//

/obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	name = "hauberk"
	desc = "A longer steel maille that protects the legs, still doesn't protect against arrows though."
	body_parts_covered = COVERAGE_FULL
	icon_state = "hauberk"
	item_state = "hauberk"
	armor = ARMOR_MAILLE
	smeltresult = /obj/item/ingot/steel
	armor_class = ARMOR_CLASS_MEDIUM
	smelt_bar_num = 2

/obj/item/clothing/suit/roguetown/armor/chainmail/hauberk/iron
	name = "iron hauberk"
	desc = "A longer iron maille that protects the legs, still doesn't protect against arrows though."
	icon_state = "ihauberk"
	item_state = "ihauberk"
	smeltresult = /obj/item/ingot/iron
	max_integrity = ARMOR_INT_CHEST_MEDIUM_IRON

/obj/item/clothing/suit/roguetown/armor/chainmail/hauberk/aalloy
	name = "decrepit hauberk"
	desc = "Frayed bronze rings and rotting leather, woven together to form a sleeved maille-atekon. Once, the armored vestments of a paladin: now, the withered veil of Zizo's undying legionnaires."
	icon_state = "ancienthauberk"
	max_integrity = ARMOR_INT_CHEST_MEDIUM_DECREPIT
	color = "#bb9696"
	smeltresult = /obj/item/ingot/aaslag
	anvilrepair = null

/obj/item/clothing/suit/roguetown/armor/chainmail/hauberk/paalloy
	name = "ancient hauberk"
	desc = "Polished gilbranze rings and silk, woven together to form a sleeved maille-atekon. To bring the lyfeless back from decrepity, to elevate them to heights once thought unsurmountable; that is the will of Zizo, made manifest."
	icon_state = "ancienthauberk"
	smeltresult = /obj/item/ingot/aaslag

/obj/item/clothing/suit/roguetown/armor/chainmail/hauberk/ornate
	slot_flags = ITEM_SLOT_ARMOR
	armor_class = ARMOR_CLASS_HEAVY
	armor = ARMOR_CUIRASS
	name = "psydonic hauberk"
	desc = "A beautiful steel cuirass, decorated with blessed silver fluting and worn atop thick chainmaille. While it falters against arrows and bolts, these interlinked layers are superb at warding off the blows of inhumen claws and axes. </br>With a blacksmith's assistance and some blessed silver ingots, all forms of Psydonic maille can be further improved."
	icon_state = "ornatehauberk"
	item_state = "ornatehauberk"
	max_integrity = ARMOR_INT_CHEST_PLATE_PSYDON

/obj/item/clothing/suit/roguetown/armor/chainmail/bikini
	name = "chainmail corslet"	// corslet, from the old French 'cors' or bodice, with the diminutive 'let', used to describe lightweight military armor since 1500. Chosen here to replace 'bikini', an extreme anachronism.
	desc = "For the daring, affording maille's protection with light weight."
	icon_state = "chainkini"
	item_state = "chainkini"
	allowed_sex = list(FEMALE)
	allowed_race = CLOTHED_RACES_TYPES
	body_parts_covered = CHEST|GROIN
	armor_class = ARMOR_CLASS_LIGHT //placed in the medium category to keep it with its parent obj

//UNIQUE//
// Context: Disciples were able to wear maille on the shirt slot, but not any actual shirts. We don't have any variables that specifically allow for blacklisting certain clothes, too.
// This is a hackjobbed solution, in the internim, for now. My guess is that the filepath determines what 'type' the item belongs to, and whether you can wear multiples or not.

/obj/item/clothing/suit/roguetown/armor/chainmail/disciple
	name = "disciple's skin"
	desc = "'..they will say of you; you descended into Hell, and gave justice to those within..' </br>'..in the heart of the abyss, you faced down the Archdevil, and slew them in a triumph of Man over God..' '</br>'..and on the third dae, you rose again from the dead and were seated at the right hand of Adonai..' </br>'..the risen messiah for the Gospel of Violence.'"
	resistance_flags = FIRE_PROOF
	icon_state = null
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	armor = list("blunt" = 30, "slash" = 50, "stab" = 50, "piercing" = 20, "fire" = 0, "acid" = 0) //Custom value; padded gambeson's slash- and stab- armor.
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT)
	body_parts_covered = COVERAGE_FULL
	body_parts_inherent = COVERAGE_FULL
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg' //If you hear this, something has gone terribly wrong.
	blocksound = SOFTUNDERHIT
	blade_dulling = DULLING_BASHCHOP
	anvilrepair = null //Should hopefully replicate the 'shirt' path's function, without exploding everything. Remove 'anvilrepair' ASAP if it prevents the armor's regeneration.
	sewrepair = TRUE
	max_integrity = 600 //Difficult to completely break.
	flags_inv = null //Exposes the chest and-or breasts. Should allow for a Disciple's thang to swang.
	surgery_cover = FALSE //Should permit surgery and other invasive processes.
	var/repair_amount = 6 
	var/repair_time = 20 SECONDS
	var/last_repair 

/obj/item/clothing/suit/roguetown/armor/chainmail/disciple/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)

/obj/item/clothing/suit/roguetown/armor/chainmail/disciple/dropped(mob/living/carbon/human/user)
	. = ..()
	if(QDELETED(src))
		return
	qdel(src)


/obj/item/clothing/suit/roguetown/armor/chainmail/disciple/take_damage(damage_amount, damage_type, damage_flag, sound_effect, attack_dir, armor_penetration)
	. = ..()
	if(obj_integrity < max_integrity)
		START_PROCESSING(SSobj, src)
		return

/obj/item/clothing/suit/roguetown/armor/chainmail/disciple/process()
	if(obj_integrity >= max_integrity) 
		STOP_PROCESSING(SSobj, src)
		src.visible_message(span_notice("[src] tautens with newfound vigor, before relaxing once more."), vision_distance = 1)
		return
	else if(world.time > src.last_repair + src.repair_time)
		src.last_repair = world.time
		obj_integrity = min(obj_integrity + src.repair_amount, src.max_integrity)
	..()
