/datum/job/roguetown/elder
	title = "Town Elder"
	flag = ELDER
	department_flag = YEOMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	allowed_ages = list(AGE_OLD)
	tutorial = "You are as venerable and ancient as the trees themselves, wise even for your years spent with the first Wardens. The people look up to you both as a teacher and a guide to solve lesser issues before violence is involved. Not everything must end in bloodshed, no matter how much the retinue wish it were the case. Lead your fellow townsfolk in these troubling times lest they incur wrath of the nobility with their ignorance."
	whitelist_req = TRUE
	outfit = /datum/outfit/job/roguetown/elder
	display_order = JDO_CHIEF
	min_pq = 2 //mentor role, not a high PQ requirement but not zero
	max_pq = null
	give_bank_account = 16
	round_contrib_points = 3

	cmode_music = 'sound/music/combat_old.ogg'//He is old so he gets old


GLOBAL_VAR_INIT(last_elder_announce, -50000) // Inits variable for later

/mob/living/carbon/human/proc/elderannouncement()
	set name = "Announcement" // MAKE THOSE WHIPPERSNAPPERS LISTEN.
	set category = "ELDER"
	if(stat)
		return
	var/announcementinput = input("Bellow to the Peaks", "Make an Announcement") as text|null
	if(announcementinput)
		if(!src.can_speak_vocal())
			to_chat(src,span_warning("I can't speak!"))
			return FALSE
		if(world.time < GLOB.last_elder_announce + 600 SECONDS)
			to_chat(src, span_warning("You must wait [round((GLOB.last_elder_announce + 600 SECONDS - world.time)/600, 0.1)] minutes before making another announcement!"))
			return FALSE
		visible_message(span_warning("[src] takes a deep breath, preparing to make an announcement.."))
		if(do_after(src, 15 SECONDS, target = src)) // Reduced to 15 seconds from 30 on the original Herald PR. 15 is well enough time for sm1 to shove you.
			say(announcementinput)
			priority_announce("[announcementinput]", "The Elder Decrees", 'sound/misc/bell.ogg', sender = src)
			GLOB.last_elder_announce = world.time
		else
			to_chat(src, span_warning("Your announcement was interrupted!"))
			return FALSE

/datum/outfit/job/roguetown/elder
	name = "Town Elder"
	jobtype = /datum/job/roguetown/elder

/datum/outfit/job/roguetown/elder/pre_equip(mob/living/carbon/human/H)
	..()
	
	cloak = /obj/item/clothing/cloak/stabard/guardhood/elder
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/white
	pants = /obj/item/clothing/under/roguetown/tights//The idea is sort of that they just pick whichever colours correspond with the lord colours in round.
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/mace//Sign of status - he doesn't have the stats to actually use this in any meaningful way.
	beltl = /obj/item/flashlight/flare/torch/lantern
	backl = /obj/item/storage/backpack/rogue/satchel
	id = /obj/item/scomstone/bad//He is meant to be helping people around - hard to do when he can't hear their calls
	backpack_contents = list(/obj/item/storage/keyring/velder  = 1, /obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/storage/belt/rogue/pouch/coins/rich = 1)
	H.verbs += /mob/living/carbon/human/proc/elderannouncement
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 5, TRUE)
	H.adjust_skillrank(/datum/skill/craft/carpentry, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/masonry, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/engineering, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/tanning, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/tracking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/ceramics, 3, TRUE)
	H.change_stat("perception", 2)
	H.change_stat("endurance", 2)
	H.change_stat("speed", -1)
	H.change_stat("constitution", 1)
	H.change_stat("intelligence", 3)
	ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, "[type]")
	ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
	if(should_wear_femme_clothes(H))//Village grandma look.
		head = /obj/item/clothing/head/roguetown/shawl
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/silkdress
		backr = /obj/item/clothing/cloak/raincloak/furcloak
	else if(should_wear_masc_clothes(H))//Bailiff sort of look to it.
		head = /obj/item/clothing/head/roguetown/chaperon/greyscale/elder
		shirt = /obj/item/clothing/suit/roguetown/shirt/tunic
		gloves = /obj/item/clothing/gloves/roguetown/leather
