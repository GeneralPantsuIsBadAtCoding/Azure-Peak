
/mob/living/proc/run_armor_check(def_zone = null, attack_flag = "blunt", absorb_text = null, soften_text = null, armor_penetration, penetrated_text, damage, blade_dulling)
	var/armor = getarmor(def_zone, attack_flag, damage, armor_penetration, blade_dulling)

	//the if "armor" check is because this is used for everything on /living, including humans
	if(armor > 0 && armor_penetration)
		armor = max(0, armor - armor_penetration)
		if(penetrated_text)
			to_chat(src, span_danger("[penetrated_text]"))
//		else
//			to_chat(src, span_danger("My armor was penetrated!"))
	else if(armor >= 100)
		if(absorb_text)
			to_chat(src, span_notice("[absorb_text]"))
//		else
//			to_chat(src, span_notice("My armor absorbs the blow!"))
	else if(armor > 0)
		if(soften_text)
			to_chat(src, span_warning("[soften_text]"))
//		else
//			to_chat(src, span_warning("My armor softens the blow!"))
	return armor


/mob/living/proc/getarmor(def_zone, type, damage, armor_penetration, blade_dulling)
	return 0

//this returns the mob's protection against eye damage (number between -1 and 2) from bright lights
/mob/living/proc/get_eye_protection()
	return 0

//this returns the mob's protection against ear damage (0:no protection; 1: some ear protection; 2: has no ears)
/mob/living/proc/get_ear_protection()
	return 0

/mob/living/proc/is_mouth_covered(head_only = 0, mask_only = 0)
	return FALSE

/mob/living/proc/is_eyes_covered(check_glasses = 1, check_head = 1, check_mask = 1)
	return FALSE
/mob/living/proc/is_pepper_proof(check_head = TRUE, check_mask = TRUE)
	return FALSE
/mob/living/proc/on_hit(obj/projectile/P)
	return BULLET_ACT_HIT

/mob/living/bullet_act(obj/projectile/P, def_zone = BODY_ZONE_CHEST)
	var/armor = run_armor_check(def_zone, P.flag, "", "",P.armor_penetration, damage = P.damage)

	next_attack_msg.Cut()

	var/on_hit_state = P.on_hit(src, armor)
	var/nodmg = FALSE
	if(!P.nodamage && on_hit_state != BULLET_ACT_BLOCK)
		if(!apply_damage(P.damage, P.damage_type, def_zone, armor))
			nodmg = TRUE
			next_attack_msg += " <span class='warning'>Armor stops the damage.</span>"
		apply_effects(P.stun, P.knockdown, P.unconscious, P.irradiate, P.slur, P.stutter, P.eyeblur, P.drowsy, armor, P.stamina, P.jitter, P.paralyze, P.immobilize)
		if(!nodmg)
			if(P.dismemberment)
				check_projectile_dismemberment(P, def_zone,armor)
			if(P.woundclass)
				check_projectile_wounding(P, def_zone)

			if(P.poisontype)// New proc for poisoning that respects if armor stopped damage from the projectile, by blocking or through reduction. Only called if poison type is defined.
				if(!P.poisonamount)
					CRASH("Projectile attempted to add poison with undefined amount.")
				if(iscarbon(src))
					var/mob/living/carbon/M = src
					M.reagents.add_reagent(P.poisontype, P.poisonamount)
					if(P.poisonfeel)
						M.show_message(span_danger("You feel an intense [P.poisonfeel] sensation spreading swiftly from the area!"))

			if(P.embedchance && !check_projectile_embed(P, def_zone))
				P.handle_drop()

		else
			P.handle_drop()

	var/organ_hit_text = ""
	var/limb_hit = check_limb_hit(def_zone)//to get the correct message info.
	if(limb_hit)
		organ_hit_text = " in \the [parse_zone(limb_hit)]"
	if(P.hitsound && !nodmg)
		var/volume = P.vol_by_damage()
		playsound(loc, pick(P.hitsound), volume, TRUE, -1)
	visible_message(span_danger("[src] is hit by \a [P][organ_hit_text]![next_attack_msg.Join()]"), \
			span_danger("I'm hit by \a [P][organ_hit_text]![next_attack_msg.Join()]"), null, COMBAT_MESSAGE_RANGE)
	next_attack_msg.Cut()


	return on_hit_state ? BULLET_ACT_HIT : BULLET_ACT_BLOCK

/mob/living/proc/check_projectile_dismemberment(obj/projectile/P, def_zone)
	return 0

/mob/living/proc/check_projectile_wounding(obj/projectile/P, def_zone)
	return simple_woundcritroll(P.woundclass, P.damage, null, def_zone, crit_message = TRUE)

/mob/living/proc/check_projectile_embed(obj/projectile/P, def_zone)
	if(!prob(P.embedchance) || !P.dropped)
		return FALSE
	simple_add_embedded_object(P.dropped, crit_message = TRUE)
	return TRUE

/obj/item/proc/get_volume_by_throwforce_and_or_w_class()
	if(throwforce && w_class)
		return CLAMP((throwforce + w_class) * 5, 30, 100)// Add the item's throwforce to its weight class and multiply by 5, then clamp the value between 30 and 100
	else if(w_class)
		return CLAMP(w_class * 8, 20, 100) // Multiply the item's weight class by 8, then clamp the value between 20 and 100
	else
		return 0

/mob/living/hitby(atom/movable/AM, skipcatch, hitpush = TRUE, blocked = FALSE, datum/thrownthing/throwingdatum, d_type = "blunt")
	if(istype(AM, /obj/item))
		var/obj/item/I = AM
		var/dtype = BRUTE
		var/zone = ran_zone(BODY_ZONE_CHEST, 65)//Hits a random part of the body, geared towards the chest
		SEND_SIGNAL(I, COMSIG_MOVABLE_IMPACT_ZONE, src, zone)
		dtype = I.damtype
		if(!blocked)
			var/armor = run_armor_check(zone, d_type, "", "",I.armor_penetration, damage = I.throwforce)
			next_attack_msg.Cut()
			var/nodmg = FALSE
			if(!apply_damage(I.throwforce, dtype, zone, armor))
				nodmg = TRUE
				next_attack_msg += " <span class='warning'>Armor stops the damage.</span>"
			if(!nodmg)
				if(iscarbon(src))
					var/obj/item/bodypart/affecting = get_bodypart(zone)
					if(affecting)
						affecting.bodypart_attacked_by(I.thrown_bclass, I.throwforce, isliving(throwingdatum.thrower) ? throwingdatum.thrower : null, affecting.body_zone, crit_message = TRUE)
				else
					simple_woundcritroll(I.thrown_bclass, I.throwforce, null, zone, crit_message = TRUE)
					if(((throwingdatum ? throwingdatum.speed : I.throw_speed) >= EMBED_THROWSPEED_THRESHOLD) || I.embedding.embedded_ignore_throwspeed_threshold)
						if(can_embed(I) && prob(I.embedding.embed_chance) && HAS_TRAIT(src, TRAIT_SIMPLE_WOUNDS) && !HAS_TRAIT(src, TRAIT_PIERCEIMMUNE))
							simple_add_embedded_object(I, silent = FALSE, crit_message = TRUE)
			visible_message(span_danger("[src] is hit by [I]![next_attack_msg.Join()]"), \
							span_danger("I'm hit by [I]![next_attack_msg.Join()]"))
			next_attack_msg.Cut()
			if(I.thrownby)
				log_combat(I.thrownby, src, "threw and hit", I)
		else
			return 1
	else
		playsound(loc, 'sound/blank.ogg', 50, TRUE, -1) //Item sounds are handled in the item itself
	..()


/mob/living/mech_melee_attack(obj/mecha/M)
	if(M.occupant.used_intent.type == INTENT_HARM)
		if(HAS_TRAIT(M.occupant, TRAIT_PACIFISM))
			to_chat(M.occupant, span_warning("I don't want to harm other living beings!"))
			return
		M.do_attack_animation(src)
		if(M.damtype == "brute")
			step_away(src,M,15)
		switch(M.damtype)
			if(BRUTE)
				Unconscious(20)
				take_overall_damage(rand(M.force/2, M.force))
				playsound(src, 'sound/blank.ogg', 50, TRUE)
			if(BURN)
				take_overall_damage(0, rand(M.force/2, M.force))
				playsound(src, 'sound/blank.ogg', 50, TRUE)
			if(TOX)
				M.mech_toxin_damage(src)
			else
				return
		updatehealth()
		visible_message(span_danger("[M.name] hits [src]!"), \
						span_danger("[M.name] hits you!"), span_hear("I hear a sickening sound of flesh hitting flesh!"), COMBAT_MESSAGE_RANGE, M)
		to_chat(M, span_danger("I hit [src]!"))
		log_combat(M.occupant, src, "attacked", M, "(INTENT: [uppertext(M.occupant.used_intent)]) (DAMTYPE: [uppertext(M.damtype)])")
	else
		step_away(src,M)
		log_combat(M.occupant, src, "pushed", M)
		visible_message(span_warning("[M] pushes [src] out of the way."), \
						span_warning("[M] pushes you out of the way."), span_hear("I hear aggressive shuffling!"), 5, M)
		to_chat(M, span_danger("I push [src] out of the way."))

/mob/living/fire_act(added, maxstacks)
	if(added > 20)
		added = 20
	if(maxstacks > 20)
		maxstacks = 20
	if(!maxstacks)
		maxstacks = 1
	if(maxstacks)
		if(fire_stacks >= maxstacks)
			return
	if(added)
		adjust_fire_stacks(added)
	else
		adjust_fire_stacks(1)
	IgniteMob()

/mob/living/proc/grabbedby(mob/living/carbon/user, supress_message = FALSE, item_override)
	if(!user || !src || anchored || !isturf(user.loc))
		return FALSE

	if(!user.pulling || user.pulling == src)
		user.start_pulling(src, supress_message = supress_message, item_override = item_override)
		return
/*
	if(!(status_flags & CANPUSH) || HAS_TRAIT(src, TRAIT_PUSHIMMUNE))
		to_chat(user, span_warning("[src] can't be grabbed more aggressively!"))
		return FALSE

	if(user.grab_state >= GRAB_AGGRESSIVE && HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_warning("I don't want to risk hurting [src]!"))
		return FALSE
	grippedby(user)*/

//proc to upgrade a simple pull into a more aggressive grab.
/mob/living/proc/grippedby(mob/living/carbon/user, instant = FALSE)
	user.changeNext_move(CLICK_CD_MELEE * 2 - user.STASPD)
	var/skill_diff = 0
	var/combat_modifier = 1
	if(user.mind)
		skill_diff += (user.mind.get_skill_level(/datum/skill/combat/wrestling)) //NPCs don't use this
	if(mind)
		skill_diff -= (mind.get_skill_level(/datum/skill/combat/wrestling))

	if(user == src)
		instant = TRUE

	if(surrendering)
		combat_modifier = 2

	if(restrained())
		combat_modifier += 0.25

	if(!(mobility_flags & MOBILITY_STAND) && user.mobility_flags & MOBILITY_STAND)
		combat_modifier += 0.05

	if(user.cmode && !cmode)
		combat_modifier += 0.3
	else if(!user.cmode && cmode)
		combat_modifier -= 0.3

	var/probby =  clamp((((4 + (((user.STASTR - STASTR)/2) + skill_diff)) * 10 + rand(-5, 5)) * combat_modifier), 5, 95)

	if(!prob(probby) && !instant && !stat)
		visible_message(span_warning("[user] struggles with [src]!"),
						span_warning("[user] struggles to restrain me!"), span_hear("I hear aggressive shuffling!"), null, user)
		if(src.client?.prefs.showrolls)
			to_chat(user, span_warning("I struggle with [src]! [probby]%"))
		else
			to_chat(user, span_warning("I struggle with [src]!"))
		playsound(src.loc, 'sound/foley/struggle.ogg', 100, FALSE, -1)
		user.Immobilize(2 SECONDS)
		user.changeNext_move(2 SECONDS)
		src.Immobilize(1 SECONDS)
		src.changeNext_move(1 SECONDS)
		return

	if(!instant)
		var/sound_to_play = 'sound/foley/grab.ogg'
		playsound(src.loc, sound_to_play, 100, FALSE, -1)

	testing("eheh1")
	user.setGrabState(GRAB_AGGRESSIVE)
	if(user.active_hand_index == 1)
		if(user.r_grab)
			user.r_grab.grab_state = GRAB_AGGRESSIVE
	if(user.active_hand_index == 2)
		if(user.l_grab)
			user.l_grab.grab_state = GRAB_AGGRESSIVE

	user.update_grab_intents()

	var/add_log = ""
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		add_log = " (pacifist)"
	send_grabbed_message(user)
	if(user != src)
		stop_pulling()
		user.set_pull_offsets(src, user.grab_state)
	log_combat(user, src, "grabbed", addition="aggressive grab[add_log]")
	return 1

/mob/living/proc/update_grab_intents(mob/living/target)
	return

/mob/living/carbon/update_grab_intents()
	var/obj/item/grabbing/G = get_active_held_item()
	if(!istype(G))
		return
	if(ismob(G.grabbed))
		if(isitem(G.sublimb_grabbed))
			var/obj/item/I = G.sublimb_grabbed
			G.possible_item_intents = I.grabbedintents(src, G.sublimb_grabbed)
		else
			if(iscarbon(G.grabbed) && G.limb_grabbed)
				var/obj/item/I = G.limb_grabbed
				G.possible_item_intents = I.grabbedintents(src, G.sublimb_grabbed)
			else
				var/mob/M = G.grabbed
				G.possible_item_intents = M.grabbedintents(src, G.sublimb_grabbed)
	if(isobj(G.grabbed))
		var/obj/I = G.grabbed
		G.possible_item_intents = I.grabbedintents(src, G.sublimb_grabbed)
	if(isturf(G.grabbed))
		var/turf/T = G.grabbed
		G.possible_item_intents = T.grabbedintents(src)
	update_a_intents()

/turf/proc/grabbedintents(mob/living/user)
	//RTD up and down
	return list(/datum/intent/grab/move)

/obj/proc/grabbedintents(mob/living/user, precise)
	return list(/datum/intent/grab/move)

/obj/item/grabbedintents(mob/living/user, precise)
	return list(/datum/intent/grab/remove, /datum/intent/grab/twistitem)

/mob/proc/grabbedintents(mob/living/user, precise)
	return list(/datum/intent/grab/move)

/mob/living/proc/send_grabbed_message(mob/living/carbon/user)
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		visible_message(span_danger("[user] firmly grips [src]!"),
						span_danger("[user] firmly grips me!"), span_hear("I hear aggressive shuffling!"), null, user)
		to_chat(user, span_danger("I firmly grip [src]!"))
	else
		visible_message(span_danger("[user] tightens [user.p_their()] grip on [src]!"), \
						span_danger("[user] tightens [user.p_their()] grip on me!"), span_hear("I hear aggressive shuffling!"), null, user)
		to_chat(user, span_danger("I tighten my grip on [src]!"))

/mob/living/attack_slime(mob/living/simple_animal/slime/M)
	if(!SSticker.HasRoundStarted())
		to_chat(M, "You cannot attack people before the game has started.")
		return

	if(M.buckled)
		if(M in buckled_mobs)
			M.Feedstop()
		return // can't attack while eating!

	if(HAS_TRAIT(src, TRAIT_PACIFISM))
		to_chat(M, span_warning("I don't want to hurt anyone!"))
		return FALSE

	if (stat != DEAD)
		log_combat(M, src, "attacked")
		M.do_attack_animation(src)
		visible_message(span_danger("\The [M.name] glomps [src]!"), \
						span_danger("\The [M.name] glomps me!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), COMBAT_MESSAGE_RANGE, M)
		to_chat(M, span_danger("I glomp [src]!"))
		return TRUE

/mob/living/attack_animal(mob/living/simple_animal/M)
	if(M.swinging)
		return
	M.swinging = TRUE
	M.face_atom(src)
	if(M.melee_damage_upper == 0)
		visible_message(span_notice("\The [M] [pick(M.a_intent.attack_verb)] [src]."), \
						span_notice("\The [M] [pick(M.a_intent.attack_verb)] me!"), null, COMBAT_MESSAGE_RANGE)
		return FALSE
	if(HAS_TRAIT(M, TRAIT_PACIFISM))
		to_chat(M, span_warning("I don't want to hurt anyone!"))
		return FALSE

	M.do_attack_animation(src, visual_effect_icon = M.a_intent.animname)
	playsound(get_turf(M), pick(M.attack_sound), 100, FALSE)

	var/cached_intent = M.used_intent

	sleep(M.used_intent.swingdelay)
	M.swinging = FALSE
	if(M.a_intent != cached_intent)
		return FALSE
	if(QDELETED(src) || QDELETED(M))
		return FALSE
	if(!M.CanReach(src))
		return FALSE
	if(M.incapacitated())
		return FALSE

	if(checkmiss(M))
		return FALSE

	if(checkdefense(M.a_intent, M))
		return FALSE

	if(M.attack_sound)
		playsound(loc, M.a_intent.hitsound, 100, FALSE)

	log_combat(M, src, "attacked")

	return TRUE


/mob/living/attack_paw(mob/living/carbon/monkey/M)
	if(isturf(loc) && istype(loc.loc, /area/start))
//		to_chat(M, "No attacking people at spawn, you jackass.")
		return FALSE

	if (M.used_intent.type == INTENT_HARM)
		if(HAS_TRAIT(M, TRAIT_PACIFISM))
			to_chat(M, span_info("I don't want to hurt anyone!"))
			return FALSE

		if(M.is_muzzled() || M.is_mouth_covered(FALSE, TRUE))
			to_chat(M, span_warning("I can't bite with my mouth covered!"))
			return FALSE
		M.do_attack_animation(src, ATTACK_EFFECT_BITE)
		if (prob(75))
			log_combat(M, src, "attacked")
			playsound(loc, 'sound/blank.ogg', 50, TRUE, -1)
			visible_message(span_danger("[M.name] bites [src]!"), \
							span_danger("[M.name] bites you!"), span_hear("I hear a chomp!"), COMBAT_MESSAGE_RANGE, M)
			to_chat(M, span_danger("I bite [src]!"))
			return TRUE
		else
			visible_message(span_danger("[M.name]'s bite misses [src]!"), \
							span_danger("I avoid [M.name]'s bite!"), span_hear("I hear the sound of jaws snapping shut!"), COMBAT_MESSAGE_RANGE, M)
			to_chat(M, span_warning("My bite misses [src]!"))
	return FALSE

/mob/living/attack_larva(mob/living/carbon/alien/larva/L)
	switch(L.used_intent.type)
		if(INTENT_HELP)
			visible_message(span_notice("[L.name] rubs its head against [src]."), \
							span_notice("[L.name] rubs its head against you."), null, null, L)
			to_chat(L, span_notice("I rub my head against [src]."))
			return FALSE

		else
			if(HAS_TRAIT(L, TRAIT_PACIFISM))
				to_chat(L, span_warning("I don't want to hurt anyone!"))
				return

			L.do_attack_animation(src)
			if(prob(90))
				log_combat(L, src, "attacked")
				visible_message(span_danger("[L.name] bites [src]!"), \
								span_danger("[L.name] bites you!"), span_hear("I hear a chomp!"), COMBAT_MESSAGE_RANGE, L)
				to_chat(L, span_danger("I bite [src]!"))
				playsound(loc, 'sound/blank.ogg', 50, TRUE, -1)
				return TRUE
			else
				visible_message(span_danger("[L.name]'s bite misses [src]!"), \
								span_danger("I avoid [L.name]'s bite!"), span_hear("I hear the sound of jaws snapping shut!"), COMBAT_MESSAGE_RANGE, L)
				to_chat(L, span_warning("My bite misses [src]!"))
	return FALSE

/mob/living/attack_alien(mob/living/carbon/alien/humanoid/M)
	switch(M.used_intent.type)
		if (INTENT_HELP)
			visible_message(span_notice("[M] caresses [src] with its scythe-like arm."), \
							span_notice("[M] caresses you with its scythe-like arm."), null, null, M)
			to_chat(M, span_notice("I caress [src] with my scythe-like arm."))
			return FALSE
		if (INTENT_GRAB)
			grabbedby(M)
			return FALSE
		if(INTENT_HARM)
			if(HAS_TRAIT(M, TRAIT_PACIFISM))
				to_chat(M, span_warning("I don't want to hurt anyone!"))
				return FALSE
			M.do_attack_animation(src)
			return TRUE
		if(INTENT_DISARM)
			M.do_attack_animation(src, ATTACK_EFFECT_DISARM)
			return TRUE

/mob/living/attack_hulk(mob/living/carbon/human/user)
	..()
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_warning("I don't want to hurt [src]!"))
		return FALSE
	return TRUE

/mob/living/ex_act(severity, target, origin)
	if(origin && istype(origin, /datum/spacevine_mutation) && isvineimmune(src))
		return
	..()

/mob/living/attack_paw(mob/living/carbon/monkey/M)
	if(isturf(loc) && istype(loc.loc, /area/start))
//		to_chat(M, "No attacking people at spawn, you jackass.")
		return FALSE

	if (M.used_intent.type == INTENT_HARM)
		if(HAS_TRAIT(M, TRAIT_PACIFISM))
			to_chat(M, span_info("I don't want to hurt anyone!"))
			return FALSE

		if(M.is_muzzled() || M.is_mouth_covered(FALSE, TRUE))
			to_chat(M, span_warning("I can't bite with my mouth covered!"))
			return FALSE
		M.do_attack_animation(src, ATTACK_EFFECT_BITE)
		if (prob(75))
			log_combat(M, src, "attacked")
			playsound(loc, 'sound/blank.ogg', 50, TRUE, -1)
			visible_message(span_danger("[M.name] bites [src]!"), \
							span_danger("[M.name] bites you!"), span_hear("I hear a chomp!"), COMBAT_MESSAGE_RANGE, M)
			to_chat(M, span_danger("I bite [src]!"))
			return TRUE
		else
			visible_message(span_danger("[M.name]'s bite misses [src]!"), \
							span_danger("I avoid [M.name]'s bite!"), span_hear("I hear the sound of jaws snapping shut!"), COMBAT_MESSAGE_RANGE, M)
			to_chat(M, span_warning("My bite misses [src]!"))
	return FALSE

//Looking for irradiate()? It's been moved to radiation.dm under the rad_act() for mobs.

/mob/living/acid_act(acidpwr, acid_volume)
	take_bodypart_damage(acidpwr * min(1, acid_volume * 0.1))
	return 1

///As the name suggests, this should be called to apply electric shocks.
/mob/living/proc/electrocute_act(shock_damage, source, siemens_coeff = 1, flags = NONE)
	SEND_SIGNAL(src, COMSIG_LIVING_ELECTROCUTE_ACT, shock_damage, source, siemens_coeff, flags)
	shock_damage *= siemens_coeff
	if((flags & SHOCK_TESLA) && (flags_1 & TESLA_IGNORE_1))
		return FALSE
	if(HAS_TRAIT(src, TRAIT_SHOCKIMMUNE))
		return FALSE
	if(shock_damage < 1)
		return FALSE
	if(!(flags & SHOCK_ILLUSION))
		adjustFireLoss(shock_damage)
	else
		adjustStaminaLoss(shock_damage)
	visible_message(
		span_danger("[src] was shocked by \the [source]!"), \
		span_danger("I feel a powerful shock coursing through my body!"), \
		span_hear("I hear a heavy electrical crack.") \
	)
	playsound(get_turf(src), pick('sound/misc/elec (1).ogg', 'sound/misc/elec (2).ogg', 'sound/misc/elec (3).ogg'), 100, FALSE)
	return shock_damage

/mob/living/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_CONTENTS)
		return
	for(var/obj/O in contents)
		O.emp_act(severity)

///Logs, gibs and returns point values of whatever mob is unfortunate enough to get eaten.
/mob/living/singularity_act()
	investigate_log("([key_name(src)]) has been consumed by the singularity.", INVESTIGATE_SINGULO) //Oh that's where the clown ended up!
	gib()
	return 20

/mob/living/narsie_act()
	if(status_flags & GODMODE || QDELETED(src))
		return

	if(GLOB.cult_narsie && GLOB.cult_narsie.souls_needed[src])
		GLOB.cult_narsie.souls_needed -= src
		GLOB.cult_narsie.souls += 1
		if((GLOB.cult_narsie.souls == GLOB.cult_narsie.soul_goal) && (GLOB.cult_narsie.resolved == FALSE))
			GLOB.cult_narsie.resolved = TRUE
			sound_to_playing_players('sound/blank.ogg')
			addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(cult_ending_helper), 1), 120)
			addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(ending_helper)), 270)
	if(client)
		makeNewConstruct(/mob/living/simple_animal/hostile/construct/harvester, src, cultoverride = TRUE)
	else
		switch(rand(1, 6))
			if(1)
				new /mob/living/simple_animal/hostile/construct/armored/hostile(get_turf(src))
			if(2)
				new /mob/living/simple_animal/hostile/construct/wraith/hostile(get_turf(src))
			if(3 to 6)
				new /mob/living/simple_animal/hostile/construct/builder/hostile(get_turf(src))
	spawn_dust()
	gib()
	return TRUE

//called when the mob receives a bright flash
/mob/living/proc/flash_act(intensity = 1, override_blindness_check = 0, affect_silicon = 0, visual = 0, type = /atom/movable/screen/fullscreen/flash)
	if(HAS_TRAIT(src, TRAIT_NOFLASH))
		return FALSE
	if(get_eye_protection() < intensity && (override_blindness_check || !(HAS_TRAIT(src, TRAIT_BLIND))))
		overlay_fullscreen("flash", type)
		addtimer(CALLBACK(src, PROC_REF(clear_fullscreen), "flash", 25), 25)
		return TRUE
	return FALSE

//called when the mob receives a loud bang
/mob/living/proc/soundbang_act()
	return 0

//to damage the clothes worn by a mob
/mob/living/proc/damage_clothes(damage_amount, damage_type = BRUTE, damage_flag = 0, def_zone)
	return


/mob/living/do_attack_animation(atom/A, visual_effect_icon, obj/item/used_item, no_effect)
	if(!used_item)
		used_item = get_active_held_item()
	..()
	setMovetype(movement_type & ~FLOATING) // If we were without gravity, the bouncing animation got stopped, so we make sure we restart the bouncing after the next movement.
