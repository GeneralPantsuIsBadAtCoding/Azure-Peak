/obj/effect/proc_holder/spell/invoked/pyro/firespark
	name = "Fire Spark"
	desc = "Emit a bolt of lightning that burns a target, preventing them from attacking and slowing them down for 6 seconds. \n\
	Damage is increased by 100% versus simple-minded creechurs."
	clothes_req = FALSE
	overlay_state = "justflame"
	sound = 'sound/magic/whiteflame.ogg'
	range = 8
	releasedrain = 30
	chargedrain = 1
	chargetime = 15
	recharge_time = 15 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokelightning
	associated_skill = /datum/skill/magic/arcane
	glow_color = GLOW_COLOR_LIGHTNING
	glow_intensity = GLOW_INTENSITY_MEDIUM
	spell_tier = 2
	invocations = list("Fulmen!")
	invocation_type = "shout"
	cost = 3
	xp_gain = TRUE
	var/firemodificator = 2
	var/delay = 1.3
	var/strike_delay = 1 // delay between each individual strike. 3 delays seems to make someone stupid able to walk into every single strikes.
	var/strikerange = 14 // how many tiles the strike can reach

/obj/effect/proc_holder/spell/invoked/pyro/firespark/cast(list/targets, mob/user = usr)
	var/turf/T = get_turf(targets[1])
	if(T.z != user.z)
		to_chat(span_warning("You can't cast this spell on a different z-level!"))
		return FALSE
	for(var/obj/effect/hotspot/H in T.contents)
		explosion(T, -1, 0, 0, 0, 0, flame_range = 2, soundin = 'sound/misc/explode/incendiary (1).ogg')
	for(var/obj/machinery/light/rogue/O in T.contents)
		O.fire_act()
		sleep(1 SECONDS)
		explosion(T, -1, 0, 0, 0, 0, flame_range = 2, soundin = 'sound/misc/explode/incendiary (1).ogg')
		sleep(10 SECONDS)
		O.extinguish()
	for(var/mob/living/L in T.contents) //doubles firestacks
		if(L.anti_magic_check())
			visible_message(span_warning("The magic fades away around you [L] "))  //antimagic needs some testing
			playsound(L, 'sound/magic/magic_nulled.ogg', 100)
			return
		if(L.fire_stacks != 0)
			if(L.fire_stacks >= 10)
				firemodificator = 0 //any*0 = 0
			var/fire_stacks = L.fire_stacks*firemodificator
			L.adjust_fire_stacks(round(fire_stacks))
	if(istype(T, /turf/open/lava))
		explosion(T, -1, 0, 0, 0, 0, flame_range = 3, soundin = 'sound/misc/explode/incendiary (1).ogg')
	new /obj/effect/temp_visual/firewave/spark(T)
	return TRUE

/obj/effect/temp_visual/firewave/spark
	duration = 20