/obj/item/clothing/neck/roguetown
	name = "necklace"
	desc = ""
	icon = 'icons/roguetown/clothing/neck.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/neck.dmi'
	bloody_icon_state = "bodyblood"
	experimental_inhand = FALSE
	alternate_worn_layer = NECK_LAYER
	var/overarmor

/obj/item/clothing/neck/roguetown/MiddleClick(mob/user, params)
	. = ..()
	overarmor = !overarmor
	to_chat(user, span_info("I [overarmor ? "wear \the [src] over my armor" : "wear \the [src] under my armor"]."))
	if(overarmor)
		alternate_worn_layer = NECK_LAYER
	else
		alternate_worn_layer = UNDER_ARMOR_LAYER
	user.update_inv_neck()
	user.update_inv_cloak()
	user.update_inv_armor()
	user.update_inv_shirt()

/obj/item/clothing/neck/roguetown/coif
	name = "coif"
	desc = "Cheap and easy to make. It's better than leaving your neck exposed."
	icon_state = "coif"
	item_state = "coif"
	color = CLOTHING_BROWN
	flags_inv = HIDEHAIR
	slot_flags = ITEM_SLOT_NECK|ITEM_SLOT_HEAD
	blocksound = SOFTHIT
	body_parts_covered = NECK|HAIR|EARS|HEAD
	armor = ARMOR_PADDED_BAD
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT)
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	sewrepair = TRUE

/obj/item/clothing/neck/roguetown/coif/padded
	name = "padded coif"
	desc = "A cheap and simple gambeson coif meant to be worn on its own or under a helmet. It's better than nothing."
	icon_state = "ccoif"
	item_state = "ccoif"
	color = null
	flags_inv = HIDEHAIR
	slot_flags = ITEM_SLOT_NECK|ITEM_SLOT_HEAD
	blocksound = SOFTHIT
	body_parts_covered = NECK|HAIR|EARS|HEAD
	armor = ARMOR_PADDED //gambeson for head
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT)
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	sewrepair = TRUE

/obj/item/clothing/neck/roguetown/coif/heavypadding
	name = "heavy padded coif"
	desc = "A heavier padded coif meant to be worn on its own or under a helmet. Layered properly, it can last through even the busiest of daes."
	icon_state = "fullpadded"
	item_state = "fullpadded"
	color = null
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	slot_flags = ITEM_SLOT_NECK|ITEM_SLOT_HEAD
	blocksound = SOFTHIT
	body_parts_covered = NECK|HAIR|EARS|HEAD|MOUTH
	armor = ARMOR_PADDED_GOOD //full padded gambeson basically
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT)
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	sewrepair = TRUE

/obj/item/clothing/neck/roguetown/coif/heavypadding/ComponentInitialize()
	return

/obj/item/clothing/neck/roguetown/coif/heavypadding/AdjustClothes(mob/user)
	if(loc == user)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			if(toggle_icon_state)
				icon_state = "fullpadded_down"
			flags_inv = HIDEHAIR
			body_parts_covered = NECK|HAIR|EARS|HEAD
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_neck()
				H.update_inv_head()
		else if(adjustable == CADJUSTED)
			adjustable = CADJUSTED_MORE
			if(toggle_icon_state)
				icon_state = "fullpadded_neck"
			flags_inv = null
			body_parts_covered = NECK
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_neck()
				H.update_inv_head()
		else if(adjustable == CADJUSTED_MORE)
			ResetAdjust(user)
		if(ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_neck()
			H.update_inv_head()

/obj/item/clothing/neck/roguetown/coif/ComponentInitialize()
	AddComponent(/datum/component/adjustable_clothing, NECK, null, null, null, null, (UPD_HEAD|UPD_MASK|UPD_NECK))	//Soundless coif

/obj/item/clothing/neck/roguetown/leather
	name = "hardened leather gorget"
	desc = "Sturdy. Durable. Will protect your neck from some good lumbering."
	icon_state = "lgorget"
	slot_flags = ITEM_SLOT_NECK
	blocksound = SOFTHIT
	body_parts_covered = NECK
	body_parts_inherent = NECK
	armor = ARMOR_LEATHER_GOOD
	prevent_crits = list(BCLASS_CUT, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST, BCLASS_SMASH)
	sewrepair = TRUE
	sellprice = 10
	max_integrity = ARMOR_INT_SIDE_HARDLEATHER
	salvage_result = /obj/item/natural/hide/cured
	salvage_amount = 1

/obj/item/clothing/neck/roguetown/chaincoif
	name = "chain coif"
	desc = "Offers superior coverage to a simple gorget, though it sacrifices some protection in return."
	icon_state = "chaincoif"
	item_state = "chaincoif"
	flags_inv = HIDEHAIR
	armor = ARMOR_MAILLE
	max_integrity = ARMOR_INT_SIDE_STEEL
	resistance_flags = FIRE_PROOF
	slot_flags = ITEM_SLOT_NECK|ITEM_SLOT_HEAD
	body_parts_covered = NECK|HAIR|EARS|HEAD
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT)
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	blocksound = CHAINHIT
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/neck/roguetown/chaincoif/ComponentInitialize()
	AddComponent(/datum/component/adjustable_clothing, NECK, null, null, 'sound/foley/equip/chain_equip.ogg', null, (UPD_HEAD|UPD_MASK|UPD_NECK))	//Chain coif.

/obj/item/clothing/neck/roguetown/chaincoif/paalloy
	name = "ancient coif"
	desc = "a coif made of ancient alloys. Aeon's grasp lifted from its form."
	icon_state = "achaincoif"
	smeltresult = /obj/item/ingot/aaslag

/obj/item/clothing/neck/roguetown/chaincoif/iron/aalloy
	name = "decrepit coif"
	desc = "a decrepit old coif. Aeon's grasp is upon it."
	icon_state = "achaincoif"
	smeltresult = /obj/item/ingot/aalloy
	max_integrity = ARMOR_INT_SIDE_DECREPIT

/obj/item/clothing/neck/roguetown/chaincoif/chainmantle
	name = "chain mantle"
	desc = "A thicker and more durable piece of neck protection that also covers the mouth when pulled up."
	icon_state = "chainmantle"
	armor = ARMOR_MAILLE
	body_parts_covered = NECK|MOUTH
	slot_flags = ITEM_SLOT_NECK
	flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT

/obj/item/clothing/neck/roguetown/chaincoif/chainmantle/ComponentInitialize()
	AddComponent(/datum/component/adjustable_clothing, (NECK|MOUTH), null, null, 'sound/foley/equip/equip_armor_chain.ogg', null, (UPD_HEAD|UPD_MASK|UPD_NECK))	//Chain coif.

/obj/item/clothing/neck/roguetown/chaincoif/iron
	name = "iron chain coif"
	desc = "A coif of meticulously crafted iron rings. It isn't steel, but metal is metal, and it might just save your life."
	icon_state = "ichaincoif"
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/iron
	max_integrity = ARMOR_INT_SIDE_IRON

/obj/item/clothing/neck/roguetown/chaincoif/full
	name = "full chain coif"
	icon_state = "fchaincoif"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	resistance_flags = FIRE_PROOF
	body_parts_covered = NECK|MOUTH|NOSE|HAIR|EARS|HEAD
	adjustable = CAN_CADJUST

/obj/item/clothing/neck/roguetown/chaincoif/full/ComponentInitialize()
	return

/obj/item/clothing/neck/roguetown/chaincoif/full/AdjustClothes(mob/user)
	if(loc == user)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			if(toggle_icon_state)
				icon_state = "chaincoif"
			flags_inv = HIDEHAIR
			body_parts_covered = NECK|HAIR|EARS|HEAD
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_neck()
				H.update_inv_head()
		else if(adjustable == CADJUSTED)
			adjustable = CADJUSTED_MORE
			if(toggle_icon_state)
				icon_state = "chaincoif_t"
			flags_inv = null
			body_parts_covered = NECK
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_neck()
				H.update_inv_head()
		else if(adjustable == CADJUSTED_MORE)
			ResetAdjust(user)
		if(ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_neck()
			H.update_inv_head()


/obj/item/clothing/neck/roguetown/bevor
	name = "bevor"
	desc = "A series of steel plates designed to protect the neck."
	icon_state = "bevor"
	armor = ARMOR_BEVOR
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel

	max_integrity = ARMOR_INT_SIDE_STEEL
	resistance_flags = FIRE_PROOF
	slot_flags = ITEM_SLOT_NECK
	body_parts_covered = NECK|MOUTH|NOSE
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	blocksound = PLATEHIT

/obj/item/clothing/neck/roguetown/bevor/iron
	name = "iron bevor"
	desc = "A series of iron plates designed to protect the neck."
	icon_state = "ibevor"
	smeltresult = /obj/item/ingot/iron
	max_integrity = ARMOR_INT_SIDE_IRON
	anvilrepair = /datum/skill/craft/armorsmithing

/obj/item/clothing/neck/roguetown/gorget
	name = "gorget"
	desc = "A series of iron plates designed to protect the neck."
	icon_state = "gorget"
	armor = ARMOR_GORGET
	smeltresult = /obj/item/ingot/iron
	anvilrepair = /datum/skill/craft/armorsmithing
	max_integrity = ARMOR_INT_SIDE_IRON
	resistance_flags = FIRE_PROOF
	body_parts_inherent = NECK
	slot_flags = ITEM_SLOT_NECK
	body_parts_covered = NECK
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	blocksound = PLATEHIT

/obj/item/clothing/neck/roguetown/gorget/aalloy
	name = "decrepit gorget"
	desc = "a decrepit, worn out gorget. Aeon's grasp is upon it."
	icon_state = "ancientgorget"
	max_integrity = ARMOR_INT_SIDE_DECREPIT
	smeltresult = /obj/item/ingot/aalloy

/obj/item/clothing/neck/roguetown/gorget/copper
	name = "neck protector"
	icon_state = "copperneck"
	desc = "An antique and simple protection for the neck, used more as an accessory by the common folk. But poor protection is still better than nothing."
	armor = ARMOR_NECK_BAD
	smeltresult = /obj/item/ingot/copper

/obj/item/clothing/neck/roguetown/fencerguard
	name = "fencing guard"
	icon_state = "fencercollar"
	armor = ARMOR_BEVOR
	smeltresult = /obj/item/ingot/steel
	anvilrepair = /datum/skill/craft/armorsmithing
	max_integrity = ARMOR_INT_SIDE_STEEL
	body_parts_inherent = NECK
	resistance_flags = FIRE_PROOF
	slot_flags = ITEM_SLOT_NECK
	body_parts_covered = NECK
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	blocksound = PLATEHIT
	allowed_race = NON_DWARVEN_RACE_TYPES
	detail_tag = "_detail"
	color = "#5058c1"
	detail_color = "#e98738"
	var/picked = FALSE

/obj/item/clothing/neck/roguetown/fencerguard/attack_right(mob/user)
	..()
	if(!picked)
		var/choice = input(user, "Choose a color.", "Otavan colors") as anything in colorlist
		var/playerchoice = colorlist[choice]
		picked = TRUE
		detail_color = playerchoice
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_shirt()
			H.update_icon()

/obj/item/clothing/neck/roguetown/fencerguard/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/neck/roguetown/gorget/forlorncollar
	name = "forlorn collar"
	desc = "A old reminder."
	icon_state = "iwolfcollaralt"

/obj/item/clothing/neck/roguetown/gorget/steel
	name = "steel gorget"
	smeltresult = /obj/item/ingot/steel
	max_integrity = ARMOR_INT_SIDE_STEEL
	icon_state = "sgorget"

/obj/item/clothing/neck/roguetown/gorget/paalloy
	name = "ancient gorget"
	desc = "A gorget made of ancient alloys. Aeon's grasp lifted from its form."
	icon_state = "ancientgorget"
	max_integrity = ARMOR_INT_SIDE_STEEL
	smeltresult = /obj/item/ingot/aaslag

/obj/item/clothing/neck/roguetown/gorget/prisoner/Initialize()
	. = ..()
	name = "cursed collar"
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)

/obj/item/clothing/neck/roguetown/gorget/prisoner/dropped(mob/living/carbon/human/user)
	. = ..()
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/clothing/neck/roguetown/gorget/cursed_collar
	name = "cursed collar"
	desc = "A metal collar that seems to radiate an ominous aura."
	icon_state = "cursed_collar"
	item_state = "cursed_collar"
	armor = ARMOR_CLOTHING
	smeltresult = /obj/item/ingot/iron
	anvilrepair = /datum/skill/craft/armorsmithing
	max_integrity = ARMOR_INT_SIDE_DECREPIT
	resistance_flags = FIRE_PROOF
	slot_flags = ITEM_SLOT_NECK
	body_parts_covered = NECK
	prevent_crits = list()
	blocksound = PLATEHIT

/obj/item/clothing/neck/roguetown/psicross
	name = "psycross"
	desc = "'With every broken bone, I swore I lived!'"
	icon_state = "psycross"
	//dropshrink = 0.75
	resistance_flags = FIRE_PROOF
	slot_flags = ITEM_SLOT_NECK|ITEM_SLOT_HIP|ITEM_SLOT_WRISTS
	sellprice = 10
	experimental_onhip = FALSE
	anvilrepair = /datum/skill/craft/armorsmithing
	grid_width = 32
	grid_height = 32

/obj/item/clothing/neck/roguetown/psicross/mob_can_equip(mob/living/M, mob/living/equipper, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE)
	..()

	if(slot == SLOT_WRISTS)
		mob_overlay_icon = 'icons/roguetown/clothing/onmob/wrists.dmi'
		sleeved = 'icons/roguetown/clothing/onmob/wrists.dmi'
	if(slot == SLOT_NECK)
		mob_overlay_icon = initial(mob_overlay_icon)
		sleeved = initial(sleeved)

	return TRUE

/obj/item/clothing/neck/roguetown/psicross/attack_right(mob/user)
	..()
	user.emote("pray")
	return

/obj/item/clothing/neck/roguetown/psicross/aalloy
	name = "decrepit psicross"
	desc = "Surely this one endures?"
	icon_state = "psycross_a"

/obj/item/clothing/neck/roguetown/zcross/aalloy
	name = "decrepit zcross"
	desc = "A symbol of progress from an era that had reason to believe in it."
	icon_state = "zcross_a"

/obj/item/clothing/neck/roguetown/psicross/astrata
	name = "amulet of Astrata"
	desc = "As sure as the sun rises, tomorrow will come."
	icon_state = "astrata"

/obj/item/clothing/neck/roguetown/psicross/noc
	name = "amulet of Noc"
	desc = "There is always more to know, more to learn, more to be."
	icon_state = "noc"

/obj/item/clothing/neck/roguetown/psicross/abyssor
	name = "amulet of Abyssor"
	desc = "To fear the unknown is to turn away from the greatest mysteries of all."
	icon_state = "abyssor"

/obj/item/clothing/neck/roguetown/psicross/dendor
	name = "amulet of Dendor"
	desc = "If you need something to worship, then worship life. Every last crawling bit of it."
	icon_state = "dendor"

/obj/item/clothing/neck/roguetown/psicross/necra
	name = "amulet of Necra"
	desc = "The certainty of death is a reminder to enjoy the time you have."
	icon_state = "necra"

/obj/item/clothing/neck/roguetown/psicross/pestra
	name = "amulet of Pestra"
	desc = "The healthy wear a crown only the sick can see."
	icon_state = "pestra"

/obj/item/clothing/neck/roguetown/psicross/ravox
	name = "amulet of Ravox"
	desc = "What are you fighting for?"
	icon_state = "ravox"

/obj/item/clothing/neck/roguetown/psicross/malum
	name = "amulet of Malum"
	desc = "From the ashes, creation."
	icon_state = "malum"

/obj/item/clothing/neck/roguetown/psicross/eora
	name = "amulet of Eora"
	desc = "In a world full of horror and hardship, all we have is each other."
	icon_state = "eora"

/obj/item/clothing/neck/roguetown/psicross/wood
	name = "wooden psycross"
	desc = "'A man with nothing can still have faith!'"
	icon_state = "psycross_w"
	item_state = "psycross_w"
	sellprice = 0

/obj/item/clothing/neck/roguetown/psicross/silver
	name = "silver psycross"
	desc = "'The horrors persist, but so do I!'"
	icon_state = "psycross_s"
	item_state = "psycross_s"
	sellprice = 50

/obj/item/clothing/neck/roguetown/psicross/silver/pickup(mob/user)
	..()

	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(!H.mind)
		return
	var/datum/antagonist/vampirelord/V_lord = H.mind.has_antag_datum(/datum/antagonist/vampirelord/)
	var/datum/antagonist/werewolf/W = H.mind.has_antag_datum(/datum/antagonist/werewolf/)
	if(H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
		to_chat(H, span_userdanger("I can't pick up the silver, it is my BANE!"))
		H.Knockdown(20)
		H.adjustFireLoss(60)
		H.Paralyze(20)
		H.fire_act(1,5)
	if(V_lord)
		if(V_lord.vamplevel < 4 && !H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
			to_chat(H, span_userdanger("I can't pick up the silver, it is my BANE!"))
			H.Knockdown(10)
			H.Paralyze(10)
	if(W && W.transformed == TRUE)
		to_chat(H, span_userdanger("I can't equip the silver, it is my BANE!"))
		H.Knockdown(20)
		H.Paralyze(20)

/obj/item/clothing/neck/roguetown/psicross/silver/mob_can_equip(mob/living/M, mob/living/equipper, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE)
	..()

	if(!ishuman(M))
		return FALSE
	var/mob/living/carbon/human/H = M
	if(!H.mind)
		return FALSE
	var/datum/antagonist/vampirelord/V_lord = H.mind.has_antag_datum(/datum/antagonist/vampirelord/)
	var/datum/antagonist/werewolf/W = H.mind.has_antag_datum(/datum/antagonist/werewolf/)
	if(H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
		to_chat(H, span_userdanger("I can't equip the silver, it is my BANE!"))
		H.Knockdown(20)
		H.adjustFireLoss(60)
		H.Paralyze(20)
		H.fire_act(1,5)
		return FALSE
	if(V_lord && V_lord.vamplevel < 4 && !H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
		to_chat(H, span_userdanger("I can't equip the silver, it is my BANE!"))
		H.Knockdown(10)
		H.Paralyze(10)
		return FALSE
	if(W && W.transformed == TRUE)
		to_chat(H, span_userdanger("I can't equip the silver, it is my BANE!"))
		H.Knockdown(20)
		H.Paralyze(20)
		return FALSE

	return TRUE

/obj/item/clothing/neck/roguetown/psicross/g
	name = "golden psycross"
	desc = "'Purity afloat, for paradise awaits!'"
	icon_state = "psycross_g"
	item_state = "psycross_g"
	//dropshrink = 0.75
	resistance_flags = FIRE_PROOF
	sellprice = 100

/obj/item/clothing/neck/roguetown/psicross/pearl //put it as a psycross so it can be used for miracles
	name = "pearl amulet"
	icon_state = "pearlcross"
	desc = "An amulet made of white pearls, usually worn by fishers or sailors."
	sellprice = 80

/obj/item/clothing/neck/roguetown/psicross/bpearl
	name = "blue pearl amulet"
	icon_state = "bpearlcross"
	desc = "An amulet made of rare blue pearls, usually worn by priests and worshippers of Abyssor, or as lucky charms for captains of ships."
	sellprice = 220

/obj/item/clothing/neck/roguetown/psicross/shell
	name = "oyster shell necklace"
	icon_state = "oyster_necklace"
	desc = "A necklace of strung-up sea shells, the calming noise they make when they clack together is reminiscent of a shellfish's claws. They remind you that while men no longer live in water, Abyssor will always remember our origins."
	sellprice = 25

/obj/item/clothing/neck/roguetown/psicross/shell/bracelet
	name = "shell bracelet"
	icon_state = "oyster_bracelet"
	desc = "A beaded bracelet made from sea shells, their rough exterior and glossy interior reminding you that Abyssor's children hide the best gifts at the deepest spots beneath the waves."
	sellprice = 15
	slot_flags = ITEM_SLOT_WRISTS

/obj/item/clothing/neck/roguetown/talkstone
	name = "talkstone"
	desc = "In moments of quiet it whispers softly, as though deciphering the silence itself."
	icon_state = "talkstone"
	item_state = "talkstone"
	//dropshrink = 0.75
	resistance_flags = FIRE_PROOF
	allowed_race = CLOTHED_RACES_TYPES
	sellprice = 70
	anvilrepair = /datum/skill/craft/armorsmithing

/obj/item/clothing/neck/roguetown/horus
	name = "amulet of appraisal"
	desc = "An amulet with a pristine eye embedded into it. Blind to everything, but to that which shines in gold."
	icon_state = "horus"
	//dropshrink = 0.75
	resistance_flags = FIRE_PROOF
	sellprice = 80
	anvilrepair = /datum/skill/craft/armorsmithing

/obj/item/clothing/neck/roguetown/horus/examine()
	. = ..()
	. += span_info("Click on a turf or an item to see how much it is worth. Avoid tables.")

/obj/item/clothing/neck/roguetown/horus/afterattack(atom/A, mob/user, params)
	. = ..()
	var/total_sellprice = 0
	if(isturf(A))
		for(var/obj/item/I in A.contents)
			total_sellprice += I.sellprice
		to_chat(user, span_notice("Everything on the ground is worth [total_sellprice] mammons."))
	else if(istype(A, /obj/item))
		var/obj/item/I = A
		total_sellprice += I.sellprice
		for(var/obj/item/item in I.contents)
			total_sellprice += item.sellprice
		to_chat(user, span_notice("The item and its contents is worth [total_sellprice] mammons."))

/obj/item/clothing/neck/roguetown/shalal
	name = "desert rider medal"
	desc = ""
	icon_state = "shalal"
	//dropshrink = 0.75
	resistance_flags = FIRE_PROOF
	sellprice = 15
	anvilrepair = /datum/skill/craft/armorsmithing

/obj/item/clothing/neck/roguetown/ornateamulet
	name = "Ornate Amulet"
	desc = "A beautiful amulet made of solid gold."
	icon_state = "ornateamulet"
	//dropshrink = 0.75
	resistance_flags = FIRE_PROOF
	sellprice = 100
	anvilrepair = /datum/skill/craft/armorsmithing

/obj/item/clothing/neck/roguetown/ornateamulet/noble
	var/choicename = FALSE
	name = "Heirloom Amulet"
	desc = "An ornate amulet representing a prestigious noble house."
	slot_flags = ITEM_SLOT_NECK|ITEM_SLOT_WRISTS|ITEM_SLOT_HIP
	sellprice = 10

/obj/item/clothing/neck/roguetown/ornateamulet/noble/attack_right(mob/user)
	if(choicename)
		return
	var/current_time = world.time
	var/namechoice = input(user, "Input a new name", "Rename Object")
	if(namechoice)
		name = namechoice
		choicename = TRUE
	else
		return
	if(world.time > (current_time + 30 SECONDS))
		return

/obj/item/clothing/neck/roguetown/skullamulet
	name = "Skull Amulet"
	desc = "Gold shaped into the form of a skull and strung into an amulet."
	icon_state = "skullamulet"
	//dropshrink = 0.75
	resistance_flags = FIRE_PROOF
	sellprice = 100
	anvilrepair = /datum/skill/craft/armorsmithing

/obj/item/clothing/neck/roguetown/psicross/naledi
	name = "naledian psy-bracelet"
	desc = "A peculiar icon of worship from a foreign land. Forming the three-progned Psydonite cross in a circular ring, this bracelet embodies the Naledian belief of Psydon's eternity."
	icon_state = "psybracelet"
	item_state = null

/obj/item/clothing/neck/roguetown/collar
	name = "collar"
	desc = "A band of leather which signifies bondage to another."
	icon_state = "collar"
	item_state = "collar"
	resistance_flags = FIRE_PROOF
	dropshrink = 0.5

/obj/item/clothing/neck/roguetown/collar/forlorn
	name = "light forlorn collar"
	desc = "A old reminder. A lighter version often used more as a status symbol for slaves. Then and now."
	icon_state = "iwolfcollaralt"

/obj/item/clothing/neck/roguetown/collar/bell_collar
	name = "bell collar"
	desc = "A band of leather with a bell that protects the local zads from the local catfolk."
	icon_state = "bell_collar"

/obj/item/clothing/neck/roguetown/collar/bell_collar/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, SFX_JINGLE_BELLS)

/obj/item/clothing/neck/roguetown/collar/feldcollar
	name = "feldcollar"
	desc = "A sturdy collar made of leather, commonly worn by field workers."
	icon_state = "feldcollar"
	item_state = "feldcollar"
	resistance_flags = FIRE_PROOF
	dropshrink = 0.5
	slot_flags = ITEM_SLOT_NECK|ITEM_SLOT_MASK
	body_parts_covered = NECK|FACE

/obj/item/clothing/neck/roguetown/collar/surgcollar
	name = "surgcollar"
	desc = "A specialized collar designed for medical practitioners, with reinforced padding."
	icon_state = "surgcollar"
	item_state = "surgcollar"
	resistance_flags = FIRE_PROOF
	dropshrink = 0.5
	slot_flags = ITEM_SLOT_NECK|ITEM_SLOT_MASK
	body_parts_covered = NECK|FACE

/obj/item/clothing/neck/roguetown/luckcharm
	name = "luck charm"
	desc = "A cabbit's foot necklace. Some say it brings good luck."
	icon_state = "luckcharm"
	sellprice = 15
	slot_flags = ITEM_SLOT_NECK
	var/goodluckactivated = FALSE

/obj/item/clothing/neck/roguetown/luckcharm/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot == SLOT_NECK)
		user.change_stat("fortune", 1) //how much luck stat it gives when equipped
		goodluckactivated = TRUE
	return

/obj/item/clothing/neck/roguetown/luckcharm/dropped(mob/living/carbon/human/user)
	. = ..()
	if(goodluckactivated == TRUE)
		user.change_stat("fortune", -1) //how much luck stat taken away when unequipped
		goodluckactivated = FALSE
	return
