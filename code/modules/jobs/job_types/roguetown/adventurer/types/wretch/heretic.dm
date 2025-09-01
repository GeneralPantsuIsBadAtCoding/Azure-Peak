/datum/advclass/wretch/heretic
	name = "Heretic"
	tutorial = "You are a heretic, spurned by the church, cast out from society - frowned upon by Psydon and his children for your faith."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/wretch/heretic
	category_tags = list(CTAG_WRETCH)
	traits_applied = list(TRAIT_STEELHEARTED, TRAIT_OUTLANDER, TRAIT_RITUALIST, TRAIT_OUTLAW, TRAIT_HERESIARCH)
	maximum_possible_slots = 3 //Ppl dont like heavy armor antags.
	classes = list("Heretic" = "You father your unholy cause through the most time-tested of ways: hard, heavy steel in both arms and armor.",
					"Spy" = "Nimble of dagger and foot both, you are the shadowy herald of the cabal. They will not see you coming.")


/datum/outfit/job/roguetown/wretch/heretic/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Heretic","Spy")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Heretic")
			to_chat(H, span_warning("You father your unholy cause through the most time-tested of ways: hard, heavy steel in both arms and armor."))
			H.mind.current.faction += "[H.name]_faction"
			H.adjust_skillrank(/datum/skill/magic/holy, 4, TRUE)
			H.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.set_blindness(0)
			ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
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
			mask = /obj/item/clothing/mask/rogue/facemask/steel
			neck = /obj/item/clothing/neck/roguetown/gorget
			armor = /obj/item/clothing/suit/roguetown/armor/plate/half
			shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
			gloves = /obj/item/clothing/gloves/roguetown/chain
			wrists = /obj/item/clothing/wrists/roguetown/bracers
			pants = /obj/item/clothing/under/roguetown/chainlegs
			shoes = /obj/item/clothing/shoes/roguetown/boots/armor
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
					head = /obj/item/clothing/head/roguetown/helmet/bascinet/pigface
				if(/datum/patron/inhumen/matthios)
					H.cmode_music = 'sound/music/combat_matthios.ogg'
					head = /obj/item/clothing/head/roguetown/helmet/heavy/bucket/gold
				if(/datum/patron/inhumen/baotha)
					H.cmode_music = 'sound/music/combat_baotha.ogg'
					head = /obj/item/clothing/head/roguetown/helmet/bascinet/etruscan
				if(/datum/patron/inhumen/graggar)
					H.cmode_music = 'sound/music/combat_graggar.ogg'
					head = /obj/item/clothing/head/roguetown/helmet/heavy/guard
				if(/datum/patron/divine/astrata)
					wrists = /obj/item/clothing/neck/roguetown/psicross/astrata
					head = /obj/item/clothing/head/roguetown/helmet/heavy/bucket/gold
					H.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
				if(/datum/patron/divine/abyssor)
					wrists = /obj/item/clothing/neck/roguetown/psicross/abyssor
					head = /obj/item/clothing/head/roguetown/helmet/heavy
					H.adjust_skillrank(/datum/skill/labor/fishing, 2, TRUE)
					ADD_TRAIT(H, TRAIT_WATERBREATHING, TRAIT_GENERIC)
				if(/datum/patron/divine/xylix)
					head = /obj/item/clothing/head/roguetown/helmet/heavy/knight/skettle
					H.cmode_music = 'sound/music/combat_jester.ogg'
					H.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
					H.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE)
					H.adjust_skillrank(/datum/skill/misc/music, 1, TRUE)
				if(/datum/patron/divine/dendor)
					wrists = /obj/item/clothing/neck/roguetown/psicross/dendor
					head = /obj/item/clothing/head/roguetown/helmet/heavy/volfplate
					H.cmode_music = 'sound/music/cmode/garrison/combat_warden.ogg'
					H.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
					H.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
				if(/datum/patron/divine/necra)
					wrists = /obj/item/clothing/neck/roguetown/psicross/necra
					head = /obj/item/clothing/head/roguetown/helmet/heavy/guard
					ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
					ADD_TRAIT(H, TRAIT_SOUL_EXAMINE, TRAIT_GENERIC)
				if(/datum/patron/divine/pestra)
					wrists = /obj/item/clothing/neck/roguetown/psicross/pestra
					head = /obj/item/clothing/head/roguetown/helmet/sallet/visored
					ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
					H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
					H.adjust_skillrank(/datum/skill/craft/alchemy, 1, TRUE)
				if(/datum/patron/divine/eora)
					wrists = /obj/item/clothing/neck/roguetown/psicross/eora
					head = /obj/item/clothing/head/roguetown/helmet/bascinet/pigface/hounskull
					ADD_TRAIT(H, TRAIT_BEAUTIFUL, TRAIT_GENERIC)
					ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
				if(/datum/patron/divine/noc)
					wrists = /obj/item/clothing/neck/roguetown/psicross/noc
					head = /obj/item/clothing/head/roguetown/helmet/heavy/knight
					H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE) // Really good at reading... does this really do anything? No. BUT it's soulful.
					H.adjust_skillrank(/datum/skill/craft/alchemy, 1, TRUE)
					H.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
				if(/datum/patron/divine/ravox)
					wrists = /obj/item/clothing/neck/roguetown/psicross/ravox
					head = /obj/item/clothing/head/roguetown/helmet/heavy/bucket
					H.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
				if(/datum/patron/divine/malum)
					wrists = /obj/item/clothing/neck/roguetown/psicross/malum
					head = /obj/item/clothing/head/roguetown/helmet/heavy/sheriff
					H.adjust_skillrank(/datum/skill/craft/blacksmithing, 1, TRUE)
					H.adjust_skillrank(/datum/skill/craft/armorsmithing, 1, TRUE)
					H.adjust_skillrank(/datum/skill/craft/weaponsmithing, 1, TRUE)
					H.adjust_skillrank(/datum/skill/craft/smelting, 1, TRUE)
				if(/datum/patron/old_god)
					head = /obj/item/clothing/head/roguetown/helmet/heavy/knight/armet
					wrists = /obj/item/clothing/neck/roguetown/psicross
					cloak = /obj/item/clothing/cloak/tabard/crusader/psydon
					H.change_stat("endurance", 2) //ENDVRE

		if("Spy")
			to_chat(H, span_warning("Nimble of dagger and foot both, you are the shadowy herald of the cabal. They will not see you coming."))
			H.mind.current.faction += "[H.name]_faction"
			pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
			armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
			cloak = /obj/item/clothing/cloak/raincloak/mortus
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
			backl = /obj/item/storage/backpack/rogue/satchel
			belt = /obj/item/storage/belt/rogue/leather
			gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
			shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
			neck = /obj/item/clothing/neck/roguetown/gorget
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather/heavy
			mask = /obj/item/clothing/mask/rogue/ragmask/black
			backpack_contents = list(
				/obj/item/storage/belt/rogue/pouch/coins/poor = 1,
				/obj/item/lockpickring/mundane = 1,
				/obj/item/flashlight/flare/torch/lantern/prelit = 1,
				/obj/item/rope/chain = 1,
				/obj/item/storage/roguebag = 1,
				/obj/item/ritechalk = 1,
				/obj/item/reagent_containers/glass/bottle/alchemical/healthpot = 1,	//Small health vial
				)
			H.adjust_skillrank(/datum/skill/magic/holy, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
			H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 5, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/stealing, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/lockpicking, 4, TRUE)
			H.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)
			H.cmode_music = 'sound/music/cmode/antag/combat_cutpurse.ogg'
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			var/weapons = list("Rapier","Dagger", "Bow", "Crossbow")
			var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
			H.set_blindness(0)
			switch(weapon_choice)
				if("Rapier")
					H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
					beltl = /obj/item/rogueweapon/scabbard/sword
					l_hand = /obj/item/rogueweapon/sword/rapier
				if("Dagger")
					H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
					beltl = /obj/item/rogueweapon/scabbard/sheath
					l_hand = /obj/item/rogueweapon/huntingknife/idagger/steel/special
				if("Bow")
					H.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
					beltl = /obj/item/quiver/arrows
					backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
				if("Crossbow")
					H.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE) //have to specifically go into bows/crossbows unlike outlaw
					beltr = /obj/item/quiver/bolts
					backr = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow

			H.change_stat("perception", 2)
			H.change_stat("intelligence", 1)
			H.change_stat("endurance", 2)
			H.change_stat("speed", 2) //Slower than outlaw, but a bit more PER and INT
			if (istype (H.patron, /datum/patron/inhumen/zizo))
				if(H.mind)
					H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/minion_order)
					H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/gravemark)
					H.mind.current.faction += "[H.name]_faction"
				ADD_TRAIT(H, TRAIT_GRAVEROBBER, TRAIT_GENERIC)
			H.mind?.AddSpell(new /obj/effect/proc_holder/spell/invoked/convert_heretic)
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
				if(/datum/patron/divine/astrata)
					wrists = /obj/item/clothing/neck/roguetown/psicross/astrata
					H.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
				if(/datum/patron/divine/abyssor)
					wrists = /obj/item/clothing/neck/roguetown/psicross/abyssor
					H.adjust_skillrank(/datum/skill/labor/fishing, 2, TRUE)
					ADD_TRAIT(H, TRAIT_WATERBREATHING, TRAIT_GENERIC)
				if(/datum/patron/divine/xylix)
					H.cmode_music = 'sound/music/combat_jester.ogg'
					H.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
					H.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE)
					H.adjust_skillrank(/datum/skill/misc/music, 1, TRUE)
				if(/datum/patron/divine/dendor)
					wrists = /obj/item/clothing/neck/roguetown/psicross/dendor
					H.cmode_music = 'sound/music/cmode/garrison/combat_warden.ogg'
					H.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
					H.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
				if(/datum/patron/divine/necra)
					wrists = /obj/item/clothing/neck/roguetown/psicross/necra
					ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
					ADD_TRAIT(H, TRAIT_SOUL_EXAMINE, TRAIT_GENERIC)
				if(/datum/patron/divine/pestra)
					wrists = /obj/item/clothing/neck/roguetown/psicross/pestra
					ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
					H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
					H.adjust_skillrank(/datum/skill/craft/alchemy, 1, TRUE)
				if(/datum/patron/divine/eora)
					wrists = /obj/item/clothing/neck/roguetown/psicross/eora
					ADD_TRAIT(H, TRAIT_BEAUTIFUL, TRAIT_GENERIC)
					ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
				if(/datum/patron/divine/noc)
					wrists = /obj/item/clothing/neck/roguetown/psicross/noc
					H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE) // Really good at reading... does this really do anything? No. BUT it's soulful.
					H.adjust_skillrank(/datum/skill/craft/alchemy, 1, TRUE)
					H.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
				if(/datum/patron/divine/ravox)
					wrists = /obj/item/clothing/neck/roguetown/psicross/ravox
					H.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
				if(/datum/patron/divine/malum)
					wrists = /obj/item/clothing/neck/roguetown/psicross/malum
					H.adjust_skillrank(/datum/skill/craft/blacksmithing, 1, TRUE)
					H.adjust_skillrank(/datum/skill/craft/armorsmithing, 1, TRUE)
					H.adjust_skillrank(/datum/skill/craft/weaponsmithing, 1, TRUE)
					H.adjust_skillrank(/datum/skill/craft/smelting, 1, TRUE)
				if(/datum/patron/old_god)
					wrists = /obj/item/clothing/neck/roguetown/psicross
					cloak = /obj/item/clothing/cloak/tabard/crusader/psydon
					H.change_stat("endurance", 2) //ENDVRE

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
