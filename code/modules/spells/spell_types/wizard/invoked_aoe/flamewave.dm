/obj/effect/proc_holder/spell/invoked/pyro/flamewave
	name = "Flame Wave"
	desc = "Send a fiery wave in one of the eight directions, gradually running away from you towards the target! \n\
	Damage is increased by 100% versus simple-minded creechurs"
	cost = 6
	releasedrain = 50
	overlay_state = "flamewave"
	action_icon_state = "flamewave"
	chargedrain = 2
	chargetime = 2 SECONDS
	recharge_time = 20 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokefire
	associated_skill = /datum/skill/magic/arcane
	gesture_required = TRUE // Offensive spell
	spell_tier = 3 // AOE
	invocations = list("Flame Est!")
	invocation_type = "shout"
	glow_color = GLOW_COLOR_FIRE
	glow_intensity = GLOW_INTENSITY_HIGH

/obj/effect/proc_holder/spell/invoked/pyro/flamewave/cast(list/targets, mob/user = usr)
	. = ..()
	var/turf/T = get_turf(targets[1])
	var/user_skill = user.get_skill_level(associated_skill)
	if(!do_after(user,0.5 SECONDS, user))
		return
	if(!T)
		return
	var/dir_to_target = get_dir(user, T)

	var/turf/current = get_step(get_turf(user), dir_to_target)

	var/list/firewave_rows = list()
	for(var/i = 1, i <= 6, i++)
		if(!current)
			break
		var/list/row = list()
		row += current
		if(user_skill > SKILL_LEVEL_JOURNEYMAN)
			row += get_step(current, turn(dir_to_target, 90))
			row += get_step(current, turn(dir_to_target, -90))

		firewave_rows += list(row)
		current = get_step(current, dir_to_target)

	var/delay = 3
	for(var/row_index = 1, row_index <= firewave_rows.len, row_index++)
		var/list/row = firewave_rows[row_index]
		spawn(delay * (row_index - 1))
			for(T in row)
				if(!T)
					continue
				for(var/mob/living/L in T)
					if(L == src)
						continue
					if (!L.mind && istype(L, /mob/living/simple_animal))
						L.adjustFireLoss(40) //x2 VS mobs
					L.adjustFireLoss(40)
				new /obj/effect/hotspot(T, dir_to_target)
				new /obj/effect/temp_visual/firewave(T, dir_to_target)
	visible_message(span_danger("[src] exhales a violent gust of wind!"))
	playsound(src, 'sound/weather/rain/wind_6.ogg', 100, TRUE)

/obj/effect/temp_visual/firewave
	icon = 'icons/effects/effects.dmi'
	icon_state = "flame"
	layer = BELOW_MOB_LAYER
	plane = GAME_PLANE
	light_outer_range = 2
	duration = 3