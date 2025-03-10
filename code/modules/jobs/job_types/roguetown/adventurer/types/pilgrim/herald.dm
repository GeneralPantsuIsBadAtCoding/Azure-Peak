GLOBAL_VAR_INIT(herald_spawned, FALSE)

/datum/advclass/herald
	name = "Herald"
	tutorial = "As a Herald, you are a messenger and storyteller. Use your voice to spread news, warnings, and tales across the land. Your announcements can reach all ears, but use this power wisely."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/herald
	category_tags = list(CTAG_TOWNER)
	traits_applied = list(TRAIT_KEENEARS)

/datum/advclass/herald/check_requirements(mob/living/carbon/human/H)
	if(GLOB.herald_spawned)
		to_chat(H, span_warning("There can only be one Herald!"))
		return FALSE
	GLOB.herald_spawned = TRUE
	return ..()

/mob/living/carbon/human/var/last_herald_announce = 0

/mob/living/carbon/human/proc/heraldannouncement()
	set name = "Announcement"
	set category = "Herald"
	if(stat)
		return
	var/inputty = input("Make an announcement", "Herald's Call") as text|null
	if(inputty)
		if(world.time < last_herald_announce + 300 SECONDS)
			to_chat(src, span_warning("You must wait [round((last_herald_announce + 300 SECONDS - world.time)/600, 0.1)] minutes before making another announcement!"))
			return FALSE
		if(!istype(get_area(src), /area/rogue/indoors/town/tavern))
			to_chat(src, span_warning("You need to be in the tavern to make an announcement!"))
			return FALSE

		visible_message(span_warning("[src] takes a deep breath, preparing to make an announcement.."))
		if(do_after(src, 30 SECONDS, target = src))
			priority_announce("[inputty]", "The Herald Proclaims", 'sound/misc/bell.ogg')
			last_herald_announce = world.time
		else
			to_chat(src, span_warning("Your announcement was interrupted!"))
			return FALSE

/datum/outfit/job/roguetown/adventurer/herald/pre_equip(mob/living/carbon/human/H)
	..()
	H.verbs += /mob/living/carbon/human/proc/heraldannouncement
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)

	head = /obj/item/clothing/head/roguetown/bardhat
	shoes = /obj/item/clothing/shoes/roguetown/boots
	pants = /obj/item/clothing/under/roguetown/tights/random
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
	gloves = /obj/item/clothing/gloves/roguetown/fingerless
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
	cloak = /obj/item/clothing/cloak/raincloak/blue
	r_hand = /obj/item/scomstone
	if(prob(50))
		cloak = /obj/item/clothing/cloak/raincloak/red
	backl = /obj/item/storage/backpack/rogue/satchel
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/message)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/mindlink)

	H.change_stat("constitution", 1)
	H.change_stat("speed", 2)
