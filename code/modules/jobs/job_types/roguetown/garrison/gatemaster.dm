/datum/job/roguetown/gatemaster
	title = "Gatemaster"
	f_title = "Gatemistress"
	flag = GATEMASTER
	department_flag = GARRISON
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	allowed_patrons = ALL_DIVINE_PATRONS
	tutorial = "Tales speak of the Gatemaster's legendary ability to stand still at a gate and ask people questions. Noble or commoner, you fill the same boots. To keep the Court and its Courtiers safe."
	display_order = JDO_GATEMASTER

	outfit = /datum/outfit/job/roguetown/gatemaster
	advclass_cat_rolls = list(CTAG_GATEMASTER = 20)
	give_bank_account = 3
	min_pq = 3	//idk same as MAA why not
	max_pq = null
	round_contrib_points = 2

	cmode_music = 'sound/music/combat_guard2.ogg'

/datum/job/roguetown/gatemaster/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.cloak, /obj/item/clothing/cloak/stabard/surcoat/guard))
			var/obj/item/clothing/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name = "gatemaster jupon ([index])"
			
/datum/outfit/job/roguetown/gatemaster
	name = "Gatemaster"
	jobtype = /datum/job/roguetown/gatemaster

/datum/outfit/job/roguetown/gatemaster/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/roguehood/red
	neck = /obj/item/clothing/neck/roguetown/gorget
	cloak = /obj/item/clothing/cloak/stabard/surcoat/guard
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	pants = /obj/item/clothing/under/roguetown/chainlegs
	gloves = /obj/item/clothing/gloves/roguetown/leather
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	belt = /obj/item/storage/belt/rogue/leather/black
	backr = /obj/item/storage/backpack/rogue/satchel/black
	backpack_contents = list(/obj/item/storage/keyring/guardcastle = 1, /obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/rope/chain = 1)
	if(H.mind)		//Stuff here is universal. Some skills are what will differ.
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("perception", 2)
		H.change_stat("constitution", 1)
	H.verbs |= /mob/proc/haltyell
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)	//Only medium because otherwise you could be a bootleg RG. Sorry, nobles, you're not getting that.
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_GUARDSMAN, TRAIT_GENERIC)	//They get this in exchange for slightly lower over-all stats, because we want them in the keep.

// Man-at-Arms Gatemaster - Shares skill-stats similar to MAA, mostly in maces and sling
/datum/advclass/gatemaster/manatarms
	name = "Men-at-Arms Gatemaster"
	tutorial = "You are a member of the Men-at-Arms, this week assigned to handling the gate. You're not expected to handle calls to aid those in town, or elsewhere, unless directly requested."
	outfit = /datum/outfit/job/roguetown/gatemaster/manatarms

	category_tags = list(CTAG_GATEMASTER)

/datum/outfit/job/roguetown/gatemaster/manatarms/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)			//Your main skill for this. Equal to MAA.
	H.mind.adjust_skillrank(/datum/skill/combat/slings, 4, TRUE)		//Low bow skill to avoid being too aggressive, but good sling skill so - works.
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)	
	H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)		//Noble one gets better swords.

	shoes = /obj/item/clothing/shoes/roguetown/boots
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/rogueweapon/mace/cudgel
	beltr = /obj/item/quiver/sling/iron
	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/sling

// Royal Guard / Courtier Gatemaster - Shares skill-stats similar to Royal Guard, mostly in sword and bows
/datum/advclass/gatemaster/noble
	name = "Noble Gatemaster"
	tutorial = "Perhaps you are a royal guard assigned to see to gate duties, or a courtier unlucky enough to be forced to do so. Your post may not be as noble as you, but you serve your purpose."
	outfit = /datum/outfit/job/roguetown/gatemaster/noble

	category_tags = list(CTAG_GATEMASTER)

/datum/outfit/job/roguetown/gatemaster/noble/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)		//Your main skill for this. Equal to MAA.
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)			//Still not great bow skill but stops aggression. Defense still good.
	H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)	

	shoes = /obj/item/clothing/shoes/roguetown/nobleboot	//Very slightly better than normal but - I guess drip.
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/rogueweapon/sword
	beltr = /obj/item/quiver/arrows
	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)				//Nobleman at da gate, what he gonna do???
