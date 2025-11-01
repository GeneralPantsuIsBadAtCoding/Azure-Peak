/obj/effect/proc_holder/spell/invoked/pyro/melting
	name = "Melting"
	desc = "Hit your target with a powerful stream of pure elemental flame! \n\
	The damage increases with each passing second as you concentrate the arcyne on the target. \n\
	A more experienced magician could have achieved more interesting effects...\n\
	Premature interruption, at the moment of preparation or early stages of ability creation, will be extremely painful for the magician!"
	overlay_state = "melting"
	action_icon_state = "melting"
	releasedrain = 30
	chargedrain = 1
	range = 5
	cost = 6
	chargetime = 3
	ignore_los = FALSE
	warnie = "sydwarning"
	movement_interrupt = TRUE
	no_early_release = TRUE
	invocations = list("Incineratio!!")
	invocation_type = "shout"
	chargedloop = /datum/looping_sound/invokefire
	associated_skill = /datum/skill/magic/arcane
	antimagic_allowed = FALSE
	spell_tier = 3
	charging_slowdown = 2
	recharge_time = 45 SECONDS
	gesture_required = TRUE
	glow_color = GLOW_COLOR_FIRE
	glow_intensity = GLOW_INTENSITY_HIGH
	var/delay = 0.5 SECONDS
	var/outline_colour = "#c23d09"

/obj/effect/proc_holder/spell/invoked/pyro/melting/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		if(do_after(user, 3 SECONDS))
			new /obj/effect/temp_visual/explosion/fast(get_turf(user))
			var/mob/living/T = targets[1]
			var/mob/living/carbon/human/U = user
			if(T.anti_magic_check())
				visible_message(span_warning("A stream of flames is crashing against [T] body!"))  //antimagic needs some testing
				playsound(get_turf(T), 'sound/magic/magic_nulled.ogg', 100)
				return TRUE

			U.visible_message(span_warning("From the outstretched arms of [U], a fiery stream breaks off, gradually gaining strength, and rushes straight into [T]!"))
			playsound(U, 'sound/misc/explode/incendiary (1).ogg', 100, TRUE)
			var/user_skill = U.get_skill_level(associated_skill)
			var/greatheat = 0
			var/datum/beam/hbeam = user.Beam(T,icon_state="heat_beam",time=(100 * 5))
			var/heat = 0
			var/filter = U.get_filter("AURA")
			var/additional = 0
			U.adjust_fire_stacks(2)
			U.ignite_mob()
			if(user_skill > SKILL_LEVEL_JOURNEYMAN)
				additional = 1
			if(!HAS_TRAIT(U, TRAIT_NOFIRE))
				ADD_TRAIT(U, TRAIT_NOFIRE, TRAIT_GENERIC)
			if (!filter)
				U.add_filter("AURA", 2, list("type" = "outline", "color" = outline_colour, "alpha" = 60, "size" = 1))
			for(var/i in 1 to 500)
				if(do_after(U, delay))
					var/damage = round(user_skill + greatheat/2) * 2
					heat++
					T.adjustFireLoss(damage)
					U.stamina_add(1 + greatheat/2)
					playsound(U, 'sound/magic/charging_fire.ogg', 100, TRUE)
					if(heat > 3)
						heat = 0
						greatheat++
						T.adjust_fire_stacks(1 + greatheat)
						T.ignite_mob()
						new /obj/effect/temp_visual/explosion/fast(get_turf(T))
						playsound(U, 'sound/misc/explode/incendiary (1).ogg', 100, TRUE)
					if(additional)
						if(greatheat == 5)
							greatheat++
							explosion(T, -1, 0, 0, 2, 0, flame_range = 2, soundin = 'sound/misc/explode/incendiary (1).ogg')
				else
					U.visible_message(span_warning("The fiery stream roasting [T] is interrupted and weakened!"))
					hbeam.End()
					U.remove_filter("AURA")
					REMOVE_TRAIT(U, TRAIT_NOFIRE, TRAIT_GENERIC)
					if(i <= 10)
						badcast()
						return FALSE
					return TRUE
		badcast()
		return FALSE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/invoked/pyro/melting/proc/badcast(mob/living/user)
	user.adjustFireLoss(30)
	user.adjust_fire_stacks(3)
	user.ignite_mob()
	new /obj/effect/temp_visual/explosion/fast(get_turf(user))
	revert_cast()