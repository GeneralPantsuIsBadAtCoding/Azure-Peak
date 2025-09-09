/datum/advclass/foreigner
	name = "Roughneck"
	tutorial = "You are a foreign swordsman, carrying nothing but your sword and your skill."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = NON_DWARVEN_RACE_TYPES //roughneck & custodian sprites dont have dwarf variants - adjust if/when a second update comes out with dwarf sprites
	outfit = /datum/outfit/job/roguetown/adventurer/foreigner
	class_select_category = CLASS_CAT_NOMAD
	traits_applied = list(TRAIT_STEELHEARTED)
	category_tags = list(CTAG_ADVENTURER, CTAG_COURTAGENT)
	subclass_languages = list(/datum/language/kazengunese)
	cmode_music = 'sound/music/combat_kazengite.ogg'
	subclass_stats = list(
		STATKEY_STR = 2,
		STATKEY_CON = 2,
		STATKEY_WIL = 1
	)
	subclass_skills = list(
		/datum/skill/combat/swords = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/shields = SKILL_LEVEL_JOURNEYMAN,		//to encourage use of the scabbard as a shield	
		/datum/skill/combat/wrestling = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/swimming = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/sewing = SKILL_LEVEL_APPRENTICE, 			//this shouldn't be enough to allow them to craft shit, rather just repair their prone-to-break armor
	)

/datum/outfit/job/roguetown/adventurer/foreigner/pre_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, span_warning("You are a foreign swordsman, carrying nothing but your sword and your skill."))
	head = /obj/item/clothing/head/roguetown/mentorhat
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/eastpants1
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/eastshirt1
	armor = /obj/item/clothing/suit/roguetown/armor/basiceast
	shoes = /obj/item/clothing/shoes/roguetown/boots
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltr = /obj/item/rogueweapon/scabbard/sword/kazengun
	beltl = /obj/item/rogueweapon/sword/sabre/mulyeog
	belt = /obj/item/storage/belt/rogue/leather/black
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
		/obj/item/recipe_book/survival = 1,
		/obj/item/flashlight/flare/torch/lantern,
		)
	H.set_blindness(0)

/datum/advclass/foreigner/custodian
	name = "Custodian"
	tutorial = "You are an ex-guardian, whenever that be for a petty noble, or a small shrine. You excel in defense with quarterstaffs, or have taken up the Naginata's offensive martial capabilities."
	allowed_races = NON_DWARVEN_RACE_TYPES //roughneck & custodian sprites dont have dwarf variants - adjust if/when a second update comes out with dwarf sprites
	outfit = /datum/outfit/job/roguetown/adventurer/custodian
	subclass_languages = list(/datum/language/kazengunese)
	cmode_music = 'sound/music/combat_kazengite.ogg'
	subclass_stats = list(
		STATKEY_STR = 2,
		STATKEY_CON = 2,
		STATKEY_WIL = 1
	)
	subclass_skills = list(
		/datum/skill/combat/polearms = SKILL_LEVEL_EXPERT,		
		/datum/skill/combat/wrestling = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/swimming = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/sewing = SKILL_LEVEL_APPRENTICE,
	)

/datum/outfit/job/roguetown/adventurer/custodian/pre_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, span_warning("You are an ex-guardian, whenever that be for a petty noble, or a small shrine. You excel in defense with quarterstaffs, or have taken up the Naginata's offensive martial capabilities."))
	head = /obj/item/clothing/head/roguetown/mentorhat
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/eastpants1
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/eastshirt2
	armor = /obj/item/clothing/suit/roguetown/armor/basiceast/mentorsuit
	shoes = /obj/item/clothing/shoes/roguetown/boots
	belt = /obj/item/storage/belt/rogue/leather/
	beltl = /obj/item/flashlight/flare/torch/lantern
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/recipe_book/survival = 1)
	H.set_blindness(0)
	var/weapons = list("Naginata","Quarterstaff")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	switch(weapon_choice)
		if("Naginata")
			r_hand = /obj/item/rogueweapon/spear/naginata
		if("Quarterstaff")
			backr = /obj/item/rogueweapon/woodstaff/quarterstaff/steel

/datum/advclass/foreigner/yoruku
	name = "Yoruku"
	tutorial = "You are a Kazengunese agent trained in assassination, sabotage, and irregular combat. You are armed with daggers or a short sword, perfect \
	for combat in the tight confines of castles and back alleys."
	allowed_races = NON_DWARVEN_RACE_TYPES //roughneck & custodian sprites dont have dwarf variants - adjust if/when a second update comes out with dwarf sprites
	outfit = /datum/outfit/job/roguetown/adventurer/yoruku
	subclass_languages = list(/datum/language/kazengunese)
	cmode_music = 'sound/music/combat_kazengite.ogg'
	traits_applied = list(TRAIT_STEELHEARTED, TRAIT_DODGEEXPERT)
	subclass_stats = list(
		STATKEY_SPD = 3,
		STATKEY_PER = 1,
		STATKEY_WIL = 1,
	)
	subclass_skills = list(
		/datum/skill/misc/climbing = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/tracking = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/swimming = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/wrestling = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/sneaking = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/lockpicking = SKILL_LEVEL_APPRENTICE,
	)

/datum/outfit/job/roguetown/adventurer/yoruku/pre_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, span_warning("You are a Kazengunese agent trained in assassination, sabotage, and irregular combat. You are armed with daggers or a short sword, perfect \
	for combat in the tight confines of castles and back alleys."))
	head = /obj/item/clothing/head/roguetown/roguehood/shalal/hijab/yoruku
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
		/obj/item/flashlight/flare/torch = 1,
		/obj/item/recipe_book/survival = 1,
		/obj/item/smokebomb = 3,
		)
	belt = /obj/item/storage/belt/rogue/leather/knifebelt/black/kazengun
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/eastpants1
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/eastshirt1
	cloak = /obj/item/clothing/cloak/thief_cloak/yoruku
	shoes = /obj/item/clothing/shoes/roguetown/boots
	H.set_blindness(0)
	var/weapons = list("Tanto","Kodachi")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	switch(weapon_choice)
		if("Tanto")
			beltr = /obj/item/rogueweapon/huntingknife/idagger/steel/kazengun
			beltl = /obj/item/rogueweapon/scabbard/sheath/kazengun
			H.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
		if("Kodachi")
			beltr = /obj/item/rogueweapon/sword/short/kazengun
			beltl = /obj/item/rogueweapon/scabbard/sword/kazengun/kodachi
			H.adjust_skillrank_up_to(/datum/skill/combat/swords, 4, TRUE)
	var/masks = list("Oni","Kitsune")
	var/mask_choice = input("Choose your mask.", "HIDE YOURSELF") as anything in masks
	switch(mask_choice)
		if("Oni")
			mask = /obj/item/clothing/mask/rogue/facemask/yoruku_oni
		if("Kitsune")
			mask = /obj/item/clothing/mask/rogue/facemask/yoruku_kitsune
