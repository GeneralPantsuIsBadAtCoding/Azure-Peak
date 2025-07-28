
/obj/item/rope
	name = "rope"
	desc = "A woven hemp rope."
	gender = PLURAL
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "rope"
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_WRISTS
	throwforce = 5
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 1
	throw_range = 3
	breakouttime = 5 SECONDS
	slipouttime = 1 MINUTES
	var/cuffsound = 'sound/blank.ogg'
	possible_item_intents = list(/datum/intent/tie)
	firefuel = 5 MINUTES
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	sewrepair = TRUE
	grid_width = 32
	grid_height = 64

/obj/item/rope/Initialize()
	. = ..()
	var/static/list/slapcraft_recipe_list = list(
		/datum/crafting_recipe/roguetown/survival/ropebelt,
		/datum/crafting_recipe/roguetown/survival/net,
		/datum/crafting_recipe/roguetown/survival/billhook,
		/datum/crafting_recipe/roguetown/survival/goedendag,
		/datum/crafting_recipe/roguetown/survival/rucksack,
		/datum/crafting_recipe/roguetown/survival/peasantry/thresher/whetstone,
		/datum/crafting_recipe/roguetown/survival/peasantry/shovel/whetstone,
		/datum/crafting_recipe/roguetown/survival/peasantry/hoe/whetstone,
		/datum/crafting_recipe/roguetown/survival/peasantry/pitchfork/whetstone,
		/datum/crafting_recipe/roguetown/survival/peasantry/peasantwarflail,
		/datum/crafting_recipe/roguetown/survival/peasantry/goedendag,
		/datum/crafting_recipe/roguetown/survival/peasantry/waraxe,
		/datum/crafting_recipe/roguetown/survival/peasantry/warspear_hoe,
		/datum/crafting_recipe/roguetown/survival/peasantry/warspear_pitchfork,
		/datum/crafting_recipe/roguetown/survival/peasantry/scythe,
		)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
		)

/datum/intent/tie
	name = "tie"
	chargetime = 0
	noaa = TRUE
	candodge = FALSE
	canparry = FALSE
	misscost = 0

/obj/item/rope/Destroy()
	if(iscarbon(loc))
		var/mob/living/carbon/M = loc
		if(M.handcuffed == src)
			M.handcuffed = null
			M.update_handcuffed()
			if(M.buckled && M.buckled.buckle_requires_restraints)
				M.buckled.unbuckle_mob(M)
		if(M.legcuffed == src)
			M.legcuffed = null
			M.update_inv_legcuffed()
	return ..()

/obj/item/rope/dropped(mob/user, silent)
	user.remove_movespeed_modifier(MOVESPEED_ID_CUFFED_LEG_SLOWDOWN)
	. = ..()

/obj/item/rope/attack(mob/living/carbon/C, mob/living/user)
	if(user.used_intent.type != /datum/intent/tie)
		..()
		return

	if(!istype(C))
		return

	if(user.aimheight > 4)
		try_cuff_arms(C, user)
		return

	if(user.aimheight <= 4)
		try_cuff_legs(C, user)
		return

/obj/item/rope/proc/try_cuff_arms(mob/living/carbon/C, mob/living/user)
	if(C.handcuffed)
		return

	if(!(C.get_num_arms(FALSE) || C.get_arm_ignore()))
		to_chat(user, span_warning("[C] has no arms to tie up."))
		return

	if(C.cmode && C.mobility_flags & MOBILITY_STAND)
		to_chat(user, span_warning("I can't tie them, they are too tense!"))
		return

	var/surrender_mod = 1
	if(C.compliance || C.surrendering || HAS_TRAIT(C, TRAIT_BAGGED))
		surrender_mod = 0.5

	C.visible_message(span_warning("[user] is trying to tie [C]'s arms with [src.name]!"), \
						span_userdanger("[user] is trying to tie my arms with [src.name]!"))
	playsound(loc, cuffsound, 100, TRUE, -2)

	if(!(do_mob(user, C, 60 * surrender_mod, double_progress = TRUE) && C.get_num_arms(FALSE)))
		to_chat(user, span_warning("I fail to tie up [C]!"))
		return

	apply_cuffs(C, user)
	C.visible_message(span_warning("[user] ties [C] with [src.name]."), \
						span_danger("[user] ties me up with [src.name]."))
	SSblackbox.record_feedback("tally", "handcuffs", 1, type)
	log_combat(user, C, "handcuffed")

/obj/item/rope/proc/try_cuff_legs(mob/living/carbon/C, mob/living/user)
	if(C.legcuffed)
		return

	if(C.get_num_legs(FALSE) < 2)
		to_chat(user, span_warning("[C] is missing two or one legs."))
		return

	if(C.cmode && C.mobility_flags & MOBILITY_STAND)
		to_chat(user, span_warning("I can't tie them, they are too tense!"))
		return

	var/surrender_mod = 1
	if(C.compliance || C.surrendering)
		surrender_mod = 0.5

	C.visible_message(span_warning("[user] is trying to tie [C]'s legs with [src.name]!"), \
						span_userdanger("[user] is trying to tie my legs with [src.name]!"))

	playsound(loc, cuffsound, 30, TRUE, -2)

	if(!do_mob(user, C, 60 * surrender_mod) || C.get_num_legs(FALSE) < 2)
		to_chat(user, span_warning("I fail to tie up [C]!"))
		return

	apply_cuffs(C, user, TRUE)
	C.visible_message(span_warning("[user] ties [C]'s legs with [src.name]."), \
						span_danger("[user] ties my legs with [src.name]."))
	SSblackbox.record_feedback("tally", "legcuffs", 1, type)

	log_combat(user, C, "legcuffed", TRUE)

/obj/item/rope/proc/apply_cuffs(mob/living/carbon/target, mob/user, leg = FALSE)
	if(!leg)
		if(target.handcuffed)
			return

		if(!user.temporarilyRemoveItemFromInventory(src) )
			return

		var/obj/item/cuffs = src

		cuffs.forceMove(target)
		target.handcuffed = cuffs

		target.update_handcuffed()
		return
	else
		if(target.legcuffed)
			return

		if(!user.temporarilyRemoveItemFromInventory(src) )
			return

		var/obj/item/cuffs = src

		cuffs.forceMove(target)
		target.legcuffed = cuffs

		target.update_inv_legcuffed()
		target.add_movespeed_modifier(MOVESPEED_ID_CUFFED_LEG_SLOWDOWN, update=TRUE, priority=100, multiplicative_slowdown=2, movetypes=GROUND)
		return


/datum/intent/whips
	name = "strike"
	blade_class = BCLASS_BLUNT
	attack_verb = list("whips", "strikes", "smacks")
	penfactor = 0 //40
	chargetime = 5
	item_d_type = "slash"

/obj/item/rope/chain
	name = "chain"
	desc = "A heavy iron chain."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "chain"
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_WRISTS
	throwforce = 5
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 1
	throw_range = 3
	breakouttime = 10 SECONDS
	slipouttime = 2 MINUTES
	cuffsound = 'sound/blank.ogg'
	possible_item_intents = list(/datum/intent/tie, /datum/intent/whips)
	firefuel = null
	smeltresult = /obj/item/ingot/iron
	drop_sound = 'sound/foley/dropsound/chain_drop.ogg'
	sewrepair = FALSE
	anvilrepair = /datum/skill/craft/blacksmithing
	resistance_flags = FIRE_PROOF

/obj/item/net
	name = "net"
	desc = ""
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "net"
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_WRISTS
	force = 10
	throwforce = 5
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "net"
	breakouttime = 35//easy to apply, easy to break out of
	gender = NEUTER
	var/knockdown = 0

/obj/item/net/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_DROPPED, PROC_REF(on_drop))

/obj/item/net/proc/on_drop()
	remove_effect()

/obj/item/net/proc/remove_effect()
	if(iscarbon(loc))
		var/mob/living/carbon/M = loc
		if(M.legcuffed == src)
			M.legcuffed = null
			M.update_inv_legcuffed()
			if(M.has_status_effect(/datum/status_effect/debuff/netted))
				M.remove_status_effect(/datum/status_effect/debuff/netted)

/obj/item/net/throw_at(atom/target, range, speed, mob/thrower, spin=1, diagonals_first = 0, datum/callback/callback)
	if(!..())
		return
	playsound(src.loc,'sound/blank.ogg', 75, TRUE)

/obj/item/net/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(..() || !iscarbon(hit_atom))//if it gets caught or the target can't be cuffed,
		return//abort
	ensnare(hit_atom)

/obj/item/net/proc/ensnare(mob/living/carbon/C)
	if(!C.legcuffed && C.get_num_legs(FALSE) >= 2)
		visible_message("<span class='danger'>\The [src] ensnares [C]!</span>")
		C.legcuffed = src
		forceMove(C)
		C.update_inv_legcuffed()
		SSblackbox.record_feedback("tally", "handcuffs", 1, type)
		to_chat(C, "<span class='danger'>\The [src] entraps you!</span>")
		C.Knockdown(knockdown)
		C.apply_status_effect(/datum/status_effect/debuff/netted)
		playsound(src, 'sound/blank.ogg', 50, TRUE)

// Failsafe in case the item somehow ends up being destroyed
/obj/item/net/Destroy()
	remove_effect()
	return ..()	
