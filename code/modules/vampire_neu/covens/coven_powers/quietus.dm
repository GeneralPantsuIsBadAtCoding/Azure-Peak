/datum/coven/quietus
	name = "Quietus"
	desc = "Get a help from the Hell creatures, resist THE FIRE, transform into an imp. Violates Masquerade."
	icon_state = "daimonion"
	power_type = /datum/coven_power/quietus
	clan_restricted = FALSE

/datum/coven_power/quietus
	name = "Quietus power name"
	desc = "Quietus power description"

//SILENCE OF DEATH
/datum/coven_power/quietus/silence_of_death
	name = "Silence of Death"
	desc = "Create an area of pure silence around you, confusing those within it."

	level = 1
	research_cost = 0
	check_flags = COVEN_CHECK_CAPABLE | COVEN_CHECK_CONSCIOUS | COVEN_CHECK_IMMOBILE | COVEN_CHECK_LYING
	duration_length = 5 SECONDS
	cooldown_length = 15 SECONDS
	duration_override = TRUE

/datum/coven_power/quietus/silence_of_death/activate()
	. = ..()
	for(var/mob/living/carbon/human/H in get_hearers_in_range(7, owner))
		if(H == owner)
			continue

		ADD_TRAIT(H, TRAIT_DEAF, "quietus")
		if(H.confused < 25)
			H.confused += 25
		addtimer(CALLBACK(src, PROC_REF(deactivate), H), duration_length)

/datum/coven_power/quietus/silence_of_death/deactivate(mob/living/carbon/human/deafened)
	. = ..()
	REMOVE_TRAIT(deafened, TRAIT_DEAF, "quietus")

/datum/coven_power/quietus/scorpions_touch
	name = "Scorpion's Touch"
	desc = "Create a powerful venom to apply to your enemies."

	level = 2
	research_cost = 2
	check_flags = COVEN_CHECK_CAPABLE | COVEN_CHECK_CONSCIOUS | COVEN_CHECK_IMMOBILE | COVEN_CHECK_LYING | COVEN_CHECK_FREE_HAND
	violates_masquerade = TRUE
	cooldown_length = 30 SECONDS
	vitae_cost = 150

/datum/coven_power/quietus/scorpions_touch/activate()
	. = ..()
	owner.put_in_active_hand(new /obj/item/melee/touch_attack/quietus(owner))

//SCORPION'S TOUCH
/obj/item/melee/touch_attack/quietus
	name = "\improper poison touch"
	desc = "This is kind of like when you rub your feet on a shag rug so you can zap your friends, only a lot less safe."
	icon = 'icons/mob/roguehudgrabs.dmi'
	icon_state = "grabbing_greyscale"
	color = COLOR_RED_LIGHT

/obj/item/melee/touch_attack/quietus/afterattack(atom/target, mob/living/carbon/user, proximity)
	if(!proximity)
		return
	if(isliving(target))
		var/mob/living/L = target
		L.adjustFireLoss(10)
		L.adjust_fire_stacks(3)
		L.ignite_mob()
	return ..()

//BAAL'S CARESS
/datum/coven_power/quietus/baals_caress
	name = "Baal's Caress"
	desc = "Transmute your vitae into a toxin that destroys all flesh it touches."

	level = 3
	research_cost = 3
	check_flags = COVEN_CHECK_CAPABLE | COVEN_CHECK_CONSCIOUS | COVEN_CHECK_IMMOBILE | COVEN_CHECK_LYING
	vitae_cost = 150
	target_type = TARGET_OBJ
	range = 15
	violates_masquerade = TRUE
	cooldown_length = 30 SECONDS

/datum/coven_power/quietus/baals_caress/can_activate(atom/target, alert = FALSE)
	. = ..()
	var/obj/item/rogueweapon/target_weapon = target
	if(!istype(target_weapon))
		if(alert)
			to_chat(owner, span_warning("[src] can only be used on weapons!"))
		return FALSE

	if(!target_weapon.sharpness)
		if(alert)
			to_chat(owner, span_warning("[src] can only be used on bladed weapons!"))
		return FALSE

	return .

/datum/coven_power/quietus/baals_caress/activate(obj/item/rogueweapon/target)
	. = ..()
	target.AddElement(/datum/element/one_time_poison, list(/datum/reagent/strongpoison = 2))

/datum/coven_power/quietus/taste_of_death
	name = "Taste of Death"
	desc = "Spit a glob of caustic blood at your enemies."

	level = 4
	research_cost = 3
	check_flags = COVEN_CHECK_CAPABLE | COVEN_CHECK_CONSCIOUS | COVEN_CHECK_IMMOBILE | COVEN_CHECK_LYING
	violates_masquerade = TRUE

/datum/coven_power/quietus/taste_of_death/post_gain()
	. = ..()
	owner.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/acidsplash/quietus)

/obj/effect/proc_holder/spell/invoked/projectile/acidsplash/quietus
	projectile_type = /obj/projectile/magic/acidsplash/quietus

/obj/projectile/magic/acidsplash/quietus
	damage = 80
	flag = "magic"
	speed = 2

//DAGON'S CALL
/datum/coven_power/quietus/dagons_call
	name = "Dagon's Call"
	desc = "Curse the last person you attacked to drown in their own blood."

	level = 5
	minimal_generation = GENERATION_ANCILLAE
	research_cost = 4
	check_flags = COVEN_CHECK_CAPABLE | COVEN_CHECK_CONSCIOUS | COVEN_CHECK_IMMOBILE | COVEN_CHECK_LYING
	cooldown_length = 30 SECONDS

/datum/coven_power/quietus/dagons_call/activate()
	. = ..()
	var/mob/living/lastattacker = owner.lastattacker_weakref?.resolve()
	if(isliving(lastattacker))
		lastattacker.adjustStaminaLoss(80)
		lastattacker.adjust_fire_stacks(6)
		lastattacker.adjustFireLoss(10)
		to_chat(owner, "You send your curse on [lastattacker], the last creature you attacked.")
	else
		to_chat(owner, "You don't seem to have last attacked soul earlier...")
		return

