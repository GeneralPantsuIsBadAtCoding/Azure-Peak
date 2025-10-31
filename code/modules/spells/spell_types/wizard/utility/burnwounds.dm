/obj/effect/proc_holder/spell/invoked/pyro/burn_wounds
	name = "Burn Wounds"
	desc = "Cauterize the wounds on the target limb using the fire arcana powers."
	overlay_state = "woundburn"
	cost = 3
	releasedrain = 35
	chargedrain = 0
	chargetime = 3
	recharge_time = 2 MINUTES
	range = 1
	ignore_los = FALSE
	warnie = "spellwarning"
	movement_interrupt = TRUE
	chargedloop = /datum/looping_sound/invokefire
	sound = 'sound/surgery/cautery1.ogg'
	invocation_type = "none"
	glow_color = GLOW_COLOR_FIRE
	glow_intensity = GLOW_INTENSITY_VERY_HIGH
	associated_skill = /datum/skill/magic/arcane
	spell_tier = 3
	antimagic_allowed = FALSE
	miracle = FALSE
	var/delay = 4.5 SECONDS	//Reduced to 1.5 seconds with Legendary

/obj/effect/proc_holder/spell/invoked/pyro/burn_wounds/cast(list/targets, mob/user = usr)
	if(ishuman(targets[1]))

		var/mob/living/carbon/human/target = targets[1]
		var/mob/living/carbon/human/HU = user
		var/def_zone = check_zone(user.zone_selected)
		var/obj/item/bodypart/affecting = target.get_bodypart(def_zone)
		var/datum/wound/wound

		if(!affecting)
			revert_cast()
			return FALSE
		if(!do_after(user, (delay - (0.5 SECONDS * HU.get_skill_level(associated_skill)))))
			revert_cast()
			to_chat(user, span_warning("We were interrupted!"))
			return FALSE
		var/foundwound = FALSE
		if(target.cmode)
			revert_cast()
			to_chat(user, "<span class='warning'>[target] is alert. I can't help.</span>")
			return FALSE
		if(length(affecting.wounds))
			for(wound in affecting.wounds)
				affecting.heal_wounds(100)
				foundwound = TRUE
			if(foundwound)
				playsound(target, 'sound/surgery/cautery2.ogg', 100, TRUE)
			affecting.change_bodypart_status(BODYPART_ORGANIC, heal_limb = TRUE)
			affecting.update_disabled()
			target.adjustFireLoss(20) //painful, but the wounds go away eh?
			target.adjust_fire_stacks(2)
			target.ignite_mob()
			return TRUE
		else
			to_chat(user, span_warning("[target] is free of wounds."))
			revert_cast()
			return FALSE