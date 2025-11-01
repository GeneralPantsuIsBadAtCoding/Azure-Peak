/obj/effect/proc_holder/spell/invoked/propulsion
	name = "Propulsion"
	desc = "Stands your target."
	overlay_state = "hierophant"
	action_icon_state = "hierophant"
	releasedrain = 30
	chargedrain = 1
	range = 5
	cost = 6
	chargetime = 3
	ignore_los = TRUE
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
	var/delay = 0.6 SECONDS
	glow_color = GLOW_COLOR_ARCANE
	glow_intensity = GLOW_INTENSITY_HIGH
	var/sparkle_path = /obj/effect/temp_visual/gravity_trap
	var/outline_colour = "#f700ffff"
	var/push_range = 1
	var/push_range_max = 1
	var/maxthrow = 3

/obj/effect/proc_holder/spell/invoked/propulsion/cast(list/targets, mob/living/user)
	if(do_after(user, 3 SECONDS))
		new /obj/effect/temp_visual/explosion/fast(get_turf(user))
		var/mob/living/carbon/human/U = user
		U.visible_message(span_warning("Tiny strands of fire link between [U], heat being transferred!"))
		playsound(U, 'sound/magic/gravity.ogg', 100, TRUE)
		var/user_skill = U.get_skill_level(associated_skill)
		var/filter = U.get_filter("AURA")
		var/list/thrownatoms = list()
		var/atom/throwtarget
		var/distfromcaster
		var/damage = round(user_skill) * 2
		push_range_max = (user_skill)
		if(push_range_max <= 4)
			push_range_max = 4 //No-no mr.Magos, you will not fullscreen devostation
		if(user_skill > SKILL_LEVEL_JOURNEYMAN)
			damage = damage * 2
		if (!filter)
			U.add_filter("AURA", 2, list("type" = "outline", "color" = outline_colour, "alpha" = 60, "size" = 1))
		for(var/i in 1 to 500)
			if(do_after(U, delay))
				for(var/turf/T in range(push_range, U))
					if(get_dist(U, T) == push_range)
						new /obj/effect/temp_visual/gravity_trap(T)
					for(var/atom/movable/AM in T)
						if(get_dist(U, AM) != push_range)
							continue
						thrownatoms += AM
				for(var/am in thrownatoms)
					var/atom/movable/AM = am
					if(AM == U || AM.anchored)
						continue
					if(ismob(AM))
						var/mob/M = AM
						if(M.anti_magic_check())
							continue
					throwtarget = get_edge_target_turf(U, get_dir(U, get_step_away(AM, U)))
					distfromcaster = get_dist(U, AM)
					new sparkle_path(get_turf(AM), get_dir(U, AM)) //created sparkles will disappear on their own
					if(isliving(AM))
						var/mob/living/M = AM
						if(distfromcaster <= push_range/2)
							M.adjustBruteLoss(damage*2)
							M.stamina_add(damage*2)
						else
							M.adjustBruteLoss(damage)
							M.stamina_add(damage)
						to_chat(M, "<span class='danger'>You're thrown back by [user]!</span>")
					AM.safe_throw_at(throwtarget, ((CLAMP((push_range - (CLAMP(distfromcaster - 2, 0, distfromcaster))), 3, push_range))), 1,U, force = MOVE_FORCE_EXTREMELY_STRONG)
					thrownatoms = list()
				push_range++
				if(push_range >= push_range_max)
					push_range = 1
				U.stamina_add(1)
				playsound(U, 'sound/magic/charging.ogg', 100, TRUE)
			else
				U.visible_message(span_warning("Severs the firelink from!"))
				U.remove_filter("AURA")
				if(i <= 10)
					badcast()
					return FALSE
				return TRUE
	badcast()
	return FALSE

/obj/effect/proc_holder/spell/invoked/propulsion/proc/badcast(mob/living/user)
	user.adjustBruteLoss(40)
	user.stamina_add(100)
	new /obj/effect/temp_visual/explosion/fast(get_turf(user))
	revert_cast()