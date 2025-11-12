/*

-- AOE INTENTS --
They're meant to be kept on the weapon and used via Strong stance's rclick.
At the moment the pattern is manually designated using coordinates in tile_coordinates.
This allows the devs to draw whatever shape they want at the cost of it feeling a little quirky.

Beyond that, it just hoovers up the tiles in t
*/
/datum/special_intent
	var/name = "special intent"
	var/desc = "desc"
	var/mob/living/carbon/human/howner
	var/obj/item/iparent

	var/list/tile_coordinates

	var/list/affected_turfs

	var/cooldown
	var/delay = 1 SECONDS
	var/fade_delay = 0.5 SECONDS

	var/_icon = 'icons/effects/effects.dmi'
	var/pre_icon_state = "blip"
	var/post_icon_state = "strike"

/datum/special_intent/proc/deploy(mob/living/user, obj/item/weapon)
	if(!ishuman(user))
		CRASH("Special intent called from a non-human parent.")
	if(!isitem(weapon))
		CRASH("Special intent called without a valid item.")
	to_chat(world, "deploy called")
	howner = user
	iparent = weapon
	process_attack()

/datum/special_intent/proc/process_attack()
	SHOULD_CALL_PARENT(TRUE)
	_create_grid()
	on_create()
	_draw_grid()
	pre_delay()
	_delay()

/datum/special_intent/proc/_create_grid()
	if(length(affected_turfs))
		LAZYCLEARLIST(affected_turfs)
	var/turf/origin = get_step(get_turf(howner), howner.dir)
	for(var/list/l in tile_coordinates)
		var/dx = l[1]
		var/dy = l[2]
		var/xdir = (dx > 0) ? EAST : (dx < 0) ? WEST : 0
		var/ydir = (dy > 0) ? NORTH : (dy < 0) ? SOUTH : 0
		to_chat(world, "dx: [dx] dy: [dy] xdir: [xdir] ydir: [ydir]")
		var/turf/step = origin

		for(var/i in 1 to dx)
			step = get_step(step, xdir)
			if(!step)
				break

		for(var/i in 1 to dy)
			step = get_step(step, ydir)
			if(!step)
				break
		
		if(step && isturf(step) && !step.density)
			to_chat(world, "adding turf to list: [step.x] [step.y]")
			LAZYADD(affected_turfs, step)


/datum/special_intent/proc/_draw_grid()
	if(!length(affected_turfs))	//Nothing to draw, but technically possible without being an error.
		return
	for(var/turf/T in affected_turfs)
		var/obj/effect/temp_visual/fx = new /obj/effect/temp_visual(T)
		fx.icon = _icon
		fx.icon_state = pre_icon_state
		fx.duration = delay

/datum/special_intent/proc/on_create()
	SHOULD_CALL_PARENT(TRUE)

/datum/special_intent/proc/pre_delay()
	SHOULD_CALL_PARENT(TRUE)

/datum/special_intent/proc/_delay()
	addtimer(CALLBACK(src, PROC_REF(post_delay)), delay)

/datum/special_intent/proc/post_delay()
	SHOULD_CALL_PARENT(TRUE)
	if(post_icon_state)
		for(var/turf/T in affected_turfs)
			var/obj/effect/temp_visual/fx = new /obj/effect/temp_visual(T)
			fx.icon = _icon
			fx.icon_state = post_icon_state
			fx.duration = fade_delay

/datum/special_intent/thrust
	name = "thrust"
	desc = "trhusty"
	tile_coordinates = list(list(0,0), list(0,1), list(0,2))
