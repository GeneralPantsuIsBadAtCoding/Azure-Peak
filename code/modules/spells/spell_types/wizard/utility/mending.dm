/obj/effect/proc_holder/spell/invoked/mending
	name = "Mending"
	desc = "Uses arcyne energy to mend an item."
	overlay_state = "mending"
	releasedrain = 50
	chargetime = 5
	recharge_time = 20 SECONDS
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	cost = 2
	spell_tier = 1 // Utility. For repair
	glow_color = GLOW_COLOR_ARCANE
	glow_intensity = GLOW_INTENSITY_LOW

	miracle = FALSE

	invocation = "Reficio"
	invocation_type = "shout" //can be none, whisper, emote and shout

/obj/effect/proc_holder/spell/invoked/mending/cast(list/targets, mob/living/user)
	if(istype(targets[1], /obj/item))
		var/obj/item/I = targets[1]
		if(!I.anvilrepair && !I.sewrepair)
			to_chat(user, span_warning("Not even magic can mend this item!"))
			revert_cast()
			return
		if(I.obj_integrity < I.max_integrity)
			var/repair_percent = 0.25
			repair_percent *= I.max_integrity
			I.obj_integrity = min(I.obj_integrity + repair_percent, I.max_integrity)
			user.visible_message(span_info("[I] glows in a faint mending light."))
			playsound(I, 'sound/foley/sewflesh.ogg', 50, TRUE, -2)
			if(I.obj_broken && I.obj_integrity >= I.max_integrity)
				I.obj_integrity = I.max_integrity
				I.obj_fix()
		else
			to_chat(user, span_info("[I] appears to be in perfect condition."))
			revert_cast()
	else
		to_chat(user, span_warning("There is no item here!"))
		revert_cast()
