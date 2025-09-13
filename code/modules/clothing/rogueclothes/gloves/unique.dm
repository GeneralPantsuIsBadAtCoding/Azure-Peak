/obj/item/clothing/gloves/roguetown/elven_gloves
	name = "woad elven gloves"
	desc = "The insides are lined with soft, living leaves and soil. They wick away moisture easily."
	icon = 'icons/roguetown/clothing/special/race_armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/race_armor.dmi'
	icon_state = "welfhand"
	item_state = "welfhand"
	armor = list("blunt" = 100, "slash" = 10, "stab" = 110, "piercing" = 20, "fire" = 0, "acid" = 0)//Resistant to blunt and stab, super weak to slash.
	prevent_crits = list(BCLASS_BLUNT, BCLASS_SMASH, BCLASS_PICK)
	resistance_flags = FIRE_PROOF
	blocksound = SOFTHIT
	max_integrity = 200
	anvilrepair = /datum/skill/craft/carpentry


/obj/item/clothing/gloves/roguetown/active
	var/active = FALSE
	desc = "Unfortunately, like most magic gloves, it must be used sparingly. Activation sigil is on the RIGHT side."
	var/cooldowny
	var/cdtime
	var/activetime
	var/activate_sound

/obj/item/clothing/gloves/roguetown/active/attack_right(mob/user)
	if(loc != user)
		return
	if(cooldowny)
		if(world.time < cooldowny + cdtime)
			to_chat(user, span_warning("Nothing happens."))
			return
	user.visible_message(span_warning("[user] primes the [src]!"))
	if(activate_sound)
		playsound(user, activate_sound, 100, FALSE, -1)
	cooldowny = world.time
	addtimer(CALLBACK(src, PROC_REF(demagicify)), activetime)
	active = TRUE
	update_icon()
	activate(user)

/obj/item/clothing/gloves/roguetown/active/proc/activate(mob/user)
	user.update_inv_wear_id()

/obj/item/clothing/gloves/roguetown/active/proc/demagicify()
	active = FALSE
	update_icon()
	if(ismob(loc))
		var/mob/user = loc
		user.visible_message(span_warning("[src] settles down."))
		user.update_inv_wear_id()

/obj/item/clothing/gloves/roguetown/active/voltic
	name = "voltic gauntlets"
	desc = "A gauntlet containing charged energy just waiting for release. Activation sigil is on the RIGHT side.."
	icon_state = "volticgauntlets"
	activate_sound = 'sound/items/stunmace_gen (2).ogg'
	cdtime = 1.5 MINUTES
	activetime = 5 SECONDS
	sellprice = 100
	var/delay = 5 SECONDS
	var/sprite_changes = 10
	var/datum/beam/current_beam = null

/obj/item/clothing/gloves/roguetown/active/voltic/attack_right(mob/user)
	if(loc != user)
		return
	if(cooldowny)
		if(world.time < cooldowny + cdtime)
			to_chat(user, span_warning("Nothing happens."))
			return
	user.visible_message(span_warning("[user] primes the [src]!"))
	if(activate_sound)
		playsound(user, activate_sound, 100, FALSE, -1)
	cooldowny = world.time
	addtimer(CALLBACK(src, PROC_REF(demagicify)), activetime)
	active = TRUE
	update_icon()
	activate(user)

/obj/item/clothing/gloves/roguetown/active/voltic/activate(mob/user)
	if (!user)
		return

	var/list/mob/living/valid_targets = list()

	// Find all mobs in range
	for (var/mob/living/carbon/C in view(2, user))
		if (C.anti_magic_check())
			visible_message(span_warning("The beam of lightning can't seem to shock [C]!"))
			playsound(get_turf(C), 'sound/magic/magic_nulled.ogg', 100)
			continue
		if (C == user) // Prevent the user from being targeted
			continue
		valid_targets += C
		user.visible_message(span_warning("[C] is connected to [user] with a voltic link!"),
			span_warning("You create a static link with [C]."))

	if (!valid_targets.len)
		return // No valid targets, exit early

	// Beam Effects and Delayed Shock
	for (var/mob/living/carbon/C in valid_targets)
		if (C == user) // Prevent the user from being targeted
			continue
		var/datum/beam/current_beam
		for (var/x = 1; x <= sprite_changes; x++)
			current_beam = new(user, C, time = 50 / sprite_changes, beam_icon_state = "lightning[ rand(1,12) ]", btype = /obj/effect/ebeam, maxdistance = 10)
			INVOKE_ASYNC(current_beam, TYPE_PROC_REF(/datum/beam, Start))
			sleep(delay / sprite_changes)


		var/dist = get_dist(user, C)
		if (dist <= 2)
			if (HAS_TRAIT(C, TRAIT_SHOCKIMMUNE))
				continue
			else
				C.Immobilize(0.5 SECONDS)
				C.apply_status_effect(/datum/status_effect/debuff/clickcd, 6 SECONDS)
				C.electrocute_act(1, src, 1, SHOCK_NOSTUN)
				C.apply_status_effect(/datum/status_effect/buff/lightningstruck, 6 SECONDS)
		else
			playsound(user, 'sound/items/stunmace_toggle (3).ogg', 100)
			user.visible_message(span_warning("The voltaic link fizzles out!"), span_warning("[C] is too far away!"))

