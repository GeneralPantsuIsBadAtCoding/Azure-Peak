/datum/advclass/psyalmist
	name = "Psyalmist"
	tutorial = "You were a bard once - but you've found a new calling. Your eyes have been opened to the divine, now you wander from city to city singing songs and telling tales of your patron's greatness."
	outfit = /datum/outfit/job/roguetown/psyalmist
	traits_applied = list(TRAIT_DODGEEXPERT, TRAIT_EMPATH)
	category_tags = list(CTAG_INQUISITION)
	subclass_languages = list(/datum/language/otavan)
	subclass_stats = list(
		STATKEY_STR = 1,
		STATKEY_WIL = 2,
		STATKEY_SPD = 3,
	)
	subclass_skills = list(
		/datum/skill/misc/music = SKILL_LEVEL_MASTER,
		/datum/skill/magic/holy = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/knives = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/wrestling = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/unarmed = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/swimming = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/athletics = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/reading = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/medicine = SKILL_LEVEL_APPRENTICE
	)
	subclass_stashed_items = list(
		"Of Psydon" = /obj/item/book/rogue/bibble/psy
	)
	
/datum/outfit/job/roguetown/psyalmist/pre_equip(mob/living/carbon/human/H)
	armor = /obj/item/clothing/suit/roguetown/armor/leather/studded/psyalmist
	backl = /obj/item/storage/backpack/rogue/satchel/otavan
	cloak = /obj/item/clothing/cloak/psyalmist
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/inq
	gloves = /obj/item/clothing/gloves/roguetown/otavan/psygloves
	wrists = /obj/item/clothing/neck/roguetown/psicross/silver
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/otavan
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather/knifebelt/black/psydon
	beltr = /obj/item/rogueweapon/huntingknife/idagger/silver/psydagger
	beltl = /obj/item/storage/belt/rogue/pouch/coins/mid
	id = /obj/item/clothing/ring/signet/silver
	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_miracles(H, cleric_tier = CLERIC_T2, passive_gain = CLERIC_REGEN_MINOR, devotion_limit = CLERIC_REQ_2)	//Capped to T2 miracles.
	var/datum/inspiration/I = new /datum/inspiration(H)
	I.grant_inspiration(H, bard_tier = BARD_T2)
	backpack_contents = list(/obj/item/roguekey/inquisition = 1,
	/obj/item/paper/inqslip/arrival/ortho = 1)


	H.cmode_music = 'sound/music/cmode/adventurer/combat_outlander3.ogg'
	H.mind?.AddSpell(new /obj/effect/proc_holder/spell/invoked/mockery)
	if(H.mind)
		var/weapons = list("Harp","Lute","Accordion","Guitar","Hurdy-Gurdy","Viola","Vocal Talisman")
		var/weapon_choice = input(H, "Choose your instrument.", "TAKE UP ARMS") as anything in weapons
		H.set_blindness(0)
		switch(weapon_choice)
			if("Harp")
				backr = /obj/item/rogue/instrument/harp
			if("Lute")
				backr = /obj/item/rogue/instrument/lute
			if("Accordion")
				backr = /obj/item/rogue/instrument/accord
			if("Guitar")
				backr = /obj/item/rogue/instrument/guitar
			if("Hurdy-Gurdy")
				backr = /obj/item/rogue/instrument/hurdygurdy
			if("Viola")
				backr = /obj/item/rogue/instrument/viola
			if("Vocal Talisman")
				backr = /obj/item/rogue/instrument/vocals


/datum/outfit/job/roguetown/psyalmist
	job_bitflag = BITFLAG_CHURCH
