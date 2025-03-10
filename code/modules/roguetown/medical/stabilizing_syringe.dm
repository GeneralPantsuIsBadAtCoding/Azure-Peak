/obj/item/reagent_containers/hypospray/medipen/stabilizing
	name = "stabilizing syringe"
	desc = "A specialized emergency syringe that replenishes blood and oxygen levels. Requires medical knowledge to use properly."
	icon_state = "0" 
	item_state = "0"
	var/used = FALSE

/obj/item/reagent_containers/hypospray/medipen/stabilizing/examine(mob/user)
	. = list()
	. += "[icon2html(src, user)] This is \a [src]."
	. += desc
	if(used)
		. += " It is empty."

/obj/item/reagent_containers/hypospray/medipen/stabilizing/attack(mob/living/M, mob/user)
	if(used)
		to_chat(user, span_warning("[src] has already been used!"))
		return

	if(!user.mind || user.mind.get_skill_level(/datum/skill/misc/medicine) < 2)
		to_chat(user, span_warning("You don't have the medical knowledge to use this syringe properly!"))
		return
	
	if(M.stat == DEAD)
		to_chat(user, span_warning("[M] is dead! You cannot help [M.p_them()]."))
		return

	if(!iscarbon(M))
		to_chat(user, span_warning("You cannot use [src] on [M]!"))
		return

	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!get_location_accessible(H, user.zone_selected))
			to_chat(user, span_warning("The clothing on [H]'s [parse_zone(user.zone_selected)] is in the way! The area needs to be exposed to inject the syringe."))
			return

	var/mob/living/carbon/C = M
	C.blood_volume = 560
	
	// Start healing oxygen damage over time
	var/healing_per_tick = 5 // 5 damage per tick, 20 ticks = 100 total
	var/ticks_remaining = 20
	
	var/heal_timer = addtimer(CALLBACK(src, PROC_REF(heal_oxygen_tick), C, healing_per_tick, ticks_remaining), 1 SECONDS, TIMER_STOPPABLE)
	
	user.visible_message(span_notice("[user] injects [M] with [src]."), span_notice("You inject [M] with [src]."))
	playsound(loc, 'sound/items/hypospray.ogg', 100, TRUE)
	
	if(heal_timer)
		icon_state = "15"
		update_icon()
		used = TRUE
	return TRUE

/obj/item/reagent_containers/hypospray/medipen/stabilizing/proc/heal_oxygen_tick(mob/living/carbon/C, amount, ticks_left)
	if(!C || C.stat == DEAD)
		return
	
	C.adjustOxyLoss(-amount)
	ticks_left--
	
	if(ticks_left > 0)
		addtimer(CALLBACK(src, PROC_REF(heal_oxygen_tick), C, amount, ticks_left), 1 SECONDS) 
