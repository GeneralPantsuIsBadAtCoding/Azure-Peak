/obj/effect/proc_holder/spell/invoked/frosting
	name = "Cryonization"
	desc = "Cold your target."
	overlay_state = "frost_bolt"
	action_icon_state = "frost_bolt"
	releasedrain = 30
	chargedrain = 1
	range = 5
	cost = 6
	chargetime = 3
	ignore_los = FALSE
	warnie = "sydwarning"
	movement_interrupt = TRUE
	no_early_release = TRUE
	invocation_type = "none"
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	antimagic_allowed = FALSE
	spell_tier = 3
	charging_slowdown = 2
	recharge_time = 45 SECONDS
	gesture_required = TRUE
	glow_color = GLOW_COLOR_ICE
	glow_intensity = GLOW_INTENSITY_HIGH
	var/delay = 0.5 SECONDS
	var/outline_colour = "#00b3ffff"

/obj/effect/proc_holder/spell/invoked/frosting/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		if(do_after(user, 3 SECONDS))
			new /obj/effect/temp_visual/kinetic_blast(get_turf(user))
			var/mob/living/T = targets[1]
			var/mob/living/carbon/human/U = user
			if(T.anti_magic_check())
				visible_message(span_warning("The gravity fades away around you [T] "))  //antimagic needs some testing
				playsound(get_turf(T), 'sound/magic/magic_nulled.ogg', 100)
				return TRUE

			U.visible_message(span_warning("Tiny strands of cold link between [U] and [T], cold being transferred!"))
			playsound(U, 'sound/magic/whiteflame.ogg', 100, TRUE)
			var/user_skill = U.get_skill_level(associated_skill)
			var/greatcold = 0
			var/datum/beam/cbeam = user.Beam(T,icon_state="cold_beam",time=(100 * 5))
			var/cold = 0
			var/filter = U.get_filter("AURA")
			var/additional = 0
			if(user_skill > SKILL_LEVEL_JOURNEYMAN)
				additional = 1
			if (!filter)
				U.add_filter("AURA", 2, list("type" = "outline", "color" = outline_colour, "alpha" = 60, "size" = 1))
			for(var/i in 1 to 500)
				if(do_after(U, delay))
					var/damage = round(user_skill + greatcold/2) * 2
					cold++
					T.stamina_add(damage)
					T.adjustFireLoss(damage/2)
					U.stamina_add(1 + greatcold/2)
					playsound(U, 'sound/magic/charging_fire.ogg', 100, TRUE)
					if(cold > 3)
						cold = 0
						greatcold++
						T.adjustFireLoss(damage*4)
						T.apply_status_effect(/datum/status_effect/buff/frost)
						new /obj/effect/temp_visual/snap_freeze(get_turf(T))
						new /obj/effect/temp_visual/kinetic_blast(get_turf(T))
						playsound(U, 'sound/magic/whiteflame.ogg', 100, TRUE)
					if(greatcold == 2)
						T.apply_status_effect(/datum/status_effect/buff/frostbite)
					if(additional)
						if(greatcold == 5)
							greatcold++
							T.apply_status_effect(/datum/status_effect/freon/freezing)
							explosion(T, -1, 0, 2, 0, 0, flame_range = 0, soundin = 'sound/magic/whiteflame.ogg')
				else
					U.visible_message(span_warning("Severs the coldlink from [T]!"))
					cbeam.End()
					U.remove_filter("AURA")
					if(i <= 10)
						badcast()
						return FALSE
					return TRUE
		badcast()
		return FALSE
	revert_cast()
	return FALSE


/obj/effect/proc_holder/spell/invoked/frosting/proc/badcast(mob/living/user)
	user.adjustFireLoss(30)
	user.apply_status_effect(/datum/status_effect/freon/freezing)
	user.apply_status_effect(/datum/status_effect/buff/frostbite)
	new /obj/effect/temp_visual/kinetic_blast(get_turf(user))
	revert_cast()