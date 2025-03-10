// Define the signals needed for the flagellant spells
#define COMSIG_MOB_APPLY_DAMAGE "mob_apply_damage"
// Define bleeding flag since it's not available in this codebase
#define BODYPART_BLEEDING (1<<1)

/obj/effect/proc_holder/spell/invoked/damage_transfer
	name = "Vicarious Suffering"
	desc = "Transfer any damage your target receives to yourself instead, taking their pain as your own for 2 minutes."
	clothes_req = FALSE
	human_req = TRUE
	charge_max = 0  // No cooldown
	cooldown_min = 0 // No minimum cooldown
	range = -1        // Infinite range
	invocation = "Your pain shall be mine!"
	invocation_type = "shout"
	action_icon_state = "damage_transfer"
	school = "holy"
	
/obj/effect/proc_holder/spell/invoked/damage_transfer/cast(list/targets, mob/living/user)
	if(!ishuman(targets[1]))
		to_chat(user, span_warning("You can only cast this on people!"))
		return FALSE
		
	var/mob/living/carbon/human/human_target = targets[1]
	if(human_target.stat == DEAD)
		to_chat(user, span_warning("[human_target] is dead!"))
		return FALSE
	
	to_chat(user, span_notice("You prepare to take [human_target]'s suffering as your own..."))
	to_chat(human_target, span_warning("[user] begins a ritual to take your suffering!"))
	
	if(do_after(user, 30, target = human_target))
		to_chat(user, span_notice("You are now bound to [human_target]'s pain for 2 minutes."))
		to_chat(human_target, span_notice("[user] has bound themselves to your suffering."))
		
		RegisterSignal(human_target, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(on_target_damaged))
		RegisterSignal(human_target, list(COMSIG_LIVING_DEATH, COMSIG_LIVING_STATUS_UNCONSCIOUS), PROC_REF(on_target_incap))
		
		addtimer(CALLBACK(src, PROC_REF(end_damage_transfer), human_target), 2 MINUTES)
		return TRUE
	return FALSE

/obj/effect/proc_holder/spell/invoked/damage_transfer/proc/on_target_incap(datum/source)
	var/mob/living/carbon/target = source
	to_chat(usr, span_warning("Your connection to [target] has been broken by their condition!"))
	to_chat(target, span_notice("[usr]'s connection to your suffering has been broken!"))
	end_damage_transfer(target)

/obj/effect/proc_holder/spell/invoked/damage_transfer/proc/end_damage_transfer(mob/living/carbon/target)
	if(QDELETED(target))
		return
	
	UnregisterSignal(target, list(COMSIG_MOB_APPLY_DAMAGE, COMSIG_LIVING_DEATH, COMSIG_LIVING_STATUS_UNCONSCIOUS))
	to_chat(usr, span_warning("Your connection to [target]'s pain has faded."))
	to_chat(target, span_notice("[usr] is no longer bound to your suffering."))

/obj/effect/proc_holder/spell/invoked/damage_transfer/proc/on_target_damaged(datum/source, damage, damagetype, def_zone)
	if(!damage || !isliving(source))
		return
	
	var/mob/living/L = source
	var/mob/living/carbon/human/H = usr
	
	if(L && H && iscarbon(L))
		// Transfer the damage
		H.apply_damage(damage, damagetype, def_zone)
		L.adjustBruteLoss(-damage) // Negate the damage on the target
		
		// Transfer bleeding status if applicable
		if(iscarbon(L) && iscarbon(H))
			var/mob/living/carbon/C_target = L
			var/mob/living/carbon/C_user = H
			
			// Check if target is bleeding
			if(C_target.get_bleed_rate() > 0)
				// Stop target bleeding
				C_target.suppress_bloodloss(5 MINUTES)
				// Make user bleed
				C_user.bleed(2)
				to_chat(H, span_warning("You take on [L]'s bleeding wounds!"))
				to_chat(L, span_notice("Your bleeding wounds transfer to [H]!"))
		
		to_chat(L, span_notice("Your wounds are taken by [H]!"))
		to_chat(H, span_warning("You feel [L]'s pain!"))
		new /obj/effect/temp_visual/heal(get_turf(L), "#FFFFFF")
		new /obj/effect/temp_visual/heal(get_turf(H), "#FF0000")

/obj/effect/proc_holder/spell/invoked/affliction_transfer
	name = "Burden of Martyrdom"
	desc = "Take on the afflictions of your target, healing their wounds and restoring missing limbs at great cost to yourself. If used on the dead, you can sacrifice your own life to restore theirs."
	clothes_req = FALSE
	human_req = TRUE
	charge_max = 0  // No cooldown
	cooldown_min = 0 // No minimum cooldown
	range = -1         // Infinite range
	invocation = "I shall bear your wounds as my own!"
	invocation_type = "shout"
	action_icon_state = "affliction_transfer"
	school = "holy"
	
/obj/effect/proc_holder/spell/invoked/affliction_transfer/cast(list/targets, mob/living/user)
	if(!ishuman(targets[1]))
		to_chat(user, span_warning("You can only cast this on people!"))
		return FALSE
		
	var/mob/living/carbon/human/human_target = targets[1]
	var/is_dead = (human_target.stat == DEAD)
	
	// Allow casting on dead targets for revival
	if(is_dead)
		to_chat(user, span_warning("[human_target] is dead. Your sacrifice could restore them, but it will cost your life!"))
		to_chat(human_target, span_warning("[user] begins a ritual of ultimate sacrifice to restore you!"))
	else
		to_chat(user, span_notice("You prepare to take [human_target]'s afflictions as your own..."))
		to_chat(human_target, span_warning("[user] begins a ritual to take your afflictions!"))
	
	if(do_after(user, is_dead ? 100 : 60, target = human_target))
		// Handle revival case
		if(is_dead)
			// Final warning
			if(alert(user, "Are you sure you want to sacrifice your life to restore [human_target]?", "Ultimate Sacrifice", "Yes", "No") != "Yes")
				to_chat(user, span_warning("You stop the ritual."))
				return FALSE
				
			// Dramatic effects
			new /obj/effect/temp_visual/heal(get_turf(user), "#FF0000")
			new /obj/effect/temp_visual/heal(get_turf(human_target), "#FFFFFF")
			
			// Transfer all wounds and damage before revival
			var/brute_to_heal = human_target.getBruteLoss()
			var/burn_to_heal = human_target.getFireLoss()
			var/tox_to_heal = human_target.getToxLoss()
			var/oxy_to_heal = human_target.getOxyLoss()
			
			// Transfer bleeding status
			if(iscarbon(human_target) && iscarbon(user))
				var/mob/living/carbon/C_target = human_target
				var/mob/living/carbon/C_user = user
				
				if(C_target.get_bleed_rate() > 0)
					C_target.suppress_bloodloss(5 MINUTES)
					C_user.bleed(10) // More severe bleeding for revival
			
			// Transfer all damage types
			human_target.adjustBruteLoss(-brute_to_heal)
			human_target.adjustFireLoss(-burn_to_heal)
			human_target.adjustToxLoss(-tox_to_heal)
			human_target.adjustOxyLoss(-oxy_to_heal)
			
			user.adjustBruteLoss(brute_to_heal)
			user.adjustFireLoss(burn_to_heal)
			user.adjustToxLoss(tox_to_heal)
			user.adjustOxyLoss(oxy_to_heal)
			
			// Transfer all bodypart damage
			for(var/obj/item/bodypart/BP in human_target.bodyparts)
				if(BP.brute_dam > 0 || BP.burn_dam > 0)
					var/obj/item/bodypart/user_bp = user.get_bodypart(BP.body_zone)
					if(user_bp)
						var/brute = BP.brute_dam
						var/burn = BP.burn_dam
						BP.heal_damage(brute, burn, 0)
						user_bp.receive_damage(brute=brute, burn=burn)
			
			// Restore missing limbs and organs as before
			var/list/missing_limbs = list()
			if(!human_target.get_bodypart(BODY_ZONE_L_ARM))
				missing_limbs += BODY_ZONE_L_ARM
			if(!human_target.get_bodypart(BODY_ZONE_R_ARM))
				missing_limbs += BODY_ZONE_R_ARM
			if(!human_target.get_bodypart(BODY_ZONE_L_LEG))
				missing_limbs += BODY_ZONE_L_LEG
			if(!human_target.get_bodypart(BODY_ZONE_R_LEG))
				missing_limbs += BODY_ZONE_R_LEG
			
			for(var/zone in missing_limbs)
				var/obj/item/bodypart/user_limb = user.get_bodypart(zone)
				if(user_limb)
					var/obj/item/bodypart/new_limb
					switch(zone)
						if(BODY_ZONE_L_ARM)
							new_limb = new /obj/item/bodypart/l_arm()
						if(BODY_ZONE_R_ARM)
							new_limb = new /obj/item/bodypart/r_arm()
						if(BODY_ZONE_L_LEG)
							new_limb = new /obj/item/bodypart/l_leg()
						if(BODY_ZONE_R_LEG)
							new_limb = new /obj/item/bodypart/r_leg()
					
					if(new_limb)
						user_limb.drop_limb(TRUE)
						qdel(user_limb)
						new_limb.replace_limb(human_target, TRUE)
			
			// Restore missing organs
			var/list/missing_organs = list()
			if(!human_target.getorganslot(ORGAN_SLOT_HEART))
				missing_organs += ORGAN_SLOT_HEART
			if(!human_target.getorganslot(ORGAN_SLOT_LIVER))
				missing_organs += ORGAN_SLOT_LIVER
			if(!human_target.getorganslot(ORGAN_SLOT_LUNGS))
				missing_organs += ORGAN_SLOT_LUNGS
			if(!human_target.getorganslot(ORGAN_SLOT_EYES))
				missing_organs += ORGAN_SLOT_EYES
			
			for(var/slot in missing_organs)
				var/obj/item/organ/user_organ = user.getorganslot(slot)
				if(user_organ)
					var/obj/item/organ/new_organ
					switch(slot)
						if(ORGAN_SLOT_HEART)
							new_organ = new /obj/item/organ/heart()
						if(ORGAN_SLOT_LIVER)
							new_organ = new /obj/item/organ/liver()
						if(ORGAN_SLOT_LUNGS)
							new_organ = new /obj/item/organ/lungs()
						if(ORGAN_SLOT_EYES)
							new_organ = new /obj/item/organ/eyes()
					
					if(new_organ)
						user_organ.Remove(user)
						qdel(user_organ)
						new_organ.Insert(human_target)
			
			// Now revive them
			human_target.revive(full_heal = FALSE, admin_revive = FALSE) // Changed to FALSE since we handled healing
			human_target.grab_ghost(force = TRUE)
			
			// Messages
			to_chat(human_target, span_notice("You feel life surge back into your body as [user] takes your wounds and sacrifices themselves for you!"))
			to_chat(user, span_warning("Your life force drains away as you restore [human_target] to life, taking on their wounds!"))
			
			// Kill the user
			user.death()
			return TRUE
			
		// Normal healing case - now takes ALL damage
		var/brute_to_heal = human_target.getBruteLoss()
		var/burn_to_heal = human_target.getFireLoss()
		var/tox_to_heal = human_target.getToxLoss()
		var/oxy_to_heal = human_target.getOxyLoss()
		
		// Transfer bleeding status from all bodyparts
		if(iscarbon(human_target) && iscarbon(user))
			var/mob/living/carbon/C_target = human_target
			var/mob/living/carbon/C_user = user
			
			// Check if target is bleeding
			if(C_target.get_bleed_rate() > 0)
				// Stop target bleeding
				C_target.suppress_bloodloss(5 MINUTES)
				// Make user bleed
				C_user.bleed(5)
				to_chat(user, span_warning("You take on [human_target]'s bleeding wounds!"))
				to_chat(human_target, span_notice("Your bleeding wounds transfer to [user]!"))
		
		// Apply full healing effects
		human_target.adjustBruteLoss(-brute_to_heal)
		human_target.adjustFireLoss(-burn_to_heal)
		human_target.adjustToxLoss(-tox_to_heal)
		human_target.adjustOxyLoss(-oxy_to_heal)
		
		user.adjustBruteLoss(brute_to_heal)
		user.adjustFireLoss(burn_to_heal)
		user.adjustToxLoss(tox_to_heal)
		user.adjustOxyLoss(oxy_to_heal)
		
		to_chat(human_target, span_notice("Your wounds are miraculously healed!"))
		to_chat(user, span_warning("You take on [human_target]'s wounds!"))
		
		// Visual effects
		new /obj/effect/temp_visual/heal(get_turf(human_target), "#FFFFFF")
		new /obj/effect/temp_visual/heal(get_turf(user), "#FF0000")
		
		// Transfer all bodypart damage
		for(var/obj/item/bodypart/BP in human_target.bodyparts)
			if(BP.brute_dam > 0 || BP.burn_dam > 0)
				var/obj/item/bodypart/user_bp = user.get_bodypart(BP.body_zone)
				if(user_bp)
					var/brute = BP.brute_dam
					var/burn = BP.burn_dam
					BP.heal_damage(brute, burn, 0)
					user_bp.receive_damage(brute=brute, burn=burn)
		
		// Restore missing limbs by sacrificing the flagellant's own
		var/list/missing_limbs = list()
		if(!human_target.get_bodypart(BODY_ZONE_L_ARM))
			missing_limbs += BODY_ZONE_L_ARM
		if(!human_target.get_bodypart(BODY_ZONE_R_ARM))
			missing_limbs += BODY_ZONE_R_ARM
		if(!human_target.get_bodypart(BODY_ZONE_L_LEG))
			missing_limbs += BODY_ZONE_L_LEG
		if(!human_target.get_bodypart(BODY_ZONE_R_LEG))
			missing_limbs += BODY_ZONE_R_LEG
		
		for(var/zone in missing_limbs)
			// Check if the flagellant has this limb to sacrifice
			var/obj/item/bodypart/user_limb = user.get_bodypart(zone)
			if(user_limb)
				// Create a new limb for the target
				var/obj/item/bodypart/new_limb
				switch(zone)
					if(BODY_ZONE_L_ARM)
						new_limb = new /obj/item/bodypart/l_arm()
					if(BODY_ZONE_R_ARM)
						new_limb = new /obj/item/bodypart/r_arm()
					if(BODY_ZONE_L_LEG)
						new_limb = new /obj/item/bodypart/l_leg()
					if(BODY_ZONE_R_LEG)
						new_limb = new /obj/item/bodypart/r_leg()
				
				if(new_limb)
					// Remove the flagellant's limb
					user_limb.drop_limb(TRUE)
					qdel(user_limb)
					
					// Give the target a new limb
					new_limb.replace_limb(human_target, TRUE)
					to_chat(human_target, span_notice("You feel a new [new_limb.name] growing!"))
					to_chat(user, span_warning("Your [new_limb.name] withers and falls off!"))
					
					// Visual effect
					new /obj/effect/temp_visual/heal(get_turf(human_target), "#FFFFFF")
			else
				to_chat(user, span_warning("You don't have a [zone] to sacrifice!"))
		
		// Restore missing organs by sacrificing the flagellant's own
		var/list/missing_organs = list()
		if(!human_target.getorganslot(ORGAN_SLOT_HEART))
			missing_organs += ORGAN_SLOT_HEART
		if(!human_target.getorganslot(ORGAN_SLOT_LIVER))
			missing_organs += ORGAN_SLOT_LIVER
		if(!human_target.getorganslot(ORGAN_SLOT_LUNGS))
			missing_organs += ORGAN_SLOT_LUNGS
		if(!human_target.getorganslot(ORGAN_SLOT_EYES))
			missing_organs += ORGAN_SLOT_EYES
		
		for(var/slot in missing_organs)
			// Check if the flagellant has this organ to sacrifice
			var/obj/item/organ/user_organ = user.getorganslot(slot)
			if(user_organ)
				// Create a new organ for the target
				var/obj/item/organ/new_organ
				switch(slot)
					if(ORGAN_SLOT_HEART)
						new_organ = new /obj/item/organ/heart()
					if(ORGAN_SLOT_LIVER)
						new_organ = new /obj/item/organ/liver()
					if(ORGAN_SLOT_LUNGS)
						new_organ = new /obj/item/organ/lungs()
					if(ORGAN_SLOT_EYES)
						new_organ = new /obj/item/organ/eyes()
				
				if(new_organ)
					// Remove the flagellant's organ
					user_organ.Remove(user)
					qdel(user_organ)
					
					// Give the target a new organ
					new_organ.Insert(human_target)
					to_chat(human_target, span_notice("You feel a new [new_organ.name] growing inside you!"))
					to_chat(user, span_warning("Your [new_organ.name] withers away!"))
					
					// Visual effect
					new /obj/effect/temp_visual/heal(get_turf(human_target), "#FFFFFF")
			else
				to_chat(user, span_warning("You don't have a [slot] to sacrifice!"))
		return TRUE
	return FALSE

/obj/effect/proc_holder/spell/invoked/burden_exchange
	name = "Exchange of Burdens"
	desc = "Switch places with your target, taking their physical burden upon yourself."
	clothes_req = FALSE
	human_req = TRUE
	charge_max = 300  // 30 seconds cooldown
	cooldown_min = 150 // 15 seconds minimum cooldown
	range = -1        // Infinite range
	invocation = "Let us trade places in this trial!"
	invocation_type = "shout"
	action_icon_state = "burden_exchange"
	school = "holy"
	
/obj/effect/proc_holder/spell/invoked/burden_exchange/cast(list/targets, mob/living/user)
	if(!isliving(targets[1]))
		to_chat(user, span_warning("You can only cast this on living beings!"))
		return FALSE
		
	var/mob/living/living_target = targets[1]
	if(living_target.stat == DEAD)
		to_chat(user, span_warning("[living_target] is dead!"))
		return FALSE
		
	if(living_target.anchored || user.anchored)
		to_chat(user, span_warning("Something is preventing the exchange!"))
		return FALSE
		
	to_chat(user, span_notice("You prepare to exchange places with [living_target]..."))
	to_chat(living_target, span_warning("[user] begins a ritual to switch places with you!"))
	
	if(do_after(user, 10, target = living_target))
		// Store positions
		var/turf/user_turf = get_turf(user)
		var/turf/target_turf = get_turf(living_target)
		
		// Visual effects at both locations
		new /obj/effect/temp_visual/heal(user_turf, "#FF0000")
		new /obj/effect/temp_visual/heal(target_turf, "#FFFFFF")
		
		// Perform the swap
		user.forceMove(target_turf)
		living_target.forceMove(user_turf)
		
		// Messages
		to_chat(user, span_notice("You switch places with [living_target]!"))
		to_chat(living_target, span_warning("[user] has switched places with you!"))
		
		// Additional visual effect after the swap
		new /obj/effect/temp_visual/heal(get_turf(user), "#FF0000")
		new /obj/effect/temp_visual/heal(get_turf(living_target), "#FFFFFF")
		return TRUE
	return FALSE

/obj/effect/proc_holder/spell/invoked/damage_link
	name = "Shared Penance"
	desc = "Transfer a portion of your current suffering to your target, making them bear some of your pain."
	clothes_req = FALSE
	human_req = TRUE
	charge_max = 600  // 1 minute cooldown
	cooldown_min = 300 // 30 seconds minimum cooldown
	range = -1        // Infinite range
	invocation = "Share in my suffering!"
	invocation_type = "shout"
	action_icon_state = "damage_link"
	school = "holy"
	
/obj/effect/proc_holder/spell/invoked/damage_link/cast(list/targets, mob/living/user)
	if(!isliving(targets[1]))
		to_chat(user, span_warning("You can only cast this on living beings!"))
		return FALSE
		
	var/mob/living/living_target = targets[1]
	if(living_target.stat == DEAD)
		to_chat(user, span_warning("[living_target] is dead!"))
		return FALSE
		
	to_chat(user, span_notice("You prepare to share your suffering with [living_target]..."))
	to_chat(living_target, span_warning("[user] begins a ritual to share their suffering with you!"))
	
	if(do_after(user, 30, target = living_target))
		// Calculate damage to transfer (30% of user's current damage)
		var/damage_to_transfer = user.getBruteLoss() * 0.3
		
		if(damage_to_transfer < 5)
			to_chat(user, span_warning("You aren't suffering enough to share your pain!"))
			return FALSE
			
		// Apply the damage transfer
		user.adjustBruteLoss(-damage_to_transfer)
		living_target.adjustBruteLoss(damage_to_transfer)
		
		// Visual effects
		new /obj/effect/temp_visual/heal(get_turf(user), "#FFFFFF")
		new /obj/effect/temp_visual/heal(get_turf(living_target), "#FF0000")
		
		to_chat(user, span_notice("You transfer some of your suffering to [living_target]."))
		to_chat(living_target, span_danger("You feel [user]'s pain flowing into you!"))
		
		// Check for additional damage types
		var/burn_damage = user.getFireLoss() * 0.3
		if(burn_damage > 5)
			user.adjustFireLoss(-burn_damage)
			living_target.adjustFireLoss(burn_damage)
			
		var/tox_damage = user.getToxLoss() * 0.3
		if(tox_damage > 5)
			user.adjustToxLoss(-tox_damage)
			living_target.adjustToxLoss(tox_damage)
			
		var/oxy_damage = user.getOxyLoss() * 0.3
		if(oxy_damage > 5)
			user.adjustOxyLoss(-oxy_damage)
			living_target.adjustOxyLoss(oxy_damage)
		return TRUE
	return FALSE

