/obj/item/medical/splint
	name = "splint"
	desc = "A rigid support used to stabilize fractures and allow them to heal properly."
	icon = 'icons/obj/chemical.dmi'  // Using existing medical icons
	icon_state = "bandaid" 
	w_class = WEIGHT_CLASS_SMALL
	var/self_delay = 50
	var/other_delay = 20

/obj/item/medical/splint/attack(mob/living/M, mob/user)
	if(M.stat == DEAD)
		to_chat(user, span_warning("[M] is dead! You can not help [M.p_them()]."))
		return

	if(!iscarbon(M))
		to_chat(user, span_warning("I can't heal [M] with \the [src]!"))
		return

	if(!user.mind || user.mind.get_skill_level(/datum/skill/misc/medicine) < 2)
		to_chat(user, span_warning("You don't know how to properly apply a splint!"))
		return

	var/obj/item/bodypart/affecting = M.get_bodypart(check_zone(user.zone_selected))
	if(!affecting) //Missing limb?
		to_chat(user, span_warning("[M] doesn't have \a [parse_zone(user.zone_selected)]!"))
		return
	
	if(!affecting.has_wound(/datum/wound/fracture))
		to_chat(user, span_warning("[M]'s [affecting.name] doesn't have a fracture!"))
		return
	
	if(affecting.bandage)
		to_chat(user, span_warning("[M]'s [affecting.name] is already bandaged!"))
		return

	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!get_location_accessible(H, affecting.body_zone))
			to_chat(user, span_warning("The clothing on [H]'s [affecting.name] is in the way! The limb needs to be exposed to apply a splint."))
			return

	var/delay = (user == M) ? self_delay : other_delay
	user.visible_message(span_notice("[user] begins applying [src] to [M]'s [affecting.name]..."), span_notice("You begin applying [src] to [M]'s [affecting.name]..."))
	
	if(!do_after(user, delay, target = M))
		return

	user.visible_message(span_green("[user] applies [src] to [M]'s [affecting.name]."), span_green("You apply [src] to [M]'s [affecting.name]."))
	
	affecting.try_bandage(src)
	
	// Set the bone immediately
	for(var/datum/wound/fracture/bone in affecting.wounds)
		bone.set_bone()
	
	// Start healing timer
	affecting.splint_timer = addtimer(CALLBACK(affecting, TYPE_PROC_REF(/obj/item/bodypart, heal_fracture)), 4 MINUTES, TIMER_STOPPABLE)
	qdel(src)
	return TRUE

/obj/item/bodypart
	var/splint_timer

/obj/item/bodypart/proc/heal_fracture()
	if(!bandage || !istype(bandage, /obj/item/medical/splint))
		return
	
	for(var/datum/wound/fracture/bone in wounds)
		if(owner)
			REMOVE_TRAIT(owner, TRAIT_PARALYSIS, "[bone.type]")  // Remove any paralysis traits
		qdel(bone)  // Remove the wound
	
	owner.visible_message(span_notice("The splint on [owner]'s [name] comes loose as the bone heals."), span_notice("The splint on your [name] comes loose as the bone heals."))
	owner.update_health_hud()
	remove_bandage()

/obj/item/bodypart/receive_damage(brute = 0, burn = 0, stamina = 0, blocked = 0, updating_health = TRUE, required_status = null)
	. = ..()
	if((brute > 0 || burn > 0) && bandage && istype(bandage, /obj/item/medical/splint))
		owner.visible_message(span_warning("The splint on [owner]'s [name] breaks!"), span_warning("The splint on your [name] breaks!"))
		if(splint_timer)
			deltimer(splint_timer)
			splint_timer = null
		remove_bandage()

/obj/item/bodypart/Destroy()
	if(splint_timer)
		deltimer(splint_timer)
		splint_timer = null
	return ..()

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

	if(!user.mind || user.mind.get_skill_level(/datum/skill/misc/medicine) < 3)
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
