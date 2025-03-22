//pseudo ranged or melee ability, invocation on mmb


/obj/effect/proc_holder/spell/invoked
	name = "invoked spell"
	range = -1
	selection_type = "range"
	no_early_release = TRUE
	charge_max = 30
	charge_type = "recharge"
	invocation_type = "shout"
	var/active_sound
	// Note: chargedrain is inherited from the parent spell class

/obj/effect/proc_holder/spell/update_icon()
	if(!action)
		return
	action.button_icon_state = "[base_icon_state][active]"
	if(overlay_state)
		action.overlay_state = overlay_state
	action.name = name
	action.UpdateButtonIcon()

/obj/effect/proc_holder/spell/invoked/Click()
	var/mob/living/user = usr
	if(!istype(user))
		return
	if(!can_cast(user))
		start_recharge()
		deactivate(user)
		return
	if(active)
		deactivate(user)
	else
		if(active_sound)
			user.playsound_local(user,active_sound,100,vary = FALSE)
		active = TRUE
		add_ranged_ability(user, null, TRUE)
		// Update intent values
		if(user.mmb_intent && user.mmb_intent.type == INTENT_SPELL)
			user.update_mmb_intent_from_ranged_ability()
		on_activation(user)
	update_icon()
	start_recharge()

/obj/effect/proc_holder/spell/invoked/deactivate(mob/living/user) //Deactivates the currently active spell (icon click)
	..()
	active = FALSE
	remove_ranged_ability(null)
	// Reset client charging state if it exists
	if(user && user.client)
		user.client.charging = 0
		user.client.doneset = 0
		user.client.chargedprog = 0
		user.client.progress = 0
		user.client.mouse_pointer_icon = 'icons/effects/mousemice/human.dmi'
		STOP_PROCESSING(SSmousecharge, user.client)
		
		// Reset the primed_spell flag to allow stamina regeneration again
		user.primed_spell = FALSE
		
	on_deactivation(user)

/obj/effect/proc_holder/spell/invoked/proc/on_activation(mob/user)
	return

/obj/effect/proc_holder/spell/invoked/proc/on_deactivation(mob/user)
	if(user)
		to_chat(user, span_notice("You release the [src.name] spell."))
	return

/obj/effect/proc_holder/spell/invoked/InterceptClickOn(mob/living/caller, params, atom/target) 
	. = ..()
	if(.)
		return FALSE
	
	// Basic checks for casting ability
	if(!can_cast(caller) || !cast_check(FALSE, ranged_ability_user))
		return FALSE
	
	// Get click parameters to detect right-click
	var/list/modifiers = params2list(params)
	
	// Handle right-click to dismiss spell
	if(modifiers["right"]) 
		to_chat(caller, span_warning("You dismiss the [src.name] spell."))
		deactivate(caller)
		return TRUE
	
	// Check if this is a projectile spell or has projectile behavior
	var/is_projectile_behavior = FALSE
	if(istype(src, /obj/effect/proc_holder/spell/invoked/projectile))
		is_projectile_behavior = TRUE
	else if(vars && ("projectile_behavior" in vars))
		is_projectile_behavior = vars["projectile_behavior"]
	
	// Projectile spells use the hold/release behavior
	if(is_projectile_behavior)
		// For projectile spells, make sure it's fully charged if no_early_release is true
		if(no_early_release && !caller.is_spell_fully_charged())
			to_chat(caller, span_warning("[src.name] was not finished charging! It fizzles."))
			revert_cast(caller)
			return FALSE
			
		// Cast the projectile spell and deactivate only if we have a valid target
		if(target && target != caller && perform(list(target), TRUE, user = ranged_ability_user))
			deactivate(caller)
			// Reset the primed_spell flag after casting
			caller.primed_spell = FALSE
			return TRUE
		
		// If clicking on nothing or self, don't deactivate - keep spell primed
		if(!target || target == caller)
			return TRUE
	else
		// Non-projectile spells can use click-to-cast when fully charged
		if(caller.is_spell_fully_charged() || !no_early_release)
			// Only cast if we have a valid target
			if(target && target != caller && perform(list(target), TRUE, user = ranged_ability_user))
				deactivate(caller)
				// Reset the primed_spell flag after casting
				caller.primed_spell = FALSE
				return TRUE
			
			// If clicking on nothing or self, don't deactivate - keep spell primed
			if(!target || target == caller)
				return TRUE
		else
			to_chat(caller, span_warning("[src.name] is not fully charged yet!"))
			return TRUE
	
	return FALSE

/obj/effect/proc_holder/spell/invoked/projectile
	var/projectile_type = /obj/projectile/magic/teleport
	var/list/projectile_var_overrides = list()
	var/projectile_amount = 1	//Projectiles per cast.
	var/current_amount = 0	//How many projectiles left.
	var/projectiles_per_fire = 1		//Projectiles per fire. Probably not a good thing to use unless you override ready_projectile().

/obj/effect/proc_holder/spell/invoked/projectile/proc/ready_projectile(obj/projectile/P, atom/target, mob/user, iteration)
	return

/obj/effect/proc_holder/spell/invoked/projectile/cast(list/targets, mob/living/user)
	. = ..()
	var/target = targets[1]
	var/turf/T = user.loc
	var/turf/U = get_step(user, user.dir) // Get the tile infront of the move, based on their direction
	if(!isturf(U) || !isturf(T))
		return FALSE
	fire_projectile(user, target)
	user.newtonian_move(get_dir(U, T))
	update_icon()
	start_recharge()
	return TRUE

/obj/effect/proc_holder/spell/invoked/projectile/proc/fire_projectile(mob/living/user, atom/target)
	current_amount--
	for(var/i in 1 to projectiles_per_fire)
		var/obj/projectile/P = new projectile_type(user.loc)
		if(istype(P, /obj/projectile/magic/bloodsteal))
			var/obj/projectile/magic/bloodsteal/B = P
			B.sender = user
		P.firer = user
		P.preparePixelProjectile(target, user)
		for(var/V in projectile_var_overrides)
			if(P.vars[V])
				P.vv_edit_var(V, projectile_var_overrides[V])
		ready_projectile(P, target, user, i)
		P.fire()
	return TRUE
