/obj/effect/proc_holder/spell/invoked/psydonlux_tamper
	name = "WEEP"
	overlay_state = "psydonweeps"
	releasedrain = 20
	chargedrain = 0
	chargetime = 0
	range = 2
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/magic/psydonbleeds.ogg'
	invocation = "I BLEED, SO THAT YOU MIGHT ENDURE!"
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = FALSE
	recharge_time = 30 SECONDS
	miracle = TRUE
	devotion_cost = 80

/obj/effect/proc_holder/spell/invoked/psydonlux_tamper/cast(list/targets, mob/living/user)
	if(!ishuman(targets[1]))
		to_chat(user, span_warning("Their Lux doesn't need to be purified."))
		revert_cast()
		return FALSE
	
	var/mob/living/carbon/human/H = targets[1]
	
	if(H == user)
		to_chat(user, span_warning("My own Lux maintains purity."))
		revert_cast()
		return FALSE

	if(H.stat == DEAD)
		to_chat(user, span_warning("[H]'s Lux is gone. I can't do anything, anymore."))
		user.emote("cry")
		revert_cast()
		return FALSE	
	
	// Transfer wounds.
	if(ishuman(H) && ishuman(user))
		var/mob/living/carbon/human/C_target = H
		var/mob/living/carbon/human/C_caster = user
		var/list/datum/wound/tw_List = C_target.get_wounds()

		if(!tw_List.len)
			revert_cast()
			return FALSE

		//Transfer wounds from each bodypart.
		for(var/datum/wound/targetwound in tw_List)
			if (istype(targetwound, /datum/wound/dismemberment))
				continue				
			if (istype(targetwound, /datum/wound/facial))
				continue					
			if (istype(targetwound, /datum/wound/fracture/head))
				continue				
			if (istype(targetwound, /datum/wound/fracture/neck))
				continue
			if (istype(targetwound, /datum/wound/cbt/permanent))
				continue			
			var/obj/item/bodypart/c_BP = C_caster.get_bodypart(targetwound.bodypart_owner.body_zone)
			c_BP.add_wound(targetwound.type)
			var/obj/item/bodypart/t_BP = C_target.get_bodypart(targetwound.bodypart_owner.body_zone)
			t_BP.remove_wound(targetwound.type)


	// Visual effects
	user.visible_message(span_danger("[user] purifies [H]'s wounds!"))
	playsound(get_turf(user), 'sound/magic/psydonbleeds.ogg', 50, TRUE)
	
	new /obj/effect/temp_visual/psyheal_rogue(get_turf(H), "#487e97") 
	new /obj/effect/temp_visual/psyheal_rogue(get_turf(H), "#487e97") 
	new /obj/effect/temp_visual/psyheal_rogue(get_turf(H), "#487e97") 
	new /obj/effect/temp_visual/psyheal_rogue(get_turf(user), "#487e97") 
	new /obj/effect/temp_visual/psyheal_rogue(get_turf(user), "#487e97") 
	new /obj/effect/temp_visual/psyheal_rogue(get_turf(user), "#487e97") 
	
	// Notify the user and target
	to_chat(user, span_notice("You purify their Lux with the merging of theirs and your own, for a mote."))
	to_chat(H, span_info("You feel a strange stirring sensation pour over your Lux, stealing your wounds."))
	return TRUE

/obj/effect/proc_holder/spell/self/psydonrespite
	name = "RESPITE"
	desc = "Stand still to focus on mending your injuries."
	overlay_state = "RESPITE"
	releasedrain = 20
	chargedrain = 0
	chargetime = 0
	range = 2
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = null
	invocation = ". . ."
	invocation_type = "none"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = FALSE
	recharge_time = 5 SECONDS
	miracle = TRUE
	devotion_cost = 0

/obj/effect/proc_holder/spell/self/psydonrespite/cast(mob/living/carbon/human/user) // It's a very tame self-heal. Nothing too special.
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
		if(current_item.type in list(/obj/item/clothing/neck/roguetown/zcross/aalloy, /obj/item/clothing/neck/roguetown/psicross, /obj/item/clothing/neck/roguetown/psicross/wood, /obj/item/clothing/neck/roguetown/psicross/aalloy, /obj/item/clothing/neck/roguetown/psicross/silver, /obj/item/clothing/neck/roguetown/psicross/g))
			switch(current_item.type) // Worn Psicross Piety bonus. For fun.
				if(/obj/item/clothing/neck/roguetown/psicross/wood)
					psicross_bonus = -2				
				if(/obj/item/clothing/neck/roguetown/psicross/aalloy)
					psicross_bonus = -4
				if(/obj/item/clothing/neck/roguetown/psicross)
					psicross_bonus = -5
				if(/obj/item/clothing/neck/roguetown/psicross/silver)
					psicross_bonus = -7
				if(/obj/item/clothing/neck/roguetown/psicross/g) // PURITY AFLOAT.
					psicross_bonus = -7
				if(/obj/item/clothing/neck/roguetown/zcross/aalloy)
					zcross_trigger = TRUE		
	if(brute > 100)
		sit_bonus1 = -2
	if(brute > 150)
		sit_bonus1 = -4
	if(brute > 200)
		sit_bonus1 = -6	
	if(brute > 300)
		sit_bonus1 = -8		
	if(brute > 350)
		sit_bonus1 = -10
	if(brute > 400)
		sit_bonus1 = -14	
		
	if(burn > 100)
		sit_bonus2 = -2
	if(burn > 150)
		sit_bonus2 = -4
	if(burn > 200)
		sit_bonus2 = -6	
	if(burn > 300)
		sit_bonus2 = -8		
	if(burn > 350)
		sit_bonus2 = -10
	if(burn > 400)
		sit_bonus2 = -14									

	if(sit_bonus1 || sit_bonus2)				
		conditional_buff = TRUE

	var/bruthealval = -7 + psicross_bonus + sit_bonus1
	var/burnhealval = -7 + psicross_bonus + sit_bonus2

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
		user.devotion?.update_devotion(-25)
		to_chat(user, "<font color='purple'>I lose 25 devotion!</font>")
		cast(user)	
		return TRUE
	else
		to_chat(H, span_warning("My thoughts and sense of quiet escape me."))	
		return FALSE					

/obj/effect/proc_holder/spell/invoked/psydonabsolve	
	name = "ABSOLVE"
	overlay_state = "psydonabsolves"
	releasedrain = 20
	chargedrain = 0
	chargetime = 0
	range = 1
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/magic/psyabsolution.ogg'
	invocation = "BE ABSOLVED!"
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = FALSE
	recharge_time = 30 SECONDS // 60 seconds cooldown
	miracle = TRUE
	devotion_cost = 80

/obj/effect/proc_holder/spell/invoked/psydonabsolve/cast(list/targets, mob/living/user)

	if(!ishuman(targets[1]))
		to_chat(user, span_warning("ABSOLUTION is for those who walk in HIS image!"))
		return FALSE
	
	var/mob/living/carbon/human/H = targets[1]
	
	if(H == user)
		to_chat(user, span_warning("You cannot ABSOLVE yourself!"))
		return FALSE
	
	// Special case for dead targets
	if(H.stat >= DEAD)
		// Check if the target has a head, brain, and heart
		var/obj/item/bodypart/head = H.get_bodypart("head")
		var/obj/item/organ/brain/brain = H.getorganslot(ORGAN_SLOT_BRAIN)
		var/obj/item/organ/heart/heart = H.getorganslot(ORGAN_SLOT_HEART)
		
		if(head && brain && heart)
			if(!H.mind)
				revert_cast()
				return FALSE
			if(HAS_TRAIT(H, TRAIT_NECRAS_VOW))
				to_chat(user, "This one has pledged themselves whole. There's nothing to ABSOLVE.")
				revert_cast()
				return FALSE	
			to_chat(user, span_warning("You attempt to revive [H] by ABSOLVING them of their death!"))
			// Dramatic effect
			user.visible_message(span_danger("[user] grabs [H] by the wrists, attempting to ABSOLVE them of their death!"))
			if(alert(H, "They want to ABSOLVE you. Will you let them?", "ABSOLUTION", "I'll allow it", "I refuse") != "I'll allow it")
				H.visible_message(span_notice("Nothing happens."))
				return FALSE
			// Create visual effects
			H.apply_status_effect(/datum/status_effect/buff/psyvived)
			// Kill the caster
			user.say("MY LYFE FOR YOURS! LYVE, AS DOES HE!", forced = TRUE)
			user.death()
			// Revive the target
			H.revive(full_heal = TRUE, admin_revive = FALSE)
			H.adjustOxyLoss(-H.getOxyLoss())
			H.grab_ghost(force = TRUE) // even suicides
			H.emote("breathgasp")
			H.Jitter(100)
			H.update_body()
			GLOB.azure_round_stats[STATS_LUX_REVIVALS]++
			ADD_TRAIT(H, TRAIT_IWASREVIVED, "[type]")
			H.apply_status_effect(/datum/status_effect/buff/psyvived)
			H.visible_message(span_notice("[H] is ABSOLVED of their death!"), span_green("I awake from the void."))		
			H.mind.remove_antag_datum(/datum/antagonist/zombie)
			H.remove_status_effect(/datum/status_effect/debuff/rotted_zombie)	//Removes the rotted-zombie debuff if they have it - Failsafe for it.
			H.apply_status_effect(/datum/status_effect/debuff/revived)	//Temp debuff on revive, your stats get hit temporarily. Doubly so if having rotted.
			return TRUE
		else
			to_chat(user, span_warning("[H] is missing vital organs and cannot be revived!"))
			revert_cast(user)
			return FALSE
	
	// Transfer afflictions from the target to the caster
	
	// Transfer damage
	var/brute_transfer = H.getBruteLoss()
	var/burn_transfer = H.getFireLoss()
	var/tox_transfer = H.getToxLoss()
	var/oxy_transfer = H.getOxyLoss()
	var/clone_transfer = H.getCloneLoss()
	
	// Heal the target
	H.adjustBruteLoss(-brute_transfer)
	H.adjustFireLoss(-burn_transfer)
	H.adjustToxLoss(-tox_transfer)
	H.adjustOxyLoss(-oxy_transfer)
	H.adjustCloneLoss(-clone_transfer)
	
	// Apply damage to the caster
	user.adjustBruteLoss(brute_transfer)
	user.adjustFireLoss(burn_transfer)
	user.adjustToxLoss(tox_transfer)
	user.adjustOxyLoss(oxy_transfer)
	user.adjustCloneLoss(clone_transfer)
	
	// Transfer blood
	var/blood_transfer = 0
	if(H.blood_volume < BLOOD_VOLUME_NORMAL)
		blood_transfer = BLOOD_VOLUME_NORMAL - H.blood_volume
		H.blood_volume = BLOOD_VOLUME_NORMAL
		user.blood_volume -= blood_transfer
		to_chat(user, span_warning("You feel your blood drain into [H]!"))
		to_chat(H, span_notice("You feel your blood replenish!"))

	// Visual effects
	user.visible_message(span_danger("[user] absolves [H]'s suffering!"))
	new /obj/effect/temp_visual/psyheal_rogue(get_turf(H), "#aa1717") 
	new /obj/effect/temp_visual/psyheal_rogue(get_turf(H), "#aa1717") 
	new /obj/effect/temp_visual/psyheal_rogue(get_turf(H), "#aa1717") 

	new /obj/effect/temp_visual/psyheal_rogue(get_turf(user), "#aa1717") 
	new /obj/effect/temp_visual/psyheal_rogue(get_turf(user), "#aa1717") 
	new /obj/effect/temp_visual/psyheal_rogue(get_turf(user), "#aa1717") 
	
	// Notify the user and target
	to_chat(user, span_warning("You absolve [H] of their injuries!"))
	to_chat(H, span_notice("[user] absolves you of your injuries!"))
	
	return TRUE
