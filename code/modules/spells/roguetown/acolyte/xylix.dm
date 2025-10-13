/obj/effect/proc_holder/spell/invoked/wheel
	name = "The Wheel"
	desc = "Spins the wheel, either buffing or debuffing the targets fortune."
	releasedrain = 10
	chargedrain = 0
	chargetime = 3
	range = 1
	no_early_release = TRUE
	movement_interrupt = TRUE
	chargedloop = /datum/looping_sound/invokeholy
	sound = 'sound/misc/letsgogambling.ogg'
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	recharge_time = 5 MINUTES
	
/obj/effect/proc_holder/spell/invoked/wheel/cast(list/targets, mob/user = usr)
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target.anti_magic_check(TRUE, TRUE))
			return FALSE
		target.apply_status_effect(/datum/status_effect/wheel)		
		return TRUE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/invoked/mastersillusion
	name = "Set Decoy"
	desc = "Creates a body double of yourself and makes you invisible, after a delay your clone explodes into smoke."
	releasedrain = 10
	chargedrain = 0
	chargetime = 0
	range = 1
	no_early_release = TRUE
	movement_interrupt = FALSE
	chargedloop = /datum/looping_sound/invokeholy
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	recharge_time = 30 SECONDS
	var/firstcast = TRUE
	var/icon/clone_icon

/obj/effect/proc_holder/spell/invoked/mastersillusion/cast(list/targets, mob/living/carbon/human/user = usr)
	if(firstcast)
		to_chat(user, span_italics("...Oh, oh, thy visage is so grand! Let us prepare it for tricks!"))
		clone_icon = get_flat_human_icon("[user.real_name] decoy", null, null, DUMMY_HUMAN_SLOT_MANIFEST, GLOB.cardinals, TRUE, user, TRUE) // We can only set our decoy icon once. This proc is sort of expensive on generation.
		firstcast = FALSE
		name = "Master's Illusion"
		to_chat(user, "There we are... Perfect.")
		revert_cast()
		return
	var/turf/T = get_turf(user)
	new /mob/living/simple_animal/hostile/rogue/xylixdouble(T, user, clone_icon)
	animate(user, alpha = 0, time = 0 SECONDS, easing = EASE_IN)
	user.mob_timers[MT_INVISIBILITY] = world.time + 7 SECONDS
	addtimer(CALLBACK(user, TYPE_PROC_REF(/mob/living/carbon/human, update_sneak_invis), TRUE), 7 SECONDS)
	addtimer(CALLBACK(user, TYPE_PROC_REF(/atom/movable, visible_message), span_warning("[user] fades back into view."), span_notice("You become visible again.")), 7 SECONDS)
	return TRUE

/mob/living/simple_animal/hostile/rogue/xylixdouble
	name = "Xylixian Double - You shouldnt be seeing this."
	desc = ""
	gender = NEUTER
	mob_biotypes = MOB_HUMANOID
	maxHealth = 20
	health = 20
	canparry = TRUE
	d_intent = INTENT_PARRY
	defprob = 50
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	del_on_death = TRUE
	loot = list(/obj/item/bomb/smoke/decoy)
	can_have_ai = FALSE
	AIStatus = AI_OFF
	ai_controller = /datum/ai_controller/mudcrab // doesnt really matter


/obj/item/bomb/smoke/decoy/Initialize()
	. = ..()
	playsound(loc, 'sound/magic/decoylaugh.ogg', 50)
	explode()

/mob/living/simple_animal/hostile/rogue/xylixdouble/Initialize(mapload, mob/living/carbon/human/copycat, icon/I)
	. = ..()
	addtimer(CALLBACK(src, TYPE_PROC_REF(/mob/living/simple_animal, death), TRUE), 7 SECONDS)
	icon = I
	name = copycat.name
	

/obj/effect/proc_holder/spell/invoked/mockery
	name = "Vicious Mockery"
	desc = "Mock your target, reducing their INT, SPD, STR and END for a time."
	releasedrain = 50
	associated_skill = /datum/skill/misc/music
	recharge_time = 2 MINUTES
	range = 7

/obj/effect/proc_holder/spell/invoked/mockery/cast(list/targets, mob/user = usr)
	playsound(get_turf(user), 'sound/magic/mockery.ogg', 40, FALSE)
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target.anti_magic_check(TRUE, TRUE))
			return FALSE
		if(!target.can_hear()) // Vicious mockery requires people to be able to hear you.
			revert_cast()
			return FALSE
		target.apply_status_effect(/datum/status_effect/debuff/viciousmockery)
		SEND_SIGNAL(user, COMSIG_VICIOUSLY_MOCKED, target)
		record_round_statistic(STATS_PEOPLE_MOCKED)
		return TRUE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/invoked/mockery/invocation(mob/user = usr)
	if(ishuman(user))
		switch(pick(1,2,3,4,5,6,7,8,9,10,11,12,13))
			if(1)
				user.say("Your mother was a Rous, and your father smelled of jacksberries!", forced = "spell")
			if(2)
				user.say("What are you going to do for a face when the Archdevil wants his arse back?!", forced = "spell")
			if(3)
				user.say("Wandought thine blades stand, much like thine loving parts!", forced = "spell")
			if(4)
				user.say("That's a face not even Eora could love!", forced = "spell")
			if(5)
				user.say("Your breath smells like raw butter and cheap beer!.", forced = "spell")
			if(6)
				user.say("I bite mine thumb, ser!", forced = "spell")
			if(7)
				user.say("But enough talk- have at thee!", forced = "spell")
			if(8)
				user.say("My grandmother fights better than you!", forced = "spell")
			if(9)
				user.say("Need you borrow mine spectacles? Come get them!", forced = "spell")
			if(10)
				user.say("How much sparring did it take to become this awful?!", forced = "spell")
			if(11)
				user.say("You may need a smith- for you seem ill-equipped for a battle of wits!", forced = "spell")
			if(12)
				user.say("Looks as if thou art PSY-DONE! No? Too soon? Alright.", forced = "spell")
			if(13)
				user.say("Ravox bring justice to your useless mentor, ser!", forced = "spell")

/datum/status_effect/debuff/viciousmockery
	id = "viciousmockery"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/viciousmockery
	duration = 600 // One minute
	effectedstats = list(STATKEY_STR = -1, STATKEY_SPD = -1,STATKEY_WIL = -1, STATKEY_INT = -3)

/atom/movable/screen/alert/status_effect/debuff/viciousmockery
	name = "Vicious Mockery"
	desc = "<span class='warning'>THAT ARROGANT BARD! ARGH!</span>\n"
	icon_state = "muscles"

/obj/effect/proc_holder/spell/self/xylixslip
	name = "Xylixian Slip"
	desc = "Jumps you up to 3 tiles away."
	overlay_state = "xylix_slip"
	releasedrain = 10
	chargedrain = 0
	chargetime = 0
	chargedloop = /datum/looping_sound/invokeholy
	sound = null
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = FALSE
	recharge_time = 12 SECONDS
	devotion_cost = 30
	miracle = TRUE
	var/leap_dist = 4	//3 tiles (+1 to account for origin tile)
	var/static/list/sounds = list('sound/magic/xylix_slip1.ogg','sound/magic/xylix_slip2.ogg','sound/magic/xylix_slip3.ogg','sound/magic/xylix_slip4.ogg')
	
/obj/effect/proc_holder/spell/self/xylixslip/cast(list/targets, mob/user = usr)
	. = ..()
	if(!ishuman(user))
		revert_cast()
		return FALSE

	var/mob/living/carbon/human/H = user

	if(H.IsImmobilized() || !(H.mobility_flags & MOBILITY_STAND))
		revert_cast()
		return FALSE

	if(H.IsOffBalanced())
		H.visible_message(span_warning("[H] loses their footing!"))
		var/turnangle = (prob(50) ? 270 : 90)
		var/turndir = turn(dir, turnangle)
		var/dist = rand(1, 2)
		var/current_turf = get_turf(H)
		var/target_turf = get_ranged_target_turf(current_turf, turndir, dist)
		H.throw_at(target_turf, dist, 1, H, TRUE)
		playsound(H,'sound/magic/xylix_slip_fail.ogg', 100)
		H.Knockdown(10)
		return TRUE
	else
		var/current_turf = get_turf(H)
		var/turf/target_turf = get_ranged_target_turf(current_turf, H.dir, leap_dist)
		H.visible_message(span_warning("[H] slips away!"))
		H.throw_at(target_turf, leap_dist, 1, H, TRUE)
		if(target_turf.landsound)
			playsound(target_turf, target_turf.landsound, 100, FALSE)
		H.emote("jump", forced = TRUE)
		H.OffBalance(8 SECONDS)
		if(prob(50))
			playsound(H, pick(sounds), 100, TRUE)
		return TRUE

#define NOTHING "nothing"
#define XYLIX "xylix"
#define ASTRATA "astrata"
#define NOC "noc"
#define ZIZO "zizo"
#define RAVOX "ravox"
#define MALUM "malum"
#define EORA "eora"

//Говно ксайликса
/datum/status_effect/xylix_blessed_luck
	id = "xylix_blessed_luck"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 2 MINUTES
	alert_type = /atom/movable/screen/alert/status_effect/buff/xylix_blessed_luck

/datum/status_effect/xylix_blessed_luck/on_apply()
	var/random_luck = rand(2,4)
	effectedstats = list("fortune" = random_luck)
	. = ..()

/atom/movable/screen/alert/status_effect/buff/xylix_blessed_luck
	name = "Благославление Ксаликса"
	desc = "Хоть вы и не выиграли одно из его одолжений, он все же благоволит вас."
	icon_state = "status"

//Говно астраты
/particles/astartian_favor
	icon = 'icons/effects/particles/generic.dmi'
	icon_state = list("dot" = 8,"curl" = 1)
	width = 64
	height = 96
	color = 0
	color_change = 0.05
	count = 200
	spawning = 50
	gradient = list("#f37a34", "#FBAF4D", "#f02b1d", "#ff6d40")
	lifespan = 1.5 SECONDS
	fade = 1 SECONDS
	fadein = 0.1 SECONDS
	grow = -0.1
	velocity = generator("box", list(-3, -0.7), list(3,3), NORMAL_RAND)
	position = generator("sphere", 8, 8, LINEAR_RAND)
	scale = generator("vector", list(2, 2), list(4,4), NORMAL_RAND)
	drift = list(0)


/datum/status_effect/astrata_favor
	id = "astrata_favor"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 41.1 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/buff/astrata_favor

/datum/status_effect/astrata_favor/on_apply()
	effectedstats = list("constitution" = 5, "willpower" = 5)
	ADD_TRAIT(owner, TRAIT_CRITICAL_RESISTANCE, XYLIX_LUCK_TRAIT)
	ADD_TRAIT(owner, TRAIT_NOPAINSTUN, XYLIX_LUCK_TRAIT)
	ADD_TRAIT(owner, TRAIT_STEELHEARTED, XYLIX_LUCK_TRAIT)
	ADD_TRAIT(owner, TRAIT_IGNOREDAMAGESLOWDOWN, XYLIX_LUCK_TRAIT)
	owner.particles = new /particles/astartian_favor()
	. = ..()

/datum/status_effect/astrata_favor/on_remove()
	REMOVE_TRAIT(owner, TRAIT_CRITICAL_RESISTANCE, XYLIX_LUCK_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_NOPAINSTUN, XYLIX_LUCK_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_STEELHEARTED, XYLIX_LUCK_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_IGNOREDAMAGESLOWDOWN, XYLIX_LUCK_TRAIT)
	qdel(owner.particles)
	owner.particles = null
	. = ..()

/atom/movable/screen/alert/status_effect/buff/astrata_favor
	name = "Одолжение Астраты"
	desc = "Хоть его и было сложно заполучить, но Ксайликс воспользовался им. Вы практически бессмертны... Временно"
	icon_state = "status"

//Говно Нок
/datum/status_effect/noc_favor
	id = "noc_favor"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 2 MINUTES
	alert_type = /atom/movable/screen/alert/status_effect/buff/noc_favor

/datum/status_effect/noc_favor/on_apply()
	effectedstats = list("intelligence" = 3, "speed" = 3)
	owner.alpha = 127
	. = ..()

/datum/status_effect/noc_favor/on_remove()
	owner.alpha = 255
	. = ..()

/atom/movable/screen/alert/status_effect/buff/noc_favor
	name = "Одолжение Нок"
	desc = "Знание, свет и тень Нок укрывает вас."
	icon_state = "status"

//Говно Зизо
/datum/status_effect/zizo_unfavor
	id = "zizo_unfavor"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 30 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/buff/zizo_unfavor

/datum/status_effect/zizo_unfavor/on_apply()
	effectedstats = list("strength" = -3, "perception" = -3, "intelligence" = -3, "constitution" = -3, "willpower" = -3, "speed" = -3)
	. = ..()

/atom/movable/screen/alert/status_effect/buff/zizo_unfavor
	name = "Вмешательство Зизо"
	desc = "Ваш покровитель не был достаточно внимателен."
	icon_state = "status"

//Говно Равокса
/datum/status_effect/ravox_favor
	id = "ravox_favor"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 2 MINUTES
	alert_type = /atom/movable/screen/alert/status_effect/buff/ravox_favor

/datum/status_effect/ravox_favor/on_apply()
	effectedstats = list("strength" = 3, "speed" = 3, "willpower" = 3)
	. = ..()

/atom/movable/screen/alert/status_effect/buff/ravox_favor
	name = "Одолжение Равокса"
	desc = "Сила Равокса поддерживает вас."
	icon_state = "status"

//Говно Малума
/datum/status_effect/malum_favor
	id = "malum_favor"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 5 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/buff/malum_favor

/datum/status_effect/malum_favor/on_apply()
	for(var/obj/item/item in owner.get_equipped_items())
		item.max_integrity *= 1.1
		item.obj_integrity = min(item.obj_integrity + item.max_integrity/2, item.max_integrity)
		if(item.blade_int)
			item.max_blade_int *= 1.1
			item.blade_int = min(item.blade_int + item.max_blade_int/2, item.max_blade_int)
	. = ..()

/atom/movable/screen/alert/status_effect/buff/malum_favor
	name = "Одолжение Малума"
	desc = "Малум доработал работу ремесленников на ваше снаряжение."
	icon_state = "status"

//Говно Эоры
/datum/status_effect/eora_favor
	id = "eora_favor"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 1 MINUTES
	alert_type = /atom/movable/screen/alert/status_effect/buff/eora_favor

/datum/status_effect/eora_favor/on_apply()
	. = ..()

/datum/status_effect/eora_favor/process()
	owner.adjustBruteLoss(-1.25)
	owner.adjustFireLoss(-1.25)
	. = ..()

/atom/movable/screen/alert/status_effect/buff/eora_favor
	name = "Одолжение Эоры"
	desc = "Эора окружает вас своей любовью."
	icon_state = "status"

/obj/effect/proc_holder/spell/invoked/xylixlian_luck
	name = "Ксайликситова удача"
	desc = "Бросьте вызов своей удаче и вашему покровителю"
	overlay_state = "xylixfortune"
	invocation_type = "none"
	associated_skill = /datum/skill/magic/holy
	recharge_time = 3 MINUTES
	miracle = TRUE
	devotion_cost = 50
	var/used_times = 0
	var/last_used = 0
	var/bonus_luck_threshould = 600

/obj/effect/proc_holder/spell/invoked/xylixlian_luck/Initialize()
	. = ..()

	last_used = world.time	

/obj/effect/proc_holder/spell/invoked/xylixlian_luck/cast(list/targets,mob/living/carbon/human/user = usr)
	user.play_overhead_indicator('modular_twilight_axis/icons/mob/overhead_effects.dmi', "xylix_fortune", 30, MUTATIONS_LAYER, soundin = 'modular_twilight_axis/sound/slotmachine.ogg', y_offset = 24)

	to_chat(user, span_danger("Ксайликс дает вам шанс, использовать одно из его одолжений"))
	var/luck_bonus = 0
	luck_bonus -= used_times * 5
	luck_bonus += 1.9444 * ((world.time - last_used) / bonus_luck_threshould)
	var/list/patronChances = list(
								XYLIX = 100 - luck_bonus,			RAVOX = 60 -luck_bonus/2, 
								EORA = 70 - luck_bonus/2,			NOTHING = 80 - luck_bonus, 
								MALUM = 50 - luck_bonus/2,			NOC = 50 - luck_bonus, 
								ASTRATA = 15 + luck_bonus * 1.5,	ZIZO = ceil(10-luck_bonus)
								)

	var/list/chances = typelist("patronChances", patronChances)
	var/result = pickweight(chances)

	used_times += 1
	last_used = world.time

	switch(result)
		if(NOTHING)
			to_chat(user, span_danger("Вы выиграли... Ничего!"))
		if(XYLIX)
			user.apply_status_effect(/datum/status_effect/xylix_blessed_luck)
			to_chat(user, span_danger("Удача Ксайликса благоволит вам!"))
		if(ASTRATA)
			user.apply_status_effect(/datum/status_effect/astrata_favor)
			to_chat(user, span_danger("Свет Астраты дает вам сил!"))
		if(NOC)
			user.apply_status_effect(/datum/status_effect/noc_favor)
			to_chat(user, span_danger("Тень от серебрянного света Нок укрывает вас!"))
		if(ZIZO)
			user.apply_status_effect(/datum/status_effect/zizo_unfavor)
			to_chat(user, span_danger("Лик Зизо насмехается над вами!"))
		if(RAVOX)
			user.apply_status_effect(/datum/status_effect/ravox_favor)
			to_chat(user, span_danger("Равокс благославляет вашу силу!"))
		if(MALUM)
			user.apply_status_effect(/datum/status_effect/malum_favor)
			to_chat(user, span_danger("Малум благославляет изделия ремесленников носимых вами!"))
		if(EORA)
			user.apply_status_effect(/datum/status_effect/eora_favor)
			to_chat(user, span_danger("Любовь Эоры окутывает вас!"))
	return ..()

#undef NOTHING
#undef XYLIX
#undef ASTRATA
#undef NOC
#undef ZIZO
#undef RAVOX
#undef MALUM
#undef EORA
