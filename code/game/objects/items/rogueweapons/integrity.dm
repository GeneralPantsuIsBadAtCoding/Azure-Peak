/obj/item
	/// Current blade integrity
	var/blade_int = 0
	/// Blade integrity at which dismemberment reaches 100% effectiveness
	var/dismember_blade_int = 0
	/// Maximum blade integrity
	var/max_blade_int = 0
	/// Whether to randomize the blade integrity on init.
	var/randomize_blade_int_on_init = FALSE
	/// Required skill to repair the blade integrity
	var/required_repair_skill = 0

/obj/item/proc/remove_bintegrity(amt as num, mob/user)
	if(user && HAS_TRAIT(user, TRAIT_SHARPER_BLADES))
		amt = amt * 0.7

	var/mob/living/L
	if(loc && loc == user)
		L = user
	else	//If we're sending messages it should be sent to a mob
		if(loc && ishuman(loc))
			L = loc
	
	if(L && max_blade_int)	
		var/ratio = blade_int / max_blade_int
		var/newratio = (blade_int - amt) / max_blade_int
		if(ratio > SHARPNESS_TIER1_THRESHOLD && newratio <= SHARPNESS_TIER1_THRESHOLD) //We are above the first threshold but are about to hit it.
			if(L.STAINT > 9)
				to_chat(L, "<font color = '#ececec'><font size = 4>The edge chips! \The [src]'s damage will start to slowly wane, now.</font>")
			playsound(L, 'sound/combat/sharpness_loss1.ogg', 100, TRUE)

		//We are above the second threshold but are about to hit it.
		if(ratio > SHARPNESS_TIER2_THRESHOLD && newratio <= SHARPNESS_TIER2_THRESHOLD)
			if(L.STAINT > 9)
				to_chat(L, "<font color = '#ececec'><font size = 4>A chunk snapped off! \The [src]'s damage will decay much quicker now.</font>")
			playsound(L, 'sound/combat/sharpness_loss2.ogg', 100, TRUE)
	
	blade_int = blade_int - amt
	if(blade_int <= 0)
		blade_int = 0
		return FALSE
	return TRUE

/obj/item/proc/degrade_bintegrity(amt as num)
	if(max_blade_int <= 10)
		max_blade_int = 10
		return FALSE
	else
		max_blade_int = max_blade_int - amt
		if(max_blade_int <= 10)
			max_blade_int = 10
		return TRUE

/obj/item/proc/add_bintegrity(amt as num)
	if(blade_int >= max_blade_int)
		blade_int = max_blade_int
		return FALSE
	else
		blade_int = blade_int + amt
		if(blade_int >= max_blade_int)
			blade_int = max_blade_int
		return TRUE

/obj/structure/attackby(obj/item/I, mob/user, params)
	user.changeNext_move(user.used_intent.clickcd)
	. = ..()


/obj/machinery/attackby(obj/item/I, mob/user, params)
	user.changeNext_move(user.used_intent.clickcd)
	. = ..()

/obj/item/attackby(obj/item/I, mob/user, params)
	user.changeNext_move(user.used_intent.clickcd)
	if(max_blade_int)
		if(istype(I, /obj/item/natural))
			var/obj/item/natural/ST = I
			if(!ST.sharpening_factor)
				return
			playsound(src.loc, pick('sound/items/sharpen_long1.ogg','sound/items/sharpen_long2.ogg'), 100)
			user.visible_message(span_notice("[user] sharpens [src]!"))
			degrade_bintegrity(0.5)
			add_bintegrity(max_blade_int * ST.sharpening_factor)
			if(blade_int >= max_blade_int)
				to_chat(user, span_info("Fully sharpened."))
			if(prob(ST.spark_chance))
				var/datum/effect_system/spark_spread/S = new()
				var/turf/front = get_step(user,user.dir)
				S.set_up(1, 1, front)
				S.start()
			return
	. = ..()
