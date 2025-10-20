//This is being left out, as it might be dangerous without a way to keep players from relinking the keep doors.

/obj/item/contraption
	name = "random piece of machinery"
	desc = "A cog with teeth meticulously crafted for tight interlocking."
	icon_state = "gear"
	w_class = WEIGHT_CLASS_SMALL
	var/on_icon
	var/off_icon
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_SMALL
	smeltresult = /obj/item/ingot/bronze
	slot_flags = ITEM_SLOT_HIP
	var/obj/item/accepted_power_source = /obj/item/roguegear
	/// This is the amount of charges we get per power source
	var/charge_per_source = 5
	var/current_charge = 0
	var/misfire_chance
	var/sneaky_misfire_chance
	/// Are we misfiring? Important for chain reactions.
	var/misfiring = FALSE
	obj_flags_ignore = TRUE
	/// If this contraption should accept cogs that alter its behaviour
	var/special_cog = FALSE

/obj/item/contraption/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,
"sx" = -6,
"sy" = -2,
"nx" = 9,
"ny" = -1,
"wx" = -6,
"wy" = -1,
"ex" = -2,
"ey" = -3,
"northabove" = 0,
"southabove" = 1,
"eastabove" = 1,
"westabove" = 0,
"nturn" = 21,
"sturn" = -18,
"wturn" = -18,
"eturn" = 21,
"nflip" = 0,
"sflip" = 8,
"wflip" = 8,
"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/contraption/examine(mob/user)
	. = ..()
	if(!istype(user, /mob/living))
		return
	/*var/mob/living/player = user
	var/skill = player.mind?.get_skill_level(/datum/skill/craft/engineering)
	if(current_charge)
		. += span_warning("The contraption has [current_charge] charges left.")
	if(!current_charge)
		. += span_warning("This contraption requires a new [initial(accepted_power_source.name)] to function.")
	if(misfire_chance)
		if(skill > 2)
			. += span_warning("You calculate this contraptions chance of failure to be anywhere between [max(0, (misfire_chance - skill) - rand(4))]% and [max(2, (misfire_chance - skill) + rand(3))]%.")
		else
			. += span_warning("It seems slightly unstable...")
	if(skill >= 6 && sneaky_misfire_chance)
		. += span_warning("This contraption has a chance for catastrophic failure in the hands of the inexperient.")*/

/obj/item/contraption/proc/battery_collapse(atom/A, mob/living/user)
	to_chat(user, span_info("The [accepted_power_source.name] wastes away into nothing."))
	playsound(src, pick('sound/combat/hits/onmetal/grille (1).ogg', 'sound/combat/hits/onmetal/grille (2).ogg', 'sound/combat/hits/onmetal/grille (3).ogg'), 100, FALSE)
	shake_camera(user, 1, 1)
	var/datum/effect_system/spark_spread/S = new()
	var/turf/front = get_turf(src)
	S.set_up(1, 1, front)
	S.start()
	return

/obj/item/contraption/proc/misfire(atom/A, mob/living/user)
	user.mind.add_sleep_experience(/datum/skill/craft/engineering, (user.STAINT * 5))
	to_chat(user, span_info("Oh fuck."))
	playsound(src, 'sound/misc/bell.ogg', 100)
	addtimer(CALLBACK(src, PROC_REF(misfire_result), A, user), rand(5, 30))

/obj/item/contraption/proc/misfire_result(atom/A, mob/living/user)
	misfiring = TRUE
	explosion(src, light_impact_range = 3, flame_range = 1, smoke = TRUE, soundin = pick('sound/misc/explode/bottlebomb (1).ogg','sound/misc/explode/bottlebomb (2).ogg'))
	qdel(src)

/obj/item/contraption/proc/charge_deduction(atom/A, mob/living/user, deduction)
	current_charge -= deduction
	if(!current_charge)
		addtimer(CALLBACK(src, PROC_REF(battery_collapse), A, user), 5)

/obj/item/contraption/attackby(obj/item/I, mob/user, params)
	var/datum/effect_system/spark_spread/S = new()
	var/turf/front = get_turf(src)
	/*if(istype(I, /obj/item/roguegear)) && special_cog)
		var/obj/item/roguegear/cog = I
		//if(cog.name_prefix)
		//	name = "[cog.name_prefix] [initial(name)]"
		//else
		if(istype(I, /obj/item/roguegear))
			name = initial(name)
		qdel(cog)
		playsound(src, pick('sound/combat/hits/onwood/fence_hit1.ogg', 'sound/combat/hits/onwood/fence_hit2.ogg', 'sound/combat/hits/onwood/fence_hit3.ogg'), 100, FALSE)
		shake_camera(user, 1, 1)
		S.set_up(1, 1, front)
		S.start()
		to_chat(user, "<span class='warning'>I use [cog] to modify [src]!</span>")
		return */
	if(istype(I, accepted_power_source))
		user.changeNext_move(CLICK_CD_FAST)
		S.set_up(1, 1, front)
		S.start()
		if(current_charge)
			to_chat(user, span_info("I try to insert the [I.name] but theres already \a [initial(accepted_power_source.name)] inside!"))
			playsound(src, 'sound/combat/hits/blunt/woodblunt (2).ogg', 100, TRUE)
			shake_camera(user, 1, 1)
		else
			to_chat(user, span_info("I insert the [I.name] and the [name] starts ticking."))
			current_charge = charge_per_source
			playsound(src, 'sound/combat/hits/blunt/woodblunt (2).ogg', 100, TRUE)
			qdel(I)
			addtimer(CALLBACK(src, PROC_REF(play_clock_sound)), 5)
	if(istype(I, /obj/item/rogueweapon/hammer))
		hammer_action(I, user)
	..()

/obj/item/contraption/proc/hammer_action(obj/item/I, mob/user)
	user.changeNext_move(CLICK_CD_FAST)
	flick(off_icon, src)
	user.visible_message(span_info("[user] beats the [name] into submission!"))
	playsound(src, pick('sound/combat/hits/onmetal/sheet (1).ogg', 'sound/combat/hits/onmetal/sheet (2).ogg', 'sound/combat/hits/onmetal/grille (1).ogg', 'sound/combat/hits/onmetal/grille (2).ogg', 'sound/combat/hits/onmetal/grille (3).ogg'), 100, TRUE)
	shake_camera(user, 1, 1)
	var/datum/effect_system/spark_spread/S = new()
	var/turf/front = get_turf(I)
	S.set_up(1, 1, front)
	S.start()
	var/probability = rand(1, 100)
	if(!current_charge)
		misfire(I, user)
		return
	if(probability <= 5)
		misfire(I, user)
	else if(probability <= 40)
		if(current_charge < charge_per_source)
			current_charge += 1
		misfire_chance = rand(1, 30)
	else
		misfire_chance = rand(10, 100)

/obj/item/contraption/proc/play_clock_sound()
	playsound(src, 'sound/misc/clockloop.ogg', 25, TRUE)

/obj/item/contraption/attack_obj(obj/O, mob/living/user)
	if(!current_charge)
		flick(off_icon, src)
		to_chat(user, span_info("The contraption beeps! It requires \a [initial(accepted_power_source.name)]!"))
		playsound(src, 'sound/magic/magic_nulled.ogg', 100, TRUE)
		return


//Shamelessly stolen multitool code
/obj/item/contraption/linker
	name = "engineering wrench"
	desc = "This strange contraption is able to connect machinery through an unknown calibration method, allowing them to communicate over long distances."
	icon = 'icons/obj/wrenches.dmi'
	icon_state = "brasswrench"
	w_class = WEIGHT_CLASS_SMALL
	tool_behaviour = TOOL_MULTITOOL
	var/datum/buffer // simple machine buffer for device linkage
	smeltresult = /obj/item/ingot/bronze
	charge_per_source = 20
	grid_width = 64
	grid_height = 32

/obj/item/contraption/linker/master
	name = "Guild Master's Wrench"
	desc = "Able to do more advanced linking than a standard wrench. Keep it out of apprentice's hands"
	charge_per_source = 200

/obj/item/contraption/linker/hammer_action(obj/item/I, mob/user)
	return

/obj/item/contraption/linker/Destroy()
	if(buffer)
		remove_buffer(buffer)
	return ..()

/obj/item/contraption/linker/examine(mob/user)
	. = ..()
	if(user.get_skill_level(/datum/skill/craft/engineering) >= 3)
		. += span_notice("Its buffer [buffer ? "contains [buffer]." : "is empty."]")
	else
		. += span_notice("All you can make out is a bunch of gibberish.")

/obj/item/contraption/linker/attack_self(mob/user)
	. = ..()
	if(user.get_skill_level(/datum/skill/craft/engineering) >= 3)
		to_chat(user, "You wipe [src] of its stored buffer.")
		remove_buffer(src)
	else
		to_chat(user, span_warning("I have no idea how to use [src]!"))

/obj/item/contraption/linker/proc/set_buffer(datum/buffer)
	if(src.buffer)
		remove_buffer(src.buffer)
	src.buffer = buffer
	if(!QDELETED(buffer))
		RegisterSignal(buffer, COMSIG_PARENT_QDELETING, PROC_REF(remove_buffer))

/**
 * Called when the buffer's stored object is deleted
 *
 * This proc does not clear the buffer of the multitool, it is here to
 * handle the deletion of the object the buffer references
 */
/obj/item/contraption/linker/proc/remove_buffer(datum/source)
	SIGNAL_HANDLER
	SEND_SIGNAL(src, COMSIG_MULTITOOL_REMOVE_BUFFER, source)
	UnregisterSignal(buffer, COMSIG_PARENT_QDELETING)
	buffer = null
