/datum/job/roguetown/pilgrima/dorf_maxxer //BORN UNDERGROUND,
	name = "Dwarf"
	tutorial = "A Dwarf. It really doesn't get better than this."
	allowed_sexes = list(MALE, FEMALE)
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 999
	spawn_positions = 999
	allowed_races = list(/datum/species/dwarf/mountain, /datum/species/dwarf)
	outfit = /datum/outfit/job/roguetown/dorfsteader
	traits_applied = list(TRAIT_JACKOFALLTRADES,
		TRAIT_ALCHEMY_EXPERT,
		TRAIT_SMITHING_EXPERT,
		TRAIT_SEWING_EXPERT,
		TRAIT_SURVIVAL_EXPERT,
		TRAIT_HOMESTEAD_EXPERT
	)
	category_tags = list(CTAG_PILGRIM, CTAG_TOWNER)
	adaptive_name = TRUE
	subclass_stats = list(
		STATKEY_INT = 3, //dwarv SMART!!
		STATKEY_STR = 2, //dwarv STRONG
		STATKEY_WIL = 1, //dwarf HARD WORKING
		STATKEY_CON = 1, //dwarf HARDY
		STATKEY_PER = -5, //dwarf cant see shit
		STATKEY_LCK = 1, //dwarf PLUCKY UNDERDOG
	)
	subclass_skills = list(
		/datum/skill/labor/farming = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/axes = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/knives = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_NOVICE,

		/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/swimming = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/stealing = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/music = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/reading = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/medicine = SKILL_LEVEL_APPRENTICE,
		/datum/skill/craft/sewing = SKILL_LEVEL_APPRENTICE,
		/datum/skill/craft/ceramics = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/tracking = SKILL_LEVEL_APPRENTICE,

		/datum/skill/craft/crafting = SKILL_LEVEL_APPRENTICE,
		/datum/skill/craft/carpentry = SKILL_LEVEL_APPRENTICE,
		/datum/skill/craft/masonry = SKILL_LEVEL_APPRENTICE,
		/datum/skill/craft/engineering = SKILL_LEVEL_APPRENTICE,
		/datum/skill/craft/traps = SKILL_LEVEL_APPRENTICE,
		/datum/skill/craft/alchemy = SKILL_LEVEL_APPRENTICE,
		/datum/skill/craft/tanning = SKILL_LEVEL_APPRENTICE,
		/datum/skill/craft/cooking = SKILL_LEVEL_APPRENTICE,

		/datum/skill/labor/lumberjacking = SKILL_LEVEL_APPRENTICE,
		/datum/skill/labor/fishing = SKILL_LEVEL_APPRENTICE,
		/datum/skill/labor/butchering = SKILL_LEVEL_APPRENTICE,
		/datum/skill/labor/mining = SKILL_LEVEL_APPRENTICE,
	)

/datum/outfit/job/roguetown/dorfsteader/pre_equip(mob/living/carbon/human/H)
	..()

	//first, randomized skills

	H.adjust_skillrank(/datum/skill/combat/swords, rand(0,1), TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, rand(0,2) ,TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, rand(0,2), TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, rand(0,2), TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, rand(0,2), TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, rand(0,2), TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, rand(0,1), TRUE)
	H.adjust_skillrank(/datum/skill/combat/bows, rand(0,2), TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, rand(0,2), TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, rand(0,2), TRUE)
	H.adjust_skillrank(/datum/skill/craft/sewing, rand(0,2), TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, rand(0,2), TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, rand(0,2), TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, rand(0,2), TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, rand(0,2), TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, rand(0,2), TRUE)

	H.set_patron(/datum/patron/divine/malum) //sire you are a dorf

	head = pick(/obj/item/clothing/head/roguetown/hatfur,
	/obj/item/clothing/head/roguetown/hatblu,
	/obj/item/clothing/head/roguetown/nightman,
	/obj/item/clothing/head/roguetown/roguehood,
	/obj/item/clothing/head/roguetown/roguehood/random,
	/obj/item/clothing/head/roguetown/roguehood/shalal/heavyhood,
	/obj/item/clothing/head/roguetown/fancyhat)

	if(prob(50))
		mask = /obj/item/clothing/mask/rogue/spectacles

	cloak = pick(/obj/item/clothing/cloak/raincloak/furcloak,
	/obj/item/clothing/cloak/half)

	armor = pick(/obj/item/clothing/suit/roguetown/armor/workervest,
	/obj/item/clothing/suit/roguetown/armor/leather/vest)

	pants = pick(/obj/item/clothing/under/roguetown/trou,
	/obj/item/clothing/under/roguetown/tights/random)

	shirt = pick(/obj/item/clothing/suit/roguetown/shirt/undershirt/random,
	/obj/item/clothing/suit/roguetown/shirt/undershirt/puritan,
	/obj/item/clothing/suit/roguetown/armor/gambeson/light)

	shoes = pick(/obj/item/clothing/shoes/roguetown/boots/leather,
	/obj/item/clothing/shoes/roguetown/shortboots)

	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
	beltl = /obj/item/flashlight/flare/torch/lantern
	backl = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list(
						/obj/item/flint = 1,
						/obj/item/flashlight/flare/torch = 1,
						/obj/item/rogueweapon/handsaw = 1,
						/obj/item/recipe_book/builder = 1,
						/obj/item/recipe_book/survival = 1,
						/obj/item/reagent_containers/powder/salt = 3,
						/obj/item/reagent_containers/food/snacks/rogue/cheddar = 2,
						/obj/item/natural/cloth = 2,
						/obj/item/book/rogue/yeoldecookingmanual = 1,
						/obj/item/natural/worms = 2,
						/obj/item/rogueweapon/shovel/small = 1,
						/obj/item/rogueweapon/chisel = 1,
						/obj/item/natural/clay = 3,
						/obj/item/natural/clay/glassbatch = 1,
						/obj/item/rogueore/coal = 1,
						/obj/item/roguegear = 1,
	)
	if(H.mind)
		H.mind.special_items["Hammer"] = /obj/item/rogueweapon/hammer/steel
		H.mind.special_items["Sheathe"] = /obj/item/rogueweapon/scabbard/sheath
		H.mind.special_items["Hunting Knife"] = /obj/item/rogueweapon/huntingknife
		H.mind.special_items["Woodcutter's Axe"] = /obj/item/rogueweapon/stoneaxe/woodcut/steel/woodcutter
		H.mind.special_items["[pick("Good", "Bad", "Normal")] Day's Wine"] = /obj/item/reagent_containers/glass/bottle/rogue/wine
		H.mind.special_items["Barber's Innocuous Bag"] = /obj/item/storage/belt/rogue/surgery_bag/full
		H.mind.special_items["Trusty Pick"] = /obj/item/rogueweapon/pick
		H.mind.special_items["Hoe"] = /obj/item/rogueweapon/hoe
		H.mind.special_items["Tuneful Instrument"] = pick(subtypesof(/obj/item/rogue/instrument))
		H.mind.special_items["Fishing Rod"] = /obj/item/fishingrod/crafted
		H.mind.special_items["Pan for Frying"] = /obj/item/cooking/pan

		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)


/datum/job/roguetown/pilgrim/dorf_guard //RAISED INSIDE A ROCKY ROOM,
	name = "Dwarf Guard"
	tutorial = "You guard your fellow Dwarves, remaining as stalwart as a Fortress. ...wait, say that again...
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		/datum/species/dwarf,
		/datum/species/dwarf/mountain
	)
	outfit = /datum/outfit/job/roguetown/mercenary/grudgebearer
	class_select_category = CLASS_CAT_RACIAL
	category_tags = list(CTAG_MERCENARY)
	cmode_music = 'sound/music/combat_dwarf.ogg'
	traits_applied = list(TRAIT_MEDIUMARMOR, TRAIT_TRAINED_SMITH, TRAIT_SMITHING_EXPERT) // Another one off exception for a combat role
	subclass_stats = list(
		STATKEY_INT = 3,
		STATKEY_WIL = 3,
		STATKEY_PER = 3,//Anvil"Strikes deftly" is based on PER
		STATKEY_STR = 1,
		STATKEY_SPD = -2
	)
	subclass_skills = list(
		/datum/skill/misc/reading = SKILL_LEVEL_EXPERT,
		/datum/skill/craft/armorsmithing = SKILL_LEVEL_EXPERT,	//Shouldn't be better than the smith (though the stats are already)
		/datum/skill/craft/blacksmithing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/smelting = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/maces = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/wrestling = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/weaponsmithing = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/climbing = SKILL_LEVEL_NOVICE,
	)

//Because the armor is race-exclusive for repairs, these guys *should* be able to repair their own guys armor layers. A Dwarf smith isn't guaranteed, after all.
/datum/outfit/job/roguetown/mercenary/grudgebearer/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		shoes = /obj/item/clothing/shoes/roguetown/boots/armor/dwarven
		cloak = /obj/item/clothing/cloak/forrestercloak/snow
		belt = /obj/item/storage/belt/rogue/leather/black
		beltr = /obj/item/rogueweapon/mace
		beltl = /obj/item/flashlight/flare/torch
		backl = /obj/item/storage/backpack/rogue/backpack
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
		gloves = /obj/item/clothing/gloves/roguetown/plate/dwarven
		pants = /obj/item/clothing/under/roguetown/trou/leather
		armor = /obj/item/clothing/suit/roguetown/armor/plate/half
		backpack_contents = list(
			/obj/item/roguekey/mercenary,
			/obj/item/storage/belt/rogue/pouch/coins/poor,
			/obj/item/rogueweapon/hammer/iron,
			/obj/item/paper/scroll/grudge,
			/obj/item/natural/feather,
			/obj/item/rogueweapon/tongs = 1,
			/obj/item/clothing/head/roguetown/helmet/heavy/dwarven,
			)
		H.merctype = 8
