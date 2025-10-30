/obj/effect/proc_holder/spell/invoked/shoking
	name = "Conduction"
	desc = "Shock your target."
	overlay_state = "thunderstrike"
	action_icon_state = "thunderstrike"
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
	chargedloop = /datum/looping_sound/invokelightning
	associated_skill = /datum/skill/magic/arcane
	antimagic_allowed = FALSE
	spell_tier = 3
	charging_slowdown = 2
	recharge_time = 45 SECONDS
	gesture_required = TRUE
	var/delay = 0.5 SECONDS
	var/outline_colour = "#eeff00ff"
	var/list/starget

/obj/effect/proc_holder/spell/invoked/shoking/cast(list/targets, mob/living/user, mob/target)
	if(isliving(targets[1]))
		if(do_after(user, 3 SECONDS))
			new /obj/effect/temp_visual/explosion/fast(get_turf(user))
			var/mob/living/T = targets[1]
			var/mob/living/carbon/human/U = user
			if(T.anti_magic_check())
				visible_message(span_warning("The gravity fades away around you [T] "))  //antimagic needs some testing
				playsound(get_turf(T), 'sound/magic/magic_nulled.ogg', 100)
				return TRUE

			U.visible_message(span_warning("Tiny strands of lighting link between [U] and [T], shock being transferred!"))
			playsound(U, 'sound/magic/lightning.ogg', 100, TRUE)
			var/user_skill = U.get_skill_level(associated_skill)
			var/greatshock = 0
			var/datum/beam/sbeam =user.Beam(T,icon_state="lightning[rand(1,12)]",time=100*5)
			var/shock = 0
			var/filter = U.get_filter("AURA")
			var/additional = 0
			if(user_skill > SKILL_LEVEL_JOURNEYMAN)
				additional = 1
			if (!filter)
				U.add_filter("AURA", 2, list("type" = "outline", "color" = outline_colour, "alpha" = 60, "size" = 1))
			for(var/i in 1 to 500)
				if(do_after(U, delay))
					var/damage = round(user_skill + greatshock/2) * 2
					shock++
					T.adjustFireLoss(damage)
					U.stamina_add(1 + greatshock/2)
					T.stamina_add(1 + greatshock/2)
					playsound(U, 'sound/magic/charging_lightning.ogg', 100, TRUE)
					if(shock > 3)
						shock = 0
						greatshock++
						T.adjustFireLoss(damage/2)
						T.adjust_fire_stacks(greatshock)
						T.ignite_mob()
						T.apply_status_effect(/datum/status_effect/debuff/clickcd, 1 SECONDS)
						T.electrocute_act(1, src, 1, SHOCK_NOSTUN)
						T.apply_status_effect(/datum/status_effect/buff/lightningstruck, 6 SECONDS)
						new /obj/effect/temp_visual/explosion/fast(get_turf(T))
						playsound(U, 'sound/magic/lightning.ogg', 100, TRUE)
						var/datum/effect_system/spark_spread/S = new()
						var/turf/front = get_step(U,U.dir)
						S.set_up(1, 1, front)
						S.start()
					if(additional)
						if(greatshock == 5)
							greatshock++
							explosion(T, -1, 0, 0, 8, 0, flame_range = 1, soundin = 'sound/magic/lightning.ogg')

				else
					U.visible_message(span_warning("Severs the firelink from [T]!"))
					sbeam.End()
					U.remove_filter("AURA")
					new /obj/effect/temp_visual/explosion(get_turf(user))
					return TRUE
		user.adjustFireLoss(30)
		user.adjust_fire_stacks(3)
		user.ignite_mob()
		new /obj/effect/temp_visual/explosion/fast(get_turf(user))
		revert_cast()
		return FALSE
	revert_cast()
	return FALSE
