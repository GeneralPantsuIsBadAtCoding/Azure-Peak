/datum/job/roguetown/squire
	title = "Squire"
	flag = SQUIRE
	department_flag = GARRISON
	faction = "Station"
	total_positions = 4
	spawn_positions = 4
	allowed_races = RACES_ALL_KINDS
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT)
	advclass_cat_rolls = list(CTAG_SQUIRE = 20)

	tutorial = "Your folks said you were going to be something, they had better aspirations for you than the life of a peasant. You practiced the basics \
		in the field alongside your friends, swordfighting with sticks, chasing rabbits with grain flail, and helping around the house lifting heavy \
		bags of grain. The Knight took notice of your potential and brought you on as his personal ward. You're going to be something someday."
	outfit = /datum/outfit/job/roguetown/squire
	display_order = JDO_SQUIRE
	give_bank_account = TRUE
	min_pq = -5 //squires aren't great but they can do some damage
	max_pq = null
	round_contrib_points = 2

	cmode_music = 'sound/music/combat_squire.ogg'

/datum/outfit/job/roguetown/squire
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/guard
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/storage/keyring/guardcastle
	cloak = /obj/item/clothing/cloak/stabard/surcoat/guard
	id = /obj/item/scomstone/bad/garrison
	job_bitflag = BITFLAG_GARRISON		//Move this role to garrison section later. Shouldn't be under youngroles for transparancy they are garrison.

/datum/job/roguetown/squire/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
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
			S.name = "squire's tabard ([index])"
