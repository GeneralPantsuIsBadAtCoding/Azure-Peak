/datum/patron/old_god
	name = null
	associated_faith = /datum/faith/old_god
	profane_words = list() //This is either going to fix everything, or cause everything to explode.

/datum/patron/old_god/orthodox
	name = "Orthodoxism"
	domain = "Otava, the Holy Psydonic Inquisition, and most of Psydonia's innermost kingdoms."
	worshippers = "Traditionalists, Commonfolk, Zealots, and the Dutiful."
	desc = "‎ </br>'PSYDON YET LYVES! PSYDON YET ENDURES!' </br>‎  </br>In the wake of the Comet Syon's impact, Psydon fell silent. None truly knew what became of Him, but most had assumed the worst: that He had undertaken the ultimate sacrifice to save His world from the Archdevil. Many of His grieving children would eventually turn their prayers to the Pantheon, but a select few held hope that Psydon still lyved. </br>‎  </br>Together, these apostles pilgrimaged to an ancient kingdom and chiseled the Orthodoxy from its ruins. From the remains of the old world, a masterwork arose: Otava, the only cathedral-state that has remained ardently Psydonic following His collapse, and the aggressor of a centuries-long conflict against the Pantheon's kingdoms. </br>‎  </br>As the largest Psydonic denomination in the new world, the Orthodoxy's beliefs are well-known to even the most ardent opposers. Psydon left humenity to recover His strength, but will soon return. The Pantheon, as His creations, are seen as 'Saints': fit for reverence, but subserveant to His divine authority. The Inhumen seek to end this world, and must be stopped."
	associated_faith = /datum/faith/old_god
	mob_traits = list(TRAIT_PSYDONIAN_GRIT)
	miracles = list(/obj/effect/proc_holder/spell/targeted/touch/orison			= CLERIC_ORI,
					/obj/effect/proc_holder/spell/self/check_boot				= CLERIC_T0,
					/obj/effect/proc_holder/spell/invoked/psydonendure			= CLERIC_T1,
					/obj/effect/proc_holder/spell/self/psydonrespite			= CLERIC_T2,
	)	
	traits_tier = list(TRAIT_PSYDONITE = CLERIC_T1)
	confess_lines = list(
		"TO HELL WITH YOU! THERE IS ONLY ONE TRUE GOD!",
		"PSYDON YET LYVES! PSYDON YET ENDURES! IN HIS NAME!",
		"DEATH TO THE ARCHDEVIL'S SPAWN! UP THE PSY!",
	)

/datum/patron/old_god/mystic
	name = "Mysticism"
	domain = "Naledi, Kazengun, Raneshen, Amazonia, and many assorted tribes across Psydonia's outer reaches."
	worshippers = "Spiritualists, Gnostics, Philosophers, and the Esoteric."
	desc = "..AAAAAAAH. AAAAAAAAH."
	associated_faith = /datum/faith/old_god
	mob_traits = list(TRAIT_PSYDONIAN_GRIT)
	miracles = list(/obj/effect/proc_holder/spell/targeted/touch/orison			= CLERIC_ORI,
					/obj/effect/proc_holder/spell/self/check_boot				= CLERIC_T0,
					/obj/effect/proc_holder/spell/invoked/psydonendure			= CLERIC_T1,
					/obj/effect/proc_holder/spell/self/psydonrespite			= CLERIC_T2,
	)
	traits_tier = list(TRAIT_PSYDONITE = CLERIC_T1)
	confess_lines = list(
		"MY SPIRIT WARDS OFF YOUR VILE CURSES, DJINN! ETERNITY AWAITS!",
		"PSYDON WILL LYVE ONCE MORE! UNITY WILL RETURN TO THIS WORLD!",
		"I WILL NOT RECANT THE TRUTH! HE IS NOTHING, YET EVERYTHING!",
	)

/datum/patron/old_god/fatal
	name = "Fatalism"
	domain = "Rockhill, the ."
	desc = "... </br>God. The manifestation of maximal good, and the father of all. </br>He, who created reality for His children to frollick within. </br>He, who breathed lyfe into the Pantheon to shepherd His virtues. </br>He, who sacrificed His strength to strike down the Archdevil with the Comet Syon. </br>He, who yet slumbers to this dae; and who may yet still return."
	worshippers = "Accelerationists, Extremists, and the Struggler."
	associated_faith = /datum/faith/old_god
	mob_traits = list(TRAIT_PSYDONIAN_GRIT, TRAIT_PSYDONITE) //Both Psydonic traits are applied no matter what, instead of just one.
	miracles = list(/obj/effect/proc_holder/spell/targeted/touch/orison			= CLERIC_T4, // An experiment. Ideal for those who want a challenge, or to simply thug it out like it's Roguetown 1E.
					/obj/effect/proc_holder/spell/self/check_boot				= CLERIC_T4, // Removes access to all miracles, Psydonic or not, while providing both Psydonic-exclusive traits to the character.
					/obj/effect/proc_holder/spell/invoked/psydonendure			= CLERIC_T4, // Note that the boon of 'passive wound regeneration' is offset by 'no longer being healed by almost every miracle'.
					/obj/effect/proc_holder/spell/self/psydonrespite			= CLERIC_T4, // Good luck. Oh, and Absolvers will still receive these miracles - a failsafe to prevent accidental softlocking.
	)
	confess_lines = list(
		"FUCK YOU!",
		"PSYDON YET LYVES! PSYDON YET ENDURES!",
		"REBUKE THE HEATHEN, SUNDER THE MONSTER!",
		"WITH EVERY BROKEN BONE, I SWORE I LYVED!",
	)

/datum/patron/old_god/hopeful
	name = "Syonism" //I know this sounds a little too close to 'Zionism', but 'Syonicism' and 'Syonacism' feel way too clunky. Easy one-letter change if it feels too evil.
	domain = "Azuria, the Order of the Silver Psycross, and those who hold hope all throughout Psydonia."
	worshippers = "Virtuists, Paladins, Optimists, and the Goodhearted."
	desc = "... </br>God. The manifestation of maximal good, and the father of all. </br>He, who created reality for His children to frollick within. </br>He, who breathed lyfe into the Pantheon to shepherd His virtues. </br>He, who sacrificed His strength to strike down the Archdevil with the Comet Syon. </br>He, who yet slumbers to this dae; and who may yet still return."
	associated_faith = /datum/faith/old_god
	mob_traits = list(TRAIT_PSYDONIAN_GRIT)
	miracles = list(/obj/effect/proc_holder/spell/targeted/touch/orison			= CLERIC_ORI,
					/obj/effect/proc_holder/spell/self/check_boot				= CLERIC_T0,
					/obj/effect/proc_holder/spell/self/psydonpray				= CLERIC_T1,
	)
	traits_tier = list(TRAIT_PSYDONITE = CLERIC_T1)
	confess_lines = list(
		"MY GOD - WITH EVERY BROKEN BONE, I SWORE I LYVED!",
		"EVEN NOW, THERE IS STILL HOPE FOR MAN! AVE PSYDONIA!",
		"WITNESS ME, PSYDON; THE SACRIFICE MADE MANIFEST!",
	)

//////////////////////////////////
//  DID YOUR REMEMBER TO PACK?  //
//////////////////////////////////

/obj/effect/proc_holder/spell/self/check_boot
	name = "BOOTCHECK"
	desc = "'Now, where did I put that..?' </br>Checks your boot - or failing that, your surroundings - for something of use."
	releasedrain = 10
	chargedrain = 0
	chargetime = 0
	chargedloop = null
	sound = null
	overlay_state = "BOOTCHECK"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	recharge_time = 10 MINUTES
	miracle = TRUE
	devotion_cost = 30
	range = 1
	var/static/list/lootpool = list(/obj/item/flowercrown/rosa,
	/obj/item/bouquet/rosa,
	/obj/item/jingle_bells,
	/obj/item/bouquet/salvia,
	/obj/item/bouquet/calendula,
	/obj/item/roguecoin/gold,
	/obj/item/roguecoin/silver,
	/obj/item/roguecoin/copper,
	/obj/item/alch/atropa,
	/obj/item/alch/salvia,
	/obj/item/alch/artemisia,
	/obj/item/alch/rosa,
	/obj/item/rogueweapon/huntingknife/idagger/navaja,
	/obj/item/lockpick,
	/obj/item/reagent_containers/glass/bottle/alchemical/strpot,
	/obj/item/reagent_containers/glass/bottle/alchemical/endpot,
	/obj/item/reagent_containers/glass/bottle/alchemical/conpot,
	/obj/item/reagent_containers/glass/bottle/alchemical/lucpot,
	/obj/item/reagent_containers/glass/bottle/rogue/poison,
	/obj/item/reagent_containers/glass/bottle/rogue/healthpot,
	/obj/item/needle,
	/obj/item/natural/rock,
	/obj/item/natural/bundle/cloth,
	/obj/item/natural/bundle/fibers,
	/obj/item/clothing/suit/roguetown/armor/leather/hide/bikini,
	/obj/item/reagent_containers/glass/bottle/waterskin/milk,
	/obj/item/reagent_containers/food/snacks/rogue/bread,
	/obj/item/reagent_containers/food/snacks/grown/apple,
	/obj/item/natural/worms,
	/obj/item/natural/worms/leech,
	/obj/item/reagent_containers/food/snacks/rogue/psycrossbun,
	/obj/item/clothing/neck/roguetown/psicross,
	/obj/item/clothing/neck/roguetown/psicross/wood,
	/obj/item/rope/chain,
	/obj/item/rope,
	/obj/item/clothing/neck/roguetown/collar,
	/obj/item/natural/dirtclod,
	/obj/item/reagent_containers/glass/cup/wooden,
	/obj/item/natural/glass,
	/obj/item/clothing/shoes/roguetown/sandals,
	/obj/item/alch/transisdust)
	
/obj/effect/proc_holder/spell/self/check_boot/cast(list/targets, mob/user = usr)
	. = ..()
	if(!ishuman(user))
		revert_cast()
		return FALSE
	var/mob/living/carbon/human/H = user
	var/obj/item/found_thing
	if(H.get_stress_amount() < 0 && H.STALUC > 10)
		found_thing = new /obj/item/roguecoin/gold
	else if(H.STALUC == 10)
		found_thing = new /obj/item/roguecoin/silver
	else
		found_thing = new /obj/item/roguecoin/copper
	to_chat(H, span_info("A coin in my boot? Psydon smiles upon me!"))
	H.put_in_hands(found_thing, FALSE)
	if(prob(H.STALUC + H.get_skill_level(associated_skill)))
		var/obj/item/extra_thing = pick(lootpool)
		new extra_thing(get_turf(user))
		to_chat(H, span_info("Ah, of course! I almost forgot I had this stashed away for a perfect occasion."))
		H.put_in_hands(extra_thing, FALSE)
	return TRUE



/////////////////////////////////
// DOES HE HEAR YOUR PRAYER?   //
/////////////////////////////////

/datum/patron/old_god/can_pray(mob/living/follower)
	. = ..()
	. = TRUE
	// Allows prayer near psycross.
	for(var/obj/structure/fluff/psycross/cross in view(4, get_turf(follower)))
		if(cross.divine == FALSE)
			to_chat(follower, span_danger("That defiled cross interupts my prayers!"))
			return FALSE
		return TRUE
	// Allows prayer if raining and outside. Psydon weeps.
	if(GLOB.forecast == "rain")
		if(istype(get_area(follower), /area/rogue/outdoors))
			return TRUE
	// Allows prayer if bleeding.
	if(follower.bleed_rate > 0)
		return TRUE
	// Allows prayer if holding silver psycross.
	if(istype(follower.get_active_held_item(), /obj/item/clothing/neck/roguetown/psicross/silver))
		return TRUE
	to_chat(follower, span_danger("For Psydon to hear my prayer I must either must be near a Pantheon Cross, shed my own blood in penitence, hold one of his silver holy symbols, or bask in his rain; as Psydon weeps for his children.."))
	return FALSE

//////////////////////////////////
// ENDURE, AS HE WOULD.         //
//////////////////////////////////

/obj/effect/proc_holder/spell/invoked/psydonendure
	name = "ENDURE"
	desc = "Invoke an envigoring prayer for those who're faltering in strength. </br>Provides minor health regeneration, staunches the target's bleeding, and helps to alleviate those who're struggling to breathe. The more valuable a caster's psycross is, the more health that is restored unto the target - this is further increased if they have been mortally wounded."
	overlay_state = "ENDURE"
	releasedrain = 20
	chargedrain = 0
	chargetime = 0
	range = 2
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/magic/ENDVRE.ogg'
	invocations = list("ON YOUR FEET!","ENDURE!","HOLD FAST!") // holy larp yelling for healing is silly
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = FALSE
	recharge_time = 30 SECONDS
	miracle = TRUE
	devotion_cost = 40

/obj/effect/proc_holder/spell/invoked/psydonendure/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		var/brute = target.getBruteLoss()
		var/burn = target.getFireLoss()
		var/list/wAmount = target.get_wounds()
		var/conditional_buff = FALSE
		var/situational_bonus = 0
		var/psicross_bonus = 0
		var/pp = 0
		var/damtotal = brute + burn
		var/zcross_trigger = FALSE
		if(user.patron?.undead_hater && (target.mob_biotypes & MOB_UNDEAD)) // YOU ARE NO LONGER MORTAL. NO LONGER OF HIM. PSYDON WEEPS.
			target.visible_message(span_danger("[target] shudders with a strange stirring feeling!"), span_userdanger("It hurts. You feel like weeping."))
			target.adjustBruteLoss(40)			
			return TRUE

		// Bonuses! Flavour! SOVL!
		for(var/obj/item/clothing/neck/current_item in target.get_equipped_items(TRUE))
			if(current_item.type in list(/obj/item/clothing/neck/roguetown/psicross/inhumen/aalloy, /obj/item/clothing/neck/roguetown/psicross, /obj/item/clothing/neck/roguetown/psicross/wood, /obj/item/clothing/neck/roguetown/psicross/aalloy, /obj/item/clothing/neck/roguetown/psicross/silver,	/obj/item/clothing/neck/roguetown/psicross/g))
				pp += 1
				if(pp >= 12 & target == user) // A harmless easter-egg. Only applies on self-cast. You'd have to be pretty deliberate to wear 12 of them.
					target.visible_message(span_danger("[target]'s many psycrosses reverberate with a strange, ephemeral sound..."), span_userdanger("HE must be waking up! I can hear it! I'm ENDURING so much!"))
					playsound(user, 'sound/magic/PSYDONE.ogg', 100, FALSE)
					sleep(60)
					user.psydo_nyte()
					user.playsound_local(user, 'sound/misc/psydong.ogg', 100, FALSE)
					sleep(20)
					user.psydo_nyte()
					user.playsound_local(user, 'sound/misc/psydong.ogg', 100, FALSE)
					sleep(15)
					user.psydo_nyte()
					user.playsound_local(user, 'sound/misc/psydong.ogg', 100, FALSE)
					sleep(10)
					user.gib()
					return FALSE
				
				switch(current_item.type) // Target-based worn Psicross Piety bonus. For fun.
					if(/obj/item/clothing/neck/roguetown/psicross/wood)
						psicross_bonus = 0.1				
					if(/obj/item/clothing/neck/roguetown/psicross/aalloy)
						psicross_bonus = 0.2	
					if(/obj/item/clothing/neck/roguetown/psicross)
						psicross_bonus = 0.3
					if(/obj/item/clothing/neck/roguetown/psicross/silver)
						psicross_bonus = 0.4	
					if(/obj/item/clothing/neck/roguetown/psicross/g) // PURITY AFLOAT.
						psicross_bonus = 0.5
					if(/obj/item/clothing/neck/roguetown/psicross/inhumen/aalloy)
						zcross_trigger = TRUE	

		if(damtotal >= 300) // ARE THEY ENDURING MUCH, IN ONE WAY OR ANOTHER?
			situational_bonus += 0.3

		if(wAmount.len > 5)	
			situational_bonus += 0.3		
	
		if (situational_bonus > 0)
			conditional_buff = TRUE

		target.visible_message(span_info("A strange stirring feeling pours from [target]!"), span_info("Sentimental thoughts drive away my pain..."))
		var/psyhealing = 3
		psyhealing += psicross_bonus
		if (conditional_buff & !zcross_trigger)
			to_chat(user, "In <b>ENDURING</b> so much, become <b>EMBOLDENED</b>!")
			psyhealing += situational_bonus
	
		if (zcross_trigger)
			user.visible_message(span_warning("[user] shuddered. Something's very wrong."), span_userdanger("Cold shoots through my spine. Something laughs at me for trying."))
			user.playsound_local(user, 'sound/misc/zizo.ogg', 25, FALSE)
			user.adjustBruteLoss(25)		
			return FALSE

		target.apply_status_effect(/datum/status_effect/buff/psyhealing, psyhealing)
		return TRUE

	revert_cast()
	return FALSE

//////////////////////////////////
// A MOMENT TO BREATHE.         //
//////////////////////////////////

/obj/effect/proc_holder/spell/self/psydonpray
	name = "PRAY"
	desc = "Catch your breath, recite a psalm betwixt huffs, and gather your wits before continuing forth. </br>‎  </br>Provides minor health regeneration while standing still. The more damage that a caster has sustained - and the more valuable that their worn psycross is, the more health that they'll regenerate with each cycle."
	overlay_state = "limb_attach"
	releasedrain = 15
	chargedrain = 0
	chargetime = 0
	range = 2
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = null
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = FALSE
	recharge_time = 5 SECONDS
	miracle = TRUE
	devotion_cost = 0

/obj/effect/proc_holder/spell/self/psydonpray/cast(mob/living/carbon/human/user) //Lesser version of 'RESPITE' and 'PERSIST'. Offers minor health regeneration.
	. = ..()
	if(!ishuman(user))
		revert_cast()
		return FALSE
		
	var/mob/living/carbon/human/H = user
	var/brute = H.getBruteLoss()
	var/burn = H.getFireLoss()
	var/conditional_buff = FALSE
	var/zcross_trigger = FALSE
	var/sit_bonus1 = 0
	var/sit_bonus2 = 0
	var/psicross_bonus = 0

	for(var/obj/item/clothing/neck/current_item in H.get_equipped_items(TRUE))
		if(current_item.type in list(/obj/item/clothing/neck/roguetown/psicross/inhumen/aalloy, /obj/item/clothing/neck/roguetown/psicross, /obj/item/clothing/neck/roguetown/psicross/wood, /obj/item/clothing/neck/roguetown/psicross/aalloy, /obj/item/clothing/neck/roguetown/psicross/silver, /obj/item/clothing/neck/roguetown/psicross/g))
			switch(current_item.type) // Worn Psicross Piety bonus. For fun.
				if(/obj/item/clothing/neck/roguetown/psicross/wood)
					psicross_bonus = -1				
				if(/obj/item/clothing/neck/roguetown/psicross/aalloy)
					psicross_bonus = -2
				if(/obj/item/clothing/neck/roguetown/psicross)
					psicross_bonus = -4
				if(/obj/item/clothing/neck/roguetown/psicross/silver)
					psicross_bonus = -6
				if(/obj/item/clothing/neck/roguetown/psicross/g) // PURITY AFLOAT.
					psicross_bonus = -7
				if(/obj/item/clothing/neck/roguetown/psicross/inhumen/aalloy)
					zcross_trigger = TRUE		
	if(brute > 100)
		sit_bonus1 = -1
	if(brute > 150)
		sit_bonus1 = -2
	if(brute > 200)
		sit_bonus1 = -3	
	if(brute > 300)
		sit_bonus1 = -4		
	if(brute > 350)
		sit_bonus1 = -7
	if(brute > 400)
		sit_bonus1 = -10	
		
	if(burn > 100)
		sit_bonus2 = -1
	if(burn > 150)
		sit_bonus2 = -2
	if(burn > 200)
		sit_bonus2 = -3	
	if(burn > 300)
		sit_bonus2 = -4		
	if(burn > 350)
		sit_bonus2 = -7
	if(burn > 400)
		sit_bonus2 = -10									

	if(sit_bonus1 || sit_bonus2)				
		conditional_buff = TRUE

	var/bruthealval = -5 + psicross_bonus + sit_bonus1
	var/burnhealval = -5 + psicross_bonus + sit_bonus2

	to_chat(H, span_info("I take a moment to collect myself..."))
	if(zcross_trigger)
		user.visible_message(span_warning("[user] shuddered. Something's very wrong."), span_userdanger("Cold shoots through my spine. Something laughs at me for trying."))
		user.playsound_local(user, 'sound/misc/zizo.ogg', 25, FALSE)
		user.adjustBruteLoss(25)		
		return FALSE

	if(do_after(H, 50))
		playsound(H, 'sound/magic/psydonrespite.ogg', 100, TRUE)
		new /obj/effect/temp_visual/psyheal_rogue(get_turf(H), "#e4e4e4") 
		new /obj/effect/temp_visual/psyheal_rogue(get_turf(H), "#e4e4e4") 
		H.adjustBruteLoss(bruthealval)
		H.adjustFireLoss(burnhealval)
		if (conditional_buff)
			to_chat(user, span_info("My pain gives way to a sense of furthered clarity before returning again, dulled."))
		user.devotion?.update_devotion(-15)
		to_chat(user, "<font color='purple'>I lose 15 devotion!</font>")
		cast(user)	
		return TRUE
	else
		to_chat(H, span_warning("My thoughts and sense of quiet escape me."))	
		return FALSE					

//////////////////////////////////
// SYONIC TECHNIQUE: SPIRITBOMB //
//////////////////////////////////

/obj/effect/proc_holder/spell/targeted/psydondefy
	name = "DEFY"
	desc = "Become a living conduit for the energies that teem from Syon's fragments, so that you may rebuke the Archdevil once more. </br>‎  </br>Unleashes a holy shockwave, barraging the deathless with explosive force. All deadites, skeletons, and vampyres within the caster's sight will be automatically struck. Requires several seconds to fully charge, and - upon release - completely exhausts the caster."
	range = 7
	overlay_state = "DEFY"
	chargedrain = 1
	releasedrain = 222
	no_early_release = TRUE
	chargetime = 5 SECONDS
	recharge_time = 77 SECONDS
	antimagic_allowed = FALSE
	cast_without_targets = FALSE
	max_targets = 777
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	warnie = "sydwarning"
	sound = 'sound/magic/revive.ogg'
	associated_skill = /datum/skill/magic/holy
	invocations = list("NGHHGRAUUUUUUGH!!!","IN HIS NNAAAAAAAAAME!!!","PSSSSSSSSYDOOOOOOOOON!!!")
	invocation_type = "shout" //You are forced to shout this out. Let them hear your cry.
	miracle = TRUE
	devotion_cost = 77

/obj/effect/proc_holder/spell/targeted/psydondefy/cast(list/targets,mob/living/user = usr)
	user.emote("rage")
	var/prob2explode = 100
	if(user && user.mind)
		prob2explode = 0
		for(var/i in 1 to user.get_skill_level(/datum/skill/magic/holy))
			prob2explode += 30
	for(var/mob/living/L in targets)
		var/isvampire = FALSE
		var/iszombie = FALSE
		if(L.stat == DEAD)
			continue
		if(L.mind)
			var/datum/antagonist/vampire/V = L.mind.has_antag_datum(/datum/antagonist/vampire)
			if(V && !SEND_SIGNAL(L, COMSIG_DISGUISE_STATUS))
				isvampire = TRUE
			if(L.mind.has_antag_datum(/datum/antagonist/zombie))
				iszombie = TRUE
			if(L.mind.special_role == "Vampire Lord" || L.mind.special_role == "Lich")	//Automatically invokes a counterspell, stunning the caster and throwing them straight at the antagonist.
				user.visible_message(span_warning("[L] resists the holy shockwave!"), span_userdanger("[L] invokes an unholy ward, disrupting my concentration! I'm thrown into the holy shockwave!"))
				user.Stun(50)
				user.throw_at(get_ranged_target_turf(user, get_dir(user,L), 7), 7, 1, L, spin = TRUE)
				return
		if((L.mob_biotypes & MOB_UNDEAD) || isvampire || iszombie)
			var/vamp_prob = prob2explode
			if(isvampire)
				vamp_prob -= 59
			if(prob(vamp_prob))
				L.visible_message("<span class='warning'>[L] is sundered by the holy shockwave!", "<span class='danger'>I'm sundered by a holy shockwave!")
				explosion(get_turf(L), light_impact_range = 1, flame_range = 1, smoke = FALSE)
				L.Stun(50)
			else
				L.visible_message(span_warning("[L] withstands the holy shockwave's barrage!"), span_userdanger("I withstand the holy shockwave's barrage!"))
	..()
	return TRUE
