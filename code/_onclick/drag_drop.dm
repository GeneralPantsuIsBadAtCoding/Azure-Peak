/*
	MouseDrop:

	Called on the atom you're dragging.  In a lot of circumstances we want to use the
	receiving object instead, so that's the default action.  This allows you to drag
	almost anything into a trash can.
*/

// Component defines for click handling
#define COMPONENT_CANCEL_CLICK 1

/atom/MouseDrop(atom/over, src_location, over_location, src_control, over_control, params)
	if(!usr || !over)
		return
	if(SEND_SIGNAL(src, COMSIG_MOUSEDROP_ONTO, over, usr) & COMPONENT_NO_MOUSEDROP)	//Whatever is receiving will verify themselves for adjacency.
		return
	if(!Adjacent(usr) || !over.Adjacent(usr))
		return // should stop you from dragging through windows
	var/list/L = params2list(params)
	if (L["middle"])
		over.MiddleMouseDrop_T(src,usr)
	else
		if(over == src)
			return usr.client.Click(src, src_location, src_control, params)
		over.MouseDrop_T(src,usr)
	if(isitem(src) && ((isturf(over) && loc == over) || ((istype(over, /obj/structure/table) || istype(over, /obj/structure/rack)) && loc == over.loc)) && (isliving(usr) || prob(10)))
		var/modifier = 1
		var/obj/item/I = src
		if(isdead(usr))
			modifier = 16
		if(!(I.item_flags & ABSTRACT))
			var/list/click_params = params2list(params)
			if(!click_params || !click_params["icon-x"] || !click_params["icon-y"])
				return
			I.pixel_x = round(CLAMP(text2num(click_params["icon-x"]) - 16, -(world.icon_size/2), world.icon_size/2)/modifier, 1)
			I.pixel_y = round(CLAMP(text2num(click_params["icon-y"]) - 16, -(world.icon_size/2), world.icon_size/2)/modifier, 1)
			return
	return

// receive a mousedrop
/atom/proc/MouseDrop_T(atom/dropping, mob/user)
	SEND_SIGNAL(src, COMSIG_MOUSEDROPPED_ONTO, dropping, user)
	return

/atom/proc/MiddleMouseDrop_T(atom/dropping, mob/user)
	SEND_SIGNAL(src, COMSIG_MOUSEDROPPED_ONTO, dropping, user)
	return

/client
	var/list/atom/selected_target[2]
	var/obj/item/active_mousedown_item = null
	var/mouseParams = ""
	var/mouseLocation = null
	var/mouseObject = null
	var/mouseControlObject = null
	var/middragtime = 0
	var/atom/middragatom
	var/tcompare
	var/charging = 0
	var/chargedprog = 0
	var/sections
	var/lastplayed
	var/part
	var/goal
	var/progress
	var/doneset
	var/aghost_toggle

/atom
	var/blockscharging = FALSE

/atom/movable/screen
	blockscharging = TRUE

/client/MouseDown(object, location, control, params)
	if(mob.incapacitated())
		return

	tcompare = object

	var/atom/AD = object

	if(mob.used_intent)
		mob.used_intent.on_mouse_up()

	if(mob.stat != CONSCIOUS)
		mob.atkswinging = null
		charging = null
		mouse_pointer_icon = 'icons/effects/mousemice/human.dmi'
		return

	if (mouse_down_icon)
		mouse_pointer_icon = mouse_down_icon
	var/delay = mob.CanMobAutoclick(object, location, params)

	mob.atkswinging = null

	charging = 0
	chargedprog = 0

	if(!mob.fixedeye) //If fixedeye isn't already enabled, we need to set this var
		mob.tempfixeye = TRUE //Change icon to 'target' red eye
		mob.nodirchange = TRUE

	for(var/atom/movable/screen/eye_intent/eyet in mob.hud_used.static_inventory)
		eyet.update_icon(mob) //Update eye icon

	if(delay)
		selected_target[1] = object
		selected_target[2] = params
		while(selected_target[1])
			Click(selected_target[1], location, control, selected_target[2])
			sleep(delay)
	active_mousedown_item = mob.canMobMousedown(object, location, params)
	if(active_mousedown_item)
		active_mousedown_item.onMouseDown(object, location, params, mob)




	var/list/L = params2list(params)
	if (L["right"])
		mob.face_atom(object, location, control, params)
		if(L["left"])
			return
		mob.atkswinging = "right"
		if(mob.oactive)
			if(mob.active_hand_index == 2)
				if(mob.next_lmove > world.time)
					return
			else
				if(mob.next_rmove > world.time)
					return
			mob.used_intent = mob.o_intent
			if(mob.used_intent.get_chargetime() && !AD.blockscharging && !mob.in_throw_mode)
				updateprogbar()
			else
				mouse_pointer_icon = 'icons/effects/mousemice/human_attack.dmi'
			return
		else
			mouse_pointer_icon = 'icons/effects/mousemice/human_looking.dmi'
			return
	if (L["middle"]) //start charging a spell or readying a mmb intent
		if(mob.next_move > world.time)
			return
		mob.atkswinging = "middle"
		if(mob.mmb_intent)
			mob.used_intent = mob.mmb_intent
			if(mob.used_intent.type == INTENT_SPELL && mob.ranged_ability)
				var/obj/effect/proc_holder/spell/S = mob.ranged_ability
				// For fully charged non-projectile invoked spells, don't start charging again
				if(mob.client?.doneset && istype(S, /obj/effect/proc_holder/spell/invoked) && !istype(S, /obj/effect/proc_holder/spell/invoked/projectile))
					return
				if(!S.cast_check(TRUE,mob))
					return
		if(!mob.mmb_intent)
			mouse_pointer_icon = 'icons/effects/mousemice/human_looking.dmi'
		else
			if(mob.mmb_intent.get_chargetime() && !AD.blockscharging)
				updateprogbar()
			else
				mouse_pointer_icon = mob.mmb_intent.pointer
		return
	if (L["left"]) //start charging a lmb intent
		if(!L["shift"] || mob.BehindAtom(AD, mob.dir))
			mob.face_atom(AD, location, control, params)
		if(L["right"])
			return
		if(mob.active_hand_index == 1)
			if(mob.next_lmove > world.time)
				return
		else
			if(mob.next_rmove > world.time)
				return
		mob.atkswinging = "left"
		mob.used_intent = mob.a_intent
		if(mob.used_intent.get_chargetime() && !AD.blockscharging && !mob.in_throw_mode)
			updateprogbar()
		else
			mouse_pointer_icon = 'icons/effects/mousemice/human_attack.dmi'
		return

/mob
	var/datum/intent/curplaying

/client/MouseUp(object, location, control, params)
	// For non-primed spells, reset charging state
	if(!doneset)
		charging = 0
	//	mob.update_warning()

	// Special handling for fully charged spells
	if(mob && mob.is_spell_fully_charged() && istype(mob.ranged_ability, /obj/effect/proc_holder/spell/invoked))
		var/obj/effect/proc_holder/spell/invoked/spell = mob.ranged_ability
		
		// Check if this spell has the projectile behavior flag, with a safe fallback
		var/is_projectile_behavior = FALSE
		if(istype(spell, /obj/effect/proc_holder/spell/invoked/projectile))
			is_projectile_behavior = TRUE
		else if(spell.vars && ("projectile_behavior" in spell.vars))
			is_projectile_behavior = spell.vars["projectile_behavior"]
		
		// For non-projectile spells that are fully charged, keep the charged mouse icon
		if(doneset && !is_projectile_behavior)
			// Keep the charged mouse icon for non-projectile spells
			mouse_pointer_icon = 'icons/effects/mousemice/swang/acharged.dmi'
			// Always ensure the sound is stopped on mouse up
			if(mob.curplaying)
				mob.curplaying.on_mouse_up()
				mob.curplaying = null
			return
			
		// For projectile spells, allow the standard click release behavior
		// but don't auto-deactivate - let the click handler manage this
		if(is_projectile_behavior)
			mouse_pointer_icon = 'icons/effects/mousemice/human.dmi'
	else
		// Default behavior - reset mouse icon
		mouse_pointer_icon = 'icons/effects/mousemice/human.dmi'

	// Always ensure the sound is stopped on mouse up
	if(mob.curplaying)
		mob.curplaying.on_mouse_up()
		mob.curplaying = null

	if(!mob.fixedeye)
		mob.tempfixeye = FALSE
		mob.nodirchange = FALSE

	if(mob.hud_used)
		for(var/atom/movable/screen/eye_intent/eyet in mob.hud_used.static_inventory)
			eyet.update_icon(mob) //Update eye icon

	if(!mob.atkswinging)
		return

	var/list/modifiers = params2list(params)
	if(modifiers["left"])
		if(mob.atkswinging != "left")
			mob.atkswinging = null
			return
	if(modifiers["right"])
		if(mob.oactive)
			if(mob.atkswinging != "right")
				mob.atkswinging = null
				return

	if(mob.stat != CONSCIOUS)
		chargedprog = 0
		mob.atkswinging = null
//		mob.update_warning()
		mouse_pointer_icon = 'icons/effects/mousemice/human.dmi'
		return

	if(mouse_up_icon)
		mouse_pointer_icon = mouse_up_icon
	selected_target[1] = null

//	var/list/L = params2list(params)

	if(tcompare)
		if(object)
			if(isatom(object) && object != tcompare && mob.atkswinging && tcompare != mob)
				var/atom/N = object
				N.Click(location, control, params)
		tcompare = null

//	mouse_pointer_icon = 'icons/effects/mousemice/human.dmi'

	if(active_mousedown_item)
		active_mousedown_item.onMouseUp(object, location, params, mob)
		active_mousedown_item = null

	if(!isliving(mob))
		return

/client/proc/updateprogbar()
	if(!mob)
		return
	if(!isliving(mob))
		return
	var/mob/living/L = mob
	if(!L.used_intent.can_charge())
		return
	L.used_intent.prewarning()

	if(!charging) //This is for spell charging
		charging = 1 
		L.used_intent.on_charge_start()
		L.update_charging_movespeed(L.used_intent)
//		L.update_warning(L.used_intent)
		progress = 0 

//		if(L.used_intent.charge_invocation) 
//			sections = 100/L.used_intent.charge_invocation.len
//		else
//			sections = null
		sections = null //commented //From what I can tell, this used to be for the mouse icon changing per % of the cast.
		goal = L.used_intent.get_chargetime() //How much charge to get in order to cast
		part = 1
		lastplayed = 0
		doneset = 0
		chargedprog = 0
		mouse_pointer_icon = 'icons/effects/mousemice/swang/acharging.dmi'
		START_PROCESSING(SSmousecharge, src)

/client/Destroy()
	STOP_PROCESSING(SSmousecharge, src)
	return ..()

/client/process()
	if(!isliving(mob))
		return PROCESS_KILL
	var/mob/living/L = mob
	
	// Only kill the process if we're missing basic dependencies
	if(!L?.client)
		if(L && L.curplaying)
			L.curplaying.on_mouse_up()
		if(L)
			L.update_charging_movespeed()
		return PROCESS_KILL
	
	// Always call update_to_mob regardless of ranged ability status
	// This ensures stamina drains even for non-ranged ability spells
	update_to_mob(L)
	
	// Return normally to keep the process running
	return

/client/proc/update_to_mob(mob/living/L)
	if(charging || doneset)
		if(progress < goal && charging)
			progress++
			chargedprog = text2num("[((progress / goal) * 100)]")
			
			// Set the charging cursor while charging
			mouse_pointer_icon = 'icons/effects/mousemice/swang/acharging.dmi'
			
			// Apply fatigue drain during charging
			// Check for spell drain value first
			var/drain_amount = L.used_intent.chargedrain
			if(istype(L.ranged_ability, /obj/effect/proc_holder/spell))
				var/obj/effect/proc_holder/spell/spell = L.ranged_ability
				// Check for both variable names due to inconsistency in the codebase
				if(spell.vars && ("chargedrain" in spell.vars) && !isnull(spell.vars["chargedrain"]))
					drain_amount = spell.vars["chargedrain"]
			
			// Apply the drain
			if(!L.rogfat_add(drain_amount))
				L.stop_attack()
				return FALSE
		else //Fully charged spell
			if(!doneset) 
				doneset = 1
				
				// Play charged sound but don't stop the loop
				playsound(L, 'sound/magic/charged.ogg', 100, TRUE)
				
				// Notify the user that the spell is fully charged and ready to use
				if(istype(L.ranged_ability, /obj/effect/proc_holder/spell))
					var/obj/effect/proc_holder/spell/spell = L.ranged_ability
					to_chat(L, span_notice("Your [spell.name] is fully charged! Click to cast."))
					
					// Set a flag on the mob to prevent stamina regeneration while spell is primed
					L.primed_spell = TRUE
				
				chargedprog = 100
				
				// Always set the fully charged cursor
				mouse_pointer_icon = 'icons/effects/mousemice/swang/acharged.dmi'
			
			// Apply fatigue drain when fully charged - same logic as during charging
			var/drain_amount = L.used_intent.chargedrain
			var/obj/effect/proc_holder/spell/spell
			if(istype(L.ranged_ability, /obj/effect/proc_holder/spell))
				spell = L.ranged_ability
				// Check for both variable names due to inconsistency in the codebase
				if(spell.vars && ("chargedrain" in spell.vars) && !isnull(spell.vars["chargedrain"]))
					drain_amount = spell.vars["chargedrain"]
				
				// For primed spells, apply drain at the same rate as charging
				if(doneset)
					if(!L.rogfat_add(drain_amount))
						// If stamina is depleted and spell is primed, automatically release it
						if(doneset)
							spell.deactivate(L)
							to_chat(L, span_warning("You lose concentration and release the spell as you become exhausted!"))
						L.stop_attack()
						return FALSE
					return TRUE
			
			// Apply the drain
			if(!L.rogfat_add(drain_amount))
				L.stop_attack()
				return FALSE
			return TRUE
	else
		return FALSE

/mob/proc/CanMobAutoclick(object, location, params)

/mob/living/carbon/CanMobAutoclick(atom/object, location, params)
	if(!object.IsAutoclickable())
		return
	var/obj/item/h = get_active_held_item()
	if(h)
		. = h.CanItemAutoclick(object, location, params)

/mob/proc/canMobMousedown(atom/object, location, params)

/mob/living/carbon/canMobMousedown(atom/object, location, params)
	var/obj/item/H = get_active_held_item()
	if(H)
		. = H.canItemMouseDown(object, location, params)

/obj/item/proc/CanItemAutoclick(object, location, params)

/obj/item/proc/canItemMouseDown(object, location, params)
	if(canMouseDown)
		return src

/obj/item/proc/onMouseDown(object, location, params, mob)
	return

/obj/item/proc/onMouseUp(object, location, params, mob)
	return

/obj/item/gun/CanItemAutoclick(object, location, params)
	. = automatic

/atom/proc/IsAutoclickable()
	. = 1

/atom/movable/screen/IsAutoclickable()
	. = 0

/atom/movable/screen/click_catcher/IsAutoclickable()
	. = 1

/client/MouseDrag(src_object,atom/over_object,src_location,over_location,src_control,over_control,params)

	if(mob.incapacitated())
		return

	var/list/L = params2list(params)
	if (L["middle"])
		if (src_object && src_location != over_location)
			middragtime = world.time
			middragatom = src_object
		else
			middragtime = 0
			middragatom = null
	else
		mob.face_atom(over_object, over_location, over_control, params)

	mouseParams = params
	mouseLocation = over_location
	mouseObject = over_object
	mouseControlObject = over_control
	if(selected_target[1] && over_object && over_object.IsAutoclickable())
		selected_target[1] = over_object
		selected_target[2] = params
	if(active_mousedown_item)
		active_mousedown_item.onMouseDrag(src_object, over_object, src_location, over_location, params, mob)


/obj/item/proc/onMouseDrag(src_object, over_object, src_location, over_location, params, mob)
	return

/client/MouseDrop(src_object, over_object, src_location, over_location, src_control, over_control, params)
	if (middragatom == src_object)
		middragtime = 0
		middragatom = null
	..()
