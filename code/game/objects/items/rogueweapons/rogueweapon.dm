

/obj/item/rogueweapon
	name = ""
	desc = ""
	icon_state = "sabre"
	item_state = "sabre"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	force = 15
	throwforce = 10
	w_class = WEIGHT_CLASS_NORMAL
	block_chance = 0
	armor_penetration = 0
	sharpness = IS_SHARP
	custom_materials = null
	possible_item_intents = list(SWORD_CUT, SWORD_THRUST)
	can_parry = TRUE
	wlength = 45
	sellprice = 1
	has_inspect_verb = TRUE
	parrysound = list('sound/combat/parry/parrygen.ogg')
	anvilrepair = /datum/skill/craft/weaponsmithing
	obj_flags = CAN_BE_HIT
	blade_dulling = DULLING_BASH
	max_integrity = 200
	wdefense = 3
	experimental_onhip = TRUE
	experimental_onback = TRUE
	embedding = list(
		"embed_chance" = 20,
		"embedded_pain_multiplier" = 1,
		"embedded_fall_chance" = 0,
	)
	var/initial_sl
	var/list/possible_enhancements
	resistance_flags = FIRE_PROOF
	obj_flags = UNIQUE_RENAME

/obj/item/rogueweapon/Initialize()
	. = ..()
	if(!destroy_message)
		var/yea = pick("[src] is broken!", "[src] is useless!", "[src] is destroyed!")
		destroy_message = span_warning("[yea]")

/obj/item/rogueweapon/get_examine_string(mob/user, thats = FALSE)
	return "[thats? "That's ":""]<b>[get_examine_name(user)]</b>"

/obj/item/rogueweapon/get_dismemberment_chance(obj/item/bodypart/affecting, mob/user)
	if(!get_sharpness() || !affecting.can_dismember(src))
		return 0

	var/total_dam = affecting.get_damage()
	var/nuforce = get_complex_damage(src, user)
	var/pristine_blade = TRUE
	if(max_blade_int && dismember_blade_int)
		var/blade_int_modifier = (blade_int / dismember_blade_int)
		//blade is about as sharp as a brick it won't dismember shit
		if(blade_int_modifier <= 0.15)
			return 0
		nuforce *= blade_int_modifier
		pristine_blade = (blade_int >= (dismember_blade_int * 0.95))

	if(user)
		if(istype(user.rmb_intent, /datum/rmb_intent/weak))
			nuforce = 0
		else if(istype(user.rmb_intent, /datum/rmb_intent/strong))
			nuforce *= 1.1

		if(user.used_intent.blade_class == BCLASS_CHOP) //chopping attacks always attempt dismembering
			nuforce *= 1.1
		else if(user.used_intent.blade_class == BCLASS_CUT)
			if(!pristine_blade && (total_dam < affecting.max_damage * 0.8))
				return 0
		else
			return 0

	if(nuforce < 10)
		return 0

	var/probability = nuforce * (total_dam / affecting.max_damage)
	var/hard_dismember = HAS_TRAIT(affecting, TRAIT_HARDDISMEMBER)
	var/easy_dismember = affecting.rotted || affecting.skeletonized || HAS_TRAIT(affecting, TRAIT_EASYDISMEMBER)
	if(affecting.owner)
		if(!hard_dismember)
			hard_dismember = HAS_TRAIT(affecting.owner, TRAIT_HARDDISMEMBER)
		if(!easy_dismember)
			easy_dismember = HAS_TRAIT(affecting.owner, TRAIT_EASYDISMEMBER)
	if(hard_dismember)
		return min(probability, 5)
	else if(easy_dismember)
		return probability * 1.5
	return probability
