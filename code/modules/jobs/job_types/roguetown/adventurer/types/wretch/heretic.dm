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
	H.mind?.AddSpell(new /obj/effect/proc_holder/spell/invoked/convert_heretic)
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
		/obj/item/rogueweapon/scabbard/sheath = 1,
		/obj/item/reagent_containers/glass/bottle/alchemical/healthpot = 1,	//Small health vial
		)
	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_miracles(H, cleric_tier = CLERIC_T1, passive_gain = CLERIC_REGEN_MINOR, devotion_limit = CLERIC_REQ_4)	//Minor regen, can level up to T4.
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

/obj/effect/proc_holder/spell/invoked/convert_heretic
	name = "Convert The Downtrodden"
	desc = "Convert an soul excommunicated, cursed, or forced onto apotasy to your cause. Requires a willing participant, and takes a long time to cast."
	invocations = list("Show this lost sheep the righteous path.")
	invocation_type = "whisper"
	sound = 'sound/magic/bless.ogg'
	devotion_cost = 100
	recharge_time = 60 MINUTES
	// Long to prevent combat casting and forcing popups.
	chargetime = 10 SECONDS
	associated_skill = /datum/skill/magic/holy
	overlay_state = "convert_heretic"

/obj/effect/proc_holder/spell/invoked/convert_heretic/cast(list/targets, mob/living/carbon/human/user)
	if(!HAS_TRAIT(user, TRAIT_HERESIARCH))
		to_chat(user, span_warning("You lack the knowledge for this ritual."))
		return FALSE

	var/mob/living/carbon/human/target = targets[1]

	if(!ishuman(target))
		revert_cast()
		return FALSE

	//This SHOULD stop most heretics from being convertible and self-curing should they somehow get cursed in the future.
	if(HAS_TRAIT(target, TRAIT_HERESIARCH))
		to_chat(user, span_warning("[target] is already serving the greater good."))
		revert_cast()
		return FALSE

	if(alert(target, "[user.real_name] is trying to convert you to their patron, [user.patron.name]. Do you accept?", "Conversion Request", "Yes", "No") != "Yes")
		to_chat(user, span_warning("[target] refused your offer of conversion."))
		revert_cast()
		return FALSE

	var/absolvable = FALSE
	// Check if target qualifies for absolving
	if(HAS_TRAIT(target, TRAIT_EXCOMMUNICATED))
		absolvable = TRUE

	if(target.has_status_effect(/datum/status_effect/debuff/apostasy))
		target.remove_status_effect(/datum/status_effect/debuff/apostasy)
		absolvable = TRUE

	// Remove from global lists
	if(target.real_name in GLOB.apostasy_players)
		GLOB.apostasy_players -= target.real_name
		absolvable = TRUE
	if(target.real_name in GLOB.excommunicated_players)
		GLOB.excommunicated_players -= target.real_name
		absolvable = TRUE

	if(!absolvable)
		to_chat(user, span_warning("[target] doesn't bear the church's marks of shame!"))
		return

	// Remove divine punishments
	target.remove_status_effect(/datum/status_effect/debuff/apostasy)
	target.remove_status_effect(/datum/status_effect/debuff/excomm)
	target.remove_stress(/datum/stressevent/apostasy)
	target.remove_stress(/datum/stressevent/excommunicated)

	// Remove divine curses
	for(var/datum/curse/C in target.curses)
		target.remove_curse(C)

	// Save devotion state if exists
	var/saved_level = CLERIC_T0
	var/saved_max_progression = CLERIC_T1
	var/saved_devotion_gain = CLERIC_REGEN_MINOR
	
	if(target.devotion)
		saved_level = target.devotion.level
		saved_devotion_gain = target.devotion.passive_devotion_gain
		saved_max_progression = target.devotion.max_progression
		
		// Remove all granted spells
		if(target.patron != user.patron)
			for(var/obj/effect/proc_holder/spell/S in target.devotion.granted_spells)
				target.mind.RemoveSpell(S)
		
		target.devotion.Destroy()

	// Change patron
	target.patron = new user.patron.type()
	to_chat(target, span_userdanger("Your soul now belongs to [user.patron.name]!"))

	// Grant new devotion
	var/datum/devotion/new_devotion = new /datum/devotion(target, target.patron)
	target.devotion = new_devotion
	new_devotion.grant_miracles(target, saved_level, saved_devotion_gain, saved_max_progression)

	// Final conversion
	ADD_TRAIT(target, TRAIT_HERESIARCH, TRAIT_GENERIC)
	ADD_TRAIT(target, TRAIT_EXCOMMUNICATED, TRAIT_GENERIC)
	to_chat(user, span_danger("You've converted [target.name] to [user.patron.name]!"))
	to_chat(target, span_danger("You feel ancient powers lifting divine burdens from your soul..."))
	
	return TRUE
