/datum/coven/demonic
	name = "Demonic"
	desc = "Get a help from the Hell creatures, resist THE FIRE, transform into an imp. Violates Masquerade."
	icon_state = "daimonion"
	clan_restricted = FALSE
	power_type = /datum/coven_power/demonic

//SENSE THE SIN
/datum/coven_power/demonic/sense_the_sin
	name = "Sense the Sin"
	desc = "Become supernaturally resistant to fire."

	level = 1
	research_cost = 0
	cancelable = TRUE
	duration_length = 20 SECONDS
	cooldown_length = 10 SECONDS

/datum/coven_power/demonic/sense_the_sin/activate()
	. = ..()
	owner.physiology.burn_mod /= 100
	ADD_TRAIT(owner, TRAIT_NOFIRE, VAMPIRE_TRAIT)
	owner.color = "#884200"

/datum/coven_power/demonic/sense_the_sin/deactivate()
	. = ..()
	owner.color = initial(owner.color)
	REMOVE_TRAIT(owner, TRAIT_NOFIRE, VAMPIRE_TRAIT)
	owner.physiology.burn_mod *= 100

//FEAR OF THE VOID BELOW
/mob/living/carbon/human/proc/give_demon_flight()
	var/obj/item/organ/wings/old_wings = getorganslot(ORGAN_SLOT_WINGS)
	if(old_wings)
		return

	var/obj/item/organ/wings/flight/night_kin/demon_wings = new(get_turf(src))
	demon_wings.Insert(src)
	update_body()
	update_body_parts(TRUE)

/mob/living/carbon/human/proc/remove_demon_flight()
	var/obj/item/organ/wings/flight/night_kin/old_wings = getorganslot(ORGAN_SLOT_WINGS)
	if(!istype(old_wings))
		return
	old_wings.Remove(src)
	qdel(old_wings)
	update_body()
	update_body_parts(TRUE)

/datum/coven_power/demonic/fear_of_the_void_below
	name = "Fear of the Void Below"
	desc = "Sprout wings and become able to fly."

	level = 2
	check_flags = COVEN_CHECK_CONSCIOUS | COVEN_CHECK_CAPABLE | COVEN_CHECK_LYING | COVEN_CHECK_IMMOBILE

	violates_masquerade = TRUE

	cancelable = TRUE
	duration_length = 30 SECONDS
	cooldown_length = 20 SECONDS

/datum/coven_power/demonic/fear_of_the_void_below/activate()
	. = ..()
	owner.give_demon_flight()

/datum/coven_power/demonic/fear_of_the_void_below/deactivate()
	. = ..()
	owner.remove_demon_flight()

//CONFLAGRATION
/datum/coven_power/demonic/conflagration
	name = "Conflagration"
	desc = "Turn your hands into deadly claws."

	level = 3
	check_flags = COVEN_CHECK_CONSCIOUS | COVEN_CHECK_CAPABLE

	violates_masquerade = TRUE

	cancelable = TRUE
	duration_length = 30 SECONDS
	cooldown_length = 10 SECONDS

/datum/coven_power/demonic/conflagration/activate()
	. = ..()
	owner.drop_all_held_items()
	owner.put_in_r_hand(new /obj/item/rogueweapon/gangrel(owner))
	owner.put_in_l_hand(new /obj/item/rogueweapon/gangrel(owner))

/datum/coven_power/demonic/conflagration/deactivate()
	. = ..()
	for(var/obj/item/rogueweapon/gangrel/claws in owner)
		qdel(claws)

//PSYCHOMACHIA
/datum/coven_power/demonic/psychomachia
	name = "Psychomachia"
	desc = "Set your foes on fire with a fireball."

	level = 4
	check_flags = COVEN_CHECK_CONSCIOUS | COVEN_CHECK_CAPABLE | COVEN_CHECK_IMMOBILE | COVEN_CHECK_LYING

/datum/coven_power/demonic/psychomachia/post_gain()
	. = ..()
	owner.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fireball/baali)

/obj/effect/proc_holder/spell/invoked/projectile/fireball/baali
	name = "Infernal Fireball"
	desc = "This spell fires an explosive fireball at a target."
	school = "evocation"
	recharge_time = 6 SECONDS
	invocation_type = "whisper"
	projectile_type = /obj/projectile/magic/aoe/fireball/rogue
	sound = 'sound/magic/fireball.ogg'

//CONDEMNTATION
/datum/coven_power/demonic/condemnation
	name = "Condemnation"
	desc = "Condemn a soul and their bloodline to suffering."
	level = 5
	check_flags = COVEN_CHECK_CONSCIOUS | COVEN_CHECK_CAPABLE | COVEN_CHECK_IMMOBILE
	target_type = TARGET_LIVING
	range = 7
	vitae_cost = 250
	cooldown_length = 120 SECONDS
	violates_masquerade = TRUE
	var/initialized_curses = FALSE
	var/list/curse_names = list()
	var/list/curses = list()
/**
/datum/coven_power/demonic/condemnation/activate(mob/living/target)
	. = ..()
	if(!initialized_curses)
		for(var/i in subtypesof(/datum/family_curse/demonic))
			var/datum/family_curse/demonic/demonic_curse = new i
			curses += demonic_curse
			curse_names += initial(demonic_curse.name)
		initialized_curses = TRUE

	to_chat(owner, span_userdanger("The greatest of curses come with the greatest of costs. Are you willing to condemn an entire bloodline?"))
	var/chosencurse = input(owner, "Pick a curse to bestow upon their family:", "Demonic Condemnation", curse_names)
	if(!chosencurse)
		return

	for(var/datum/family_curse/demonic/C in curses)
		if(C.name == chosencurse)
			// Get or create heritage for the target
			var/datum/heritage/target_heritage = get_or_create_heritage(target)
			if(!target_heritage)
				to_chat(owner, span_warning("Something prevents you from cursing their bloodline!"))
				return

			// Apply the family curse
			target_heritage.AddFamilyCurse(C.type, C.severity, owner)

			// Reduce caster's blood pool based on curse severity
			var/blood_cost = C.severity * 50 // Scale cost with severity
			owner.maxbloodpool -= blood_cost
			if(owner.bloodpool > owner.maxbloodpool)
				owner.bloodpool = owner.maxbloodpool

			to_chat(owner, span_userdanger("You have condemned [target]'s entire bloodline with [C.name]!"))
			to_chat(target, span_userdanger("A terrible curse settles upon your family line! You feel the weight of [C.name]!"))

			return TRUE

/datum/coven_power/demonic/condemnation/proc/get_or_create_heritage(mob/living/carbon/human/target)
	if(!istype(target))
		return null

	// Check if target already has a heritage
	if(target.family_datum)
		return target.family_datum

	// Create new heritage if none exists
	var/datum/heritage/new_heritage = new /datum/heritage(src, "Cursed Bloodline")
	target.family_datum = new_heritage
	return new_heritage
*/
/obj/item/rogueweapon/gangrel
	name = "claws"
	desc = ""
	item_state = null
	lefthand_file = null
	righthand_file = null
	icon = 'icons/roguetown/weapons/special/claws.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/claws_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/claws_righthand.dmi'
	icon_state = "claws"
	max_blade_int = 900
	max_integrity = 900
	force = 6
	wdefense = 9
	armor_penetration = 100
	block_chance = 20
	associated_skill = /datum/skill/combat/unarmed
	wlength = WLENGTH_NORMAL
	wbalance = WBALANCE_NORMAL
	w_class = WEIGHT_CLASS_BULKY
	can_parry = TRUE
	sharpness = IS_SHARP
	parrysound = "bladedmedium"
	swingsound = BLADEWOOSH_MED
	possible_item_intents = list(/datum/intent/simple/werewolf)
	parrysound = list('sound/combat/parry/parrygen.ogg')
	embedding = list("embedded_pain_multiplier" = 0, "embed_chance" = 0, "embedded_fall_chance" = 0)
	item_flags = DROPDEL
	//masquerade_violating = TRUE

/obj/item/rogueweapon/gangrel/afterattack(atom/target, mob/living/carbon/user, proximity)
	if(!proximity)
		return
	if(isliving(target))
		var/mob/living/L = target
		L.apply_damage(30, BURN)
	. = ..()
