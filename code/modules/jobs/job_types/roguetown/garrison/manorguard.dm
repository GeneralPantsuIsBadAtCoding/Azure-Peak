/datum/job/roguetown/manorguard
	title = "Man at Arms"
	flag = MANATARMS
	department_flag = GARRISON
	faction = "Station"
	total_positions = 8
	spawn_positions = 8

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	tutorial = "Having proven yourself loyal and capable, you are entrusted to defend the town and enforce its laws. \
				Trained regularly in combat and siege warfare, you deal with threats - both within and without. \
				Obey your Sergeant-at-Arms, the Marshal, and the Crown. Show the nobles and knights your respect, so that you may earn it in turn. Not as a commoner, but as a soldier.."
	display_order = JDO_CASTLEGUARD
	whitelist_req = TRUE

	outfit = /datum/outfit/job/roguetown/manorguard
	advclass_cat_rolls = list(CTAG_MENATARMS = 20)

	give_bank_account = 22
	min_pq = 3
	max_pq = null
	round_contrib_points = 2

	cmode_music = 'sound/music/combat_ManAtArms.ogg'

/datum/outfit/job/roguetown/manorguard
	job_bitflag = BITFLAG_GARRISON

/datum/job/roguetown/manorguard/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")
		if(istype(H.cloak, /obj/item/clothing/cloak/stabard/surcoat/guard))
			var/obj/item/clothing/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name = "man-at-arms jupon ([index])"

/datum/outfit/job/roguetown/manorguard
	cloak = /obj/item/clothing/cloak/stabard/surcoat/guard
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	beltl = /obj/item/rogueweapon/mace/cudgel
	belt = /obj/item/storage/belt/rogue/leather/black
	backr = /obj/item/storage/backpack/rogue/satchel/black
	id = /obj/item/scomstone/bad/garrison
