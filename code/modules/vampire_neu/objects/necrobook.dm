#define SUN_STEAL_COST 5000
#define DEATH_KNIGHT_COST 2500

/obj/structure/vampire/necromanticbook // Used to summon undead to attack town/defend manor.
	name = "Tome of Souls"
	icon_state = "tome"
	var/list/useoptions = list("Create Death Knight", "Steal the Sun")
	var/sunstolen = FALSE

/obj/structure/vampire/necromanticbook/attack_hand(mob/living/carbon/human/user)
	if(!user.clan)
		return

	if(user.maxbloodpool < 4000)
		to_chat(user, span_warning("I have yet to regain this aspect of my power."))
		return TRUE

	switch(input(user, "What to do?", "VAMPYRE") as null|anything in useoptions)
		if("Create Death Knight")
			if(alert(user, "Create a Death Knight? Cost:[DEATH_KNIGHT_COST]", src, "MAKE IT SO", "I RESCIND") != "MAKE IT SO")
				return
			if(length(SSmapping.retainer.death_knights) >= 3)
				to_chat(user, span_warning("I cannot summon any more death knights."))
				return
			if(!user.has_bloodpool_cost(DEATH_KNIGHT_COST))
				to_chat(user, span_warning("I do not have enough vitae, I need [DEATH_KNIGHT_COST] vitae for a Death Knight."))
				return
			if(!do_after(user, 10 SECONDS, src))
				return
			if(!user.has_bloodpool_cost(DEATH_KNIGHT_COST))
				to_chat(user, span_warning("I do not have enough vitae, I need [DEATH_KNIGHT_COST] vitae for a Death Knight."))
				return

			user.adjust_bloodpool(DEATH_KNIGHT_COST)
			user.playsound_local(get_turf(src), 'sound/misc/vcraft.ogg', 100, FALSE, pressure_affected = FALSE)
			to_chat(user, span_notice("I have summoned a knight from the underworld. I need only wait for them to materialize."))
			var/list/candidates = pollGhostCandidates("Do you want to play as a Necromancer's skeleton?", ROLE_DEATH_KNIGHT, null, null, 10 SECONDS, POLL_IGNORE_DEATHKNIGHT)
			if(!LAZYLEN(candidates))
				to_chat(user, span_warning("The depths are hollow."))
				return FALSE

			var/mob/C = pick(candidates)
			if(!C || !istype(C, /mob/dead))
				return FALSE

			if (istype(C, /mob/dead/new_player))
				var/mob/dead/new_player/N = C
				N.close_spawn_windows()

			var/mob/living/carbon/human/species/skeleton/no_equipment/target = new /mob/living/carbon/human/species/skeleton/no_equipment(get_turf(src))
			target.key = C.key
			SSjob.EquipRank(target, "Death Knight", TRUE)
			target.visible_message(span_warning("[target]'s eyes light up with an eerie glow!"))
			addtimer(CALLBACK(target, TYPE_PROC_REF(/mob/living/carbon/human, choose_name_popup), "DEATH KNIGHT"), 3 SECONDS)
			addtimer(CALLBACK(target, TYPE_PROC_REF(/mob/living/carbon/human, choose_pronouns_and_body)), 7 SECONDS)

		if("Steal the Sun")
			if(!can_steal_sun(user))
				return
			if(alert(user, "Force Azuria into Night? Cost:[SUN_STEAL_COST]", src, "MAKE IT SO", "I RESCIND") != "MAKE IT SO")
				return
			if(!do_after(user, 10 SECONDS, src))
				return
			if(!can_steal_sun(user))
				return

			user.adjust_bloodpool(SUN_STEAL_COST)

			sunstolen = TRUE
			sunsteal()

/proc/sunsteal()
	GLOB.todoverride = "night"
	settod()
	priority_announce("The Sun is torn from the sky!", "Terrible Omen", 'sound/misc/astratascream.ogg')
	addomen(OMEN_SUNSTEAL)
	SSParticleWeather.run_weather(/datum/particle_weather/fog/blood, TRUE)
	for(var/mob/living/carbon/human/astrater as anything in GLOB.human_list)
		if(!istype(astrater.patron, /datum/patron/divine/astrata))
			continue
		to_chat(astrater, span_userdanger("You feel the pain of [astrater.patron]!"))
		astrater.emote("painscream", intentional = FALSE)

	for(var/turf/open/water/W in world)
		W.water_reagent = /datum/reagent/blood
		W.water_color = "#C80000"
		W.mapped = FALSE
		W.update_icon()
		CHECK_TICK

	for(var/obj/machinery/light/light in GLOB.machines)
		if(prob(40))
			light.extinguish()
		else
			light.flicker(rand(2, 5))
		CHECK_TICK

	for(var/obj/item/flashlight/flare/torch/torch in GLOB.weather_act_upon_list)
		torch.turn_off()
		CHECK_TICK

	for(var/obj/structure/soil/soil in GLOB.soil_list)
		soil.plant_dead = TRUE
		soil.produce_ready = FALSE
		soil.update_icon()
		CHECK_TICK

	for(var/mob/living/carbon/human in GLOB.human_list)
		if(human.clan)
			continue

		human.stress_freakout()

	var/list/spawn_locs = GLOB.hauntstart.Copy()
	if(LAZYLEN(GLOB.hauntstart))
		for(var/i in 1 to 20)
			var/obj/effect/landmark/events/haunts/_T = pick_n_take(spawn_locs)
			if(_T)
				_T = get_turf(_T)
				if(isfloorturf(_T))
					new /mob/living/carbon/human/species/skeleton/npc(_T)

/obj/structure/vampire/necromanticbook/proc/can_steal_sun(mob/living/carbon/human/user)
	if(sunstolen)
		to_chat(user, span_warning("The Sun is already stolen."))
		return
	if(GLOB.tod == "night")
		to_chat(user, span_warning("The Moon is watching. I must wait for Her to return."))
		return
	if(!user.adjust_bloodpool(SUN_STEAL_COST))
		to_chat(user, span_warning("I do not have enough vitae, I need [SUN_STEAL_COST] vitae to steal the Sun."))
		return

	return TRUE

#undef SUN_STEAL_COST
#undef DEATH_KNIGHT_COST
