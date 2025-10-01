/datum/job/roguetown/puritan
	title = "Inquisitor"
	flag = PURITAN
	department_flag = INQUISITION
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_NO_CONSTRUCT		//Not been around long enough to be inquisitor, brand new race to the world.
	allowed_patrons = list(/datum/patron/old_god) //You MUST have a Psydonite character to start. Just so people don't get japed into Oops Suddenly Psydon!
	tutorial = "You have been sent here as a diplomatic envoy from the Sovereignty of Otava: a silver-tipped olive branch, unmatched in aptitude and unshakable in faith. Though you might be ostracized due to your Psydonic beliefs, neither the Church nor Crown can deny your value, whenever matters of inhumenity arise to threaten this fief."
	whitelist_req = TRUE
	cmode_music = 'sound/music/inquisitorcombat.ogg'
	selection_color = JCOLOR_INQUISITION

	outfit = /datum/outfit/job/roguetown/puritan
	display_order = JDO_PURITAN
	advclass_cat_rolls = list(CTAG_PURITAN = 20)
	give_bank_account = 30
	min_pq = 10
	max_pq = null
	round_contrib_points = 2
	job_subclasses = list(
		/datum/advclass/puritan/inspector,
		/datum/advclass/puritan/ordinator
	)

/datum/outfit/job/roguetown/puritan
	name = "Inquisitor"
	jobtype = /datum/job/roguetown/puritan
	job_bitflag = BITFLAG_CHURCH	//Counts as church.
	allowed_patrons = list(/datum/patron/old_god)

////Classic Inquisitor with a much more underground twist. Use listening devices, sneak into places to gather evidence, track down suspicious individuals. Has relatively the same utility stats as Confessor, but fulfills a different niche in terms of their combative job as the head honcho. 

/datum/advclass/puritan/inspector
	name = "Inquisitor"
	tutorial = "Investigators from countless backgrounds, personally chosen by the High Bishop of the Otavan Sovereignty to root out heresy all across the world. Dressed in fashionable leathers and armed with a plethora of equipment, these beplumed officers are ready to tackle the inhumen: anywhere, anytime. Ideal for those who prefer sleuthy-and-clandestine affairs."
	outfit = /datum/outfit/job/roguetown/puritan/inspector
	subclass_languages = list(/datum/language/otavan)
	category_tags = list(CTAG_PURITAN)
	traits_applied = list(
		TRAIT_STEELHEARTED,
		TRAIT_DODGEEXPERT,
		TRAIT_MEDIUMARMOR,
		TRAIT_BLACKBAGGER,
		TRAIT_SILVER_BLESSED,
		TRAIT_INQUISITION,
		TRAIT_PERFECT_TRACKER,
		TRAIT_PURITAN,
		TRAIT_OUTLANDER
		)
	subclass_stats = list(
		STATKEY_CON = 3,
		STATKEY_PER = 3,
		STATKEY_INT = 3,
		STATKEY_STR = 2,
		STATKEY_WIL = 2,
		STATKEY_SPD = 1,
	)
	subclass_skills = list(
		/datum/skill/misc/lockpicking = SKILL_LEVEL_MASTER,
		/datum/skill/misc/tracking = SKILL_LEVEL_MASTER,
		/datum/skill/misc/sneaking = SKILL_LEVEL_MASTER,
		/datum/skill/combat/knives = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/climbing = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/athletics = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/crossbows = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/wrestling = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/reading = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/medicine = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/sewing = SKILL_LEVEL_APPRENTICE,
	)
	subclass_stashed_items = list(
		"Of Psydon" = /obj/item/book/rogue/bibble/psy
	)

/datum/outfit/job/roguetown/puritan/inspector/pre_equip(mob/living/carbon/human/H)
	..()
	has_loadout = TRUE
	H.verbs |= /mob/living/carbon/human/proc/faith_test
	H.verbs |= /mob/living/carbon/human/proc/torture_victim
	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_miracles(H, cleric_tier = CLERIC_T1, passive_gain = CLERIC_REGEN_WEAK, devotion_limit = CLERIC_REQ_1) //Capped to T1 miracles.
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/inq
	belt = /obj/item/storage/belt/rogue/leather/knifebelt/black/psydon
	neck = /obj/item/clothing/neck/roguetown/gorget/steel
	shoes = /obj/item/clothing/shoes/roguetown/boots/otavan/inqboots
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/otavan
	backr =  /obj/item/storage/backpack/rogue/satchel/otavan
	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	beltr = /obj/item/quiver/bolts
	head = /obj/item/clothing/head/roguetown/inqhat
	mask = /obj/item/clothing/mask/rogue/spectacles/inq/spawnpair
	gloves = /obj/item/clothing/gloves/roguetown/otavan/psygloves
	wrists = /obj/item/clothing/neck/roguetown/psicross/silver
	id = /obj/item/clothing/ring/signet/silver
	armor = /obj/item/clothing/suit/roguetown/armor/plate/scale/inqcoat
	backpack_contents = list(
		/obj/item/storage/keyring/puritan = 1,
		/obj/item/lockpickring/mundane = 1,
		/obj/item/rogueweapon/huntingknife/idagger/silver/psydagger,
		/obj/item/clothing/head/inqarticles/blackbag = 1,
		/obj/item/inqarticles/garrote = 1,
		/obj/item/rope/inqarticles/inquirycord = 1,
		/obj/item/grapplinghook = 1,
		/obj/item/storage/belt/rogue/pouch/coins/rich = 1,
		/obj/item/paper/inqslip/arrival/inq = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1
		)


/datum/outfit/job/roguetown/puritan/inspector/choose_loadout(mob/living/carbon/human/H)
	. = ..()
	var/weapons = list("Eucharist (Rapier)", "Daybreak (Whip)", "Stigmata (Halberd)")
	var/weapon_choice = input(H,"CHOOSE YOUR RELIQUARY PIECE.", "WIELD THEM IN HIS NAME.") as anything in weapons
	switch(weapon_choice)
		if("Eucharist (Rapier)")
			H.put_in_hands(new /obj/item/rogueweapon/sword/rapier/psy/relic(H), TRUE)
			H.equip_to_slot_or_del(new /obj/item/rogueweapon/scabbard/sword, SLOT_BELT_L, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/swords, 4, TRUE)
		if("Daybreak (Whip)")
			H.put_in_hands(new /obj/item/rogueweapon/whip/antique/psywhip(H), TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/whipsflails, 4, TRUE)
		if("Stigmata (Halberd)")
			H.put_in_hands(new /obj/item/rogueweapon/halberd/psyhalberd/relic(H), TRUE)
			H.put_in_hands(new /obj/item/rogueweapon/scabbard/gwstrap(H), TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/polearms, 4, TRUE)


///The dirty, violent side of the Inquisition. Meant for confrontational, conflict-driven situations as opposed to simply sneaking around and asking questions. Templar with none of the miracles, but with all the muscles and more. 

/datum/advclass/puritan/ordinator
	name = "Ordinator"
	tutorial = "Adjudicators who - through valor and martiality - have proven themselves to be champions in all-but-name. Now, they have been personally chosen by the High Bishop of the Otavan Sovereignty for a mission-most-imperative: to hunt down and destroy the monsters threatening this fief. Ideal for those who prefer overt-and-chivalrous affairs."
	outfit = /datum/outfit/job/roguetown/puritan/ordinator
	subclass_languages = list(/datum/language/otavan)
	cmode_music = 'sound/music/combat_inqordinator.ogg'

	category_tags = list(CTAG_PURITAN)
	traits_applied = list(
		TRAIT_STEELHEARTED,
		TRAIT_HEAVYARMOR,
		TRAIT_BLACKBAGGER,
		TRAIT_SILVER_BLESSED,
		TRAIT_INQUISITION,
		TRAIT_PURITAN,
		TRAIT_OUTLANDER
		)
	subclass_stats = list(
		STATKEY_CON = 3,
		STATKEY_WIL = 3,
		STATKEY_INT = 2,
		STATKEY_STR = 2,
		STATKEY_PER = 2
	)
	subclass_skills = list(
		/datum/skill/misc/climbing = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/athletics = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/wrestling = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/unarmed = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/reading = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/medicine = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/tracking = SKILL_LEVEL_MASTER,
	)
	subclass_stashed_items = list(
		"Of Psydon" = /obj/item/book/rogue/bibble/psy
	)

/datum/outfit/job/roguetown/puritan/ordinator/pre_equip(mob/living/carbon/human/H)
	..()
	has_loadout = TRUE
	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_miracles(H, cleric_tier = CLERIC_T1, passive_gain = CLERIC_REGEN_WEAK, devotion_limit = CLERIC_REQ_1) //Capped to T1 miracles.
	H.verbs |= /mob/living/carbon/human/proc/faith_test
	H.verbs |= /mob/living/carbon/human/proc/torture_victim
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/inq
	armor = /obj/item/clothing/suit/roguetown/armor/plate/full/fluted/ornate/ordinator
	belt = /obj/item/storage/belt/rogue/leather/steel/tasset
	neck = /obj/item/clothing/neck/roguetown/gorget/steel
	shoes = /obj/item/clothing/shoes/roguetown/boots/otavan/inqboots
	backl = /obj/item/storage/backpack/rogue/satchel/otavan
	wrists = /obj/item/clothing/neck/roguetown/psicross/silver
	id = /obj/item/clothing/ring/signet/silver
	pants = /obj/item/clothing/under/roguetown/platelegs
	cloak = /obj/item/clothing/cloak/ordinatorcape
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
	head = /obj/item/clothing/head/roguetown/helmet/heavy/ordinatorhelm
	gloves = /obj/item/clothing/gloves/roguetown/otavan/psygloves
	backpack_contents = list(
		/obj/item/storage/keyring/puritan = 1,
		/obj/item/paper/inqslip/arrival/inq = 1
		)

/datum/outfit/job/roguetown/puritan/ordinator/choose_loadout(mob/living/carbon/human/H)
	. = ..()
	var/weapons = list("Covenant And Creed (Broadsword + Shield)", "Covenant and Consecratia (Flail + Shield)", "Apocrypha (Greatsword) and a Silver Dagger")
	var/weapon_choice = input(H,"CHOOSE YOUR RELIQUARY PIECE.", "WIELD THEM IN HIS NAME.") as anything in weapons
	switch(weapon_choice)
		if("Covenant And Creed (Broadsword + Shield)")
			H.put_in_hands(new /obj/item/rogueweapon/greatsword/bsword/psy/relic(H), TRUE)
			H.put_in_hands(new /obj/item/paper/inqslip/arrival/inq(H), TRUE)
			H.equip_to_slot_or_del(new /obj/item/rogueweapon/shield/tower/metal/psy, SLOT_BACK_R, TRUE)
			var/annoyingbag = H.get_item_by_slot(SLOT_BACK_L)
			qdel(annoyingbag)
			H.equip_to_slot(new /obj/item/rogueweapon/scabbard/gwstrap, SLOT_BACK_L, TRUE)
			H.equip_to_slot_or_del(new /obj/item/storage/keyring/puritan, SLOT_BELT_L, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/swords, 5, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/shields, 4, TRUE)
		if("Covenant and Consecratia (Flail + Shield)")
			H.put_in_hands(new /obj/item/rogueweapon/flail/sflail/psyflail/relic(H), TRUE)
			H.equip_to_slot_or_del(new /obj/item/rogueweapon/shield/tower/metal/psy, SLOT_BACK_R, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/whipsflails, 5, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/shields, 4, TRUE)
		if("Apocrypha (Greatsword) and a Silver Dagger")
			H.put_in_hands(new /obj/item/rogueweapon/greatsword/psygsword/relic(H), TRUE)
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/silver/psydagger(H), TRUE)
			H.equip_to_slot_or_del(new /obj/item/rogueweapon/scabbard/gwstrap, SLOT_BACK_R, TRUE)
			H.equip_to_slot_or_del(new /obj/item/rogueweapon/scabbard/sheath, SLOT_BELT_L, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/swords, 5, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)


/obj/item/clothing/gloves/roguetown/chain/blk
		color = CLOTHING_GREY

/obj/item/clothing/under/roguetown/chainlegs/blk
		color = CLOTHING_GREY

/obj/item/clothing/suit/roguetown/armor/plate/blk
		color = CLOTHING_GREY

/obj/item/clothing/shoes/roguetown/boots/armor/blk
		color = CLOTHING_GREY

/mob/living/carbon/human/proc/faith_test()
	set name = "Test Faith"
	set category = "Inquisition"
	var/obj/item/grabbing/I = get_active_held_item()
	var/mob/living/carbon/human/H
	var/obj/item/S = get_inactive_held_item()
	var/found = null
	if(!istype(I) || !ishuman(I.grabbed))
		to_chat(src, span_warning("I don't have a victim in my hands!"))
		return
	H = I.grabbed
	if(H == src)
		to_chat(src, span_warning("I already torture myself."))
		return
	if (!H.restrained())
		to_chat(src, span_warning ("My victim needs to be restrained in order to do this!"))
		return
	if(!istype(S, /obj/item/clothing/neck/roguetown/psicross/silver))
		to_chat(src, span_warning("I need to be holding a silver psycross to extract this divination!"))
		return
	for(var/obj/structure/fluff/psycross/N in oview(5, src))
		found = N
	if(!found)
		to_chat(src, span_warning("I need a large psycross structure nearby to extract this divination!"))	
		return
	if(!H.stat)
		var/static/list/faith_lines = list(
			"DO YOU DENY THE ALLFATHER?",
			"WHO IS YOUR GOD?",
			"ARE YOU FAITHFUL?",
			"WHO IS YOUR SHEPHERD?",
		)
		src.visible_message(span_warning("[src] shoves the silver psycross in [H]'s face!"))
		say(pick(faith_lines), spans = list("torture"))
		H.emote("agony", forced = TRUE)

		if(!(do_mob(src, H, 10 SECONDS)))
			return
		src.visible_message(span_warning("[src]'s silver psycross abruptly catches flame, burning away in an instant!"))
		H.confess_sins("patron")
		qdel(S)
		return
	to_chat(src, span_warning("This one is not in a ready state to be questioned..."))

/mob/living/carbon/human/proc/confess_sins(confession_type = "antag")
	var/static/list/innocent_lines = list(
		"I AM NO SINNER!",
		"I'M INNOCENT!",
		"I HAVE NOTHING TO CONFESS!",
		"I AM FAITHFUL!",
	)
	var/list/confessions = list()
	switch(confession_type)
		if("patron")
			if(length(patron?.confess_lines))
				confessions += patron.confess_lines
		if("antag")
			for(var/datum/antagonist/antag in mind?.antag_datums)
				if(!length(antag.confess_lines))
					continue
				confessions += antag.confess_lines
	if(length(confessions))
		say(pick(confessions), spans = list("torture"))
		return
	say(pick(innocent_lines), spans = list("torture"))

/mob/living/carbon/human/proc/torture_victim()
	set name = "Reveal Allegiance"
	set category = "Inquisition"
	var/obj/item/grabbing/I = get_active_held_item()
	var/mob/living/carbon/human/H
	var/obj/item/S = get_inactive_held_item()
	var/found = null
	if(!istype(I) || !ishuman(I.grabbed))
		to_chat(src, span_warning("I don't have a victim in my hands!"))
		return
	H = I.grabbed
	if(H == src)
		to_chat(src, span_warning("I already torture myself."))
		return
	if (!H.restrained())
		to_chat(src, span_warning ("My victim needs to be restrained in order to do this!"))
		return
	if(!istype(S, /obj/item/clothing/neck/roguetown/psicross/silver))
		to_chat(src, span_warning("I need to be holding a silver psycross to extract this divination!"))
		return
	for(var/obj/structure/fluff/psycross/N in oview(5, src))
		found = N
	if(!found)
		to_chat(src, span_warning("I need a large psycross structure nearby to extract this divination!"))
		return	
	if(!H.stat)
		var/static/list/torture_lines = list(
			"CONFESS!",
			"TELL ME YOUR SECRETS!",
			"SPEAK!",
			"YOU WILL SPEAK!",
			"TELL ME!",
		)
		say(pick(torture_lines), spans = list("torture"))
		H.emote("agony", forced = TRUE)

		if(!(do_mob(src, H, 10 SECONDS)))
			return
		src.visible_message(span_warning("[src]'s silver psycross abruptly catches flame, burning away in an instant!"))
		H.confess_sins("antag")
		qdel(S)
		return
	to_chat(src, span_warning("This one is not in a ready state to be questioned..."))
