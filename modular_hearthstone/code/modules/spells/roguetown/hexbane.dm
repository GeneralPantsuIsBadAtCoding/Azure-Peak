// An immediate advanced Counterspell

/obj/effect/proc_holder/spell/invoked/hexbaneimmediate
	name = "Miraculous Hexbane"
	desc = "A secretive variation of the typical Counterspell. Nullify the arcyne energy surrounding a target for an extended period of Time. Either preventing magic from being used outright, or preventing most magics from affecting the subject."
	releasedrain = 60
	chargedrain = 0
	chargetime = 20
	charge_max = 60 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokelightning
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	overlay_state = "rune2"

/obj/effect/proc_holder/spell/invoked/hexbaneimmediate/cast(list/targets, mob/user = usr)
	if(isliving(targets[1]))
		var/mob/living/carbon/target = targets[1]
		if(HAS_TRAIT(target, TRAIT_COUNTERCOUNTERSPELL))
			to_chat(user, "<span class='warning'>Their Magicks are too potent to be disabled this way!</span>")
			revert_cast()
			return
		ADD_TRAIT(target, TRAIT_SPELLCOCKBLOCK, MAGIC_TRAIT)
		ADD_TRAIT(target, TRAIT_ANTIMAGIC, MAGIC_TRAIT)
		to_chat(target, span_warning("My connection to the Arcyne has been severed violently! The air feels still and cold..."))
		target.visible_message("[target]'s arcyne aura fades with aggressive discharge.")
		addtimer(CALLBACK(src, PROC_REF(remove_buff), target), wait = 30 SECONDS)
		return TRUE


/obj/effect/proc_holder/spell/invoked/hexbaneimmediate/proc/remove_buff(mob/living/carbon/target)
	REMOVE_TRAIT(target, TRAIT_SPELLCOCKBLOCK, MAGIC_TRAIT)
	REMOVE_TRAIT(target, TRAIT_ANTIMAGIC, MAGIC_TRAIT)
	to_chat(target, span_warning("I feel my connection to the arcyne surround me once more."))
	target.visible_message("[target]'s arcyne aura seems to return once more.")


#define HEXBANE_ACTIVE "hexbane_glow"

/atom/movable/screen/alert/status_effect/buff/hexbanefield
	name = "Magick Disabled"
	desc = "I am under the ward's of a Hexbane Field!"
	icon_state = "buff"

/datum/status_effect/buff/casting_hexbane
	var/outline_colour = "#9255ff"
	var/effect_color = "#800000"
	var/pulse = 0
	var/ticks_to_apply = 5
	var/damage_interval = 5 SECONDS
	var/last_damage = 0
	id = "hexhexbanefield"
	alert_type = /atom/movable/screen/alert/status_effect/buff/hexbanefield
	duration = -1

/obj/effect/proc_holder/spell/targeted/touch/hexbaneorison
	name = "Hexbane's Orison"
	desc = "The secretive technique of all Hexbane's and their main tool to counteract the application of Magicks. The strain of maintaining these wards slowly damages the caster."
	clothes_req = FALSE
	drawmessage = "I prepare to perform the rites of Hexbane."
	dropmessage = "I let my focus wave away from the rites of Hexbane."
	school = "transmutation"
	chargedrain = 0
	chargetime = 0
	releasedrain = 5
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	hand_path = /obj/item/melee/touch_attack/hexbaneorison

/obj/item/melee/touch_attack/hexbaneorison
	name = "Hexbane's Orison"
	desc = "The Hexbane's Orison, the staple technique of every Hexbane. Able to invoke a series of wards around its caster that absorbs and suppresses any surrounding fields of Magick at the expense of their own Vitality."
	catchphrase = null
	icon_state = "grabbing_greyscale"
	icon = 'icons/mob/roguehudgrabs.dmi'
	color = "#9255FF"
	var/casting = FALSE
	var/xp_interval = 150
	var/xp_cooldown = 0
	var/right_click = FALSE
	twohands_required = TRUE
	var/datum/looping_sound/hexbanecast/soundloop

/datum/looping_sound/hexbanecast
	mid_sounds = list('sound/magic/hexbanecast.ogg' = 1)
	mid_length = 5 SECONDS
	volume = 100

/obj/item/melee/touch_attack/hexbaneorison/attack_self(mob/living/user)
	if(!(user.mobility_flags & MOBILITY_STAND))
		to_chat(user, span_warning("You need to be standing to perform the Hexbane rituals!"))
		return

	. = ..()
	casting = !casting
	update_icon()
	if(casting)
		user.apply_status_effect(/datum/status_effect/buff/casting_hexbane)
		soundloop.start()
		var/songhearers = view(7, user)
		for(var/mob/living/carbon/human/target in songhearers)
			to_chat(target,span_cultsmall("[user] begins casting Hexbane rituals."))
		to_chat(user, span_danger("You feel the wards draining your vitality!"))
	if(!casting)
		soundloop.stop()
		user.remove_status_effect(/datum/status_effect/buff/casting_hexbane)
		to_chat(user, span_notice("The strain on your body lessens as the wards fade."))

/obj/item/melee/touch_attack/hexbaneorison/Initialize()
	. = ..()
	soundloop = new(src, FALSE)

/obj/item/melee/touch_attack/hexbaneorison/update_icon()
	if(casting)
		icon_state = "pulling"
	else
		icon_state = "grabbing_greyscale"

/obj/item/melee/touch_attack/hexbaneorison/dropped(mob/living/user, silent)
	. = ..()
	casting = FALSE
	update_icon()
	if(soundloop)
		soundloop.stop()
		user.remove_status_effect(/datum/status_effect/buff/casting_hexbane)

/atom/movable/screen/alert/status_effect/buff/casting_hexbane
	name = "Casting a Hexbane"
	desc = "I am casting my Hexbane rituals. The strain is sapping my energy!"
	icon_state = "buff"

/datum/status_effect/buff/casting_hexbane/on_creation(mob/living/new_owner, stress, colour)
	effect_color = "#800000"
	return ..()

/datum/status_effect/buff/casting_hexbane/tick()
	// Check if caster is no longer standing
	if(!(owner.mobility_flags & MOBILITY_STAND))
		if(isliving(owner))
			var/mob/living/L = owner
			var/obj/item/melee/touch_attack/hexbaneorison/hexbane_item = locate() in L
			if(hexbane_item?.casting)
				hexbane_item.casting = FALSE
				hexbane_item.update_icon()
				hexbane_item.soundloop.stop()
				L.remove_status_effect(/datum/status_effect/buff/casting_hexbane)
				to_chat(L, span_warning("The Hexbane rituals falter as you collapse!"))
		return

	var/obj/effect/temp_visual/music_rogue/M = new /obj/effect/temp_visual/music_rogue(get_turf(owner))
	M.color = "#800000"
	pulse += 1

	if(world.time > last_damage + damage_interval)
		last_damage = world.time
		if(isliving(owner))
			var/mob/living/L = owner
			L.apply_damage(7, BURN, null, L.run_armor_check(null, "magic"))
			to_chat(L, span_danger("The Hexbane wards are draining your life!"))

	if(pulse >= ticks_to_apply)
		pulse = 0
		for(var/mob/living/carbon/human/H in hearers(7, owner))
			if(HAS_TRAIT(H, TRAIT_COUNTERCOUNTERSPELL))
				to_chat(owner, span_warning("Their Magicks are too potent to be disabled!"))
				return
			H.apply_status_effect(/datum/status_effect/buff/casting_hexbane)

/datum/status_effect/buff/casting_hexbane/on_apply()
	. = ..()
	var/filter = owner.get_filter(HEXBANE_ACTIVE)
	if(!filter)
		owner.add_filter(HEXBANE_ACTIVE, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 200, "size" = 1))
	to_chat(owner, span_warning("I feel the Hexbane ward's sapping the magicks around me!"))
	ADD_TRAIT(owner, TRAIT_ANTIMAGIC, MAGIC_TRAIT)

/datum/status_effect/buff/casting_hexbane/on_remove()
	. = ..()
	to_chat(owner, span_warning("The Hexbane ward's protection fades..."))
	owner.remove_filter(HEXBANE_ACTIVE)
	REMOVE_TRAIT(owner, TRAIT_ANTIMAGIC, MAGIC_TRAIT)