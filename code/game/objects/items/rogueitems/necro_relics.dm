// One-use crystal that spawns a Greater Undead, should delete after use.
/obj/item/necro_relics/necro_crystal
	name = "dark crystal"
	desc = "It feels cold in your hands. You shouldn't be holding this."
	icon = 'icons/roguetown/items/gems.dmi'
	icon_state = "necro_crystal"
	hitsound = 'sound/blank.ogg'
	dropshrink = 0.6
	var/last_use_time = 0
	var/use_cooldown = 300 // 30 seconds to prevent spamming it for multiple free goons
	grid_height = 32
	grid_width = 32

/obj/item/necro_relics/necro_crystal/attack_self(mob/living/user)
	..()
	if(!user) 
		return FALSE
	if(world.time - src.last_use_time < src.use_cooldown)
		to_chat(user, span_warning("The crystal thrums under your touch, but remains inert."))
		return FALSE

	// Ask the Necromancer for a task for the skeleton BEFORE the timer
	var/tasks = list("TOIL","FIGHT","GUARD","SEEK")
	var/tasks_choice = input(user, "WHAT IS THY BIDDING?", "IN HER NAME") as anything in tasks
	if(!tasks_choice)
		to_chat(user, span_warning("You must assign a task for your skeleton!"))
		return FALSE

	src.last_use_time = world.time

	if(!do_after(user, 60, src))
		to_chat(user, span_warning("You lose your concentration."))
		return FALSE
	if(!HAS_TRAIT(user, TRAIT_CABAL))
		to_chat(user, span_warning("The crystal rejects you! It shatters within your grasp!"))
		user.flash_fullscreen("redflash1")
		new /obj/item/natural/glass_shard(get_turf(src))
		playsound(src, "glassbreak", 70, TRUE)
		qdel(src) 
		return FALSE

	var/turf/T = get_step(user, user.dir)
	if(!isopenturf(T))
		to_chat(user, span_warning("The targeted location is blocked. My summon fails to come forth."))
		return FALSE

	var/necro_name = user.real_name ? user.real_name : user.name
	var/list/candidates = pollGhostCandidates("The veil splits! A hand reaches forth! Serve [necro_name] in undeath as a Greater Skeleton? YOU WILL [tasks_choice]", ROLE_NECRO_SKELETON, null, null, 10 SECONDS, POLL_IGNORE_NECROMANCER_SKELETON)
	if(!LAZYLEN(candidates))
		to_chat(user, span_warning("The depths are hollow."))
		return FALSE

	var/mob/C = pick(candidates)
	if(!C || !istype(C, /mob/dead))
		return FALSE

	if (istype(C, /mob/dead/new_player))
		var/mob/dead/new_player/N = C
		N.close_spawn_windows()

	var/mob/living/carbon/human/species/skeleton/no_equipment/target = new /mob/living/carbon/human/species/skeleton/no_equipment(T)
	target.key = C.key
	SSjob.EquipRank(target, "Greater Skeleton", TRUE)
	target.visible_message(span_warning("[target]'s eyes light up with an eerie glow!"))

	target.mind.AddSpell(new /obj/effect/proc_holder/spell/self/suicidebomb/lesser)
	addtimer(CALLBACK(target, TYPE_PROC_REF(/mob/living/carbon/human, choose_name_popup), "GREATER SKELETON"), 3 SECONDS)
	addtimer(CALLBACK(target, TYPE_PROC_REF(/mob/living/carbon/human, choose_pronouns_and_body)), 7 SECONDS)

	to_chat(user, span_notice("The crystal dissipates into dust."))
	user.flash_fullscreen("redflash1")
	new /obj/item/natural/glass_shard(get_turf(src))
	playsound(src, "shatter", 70, TRUE)
	qdel(src) 

	return TRUE

/obj/item/necro_relics/necro_crystal/Initialize()
	..()
	set_light(2, 2, 1, l_color = "#551c1c")

/mob/living/carbon/human/proc/choose_pronouns_and_body()
	var/p_input = input(src, "Choose your character's pronouns", "Pronouns") as anything in GLOB.pronouns_list
	if(p_input)
		src.pronouns = p_input
	if(alert(src, "Do you wish to change your frame?", "Body Type", "Yes", "No") == "Yes")
		src.gender = (src.gender == MALE) ? FEMALE : MALE
	src.regenerate_icons()
