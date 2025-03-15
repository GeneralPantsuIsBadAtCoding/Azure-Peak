// Define the signals needed for the flagellant spells
#define COMSIG_MOB_APPLY_DAMAGE "mob_apply_damage"
// Define the signals that aren't defined elsewhere in this context
#define COMSIG_HUMAN_ATTACKED "human_attacked"
#define COMSIG_ATTACK_LANDED "attack_landed"
// These are already defined elsewhere in the codebase, so we'll use them directly
// #define COMSIG_LIVING_DEATH "living_death"
// #define COMSIG_LIVING_STATUS_UNCONSCIOUS "living_status_unconscious"
#define COMPONENT_CANCEL_ATTACK_CHAIN (1<<0)
// Define bleeding flag since it's not available in this codebase
#define BODYPART_BLEEDING (1<<1)

/obj/effect/proc_holder/spell/invoked/damage_transfer
	name = "Martyr's Shield"
	desc = "Take the suffering of others upon yourself."
	overlay_state = "damage_transfer"
	releasedrain = 0
	chargedrain = 0
	chargetime = 0
	range = -1 // Unlimited range
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/magic/diagnose.ogg'
	invocation = "PATI PRO ALIIS!"
	invocation_type = "shout"
	associated_skill = /datum/skill/misc/medicine
	antimagic_allowed = TRUE
	charge_max = 300 // 30 seconds cooldown
	miracle = FALSE
	devotion_cost = 0
	var/mob/living/carbon/human/linked_target = null
	var/mob/living/carbon/human/linked_caster = null
	var/transfer_active = FALSE
	var/last_attack_info = null

/obj/effect/proc_holder/spell/invoked/damage_transfer/cast(list/targets, mob/living/user)
	if(!ishuman(targets[1]))
		to_chat(user, span_warning("This spell only works on humans!"))
		return FALSE
	
	var/mob/living/carbon/human/H = targets[1]
	
	if(H == user)
		to_chat(user, span_warning("You cannot cast this on yourself!"))
		return FALSE
	
	if(H.stat >= DEAD)
		to_chat(user, span_warning("[H] is already dead!"))
		return FALSE
	
	// Store references to the target and caster
	linked_target = H
	linked_caster = user
	
	// Register signals to intercept attacks and damage
	RegisterSignal(H, COMSIG_HUMAN_ATTACKED, PROC_REF(on_target_attacked))
	RegisterSignal(H, COMSIG_ATTACK_LANDED, PROC_REF(on_attack_landed))
	RegisterSignal(H, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(on_target_damaged))
	RegisterSignal(H, COMSIG_LIVING_STATUS_UNCONSCIOUS, PROC_REF(on_target_incap))
	
	// Visual effects
	var/obj/effect/temp_visual/dir_setting/bloodsplatter/B = new(get_turf(user), get_dir(user, H))
	B.color = "#FFFFFF"
	
	// Notify the user and target
	to_chat(user, span_notice("You connect with [H]'s suffering. Their pain will now be yours."))
	to_chat(H, span_warning("[user] connects with your suffering. Your pain will now be theirs."))
	
	// Set a timer to end the effect after 2 minutes
	addtimer(CALLBACK(src, PROC_REF(end_damage_transfer)), 2 MINUTES)
	
	return TRUE

/obj/effect/proc_holder/spell/invoked/damage_transfer/proc/on_target_incap(datum/source, flag, old_value, new_value)
	if(!isliving(source) || !linked_caster || !linked_target)
		return
	
	if(new_value && !old_value)
		var/mob/living/L = source
		var/mob/living/carbon/human/H = linked_caster
		
		to_chat(L, span_warning("The connection with [H] breaks as you fall unconscious!"))
		to_chat(H, span_warning("The connection with [L] breaks as they fall unconscious!"))
		
		end_damage_transfer()

/obj/effect/proc_holder/spell/invoked/damage_transfer/proc/end_damage_transfer()
	if(!linked_target || !linked_caster)
		return
	
	// Unregister all signals
	UnregisterSignal(linked_target, list(
		COMSIG_HUMAN_ATTACKED,
		COMSIG_ATTACK_LANDED,
		COMSIG_MOB_APPLY_DAMAGE,
		COMSIG_LIVING_STATUS_UNCONSCIOUS
	))
	
	// Notify the user and target
	if(!QDELETED(linked_caster))
		to_chat(linked_caster, span_notice("Your connection with [linked_target]'s suffering fades."))
	
	if(!QDELETED(linked_target))
		to_chat(linked_target, span_notice("The connection with [linked_caster] fades."))
	
	// Clear references
	linked_target = null
	linked_caster = null
	transfer_active = FALSE
	last_attack_info = null

// This is called when an attack is initiated against the target
/obj/effect/proc_holder/spell/invoked/damage_transfer/proc/on_target_attacked(datum/source, mob/living/attacker, attack_type)
	if(!isliving(source) || !attacker || !linked_caster || !linked_target)
		return
	
	// Store information about the attack for later use
	last_attack_info = list(
		"attacker" = attacker,
		"attack_type" = attack_type,
		"zone_selected" = attacker.zone_selected,
		"weapon" = attacker.get_active_held_item()
	)
	
	// Immediately redirect the attack to the caster
	if(attacker && linked_caster)
		// Change the attacker's target to the caster
		attacker.lastattacker = linked_caster
		attacker.lastattackerckey = linked_caster.ckey
		
		// Notify everyone about the redirection
		to_chat(attacker, span_warning("Your attack is redirected to [linked_caster]!"))
		to_chat(linked_target, span_notice("Your wounds are taken by [linked_caster]!"))
		to_chat(linked_caster, span_warning("You feel [linked_target]'s pain!"))
		
		// Visual effects
		new /obj/effect/temp_visual/heal(get_turf(linked_target), "#FFFFFF")
		new /obj/effect/temp_visual/dir_setting/bloodsplatter(get_turf(linked_caster), get_dir(linked_target, linked_caster))
		
		// Set the transfer flag to active
		transfer_active = TRUE
		
		// Return TRUE to indicate we're handling the attack
		return TRUE
	
	return FALSE

// This is called when an attack successfully lands on the target (not dodged or parried)
/obj/effect/proc_holder/spell/invoked/damage_transfer/proc/on_attack_landed(datum/source, mob/living/attacker, attack_type)
	if(!isliving(source) || !attacker || !linked_caster || !linked_target || !transfer_active)
		transfer_active = FALSE
		last_attack_info = null
		return
	
	// Reset the transfer flag
	transfer_active = FALSE
	last_attack_info = null
	
	return

// This is called when the target takes damage
/obj/effect/proc_holder/spell/invoked/damage_transfer/proc/on_target_damaged(datum/source, damage, damagetype, def_zone)
	if(!isliving(source) || !linked_caster || !linked_target)
		return
	
	var/mob/living/L = source
	var/mob/living/carbon/human/H = linked_caster
	
	if(L && H && iscarbon(L))
		// Prevent the target from taking damage
		L.adjustBruteLoss(-damage)
		
		// Apply the damage to the caster instead
		if(damagetype == BRUTE)
			H.adjustBruteLoss(damage)
		else if(damagetype == BURN)
			H.adjustFireLoss(damage)
		else if(damagetype == TOX)
			H.adjustToxLoss(damage)
		else if(damagetype == OXY)
			H.adjustOxyLoss(damage)
		else if(damagetype == CLONE)
			H.adjustCloneLoss(damage)
		else if(damagetype == STAMINA)
			H.adjustStaminaLoss(damage)
		
		// Handle bleeding transfer
		if(iscarbon(L) && iscarbon(H))
			var/mob/living/carbon/C_target = L
			var/mob/living/carbon/C_caster = H
			
			// Get the bodypart that was hit
			var/obj/item/bodypart/target_part = C_target.get_bodypart(def_zone)
			var/obj/item/bodypart/caster_part = C_caster.get_bodypart(def_zone)
			
			if(target_part && caster_part)
				// Transfer bleeding status
				if(target_part.status & BODYPART_BLEEDING)
					target_part.status &= ~BODYPART_BLEEDING
					caster_part.status |= BODYPART_BLEEDING
				
				// Transfer bleeding status using mob's bleed_rate instead of bodypart
				if(C_target.bleed_rate > 0)
					var/bleed_amount = C_target.bleed_rate
					C_target.bleed_rate = 0
					C_caster.bleed_rate += bleed_amount
					C_target.update_damage_overlays()
					C_caster.update_damage_overlays()
		
		// Visual effects
		new /obj/effect/temp_visual/heal(get_turf(L), "#FF0000")
		new /obj/effect/temp_visual/dir_setting/bloodsplatter(get_turf(H), get_dir(L, H))
		
		return TRUE
	
	return FALSE

/obj/effect/proc_holder/spell/invoked/affliction_transfer
	name = "Penitent's Absolution"
	desc = "Take the afflictions of others upon yourself."
	overlay_state = "affliction_transfer"
	releasedrain = 0
	chargedrain = 0
	chargetime = 0
	range = -1 // Unlimited range
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/magic/diagnose.ogg'
	invocation = "SUSCIPE DOLOREM!"
	invocation_type = "shout"
	associated_skill = /datum/skill/misc/medicine
	antimagic_allowed = TRUE
	charge_max = 300 // 30 seconds cooldown
	devotion_cost = 0

/obj/effect/proc_holder/spell/invoked/affliction_transfer/cast(list/targets, mob/living/user)
	if(!ishuman(targets[1]))
		to_chat(user, span_warning("This spell only works on humans!"))
		return FALSE
	
	var/mob/living/carbon/human/H = targets[1]
	
	if(H == user)
		to_chat(user, span_warning("You cannot cast this on yourself!"))
		return FALSE
	
	// Special case for dead targets
	if(H.stat >= DEAD)
		// Check if the target has a head, brain, and heart
		var/obj/item/bodypart/head = H.get_bodypart("head")
		var/obj/item/organ/brain/brain = H.getorganslot(ORGAN_SLOT_BRAIN)
		var/obj/item/organ/heart/heart = H.getorganslot(ORGAN_SLOT_HEART)
		
		if(head && brain && heart)
			to_chat(user, span_warning("You attempt to revive [H] by taking their death upon yourself!"))
			
			// Dramatic effect
			user.visible_message(span_danger("[user] grabs [H] and begins to glow with an eerie light!"))
			
			// Create visual effects
			new /obj/effect/temp_visual/dir_setting/bloodsplatter(get_turf(user), get_dir(H, user))
			new /obj/effect/temp_visual/dir_setting/bloodsplatter(get_turf(H), get_dir(user, H))
			
			// Kill the caster
			user.death()
			
			// Revive the target
			H.revive(full_heal = TRUE, admin_revive = FALSE)
			
			// Notify the target
			to_chat(H, span_warning("[user] has sacrificed themselves to bring you back to life!"))
			
			return TRUE
		else
			to_chat(user, span_warning("[H] is missing vital organs and cannot be revived!"))
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
	
	// Transfer bleeding wounds
	if(iscarbon(H) && iscarbon(user))
		var/mob/living/carbon/C_target = H
		var/mob/living/carbon/C_caster = user
		
		// Transfer bleeding from each bodypart
		for(var/obj/item/bodypart/target_part in C_target.bodyparts)
			var/obj/item/bodypart/caster_part = C_caster.get_bodypart(target_part.body_zone)
			
			if(target_part && caster_part)
				// Transfer bleeding status
				if(target_part.status & BODYPART_BLEEDING)
					target_part.status &= ~BODYPART_BLEEDING
					caster_part.status |= BODYPART_BLEEDING
		
		// Transfer overall bleeding rate
		if(C_target.bleed_rate > 0)
			var/bleed_amount = C_target.bleed_rate
			C_target.bleed_rate = 0
			C_caster.bleed_rate += bleed_amount
		
		// Update damage overlays
		C_target.update_damage_overlays()
		C_caster.update_damage_overlays()
	
	// Transfer missing limbs (if possible)
	for(var/zone in list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG))
		if(!H.get_bodypart(zone) && user.get_bodypart(zone))
			var/obj/item/bodypart/limb = user.get_bodypart(zone)
			limb.drop_limb(TRUE)
			H.visible_message(span_warning("[user]'s [limb.name] transforms and attaches to [H]!"))
			limb.attach_limb(H)
	
	// Transfer missing organs (if possible)
	for(var/slot in list(ORGAN_SLOT_HEART, ORGAN_SLOT_LUNGS, ORGAN_SLOT_LIVER, ORGAN_SLOT_EYES, ORGAN_SLOT_EARS, ORGAN_SLOT_TONGUE))
		if(!H.getorganslot(slot) && user.getorganslot(slot))
			var/obj/item/organ/organ = user.getorganslot(slot)
			organ.Remove(user)
			H.visible_message(span_warning("[user]'s [organ.name] transforms and enters [H]'s body!"))
			organ.Insert(H)
	
	// Visual effects
	user.visible_message(span_danger("[user] takes [H]'s afflictions upon themselves!"))
	playsound(get_turf(user), 'sound/magic/diagnose.ogg', 50, TRUE)
	
	new /obj/effect/temp_visual/heal(get_turf(H), "#00FF00")
	new /obj/effect/temp_visual/dir_setting/bloodsplatter(get_turf(user), get_dir(H, user))
	
	// Notify the user and target
	to_chat(user, span_warning("You take [H]'s afflictions upon yourself!"))
	to_chat(H, span_notice("[user] takes your afflictions upon themselves!"))
	
	return TRUE

/obj/effect/proc_holder/spell/invoked/burden_exchange
	name = "Divine Transposition"
	desc = "Exchange your position with another, taking their burdens upon yourself."
	overlay_state = "burden_exchange"
	releasedrain = 0
	chargedrain = 0
	chargetime = 0
	range = -1 // Unlimited range
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/magic/diagnose.ogg'
	invocation = "COMMUTATIO LOCORUM!"
	invocation_type = "shout"
	associated_skill = /datum/skill/misc/medicine
	antimagic_allowed = TRUE
	charge_max = 300 // 30 seconds cooldown
	miracle = FALSE
	devotion_cost = 0

/obj/effect/proc_holder/spell/invoked/burden_exchange/cast(list/targets, mob/living/user)
	if(!isliving(targets[1]))
		to_chat(user, span_warning("This spell only works on living beings!"))
		return FALSE
	
	var/mob/living/target = targets[1]
	
	if(target == user)
		to_chat(user, span_warning("You cannot cast this on yourself!"))
		return FALSE
	
	// Get the locations of the caster and target
	var/turf/caster_loc = get_turf(user)
	var/turf/target_loc = get_turf(target)
	
	// Check if either location is invalid
	if(!caster_loc || !target_loc)
		to_chat(user, span_warning("One of the locations is invalid!"))
		return FALSE
	
	// Visual effects before teleport
	user.visible_message(span_danger("[user] and [target] begin to shimmer with mystical energy!"))
	playsound(get_turf(user), 'sound/magic/diagnose.ogg', 50, TRUE)
	
	new /obj/effect/temp_visual/heal(get_turf(target), "#FF00FF")
	new /obj/effect/temp_visual/heal(get_turf(user), "#FF00FF")
	
	// Teleport the caster and target
	var/turf/temp_loc = get_turf(user) // Store the caster's location temporarily
	
	// Teleport the caster to the target's location
	user.forceMove(target_loc)
	
	// Teleport the target to the caster's original location
	target.forceMove(temp_loc)
	
	// Visual effects after teleport
	playsound(get_turf(user), 'sound/magic/diagnose.ogg', 50, TRUE)
	playsound(get_turf(target), 'sound/magic/diagnose.ogg', 50, TRUE)
	
	new /obj/effect/temp_visual/heal(get_turf(target), "#FF00FF")
	new /obj/effect/temp_visual/heal(get_turf(user), "#FF00FF")
	
	// Notify the user and target
	to_chat(user, span_warning("You exchange places with [target]!"))
	if(istype(target, /mob/living/carbon))
		to_chat(target, span_warning("[user] exchanges places with you!"))
	
	return TRUE

/obj/effect/proc_holder/spell/invoked/damage_link
	name = "Flagellant's Offering"
	desc = "Share your suffering with another, transferring a portion of your damage to them."
	overlay_state = "damage_link"
	releasedrain = 0
	chargedrain = 0
	chargetime = 0
	range = -1 // Unlimited range
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/magic/diagnose.ogg'
	invocation = "DIVIDE ET IMPERA DOLOREM!"
	invocation_type = "shout"
	associated_skill = /datum/skill/misc/medicine
	antimagic_allowed = TRUE
	charge_max = 300 // 30 seconds cooldown
	miracle = FALSE
	devotion_cost = 0

/obj/effect/proc_holder/spell/invoked/damage_link/cast(list/targets, mob/living/user)
	if(!isliving(targets[1]))
		to_chat(user, span_warning("This spell only works on living beings!"))
		return FALSE
	
	var/mob/living/target = targets[1]
	
	if(target == user)
		to_chat(user, span_warning("You cannot cast this on yourself!"))
		return FALSE
	
	// Calculate 20% of the caster's current damage
	var/brute_transfer = user.getBruteLoss() * 0.2
	var/burn_transfer = user.getFireLoss() * 0.2
	var/tox_transfer = user.getToxLoss() * 0.2
	var/oxy_transfer = user.getOxyLoss() * 0.2
	var/clone_transfer = user.getCloneLoss() * 0.2
	
	// Heal the caster
	user.adjustBruteLoss(-brute_transfer)
	user.adjustFireLoss(-burn_transfer)
	user.adjustToxLoss(-tox_transfer)
	user.adjustOxyLoss(-oxy_transfer)
	user.adjustCloneLoss(-clone_transfer)
	
	// Apply damage to the target
	target.adjustBruteLoss(brute_transfer)
	target.adjustFireLoss(burn_transfer)
	target.adjustToxLoss(tox_transfer)
	target.adjustOxyLoss(oxy_transfer)
	target.adjustCloneLoss(clone_transfer)
	
	// Transfer bleeding if possible
	if(iscarbon(user) && iscarbon(target))
		var/mob/living/carbon/C_caster = user
		var/mob/living/carbon/C_target = target
		
		// Transfer 20% of bleeding rate
		if(C_caster.bleed_rate > 0)
			var/bleed_amount = C_caster.bleed_rate * 0.2
			C_caster.bleed_rate -= bleed_amount
			C_target.bleed_rate += bleed_amount
			
			// Transfer bleeding status from bodyparts
			for(var/obj/item/bodypart/caster_part in C_caster.bodyparts)
				var/obj/item/bodypart/target_part = C_target.get_bodypart(caster_part.body_zone)
				
				if(caster_part && target_part)
					if(caster_part.status & BODYPART_BLEEDING)
						target_part.status |= BODYPART_BLEEDING
			
			// Update damage overlays
			C_caster.update_damage_overlays()
			C_target.update_damage_overlays()
	
	// Visual effects
	user.visible_message(span_danger("[user] transfers some of their suffering to [target]!"))
	playsound(get_turf(user), 'sound/magic/diagnose.ogg', 50, TRUE)
	
	new /obj/effect/temp_visual/heal(get_turf(user), "#FF00FF")
	new /obj/effect/temp_visual/dir_setting/bloodsplatter(get_turf(target), get_dir(user, target))
	
	// Notify the user and target
	to_chat(user, span_notice("You transfer some of your suffering to [target]."))
	if(istype(target, /mob/living/carbon))
		to_chat(target, span_warning("[user] transfers some of their suffering to you!"))
	
	return TRUE

