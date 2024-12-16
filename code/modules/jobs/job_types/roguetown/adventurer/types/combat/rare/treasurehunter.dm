//dagger and huntknife
/datum/advclass/gravedigger
	name = "Treasure Hunter"
	tutorial = "A treasure hunter trained in the art of the Giza, discern what is treasure or not, your fortune could be hidden anywhere."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/gravedigger
	traits_applied = list(TRAIT_MEDIUMARMOR, TRAIT_SEEPRICES)
	category_tags = list(CTAG_ADVENTURER)


/datum/outfit/job/roguetown/adventurer/gravedigger/pre_equip(mob/living/carbon/human/H)
	..()
	var/classchoice
	H.adjust_blindness(-3)
	H.visible_message(span_info("I contributed into this world, I have been around..."))
	pants = /obj/item/clothing/under/roguetown/tights/black
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	backl = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather
	gloves = /obj/item/clothing/gloves/roguetown/fingerless
	cloak = /obj/item/clothing/cloak/raincloak/mortus
	shoes = /obj/item/clothing/shoes/roguetown/boots
	beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
	backr = /obj/item/rogueweapon/shovel

	var/classes = list("Treasure Hunter","Archeologist")
	classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes
	switch(classchoice)
		if("Treasure Hunter")
			H.set_blindness(0)
			treasurehunterarch(H)
		if("Archeologist")
			H.set_blindness(0)
			archeologistarch(H)


/datum/outfit/job/roguetown/adventurer/gravedigger/proc/treasurehunterarch(mob/living/carbon/human/H)
	head = /obj/item/clothing/head/roguetown/puritan
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail
	beltl = /obj/item/rogueweapon/sword
	belt = /obj/item/storage/belt/rogue/leather
	backpack_contents = list(
					/obj/item/rogueweapon/pick = 1,
					/obj/item/lockpick,
					/obj/item/rogueweapon/huntingknife/idagger/navaja,
					/obj/item/flashlight/flare/torch = 1,
					)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/tracking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)

		H.change_stat("strength", 1)
		H.change_stat("perception", 2)
		H.change_stat("intelligence", 1)
		H.change_stat("speed", 2)
		H.change_stat("endurance", 2)
		H.change_stat("fortune", 3)

/datum/outfit/job/roguetown/adventurer/gravedigger/proc/archeologistarch(mob/living/carbon/human/H)
	head = /obj/item/clothing/head/roguetown/fedora
	beltl = /obj/item/rogueweapon/whip
	belt = /obj/item/storage/belt/rogue/leather
	backpack_contents = list(
				/obj/item/rogueweapon/pick = 1,
				/obj/item/lockpick,
				/obj/item/rogueweapon/huntingknife/idagger/steel,
				/obj/item/flashlight/flare/torch = 1,
				)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/tracking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)

		H.change_stat("strength", 2)
		H.change_stat("perception", 2)
		H.change_stat("intelligence", 3)
		H.change_stat("speed", 1)
