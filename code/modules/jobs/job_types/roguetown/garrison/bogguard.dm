/datum/job/roguetown/bogguardsman
	title = "Warden"
	flag = BOGGUARD
	department_flag = GARRISON
	faction = "Station"
	total_positions = 4
	spawn_positions = 4
	selection_color = JCOLOR_SOLDIER

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	tutorial = "Typically a denizen of the sparsely populated Azure woods, you volunteered up with the wardens--a group of ranger types who keep a vigil over the untamed wilds. \
				While Wardens have no higher authority, operating as a fraternity of rangers, you will be called upon as members of the garrison by the Marshal or the Crown. \
				Serve their will and recieve what a ranger craves the most - freedom and safety."
	display_order = JDO_BOGGUARD
	whitelist_req = TRUE

	outfit = /datum/outfit/job/roguetown/bogguardsman
	advclass_cat_rolls = list(CTAG_WARDEN = 20)

	give_bank_account = 16
	min_pq = 0
	max_pq = null
	round_contrib_points = 2

	cmode_music = 'sound/music/cmode/garrison/combat_warden.ogg'

/datum/outfit/job/roguetown/bogguardsman
	neck = /obj/item/clothing/neck/roguetown/coif
	gloves = /obj/item/clothing/gloves/roguetown/leather
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/quiver/arrows
	beltl = /obj/item/rogueweapon/stoneaxe/woodcut/wardenpick
	backr = /obj/item/storage/backpack/rogue/satchel
	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
	id = /obj/item/scomstone/bad/garrison
	job_bitflag = BITFLAG_GARRISON

/datum/job/roguetown/bogguardsman/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")
