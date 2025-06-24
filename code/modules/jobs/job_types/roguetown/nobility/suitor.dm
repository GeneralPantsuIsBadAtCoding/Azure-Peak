/datum/job/roguetown/suitor
	title = "Suitor"
	flag = SUITOR
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 0
	spawn_positions = 0

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_NO_CONSTRUCT
	advclass_cat_rolls = list(CTAG_CONSORT = 20)
	tutorial = "You are a noble from a foreign court who has travelled to Azure Peak in order to win the hand of Azuria's most eligible bachelor and secure a political ally for your house. Competition is fierce, and it seems you're not the only one vying for the duke's favor..."

	outfit = /datum/outfit/job/roguetown/suitor

	display_order = JDO_SUITOR
	give_bank_account = 40
	noble_income = 20
	min_pq = 3
	max_pq = null
	round_contrib_points = 3
	cmode_music = 'sound/music/combat_noble.ogg'

/datum/job/roguetown/suitor/after_spawn(mob/living/H, mob/M, latejoin)
	. = ..()
	if(ishuman(H))
		var/mob/living/carbon/human/Q = H
		Q.advsetup = 1
		Q.invisibility = INVISIBILITY_MAXIMUM
		Q.become_blind("advsetup")

/datum/outfit/job/roguetown/suitor
	job_bitflag = BITFLAG_ROYALTY

/datum/advclass/suitor/envoy
	name = "Envoy"
	tutorial = "You're a graceful envoy - fluent in flattery, courtesy, and calculated sincerity. You'll charm your way into the Duke's heart, winning favor with warmth, wit, and well-timed smiles."
	outfit = /datum/outfit/job/roguetown/suitor/envoy
	category_tags = list(CTAG_CONSORT)

/datum/outfit/job/roguetown/suitor/envoy/pre_equip(mob/living/carbon/human/H)
	..()
	if(should_wear_femme_clothes(H))
		neck = /obj/item/roguekey/manor
		beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
		belt = /obj/item/storage/belt/rogue/leather/cloth/lady
		head = /obj/item/clothing/head/roguetown/nyle/consortcrown
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gown/wintergown
		backl = /obj/item/rogue/instrument/harp
		beltl = /obj/item/flashlight/flare/torch/lantern
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
		pants = /obj/item/clothing/under/roguetown/tights/stockings/silk/random
		backr = /obj/item/storage/backpack/rogue/satchel
		id = /obj/item/clothing/ring/signet
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
	else if(should_wear_masc_clothes(H))
		head = /obj/item/clothing/head/roguetown/nyle/consortcrown
		pants = /obj/item/clothing/under/roguetown/tights
		armor = /obj/item/clothing/suit/roguetown/shirt/tunic/noblecoat
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/lowcut
		backl = /obj/item/rogue/instrument/lute
		shoes = /obj/item/clothing/shoes/roguetown/boots/nobleboot
		belt = /obj/item/storage/belt/rogue/leather
		neck = /obj/item/roguekey/manor
		beltl = /obj/item/flashlight/flare/torch/lantern
		beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
		backr = /obj/item/storage/backpack/rogue/satchel
		id = /obj/item/clothing/ring/signet
	H.adjust_skillrank(/datum/skill/misc/music, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.change_stat("intelligence", 3)
	H.change_stat("perception", 3)
	H.change_stat("endurance", 1)
	H.change_stat("speed", 1)
	H.change_stat("fortune", 1)
	ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NUTCRACKER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_OUTLANDER, TRAIT_GENERIC)
	if(H.mind)
		var/datum/antagonist/new_antag = new /datum/antagonist/suitor()
		H.mind.add_antag_datum(new_antag)

/datum/advclass/suitor/schemer
	name = "Schemer"
	tutorial = "You're a silver-tongued snake - master of whispers, poison, and perfectly timed accidents. Why win hearts when you can twist them? With rivals removed and secrets weaponized, the Duke will have no choice but to choose you."
	outfit = /datum/outfit/job/roguetown/suitor/schemer
	category_tags = list(CTAG_CONSORT)

/datum/outfit/job/roguetown/suitor/schemer/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)
	H.change_stat("intelligence", 1)
	H.change_stat("perception", 1)
	H.change_stat("endurance", 1)
	H.change_stat("speed", 3)
	H.change_stat("fortune", 1)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_OUTLANDER, TRAIT_GENERIC)
	head = /obj/item/clothing/head/roguetown/nyle/consortcrown
	pants = /obj/item/clothing/under/roguetown/tights/black
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather/heavy
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	shoes = /obj/item/clothing/shoes/roguetown/boots/nobleboot
	belt = /obj/item/storage/belt/rogue/leather/black
	neck = /obj/item/roguekey/manor
	beltl = /obj/item/rogueweapon/huntingknife/idagger/steel
	beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
	backr = /obj/item/storage/backpack/rogue/satchel
	id = /obj/item/clothing/ring/silver
	if(should_wear_femme_clothes(H))
		armor = /obj/item/clothing/suit/roguetown/armor/armordress/winterdress
	if(should_wear_masc_clothes(H))
		armor = /obj/item/clothing/suit/roguetown/armor/longcoat
	backpack_contents = list(/obj/item/reagent_containers/glass/bottle/rogue/poison = 1, /obj/item/lockpick = 1)
	if(H.mind)
		var/datum/antagonist/new_antag = new /datum/antagonist/suitor()
		H.mind.add_antag_datum(new_antag)

/datum/advclass/suitor/gallant
	name = "Gallant"
	tutorial = "With honor and the flash of your steel, you meet your rivals in open challenge. You'll win the Duke's favor not with whispers or warmth, but with roaring applause."
	outfit = /datum/outfit/job/roguetown/suitor/gallant
	category_tags = list(CTAG_CONSORT)

/datum/outfit/job/roguetown/suitor/gallant/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	H.change_stat("strength", 1)
	H.change_stat("intelligence", 2)
	H.change_stat("perception", 1)
	H.change_stat("constutition", 1)
	H.change_stat("endurance", 1)
	H.change_stat("speed", 1)
	H.change_stat("fortune", 1)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_OUTLANDER, TRAIT_GENERIC)
	head = /obj/item/clothing/head/roguetown/nyle/consortcrown
	mask = /obj/item/clothing/head/roguetown/roguehood/shalal/hijab/gallant
	pants = /obj/item/clothing/under/roguetown/tights/black
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather/heavy
	armor = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/otavan
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	shoes = /obj/item/clothing/shoes/roguetown/boots/nobleboot
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/roguekey/manor
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/rogueweapon/sword/sabre/dec
	backr = /obj/item/storage/backpack/rogue/satchel
	id = /obj/item/clothing/ring/silver
	backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/mid = 1)
	if(H.mind)
		var/datum/antagonist/new_antag = new /datum/antagonist/suitor()
		H.mind.add_antag_datum(new_antag)


/obj/item/clothing/head/roguetown/roguehood/shalal/hijab/gallant
	color = "#384d8a"
