/obj/structure/handcart
	name = "cart"
	desc = "A wooden cart that will help you carry many things."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "cart-empty"
	density = TRUE
	max_integrity = 600
	anchored = FALSE
	climbable = TRUE

	var/current_capacity = 0
	/// Maximujm amount of weight the cart can hold
	var/maximum_capacity = 60

	var/upgrade_level = 0 // This is the carts upgrade level, capacity increases with upgrade level
	facepull = FALSE
	throw_range = 1

/obj/item/cart_upgrade
	name = "Example upgrade cog"
	desc = "Example upgrade."
	icon_state = "upgrade"
	icon = 'icons/roguetown/misc/structure.dmi'
	var/ulevel = 0
	grid_width = 64
	grid_height = 32

/obj/item/cart_upgrade/level_1
	name = "woodcutters wheelbrace"
	desc = "A wheelbrace, skillfully cut by a woodworker that can increase the carry capacity of a wooden cart."
	icon_state = "upgrade"
	ulevel = 1

/obj/item/cart_upgrade/level_2
	name = "reinforced woodcutters wheelbrace"
	desc = "A wheelbrace, expertly crafted by a woodworker that can further increase the carry capacity of a wooden cart. The first upgrade is required for this one to function."
	icon_state = "upgrade2"
	ulevel = 2

/obj/structure/handcart/examine(mob/user)
	. = ..()
	. += span_info("Use <b>TOUCH</i> intent while on a tile with items to try loading everything inside.")
	if(upgrade_level == 1)
		. += span_notice("This cart has a <i>level 1</i> woodcutters wheelbrace instaled.")
	else if(upgrade_level == 2)
		. += span_notice("This cart has a <i>level 2</i> woodcutters wheelbrace instaled.")
	. += span_notice("[span_bold("Drag")] large items such as chests or people onto this to load them in.")
	. += span_notice("[span_bold("Lie down")] and drag yourself onto it to climb inside.")
	. += span_notice("[span_bold("Right click")] to dump it out.")


/obj/structure/handcart/proc/manage_upgrade(obj/item/cart_upgrade/upgrade, mob/living/user)
	if(upgrade_level == upgrade.ulevel)
		to_chat(user, span_warn("[src] already has an upgrade of that type."))
		return
	switch(upgrade.ulevel)
		if(1)
			maximum_capacity = 90
		if(2)
			maximum_capacity = 120
	to_chat(user, span_notice("You install [upgrade] into [src]."))
	qdel(upgrade)
	update_icon()

/obj/structure/handcart/Initialize(mapload)
	RegisterSignal(src, list(COMSIG_ATOM_ENTERED, COMSIG_ATOM_EXITED), PROC_REF(contents_changed))
	RegisterSignal(src, COMSIG_STORAGE_MOUSEDROP, PROC_REF(commandeer_mousedrop))
	if(mapload)		// if closed, any item at the crate's loc is put in the contents
		addtimer(CALLBACK(src, PROC_REF(take_contents)), 0)
	. = ..()

/obj/structure/handcart/Destroy()
	UnregisterSignal(src, list(COMSIG_STORAGE_MOUSEDROP, COMSIG_ATOM_ENTERED, COMSIG_ATOM_EXITED))
	dump_contents()
	return ..()

/obj/structure/handcart/proc/commandeer_mousedrop(datum/source, datum/component/storage/storage_datum, atom/actual_dropped_atom)
	SIGNAL_HANDLER

	if(isitem(actual_dropped_atom))
		return NONE
	return COMPONENT_RELEASE_TO_MOUSEDROPPED

/obj/structure/handcart/container_resist(mob/living/user)
	visible_message(span_notice("[src] rocks slightly as something inside seems to be jostling forcefully."), vision_distance = 3)
	if(user.incapacitated())
		// Resist logic chain will cause them to attempt to remove their cuffs regardless
		// so they need to do that before they can escape the cart
		return FALSE
	to_chat(user, "You clamber out of [src].")
	user.forceMove(drop_location())

/obj/structure/handcart/proc/contents_changed(datum/source, atom/movable/atom_moving)
	SIGNAL_HANDLER

	// Don't do anything if it's not a real object
	if(!istype(atom_moving, /obj) && !istype(atom_moving, /mob/living))
		return NONE
	recalculate_weight(atom_moving)

/obj/structure/handcart/proc/recalculate_weight(atom/movable/moved_atom)
	var/weight
	var/entering = (moved_atom.loc == src)
	var/mob/living/moved_living = null
	var/obj/item/moved_item = null
	if(isliving(moved_atom))
		moved_living = moved_atom
		weight = min(moved_living.mob_size * 5, 1)
	else if(isitem(moved_atom))
		moved_item = moved_atom
		weight = moved_item.w_class
	else // presumably a mobile structure or machine, assume they're all roughly twice as big as a person
		weight = MOB_SIZE_HUMAN * 5 * 2 // 2 * 5 * 2
	if(entering)
		current_capacity += weight
		if(current_capacity > maximum_capacity)
			//shortened distance on this message to minimize the potential of it being spammed
			visible_message(span_warn("[moved_atom] is simply too big to fit within the space remaining inside [src], and it tumbles out."), vision_distance = 1)
			moved_atom.forceMove(drop_location())
			moved_item?.randomize_offsets()
	else
		current_capacity -= weight
	update_icon()

/obj/structure/handcart/dump_contents()
	var/atom/L = drop_location()
	for(var/atom/movable/AM in src)
		AM.forceMove(L)
		if(isitem(AM))
			var/obj/item/moved_item = AM
			moved_item.randomize_offsets()

/obj/structure/handcart/MouseDrop_T(atom/movable/mousedropping, mob/living/user)
	if(!istype(mousedropping) || !isturf(mousedropping.loc) || istype(mousedropping, /atom/movable/screen))
		return FALSE
	if(!istype(user) || user.incapacitated())
		return FALSE
	if(!Adjacent(user) || !user.Adjacent(mousedropping))
		return FALSE
	if(user == mousedropping) //try to climb into or onto it
		if(user.mobility_flags & MOBILITY_STAND)
			return ..()
		put_in(mousedropping, user)
		return TRUE
	if(!insertion_allowed(mousedropping, user))
		return FALSE
	if(!put_in(mousedropping, user))
		return FALSE
	return TRUE
			
/obj/structure/handcart/attackby(obj/item/I, mob/user, params)
	if(user.cmode)
		return ..()
	if(istype(I, /obj/item/cart_upgrade))
		manage_upgrade(I, user)
		return TRUE
	if(!insertion_allowed(I, user))
		return NONE
	if(put_in(I, user))
		return TRUE
	return ..()

/obj/structure/handcart/interact(mob/living/user)
	var/turf/user_turf = get_turf(user)
	if(user_turf != user.loc)
		return FALSE
	for(var/obj/item/I in user_turf)
		if(!insertion_allowed(I, user))
			continue
		put_in(I, user)

/obj/structure/handcart/attack_right(mob/user)
	if(!can_interact(user))
		return FALSE
	if(!length(contents))
		to_chat(user, span_notice("But [src] is already empty."))
		return FALSE
	user.changeNext_move(CLICK_CD_MELEE)
	dump_contents()
	visible_message(span_info("[user] dumps out [src]!"))
	playsound(loc, 'sound/foley/cartdump.ogg', 100, FALSE, -1)
	return TRUE

/obj/structure/handcart/proc/put_in(atom/movable/moved_atom, mob/user)
	if(moved_atom == user)
		user.visible_message(span_notice("[user] starts shimmying up inside of [src]..."))
		if(!do_after(user, 2 SECONDS))
			return FALSE
		. = TRUE
	else if(isitem(moved_atom))
		if(!user.transferItemToLoc(moved_atom, src))
			return FALSE
		. = TRUE
	else // we already checked if it's allowed to be moved into here
		user.visible_message(span_notice("[user] starts moving [moved_atom] into [src]..."))
		if(!do_after_mob(user, moved_atom, 2 SECONDS))
			return FALSE
		. = TRUE
	if(.)
		playsound(loc, 'sound/foley/cartadd.ogg', 100, FALSE, -1)
		moved_atom.forceMove(src)
	return TRUE

/obj/structure/handcart/proc/take_contents()
	var/atom/L = drop_location()
	for(var/atom/movable/AM as anything in L)
		if(AM != src && insertion_allowed(AM, null))
			AM.forceMove(src)

/obj/structure/handcart/update_icon()
	. = ..()
	cut_overlays()
	if(upgrade_level)
		if(upgrade_level == 1)
			add_overlay("ov_upgrade")
		if(upgrade_level == 2)
			add_overlay("ov_upgrade2")
	if(length(contents))
		icon_state = "cart-full"
	else
		icon_state = "cart-empty"

/obj/structure/handcart/proc/try_mob_insert(mob/living/inserted_mob, mob/living/user)
	. = TRUE
	var/to_user = null
	if(!istype(inserted_mob))
		. = FALSE
	else if(!isliving(inserted_mob)) //let's not put ghosts or camera mobs inside closets...
		. = FALSE
	else if(inserted_mob.anchored)
		to_user = span_warn("You can't seem to move [span_bold("[inserted_mob]")].")
		. = FALSE
	else if((inserted_mob.buckled && inserted_mob.buckled != src))
		to_user = span_warn("Unbuckle [span_bold("[inserted_mob]")] first!")
		. = FALSE
	else if(inserted_mob.incorporeal_move)
		to_user = span_warn("Your hands phase right through [span_bold("[inserted_mob]")]!")
		. = FALSE
	else if(inserted_mob.has_buckled_mobs())
		to_user = span_warn("You can only move one living thing at a time into [span_bold("[src]")].")
		. = FALSE
	if(istype(user) && !isnull(to_user))
		to_chat(user, to_user)
	return .

/obj/structure/handcart/proc/try_obj_insert(obj/inserted_object, mob/living/user)
	. = TRUE
	var/to_user = null
	if(!istype(inserted_object))
		. = FALSE
	else if(inserted_object.anchored)
		to_user = span_warn("You can't seem to move [span_bold("[inserted_object]")].")
		. = FALSE
	else if(inserted_object.has_buckled_mobs())
		to_user = span_warn("Unbuckle everything on [span_bold("[inserted_object]")] first.")
		. = FALSE
	else if(isitem(inserted_object))
		var/obj/item/inserted_item = inserted_object
		if(HAS_TRAIT(inserted_item, TRAIT_NODROP) || inserted_item.item_flags & ABSTRACT)
			. = FALSE
	if(istype(user) && !isnull(to_user))
		to_chat(user, to_user)
	return .

/obj/structure/handcart/proc/insertion_allowed(atom/movable/AM, mob/living/user)
	if(!ismovable(AM))
		return FALSE
	if(ismob(AM))
		return try_mob_insert(AM, user)
	if(isobj(AM))
		return try_obj_insert(AM, user)

/obj/structure/handcart/Move(atom/newloc, direct, glide_size_override)
	. = ..()
	if (. && pulledby && dir != pulledby.dir)
		setDir(pulledby.dir)
