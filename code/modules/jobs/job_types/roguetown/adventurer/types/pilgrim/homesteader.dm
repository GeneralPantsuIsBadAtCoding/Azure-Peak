/datum/advclass/homesteader
	name = "Homesteader"
	tutorial = "Azure population's tendency to take up arms and become unwashed beastslayers had forced you to take up jobs, small and large of most professions.\n A jack of all trades, what will you be known as this week?"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/homesteader
	traits_applied = list(TRAIT_JACKOFALLTRADES)
	category_tags = list(CTAG_PILGRIM, CTAG_TOWNER)
	adaptive_name = TRUE

/datum/outfit/job/roguetown/homesteader/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank_up_to(/datum/skill/combat/axes, 2, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/wrestling, 1, TRUE)

	H.adjust_skillrank_up_to(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/misc/swimming, 3, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/misc/stealing, 2, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/misc/music, 2, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/misc/reading, 2, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/misc/medicine, 2, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/misc/sewing, 2, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/misc/ceramics, 2, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/misc/tracking, 2, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/misc/lockpicking, 2, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/misc/sneaking, 2, TRUE)
	H.adjust_skillrank_down_to(/datum/skill/misc/riding, 2, TRUE)

	H.adjust_skillrank_up_to(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/craft/carpentry, 2, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/craft/masonry, 2, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/craft/engineering, 2, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/craft/traps, 2, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/craft/alchemy, 2, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/craft/tanning, 2, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/craft/cooking, 2, TRUE)

	H.adjust_skillrank_up_to(/datum/skill/labor/lumberjacking, 2, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/labor/fishing, 2, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/labor/butchering, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)

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
						/obj/item/dye_brush = 1,
						/obj/item/recipe_book/builder = 1,
						/obj/item/recipe_book/survival = 1,
						/obj/item/reagent_containers/powder/salt = 3,
						/obj/item/reagent_containers/food/snacks/rogue/cheddar = 2,
						/obj/item/natural/cloth = 2,
						/obj/item/book/rogue/yeoldecookingmanual = 1,
						/obj/item/natural/worms = 2,
						/obj/item/rogueweapon/shovel/small = 1,
						/obj/item/hair_dye_cream = 3,
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
	H.change_stat("strength", 1)
	H.change_stat("endurance", 1)
	H.change_stat("intelligence", 3)	//This guy's here to grind, baby.
	H.change_stat("perception", 1)
	H.change_stat("fortune", 1)
