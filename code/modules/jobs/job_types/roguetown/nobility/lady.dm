/datum/job/roguetown/lady
	title = "Consort"
	flag = LADY
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_NO_CONSTRUCT
	tutorial = "Picked out of your political value rather than likely any form of love, you have become the Grand Duke's most trusted confidant--and likely friend--throughout your marriage. Your loyalty and perhaps even your love will be tested this day... for the daggers that threaten your beloved are as equally pointed at your own throat."

	spells = list(/obj/effect/proc_holder/spell/self/convertrole/servant,
	/obj/effect/proc_holder/spell/self/grant_nobility)
	outfit = /datum/outfit/job/roguetown/lady

	display_order = JDO_LADY
	give_bank_account = 50
	noble_income = 22
	min_pq = 5
	max_pq = null
	round_contrib_points = 3

/datum/job/roguetown/exlady //just used to change the ladys title
	title = "Consort Dowager"
	flag = LADY
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	display_order = JDO_LADY
	give_bank_account = TRUE

/datum/outfit/job/roguetown/lady
	job_bitflag = BITFLAG_ROYALTY

/datum/outfit/job/roguetown/lady/pre_equip(mob/living/carbon/human/H)
	. = ..()
	ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NUTCRACKER, TRAIT_GENERIC)
//		SSticker.rulermob = H
	if(should_wear_femme_clothes(H))
		beltl = /obj/item/storage/keyring/royal
		neck = /obj/item/storage/belt/rogue/pouch/coins/rich
		belt = /obj/item/storage/belt/rogue/leather/cloth/lady
		head = /obj/item/clothing/head/roguetown/nyle/consortcrown
		shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/winterdress
		pants = /obj/item/clothing/under/roguetown/tights/stockings/silk/random	//Added Silk Stockings for the female nobles
		id = /obj/item/scomstone/garrison
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
	else if(should_wear_masc_clothes(H))
		head = /obj/item/clothing/head/roguetown/nyle/consortcrown
		pants = /obj/item/clothing/under/roguetown/tights
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/guard
		armor = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
		belt = /obj/item/storage/belt/rogue/leather
		beltl = /obj/item/storage/keyring/royal
		beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
		backr = /obj/item/storage/backpack/rogue/satchel
		id = /obj/item/clothing/ring/silver
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.change_stat("intelligence", 3)
		H.change_stat("endurance", 3)
		H.change_stat("speed", 2)
		H.change_stat("perception", 2)
		H.change_stat("fortune", 5)

/obj/effect/proc_holder/spell/self/convertrole/servant
	name = "Recruit Servant"
	new_role = "Servant"
	overlay_state = "recruit_servant"
	recruitment_faction = "Servants"
	recruitment_message = "Serve the crown, %RECRUIT!"
	accept_message = "FOR THE CROWN!"
	refuse_message = "I refuse."
	recharge_time = 100

/obj/effect/proc_holder/spell/self/convertrole/mercenary
	name = "Recruit Mercenary"
	new_role = "Mercenary"
	recruitment_faction = "MERCENARIES"
	recruitment_message = "Serve the Guild, %RECRUIT!"
	accept_message = "FOR THE GUILD!"
	refuse_message = "I refuse."
	recharge_time = 100

/obj/effect/proc_holder/spell/self/convertrole/bog
	name = "Recruit Warden"
	new_role = "Warden"
	recruitment_faction = "Bog Guard"
	recruitment_message = "Serve the Wardens, %RECRUIT!"
	accept_message = "FOR THE GROVE!"
	refuse_message = "I refuse."
