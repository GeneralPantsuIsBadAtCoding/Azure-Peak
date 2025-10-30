/obj/effect/proc_holder/spell/invoked/bridge
	name = "Bridge"
	desc = "Lashes out a delayed line of dark magic, lowering the physical prowess of all in it's path."
	cost = 3
	releasedrain = 50
	overlay_state = "wither" // just using the curse blob, it's placeholder.
	chargedrain = 2
	chargetime = 2 SECONDS
	recharge_time = 20 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	gesture_required = TRUE // Offensive spell
	spell_tier = 2
	invocations = list("Arescentem!")
	invocation_type = "shout"
	glow_color = "#8d3af9ff" // evil ass purple
	glow_intensity = GLOW_INTENSITY_HIGH
	var/delay = 4
	var/strike_delay = 1 // delay between each individual strike. 3 delays seems to make someone stupid able to walk into every single strikes.
	var/strikerange = 1 // how many tiles the strike can reach

/obj/effect/proc_holder/spell/invoked/bridge/cast(list/targets, mob/user = usr)
	var/turf/T = get_turf(targets[1])

	var/turf/source_turf = get_turf(user)

	var/user_skill = usr.get_skill_level(associated_skill)
	strikerange = (user_skill*2)
	
	if(T.z != user.z)
		to_chat(span_warning("You can't cast this spell on a different z-level!"))
		return FALSE

	var/list/affected_turfs = getline(source_turf, T)
	affected_turfs |= T

	for(var/i = 1, i < affected_turfs.len, i++)
		var/turf/affected_turf = affected_turfs[i]
		if(affected_turf == source_turf)
			continue
		if(!(affected_turf in view(source_turf)))
			continue
		if(!istype(affected_turf, /turf/open/transparent/openspace))
			continue
		var/tile_delay = strike_delay * (i - 1) + delay
		new /obj/effect/temp_visual/trap(affected_turf, tile_delay)
		addtimer(CALLBACK(src, PROC_REF(strike), affected_turf), wait = tile_delay)
	return TRUE

/obj/effect/proc_holder/spell/invoked/bridge/proc/strike(var/turf/moving_turf)
	new /turf/open/floor/rogue/twig/platform/arcane(moving_turf)
	playsound(moving_turf, 'sound/magic/shadowstep_destination.ogg', 50)

/turf/open/floor/rogue/twig/platform/arcane
	name = "bridge plating"
	icon_state = "arcana"

/turf/open/floor/rogue/twig/platform/arcane/Initialize()
	addtimer(CALLBACK(src, PROC_REF(boom)), wait = 15 SECONDS)
	. = ..()

/turf/open/floor/rogue/twig/platform/arcane/proc/boom()
	playsound(src, 'sound/magic/magic_nulled.ogg', 60)
	destroy(src)
	qdel()
