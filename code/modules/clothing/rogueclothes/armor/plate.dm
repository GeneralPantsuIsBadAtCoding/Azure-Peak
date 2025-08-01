// BASE
/obj/item/clothing/suit/roguetown/armor/plate
	slot_flags = ITEM_SLOT_ARMOR
	name = "steel half-plate"
	desc = "\'Adventurer-fit\' plate armor with pauldrons. The poor fitting leaves many small gaps for daggers and bolts to pierce something vital, so a gambeson is recommended."
	body_parts_covered = COVERAGE_TORSO
	icon_state = "halfplate"
	item_state = "halfplate"
	armor = ARMOR_PLATE
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	nodismemsleeves = TRUE
	max_integrity = ARMOR_INT_CHEST_PLATE_STEEL
	allowed_sex = list(MALE, FEMALE)
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	equip_delay_self = 4 SECONDS
	unequip_delay_self = 4 SECONDS
	armor_class = ARMOR_CLASS_HEAVY
	smelt_bar_num = 3

/obj/item/clothing/suit/roguetown/armor/plate/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, SFX_PLATE_STEP)

/obj/item/clothing/suit/roguetown/armor/plate/iron
	name = "iron half-plate"
	desc = "A basic half-plate of iron, protective and moderately durable."
	icon_state = "ironplate"
	item_state = "ironplate"
	boobed = FALSE	//the armor just looks better with this, makes sense and is 8 sprites less
	max_integrity = ARMOR_INT_CHEST_PLATE_IRON
	smeltresult = /obj/item/ingot/iron

/obj/item/clothing/suit/roguetown/armor/plate/aalloy
	name = "decrepit half-plate"
	desc = "Worn out and decrepit halfplate. Aeon's grasp is upon it."
	icon_state = "ancientplate"
	item_state = "ancientplate"
	max_integrity = ARMOR_INT_CHEST_PLATE_DECREPIT
	smeltresult = /obj/item/ingot/aalloy

/obj/item/clothing/suit/roguetown/armor/plate/paalloy
	name = "ancient half-plate"
	desc = "Plate formed out of ancient alloys. Aeon's grasp has been lifted from it."
	icon_state = "ancientplate"
	item_state = "ancientplate"
	smeltresult = /obj/item/ingot/aaslag

/obj/item/clothing/suit/roguetown/armor/plate/fluted
	name = "fluted half-plate"
	desc = "A sturdily made fluted half-plate armour-set, complete with pauldrons and shoulder-guards. \
	Supposedly made to deflect blows."
	icon_state = "flutedhalfplate"

	equip_delay_self = 6 SECONDS
	unequip_delay_self = 6 SECONDS

	max_integrity = ARMOR_INT_CHEST_PLATE_STEEL
	body_parts_covered = COVERAGE_SHIRT

/obj/item/clothing/suit/roguetown/armor/plate/fluted/graggar
	name = "vicious half-plate"
	desc = "A fluted half-plate armour-set which stirs with the same violence driving our world. This inner motive makes it far less restrictive."
	armor_class = ARMOR_CLASS_MEDIUM
	max_integrity = ARMOR_INT_CHEST_PLATE_STEEL // We are probably one of the best medium armor sets. At higher integ than most(heavy armor levels, pretty much. But worse resistances, we get the bonus over the other sets of being medium and being unequippable.)
	icon_state = "graggarplate"
	armor = ARMOR_CUIRASS

/obj/item/clothing/suit/roguetown/armor/plate/fluted/graggar/pickup(mob/living/user)
	if(!HAS_TRAIT(user, TRAIT_HORDE))
		to_chat(user, "<font color='red'>UNWORTHY HANDS TOUCHING THIS ARMOR, CEASE OR BE RENDED ASUNDER!</font>")
		user.adjust_fire_stacks(5)
		user.IgniteMob()
		user.Stun(40)
	..()

/obj/item/clothing/suit/roguetown/armor/plate/fluted/ornate
	name = "psydonian half-plate"
	desc = "A sturdily made fluted half-plate armour-set, complete with pauldrons and shoulder-guards. \
			Favored by both the Holy Otavan Inquisition and the Order of the Silver Psycross. It smells of the madness of an enduring God."
	icon_state = "ornatehalfplate"

	max_integrity = ARMOR_INT_CHEST_PLATE_PSYDON

/obj/item/clothing/suit/roguetown/armor/plate/fluted/ornate/equipped(mob/living/user, slot)
	. = ..()
	if(slot == SLOT_ARMOR)
		user.apply_status_effect(/datum/status_effect/buff/psydonic_endurance)

/obj/item/clothing/suit/roguetown/armor/plate/fluted/ornate/dropped(mob/living/carbon/human/user)
	. = ..()
	if(istype(user) && user?.wear_armor == src)
		user.remove_status_effect(/datum/status_effect/buff/psydonic_endurance)

// Full plate armor

/obj/item/clothing/suit/roguetown/armor/plate/full
	name = "plate armor"
	desc = "Full steel plate armor. Slow to don and doff without the aid of a good squire."
	icon_state = "plate"
	body_parts_covered = COVERAGE_FULL
	equip_delay_self = 12 SECONDS
	unequip_delay_self = 12 SECONDS
	equip_delay_other = 3 SECONDS
	strip_delay = 6 SECONDS
	smelt_bar_num = 4

/obj/item/clothing/suit/roguetown/armor/plate/full/iron
	name = "iron plate armor"
	icon_state = "iplate"
	desc = "Full iron plate armor. Slow to don and doff without the aid of a good squire."
	smeltresult = /obj/item/ingot/iron
	max_integrity = ARMOR_INT_CHEST_PLATE_IRON

/obj/item/clothing/suit/roguetown/armor/plate/full/fluted
	name = "fluted plate"
	desc = "A sturdily made fluted full-plate. Supposedly made to deflect blows from blades and arrows."
	icon_state = "flutedplate"

	max_integrity = ARMOR_INT_CHEST_PLATE_STEEL

/obj/item/clothing/suit/roguetown/armor/plate/full/fluted/ornate
	name = "psydonian plate"
	desc = "A sturdily made fluted full-plate. Heavy-duty, and made to deflect blows from blades and arrows. \
			Favored by both the Holy Otavan Inquisition and the Order of the Silver Psycross. It smells of the madness of an enduring God."
	icon_state = "ornateplate"

	max_integrity = ARMOR_INT_CHEST_PLATE_PSYDON

	/// Whether the user has the Heavy Armour Trait prior to donning.
	var/traited = FALSE

/obj/item/clothing/suit/roguetown/armor/plate/full/fluted/ornate/equipped(mob/living/user, slot)
	. = ..()
	if(slot == SLOT_ARMOR)
		user.apply_status_effect(/datum/status_effect/buff/psydonic_endurance)

/obj/item/clothing/suit/roguetown/armor/plate/full/fluted/ornate/dropped(mob/living/carbon/human/user)
	. = ..()
	if(istype(user) && user?.wear_armor == src)
		user.remove_status_effect(/datum/status_effect/buff/psydonic_endurance)


/obj/item/clothing/suit/roguetown/armor/plate/full/fluted/ornate/ordinator
	name = "inquisitorial ordinator's plate"
	desc = "A relic that is said to have survived the Grenzelhoft-Otavan war, refurbished and repurposed to slay the arch-enemy in the name of Psydon. <br> A fluted cuirass that has been reinforced with thick padding and an additional shoulder piece. You will endure."
	icon_state = "ordinatorplate"	

/obj/item/clothing/suit/roguetown/armor/plate/full/matthios
	name = "gilded fullplate"
	desc = "Often, you have heard that told,"
	icon_state = "matthiosarmor"
	max_integrity = ARMOR_INT_CHEST_PLATE_ANTAG	
	peel_threshold = 5	//-Any- weapon will require 5 peel hits to peel coverage off of this armor.

/obj/item/clothing/suit/roguetown/armor/plate/full/matthios/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)

/obj/item/clothing/suit/roguetown/armor/plate/full/matthios/dropped(mob/living/carbon/human/user)
	. = ..()
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/clothing/suit/roguetown/armor/plate/full/zizo
	name = "darksteel fullplate"
	desc = "Full plate. Called forth from the edge of what should be known. In Her name."
	icon_state = "zizoplate"
	max_integrity = ARMOR_INT_CHEST_PLATE_ANTAG
	peel_threshold = 5	//-Any- weapon will require 5 peel hits to peel coverage off of this armor.

/obj/item/clothing/suit/roguetown/armor/plate/full/zizo/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)

/obj/item/clothing/suit/roguetown/armor/plate/full/zizo/dropped(mob/living/carbon/human/user)
	. = ..()
	if(QDELETED(src))
		return
	qdel(src)


/obj/item/clothing/suit/roguetown/armor/plate/full/bikini
	name = "full-plate corset"
	desc = "Breastplate, pauldrons, couters, cuisses... did you forget something?"
	icon_state = "platekini"
	allowed_sex = list(FEMALE)
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	equip_delay_self = 8 SECONDS
	unequip_delay_self = 8 SECONDS
	equip_delay_other = 3 SECONDS
	strip_delay = 6 SECONDS
	smelt_bar_num = 3

/obj/item/clothing/suit/roguetown/armor/heartfelt/lord
	slot_flags = ITEM_SLOT_ARMOR
	name = "coat of armor"
	desc = "A lordly coat of armor."
	body_parts_covered = CHEST|GROIN|VITALS|LEGS|ARMS
	icon_state = "heartfelt"
	item_state = "heartfelt"
	armor = ARMOR_PLATE
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	allowed_sex = list(MALE, FEMALE)
	nodismemsleeves = TRUE
	blocking_behavior = null
	max_integrity = ARMOR_INT_CHEST_PLATE_STEEL
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	armor_class = ARMOR_CLASS_HEAVY
	smelt_bar_num = 4

/obj/item/clothing/suit/roguetown/armor/heartfelt/hand
	slot_flags = ITEM_SLOT_ARMOR
	name = "coat of armor"
	desc = "A lordly coat of armor."
	body_parts_covered = COVERAGE_FULL
	icon_state = "heartfelt_hand"
	item_state = "heartfelt_hand"
	armor = ARMOR_PLATE
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	allowed_sex = list(MALE, FEMALE)
	nodismemsleeves = TRUE
	blocking_behavior = null
	max_integrity = ARMOR_INT_CHEST_PLATE_STEEL
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	armor_class = ARMOR_CLASS_HEAVY
	smelt_bar_num = 4

/obj/item/clothing/suit/roguetown/armor/plate/otavan
	name = "otavan half-plate"
	desc = "Half-plate armor with pauldrons. Recommended to layer with the otavan gambeson."
	armor = ARMOR_PLATE
	body_parts_covered = COVERAGE_TORSO
	icon_state = "corsethalfplate"
	item_state = "corsethalfplate"
	adjustable = CAN_CADJUST
	allowed_race = NON_DWARVEN_RACE_TYPES
	detail_tag = "_detail"
	color = "#FFFFFF"
	detail_color = "#5058c1"
	var/swapped_color // holder for corset colour when the corset is toggled off.

/obj/item/clothing/suit/roguetown/armor/plate/otavan/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/suit/roguetown/armor/plate/otavan/AdjustClothes(mob/user)
	if(loc == user)
		playsound(user, "sound/foley/dropsound/cloth_drop.ogg", 100, TRUE, -1)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			icon_state = "fancyhalfplate"
			body_parts_covered = CHEST|GROIN|VITALS
			flags_cover = null
			emote_environment = 0
			swapped_color = detail_color
			detail_color = "#ffffff"
			update_icon()
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_armor()
			block2add = null
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)
			detail_color = swapped_color
			emote_environment = 3
			update_icon()
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_armor()


// MEDIUM
/obj/item/clothing/suit/roguetown/armor/plate/bikini
	name = "half-plate corslet"
	desc = "A high breastplate and hip armor allowing flexibility and great protection, save for the stomach."
	body_parts_covered = CHEST|GROIN
	icon_state = "halfplatekini"
	item_state = "halfplatekini"
	armor = ARMOR_CUIRASS // Identical to steel cuirass, but covering the groin instead of the vitals.
	max_integrity = ARMOR_INT_CHEST_MEDIUM_STEEL	// Identical to steel cuirasss. Same steel price.
	allowed_sex = list(FEMALE)
	armor_class = ARMOR_CLASS_MEDIUM
	smelt_bar_num = 2

/obj/item/clothing/suit/roguetown/armor/plate/half
	slot_flags = ITEM_SLOT_ARMOR
	name = "steel cuirass"
	desc = "A basic cuirass of steel. Lightweight and durable. A crossbow bolt will probably go right through this, but not an arrow."
	body_parts_covered = COVERAGE_VEST
	icon_state = "cuirass"
	item_state = "cuirass"
	armor = ARMOR_CUIRASS
	allowed_race = CLOTHED_RACES_TYPES
	nodismemsleeves = TRUE
	blocking_behavior = null
	max_integrity = ARMOR_INT_CHEST_MEDIUM_STEEL
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	armor_class = ARMOR_CLASS_MEDIUM
	smelt_bar_num = 2

/obj/item/clothing/suit/roguetown/armor/plate/half/fencer
	name = "fencer's cuirass"
	desc = "An expertly smithed form-fitting steel cuirass that is much lighter and agile, but breaks with much more ease. It's thinner, but backed with silk and leather."
	armor = ARMOR_LIGHTCUIRASS
	armor_class = ARMOR_CLASS_LIGHT
	max_integrity = ARMOR_INT_CHEST_FENCER_STEEL
	smelt_bar_num = 1
	icon_state = "fencercuirass"
	item_state = "fencercuirass"

/obj/item/clothing/suit/roguetown/armor/plate/half/fencer/psydon
	name = "psydonian chestplate"
	desc = "An expertly smithed form-fitting steel cuirass that is much lighter and agile, but breaks with much more ease. It's thinner, but backed with silk and leather."
	smelt_bar_num = 1
	icon_state = "ornatechestplate"
	item_state = "ornatechestplate"

/obj/item/clothing/suit/roguetown/armor/plate/half/aalloy
	name = "decrepit cuirass"
	desc = "A withered cuirass. Aeon's grasp is upon its form."
	icon_state = "ancientcuirass"
	smeltresult = /obj/item/ingot/aalloy
	max_integrity = ARMOR_INT_CHEST_MEDIUM_DECREPIT

/obj/item/clothing/suit/roguetown/armor/plate/half/paalloy
	name = "ancient cuirass"
	desc = "A cuirass of ancient alloys. Aeon's grasp lifted from its form."
	icon_state = "ancientcuirass"
	smeltresult = /obj/item/ingot/aaslag

/obj/item/clothing/suit/roguetown/armor/plate/half/fluted
	name = "fluted cuirass"
	icon_state = "flutedcuirass"
	desc = "A sturdy steel cuirass with tassets. Supposedly protective, though maybe not against crossbow bolts."

	body_parts_covered = CHEST | VITALS | LEGS 
	max_integrity = ARMOR_INT_CHEST_MEDIUM_STEEL

/obj/item/clothing/suit/roguetown/armor/plate/half/fluted/ornate
	name = "psydonian cuirass"
	icon_state = "ornatecuirass"
	desc = "An ornate steel cuirass with tassets, favored by both the Holy Otavan Inquisition and the Order of the Silver Psycross. \
			Made to endure."
	
/obj/item/clothing/suit/roguetown/armor/plate/half/iron
	name = "iron breastplate"
	desc = "A basic cuirass of iron, protective and moderately durable."
	icon_state = "ibreastplate"
	boobed = FALSE	//the armor just looks better with this, makes sense and is 8 sprites less
	max_integrity = ARMOR_INT_CHEST_MEDIUM_IRON
	smeltresult = /obj/item/ingot/iron
	smelt_bar_num = 2

/obj/item/clothing/suit/roguetown/armor/plate/half/copper
	name = "heart protector"
	desc = "Very simple and crude protection for the chest. Ancient fighters once used similar gear, with better quality..."
	icon_state = "copperchest"
	max_integrity = ARMOR_INT_CHEST_MEDIUM_DECREPIT
	armor = list("blunt" = 75, "slash" = 75, "stab" = 75, "piercing" = 40, "fire" = 0, "acid" = 0)	//idk what this armor is but I ain't making a define for it
	smeltresult = /obj/item/ingot/copper
	body_parts_covered = CHEST
	armor_class = ARMOR_CLASS_LIGHT
	smelt_bar_num = 2

/obj/item/clothing/suit/roguetown/armor/plate/half/elven
	name = "elven guardian cuirass"
	desc = "A cuirass made of steel with a thin decorative gold plating. Lightweight and durable."
	color = COLOR_ASSEMBLY_GOLD

/obj/item/clothing/suit/roguetown/armor/plate/scale
	slot_flags = ITEM_SLOT_ARMOR
	name = "scalemail"
	desc = "Metal scales interwoven intricately to form flexible protection!"
	body_parts_covered = COVERAGE_ALL_BUT_ARMS
	allowed_sex = list(MALE, FEMALE)
	icon_state = "lamellar"
	max_integrity = ARMOR_INT_CHEST_MEDIUM_SCALE
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	equip_delay_self = 4 SECONDS
	armor_class = ARMOR_CLASS_MEDIUM
	smelt_bar_num = 2

/obj/item/clothing/suit/roguetown/armor/plate/scale/steppe
	name = "steel steppesman hatanga"
	desc = "A set of steel-scaled hatanga armor hailing from the southern steppes."
	icon_state = "hudesutu"
	max_integrity = ARMOR_INT_CHEST_MEDIUM_HATANGA		//Grenzel gets 100+ integrity, I don't see why not give a +50 here.

/obj/item/clothing/suit/roguetown/armor/plate/scale/inqcoat
	slot_flags = ITEM_SLOT_ARMOR
	slot_flags = ITEM_SLOT_ARMOR
	name = "inquisitorial duster"
	desc = "A heavy coat lined with thin metal plates; only the finest for the inquisition, complete with space to fit a Psydonian Cuirass."
	body_parts_covered = COVERAGE_FULL
	allowed_sex = list(MALE, FEMALE)
	allowed_sex = list(MALE, FEMALE)
	icon_state = "inqcoat"
	item_state = "inqcoat"
	sleevetype = "shirt"
	max_integrity = 300
	anvilrepair = /datum/skill/craft/armorsmithing
	equip_delay_self = 4 SECONDS
	armor_class = ARMOR_CLASS_LIGHT
	armor = ARMOR_LEATHER_STUDDED
	smeltresult = /obj/item/ingot/iron
	smelt_bar_num = 2
	blocksound = SOFTHIT

/obj/item/clothing/suit/roguetown/armor/plate/scale/inqcoat/ComponentInitialize()	//No movement rustle component.
	return

/obj/item/clothing/suit/roguetown/armor/plate/scale/inqcoat/attackby(obj/item/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/clothing/suit/roguetown/armor/plate/half/fluted/ornate))
		user.visible_message(span_warning("[user] starts to fit [W] inside the [src]."))
		if(do_after(user, 12 SECONDS))
			var/obj/item/clothing/suit/roguetown/armor/plate/scale/inqcoat/armored/P = new /obj/item/clothing/suit/roguetown/armor/plate/scale/inqcoat/armored(get_turf(src.loc))
			if(user.is_holding(src))
				user.dropItemToGround(src)
			user.put_in_hands(P)
			P.obj_integrity = src.obj_integrity
			qdel(src)
			qdel(W)
		else
			user.visible_message(span_warning("[user] stops fitting [W] inside the [src]."))
		return


/obj/item/clothing/suit/roguetown/armor/plate/scale/inqcoat/armored
	slot_flags = ITEM_SLOT_ARMOR
	name = "armored inquisitorial duster"
	desc = "Metal plates reinforce this heavy coat, worn over the top of the finest Psydonian plate."
	smeltresult = /obj/item/ingot/steel 
	icon_state = "inqcoata"
	item_state = "inqcoata"
	equip_delay_self = 4 SECONDS
	max_integrity = 300
	armor_class = ARMOR_CLASS_MEDIUM
	armor = ARMOR_CUIRASS
	smelt_bar_num = 2
	smeltresult = /obj/item/ingot/steel
	blocksound = PLATEHIT	

/obj/item/clothing/suit/roguetown/armor/plate/scale/inqcoat/armored/ComponentInitialize()
	AddComponent(/datum/component/item_equipped_movement_rustle, SFX_PLATE_STEP)
	return
