/mob/living/proc/attempt_disarm(mob/living/user, obj/item/O) //this is SPECIFICALLY for weapon-intent disarms
	var/obj/item/I
	if(!IsOffBalanced(src))
		to_chat(user, span_warning("They must be off-balanced before I can disarm them!"))
		return
	I = get_active_held_item()
	if(!I)
		I = get_inactive_held_item()
	if(I)
		var/mob/living/carbon/human/target = src
		target.disarmed(I)
		playsound(src, 'sound/combat/clash_struck.ogg', 100)
		flash_fullscreen("whiteflash")
		user.flash_fullscreen("whiteflash")
		var/datum/effect_system/spark_spread/S = new()
		var/turf/front = get_step(src,src.dir)
		S.set_up(1, 1, front)
		S.start()
	else
		to_chat(user, span_warning("They aren't holding anything that can be disarmed!"))
		return
