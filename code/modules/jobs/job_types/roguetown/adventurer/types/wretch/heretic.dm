/datum/advclass/wretch/heretic
	name = "Heretic"
	tutorial = "You are a heretic, spurned by the church, cast out from society - frowned upon by Psydon and his children for your faith."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/wretch/heretic
	category_tags = list(CTAG_WRETCH)
	traits_applied = list(TRAIT_STEELHEARTED, TRAIT_OUTLANDER, TRAIT_HEAVYARMOR, TRAIT_RITUALIST, TRAIT_OUTLAW, TRAIT_HERESIARCH)
	maximum_possible_slots = 3 //Ppl dont like heavy armor antags.

/datum/outfit/job/roguetown/wretch/heretic/pre_equip(mob/living/carbon/human/H)
	H.mind.current.faction += "[H.name]_faction"
	H.adjust_skillrank(/datum/skill/magic/holy, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.set_blindness(0)
	var/weapons = list("Longsword", "Mace", "Flail", "Axe")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	switch(weapon_choice)
		if("Longsword")
			H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			beltr = /obj/item/rogueweapon/scabbard/sword
			r_hand = /obj/item/rogueweapon/sword/long
		if("Mace")
			H.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
			beltr = /obj/item/rogueweapon/mace/steel
		if("Flail")
			H.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
			beltr = /obj/item/rogueweapon/flail/sflail
		if("Axe")
			H.adjust_skillrank(/datum/skill/combat/axes, 1, TRUE)
			beltr = /obj/item/rogueweapon/stoneaxe/woodcut/steel
	H.change_stat("strength", 2)  // Heretic is by far the best class with access to rituals (as long as they play a god with ritual), holy and heavy armor. So they keep 7 points.
	H.change_stat("constitution", 2)
	H.change_stat("endurance", 1)
	// You can convert those the church has shunned.
	H.verbs |= /mob/living/carbon/human/proc/absolve_heretic
	if (istype (H.patron, /datum/patron/inhumen/zizo))
		if(H.mind)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/minion_order)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/gravemark)
			H.mind.current.faction += "[H.name]_faction"
		ADD_TRAIT(H, TRAIT_GRAVEROBBER, TRAIT_GENERIC)
	head = /obj/item/clothing/head/roguetown/helmet/bascinet
	mask = /obj/item/clothing/mask/rogue/facemask/steel
	neck = /obj/item/clothing/neck/roguetown/gorget
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	gloves = /obj/item/clothing/gloves/roguetown/chain
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	pants = /obj/item/clothing/under/roguetown/chainlegs
	shoes = /obj/item/clothing/shoes/roguetown/boots
	cloak = /obj/item/clothing/cloak/cape/crusader
	backl = /obj/item/storage/backpack/rogue/satchel
	backr = /obj/item/rogueweapon/shield/tower/metal
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/rogueweapon/huntingknife
	backpack_contents = list(
		/obj/item/storage/belt/rogue/pouch/coins/poor = 1,
		/obj/item/ritechalk = 1,
		/obj/item/flashlight/flare/torch/lantern/prelit = 1,
		/obj/item/rope/chain = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1
		)
	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_miracles(H, cleric_tier = CLERIC_T1, passive_gain = CLERIC_REGEN_MINOR)	//Minor regen, can level up to T4.
	wretch_select_bounty(H)
	switch(H.patron?.type)
		if(/datum/patron/inhumen/zizo)
			H.cmode_music = 'sound/music/combat_heretic.ogg'
		if(/datum/patron/inhumen/matthios)
			H.cmode_music = 'sound/music/combat_matthios.ogg'
		if(/datum/patron/inhumen/baotha)
			H.cmode_music = 'sound/music/combat_baotha.ogg'
		if(/datum/patron/inhumen/graggar)
			H.cmode_music = 'sound/music/combat_graggar.ogg'

/mob/living/carbon/human
	COOLDOWN_DECLARE(heretic_absolve)

/mob/living/carbon/human/proc/absolve_heretic()
	set name = "Convert The Downtrodden"
	set category = "Heretic"

	if(stat)
		return

	if(!HAS_TRAIT(src, TRAIT_HERESIARCH))
		to_chat(src, span_warning("You lack the dark knowledge for this ritual."))
		return

	if(!COOLDOWN_FINISHED(src, heretic_absolve))
		to_chat(src, span_warning("You must wait before performing this ritual again."))
		return

	var/target_name = input("Absolve a soul from divine punishment", "Target Name") as text|null
	if(!target_name)
		return

	if(!mind || !mind.do_i_know(name = target_name))
		to_chat(src, span_warning("You don't know anyone by that name."))
		return

	// Find the actual mob if online
	var/mob/living/carbon/human/target
	for(var/mob/living/carbon/human/H in GLOB.human_list)
		if(H.real_name == target_name)
			target = H
			break

	//Using this to check whether the target is valid for absolving.
	var/absolved = FALSE
	//Prevents being able to convert people that weren't excommunicated.
	if(target_name in GLOB.excommunicated_players && !HAS_TRAIT(target, TRAIT_EXCOMMUNICATED))
		to_chat(src, span_warning("This one was already freed from injustice long ago."))
		return
	else
		//They were excommunicated, we can accept them into our flock.
		absolved = TRUE

	// Remove from global lists
	if(target_name in GLOB.apostasy_players)
		GLOB.apostasy_players -= target_name
		absolved = TRUE

	if(!target)
		to_chat(src, span_warning("Could not find [target_name]."))
		return

	// Get target's consent
	var/consent = alert(target, "[src.real_name] is trying to convert you to their patron, [src.patron.name]. Do you accept?", "Conversion Request", "Yes", "No")
	if(consent != "Yes")
		to_chat(src, span_warning("[target_name] refused your offer of conversion."))
		return

	// Remove divine punishments
	target.remove_status_effect(/datum/status_effect/debuff/apostasy)
	target.remove_status_effect(/datum/status_effect/debuff/excomm)
	target.remove_stress(/datum/stressevent/apostasy)
	target.remove_stress(/datum/stressevent/excommunicated)

	// Remove divine curses
	for(var/datum/curse/C in target.curses)
		target.remove_curse(C)
		absolved = TRUE

	// Save devotion state if exists
	var/saved_level = CLERIC_T0
	var/saved_devotion = 0
	var/saved_progression = 0
	var/saved_devotion_gain = 0
	if(target.devotion)
		saved_level = target.devotion.level
		saved_devotion = target.devotion.devotion
		saved_progression = target.devotion.progression
		saved_devotion_gain = target.devotion.passive_devotion_gain
		// Remove all granted spells
		for(var/obj/effect/proc_holder/spell/S in target.devotion.granted_spells)
			target.mind.RemoveSpell(S)
		qdel(target.devotion)

	// Change patron
	target.patron = src.patron
	to_chat(target, span_userdanger("Your soul now belongs to [src.patron.name]!"))

	// Grant new devotion
	var/datum/devotion/new_devotion = new /datum/devotion(target, target.patron)
	new_devotion.grant_miracles(
		target,
		cleric_tier = saved_level,
		passive_gain = saved_devotion_gain,
		start_maxed = FALSE
	)
	new_devotion.devotion = saved_devotion
	new_devotion.progression = saved_progression
	new_devotion.try_add_spells(silent = TRUE)

	if(absolved)
		to_chat(src, span_danger("You've converted [target_name] to [src.patron.name] and restored their divine connection!"))
		//Multiple heretics possible but only one priest, the cooldown should probably be long.
		COOLDOWN_START(src, heretic_absolve, 60 MINUTES)
	else
		to_chat(src, span_danger("You've converted [target_name] to [src.patron.name]!"))

	ADD_TRAIT(target, TRAIT_HERESIARCH, TRAIT_GENERIC)
	// Just in case let's excommunicate them here again so they actually show up as a heretic..
	ADD_TRAIT(target, TRAIT_EXCOMMUNICATED, TRAIT_GENERIC)
