/datum/advclass/hunter
	name = "Hunter"
	tutorial = "You are a hunter. With your bow you hunt the fauna of the glade, skinning what you kill and cooking any meat left over. The job is dangerous but important in the circulation of clothing and light armor."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/hunter
	cmode_music = 'sound/music/cmode/towner/combat_towner2.ogg'
	
	category_tags = list(CTAG_PILGRIM, CTAG_TOWNER)
	classes = list("Spearhunter" = "You are a hunter who specializes in spears, excelling in strength and endurance.",
					"Bowman" = "You are a hunter who uses a bow, excelling in speed and perception.")

/datum/outfit/job/roguetown/adventurer/hunter/pre_equip(mob/living/carbon/human/H)
	..()
	var/classes = list("Bowman","Spearhunter")
	var/classchoice = input("Choose your archetype", "Available archetypes") as anything in classes

	switch(classchoice)
		if("Spearhunter")
			to_chat(H, span_warning("You are a hunter who specializes in spears, excelling in strength and endurance."))
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/light
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
			shoes = /obj/item/clothing/shoes/roguetown/boots/furlinedboots
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
			backr = /obj/item/rogueweapon/scabbard/gwstrap
			backl = /obj/item/storage/backpack/rogue/backpack
			belt = /obj/item/storage/belt/rogue/leather
			beltr = /obj/item/storage/meatbag
			beltl = /obj/item/flashlight/flare/torch/lantern
			l_hand = /obj/item/rogueweapon/spear
			backpack_contents = list(
						/obj/item/flint = 1,
						/obj/item/bait = 1,
						/obj/item/rogueweapon/huntingknife = 1,
						/obj/item/recipe_book/survival = 1,
						/obj/item/recipe_book/leatherworking = 1,
						/obj/item/rogueweapon/scabbard/sheath = 1
						)
			gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
			ADD_TRAIT(H, TRAIT_OUTDOORSMAN, TRAIT_GENERIC)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
			H.adjust_skillrank(/datum/skill/craft/tanning, 3, TRUE)
			H.adjust_skillrank(/datum/skill/labor/fishing, 1, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
			H.adjust_skillrank(/datum/skill/labor/butchering, 3, TRUE)
			H.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
			H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.adjust_skillrank(/datum/skill/misc/tracking, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.change_stat(STATKEY_STR, 2)
			H.change_stat(STATKEY_CON, 1)
			H.change_stat(STATKEY_WIL, 1)
			H.cmode_music = 'sound/music/cmode/towner/combat_towner2.ogg'
			return
		if("Bowman")
			pants = /obj/item/clothing/under/roguetown/trou/artipants
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/lowcut
			shoes = /obj/item/clothing/shoes/roguetown/boots/leather
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
			backr = /obj/item/storage/backpack/rogue/satchel
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
			belt = /obj/item/storage/belt/rogue/leather
			beltr = /obj/item/quiver/arrows
			beltl = /obj/item/rogueweapon/scabbard/sword
			l_hand = /obj/item/rogueweapon/sword/short/messer/iron
			r_hand = /obj/item/storage/meatbag
			backpack_contents = list(
						/obj/item/flint = 1,
						/obj/item/bait = 1,
						/obj/item/rogueweapon/huntingknife = 1,
						/obj/item/flashlight/flare/torch = 1,
						/obj/item/flashlight/flare/torch/lantern = 1,
						/obj/item/recipe_book/survival = 1,
						/obj/item/recipe_book/leatherworking = 1,
						/obj/item/rogueweapon/scabbard/sheath = 1
						)
			gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
			ADD_TRAIT(H, TRAIT_OUTDOORSMAN, TRAIT_GENERIC)

			H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/axes, 1, TRUE)
			H.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
			H.adjust_skillrank(/datum/skill/craft/tanning, 3, TRUE)
			H.adjust_skillrank(/datum/skill/labor/fishing, 1, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
			H.adjust_skillrank(/datum/skill/labor/butchering, 3, TRUE)
			H.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
			H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.adjust_skillrank(/datum/skill/misc/tracking, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.change_stat(STATKEY_INT, 1)
			H.change_stat(STATKEY_PER, 3)
			H.change_stat(STATKEY_SPD, 1)
