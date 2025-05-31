// One-use crystal that spawns a Greater Undead, should delete after use.
/obj/item/necro_relics/necro_crystal
    name = "dark crystal"
    desc = "It feels cold in your hands. You shouldn't be holding this."
    icon = 'icons/roguetown/items/gems.dmi'
    icon_state = "sapphire"
    hitsound = 'sound/blank.ogg'
    dropshrink = 0.6
    var/last_use_time = 0
    var/use_cooldown = 300 // 30 seconds to prevent spamming it for multiple free goons
    grid_height = 32
    grid_width = 32



/obj/item/necro_relics/necro_crystal/attack_self(mob/living/user)
	. = ..()
	if(!user) return FALSE
	if(world.time - src.last_use_time < src.use_cooldown)
		to_chat(user, span_warning("The crystal thrums under your touch, but remains inert."))
		return FALSE
	src.last_use_time = world.time
	if(!do_after(user, 60, src))
		to_chat(user, span_warning("You lose your concentration."))
		return FALSE
	if(!HAS_TRAIT(user, TRAIT_CABAL))
		to_chat(user, span_warning("The crystal rejects you! It shatters within your grasp!"))
		user.flash_fullscreen("redflash1")
		new /obj/item/natural/glass/shard(get_turf(src))
		playsound(src, "glassbreak", 70, TRUE)
		qdel(src) 
		return FALSE
	var/turf/T = get_step(user, user.dir)
	if(isopenturf(T))
		var/mob/living/carbon/human/target = new /mob/living/carbon/human/species/skeleton/no_equipment(T)
		var/list/candidates = pollCandidatesForMob("Do you want to play as a Necromancer's skeleton?", ROLE_NECRO_SKELETON, null, null, 100, target, POLL_IGNORE_NECROMANCER_SKELETON)
		if(LAZYLEN(candidates))
			var/mob/C = pick(candidates)
			if(istype(C,/mob/dead/new_player))
				var/mob/dead/new_player/N = C
				N.close_spawn_windows()
			target.key = C.key
			target.visible_message(span_warning("[target]'s eyes light up with an eerie glow!"))
			target.mind.AddSpell(new /obj/effect/proc_holder/spell/self/suicidebomb/lesser)
			target.equipOutfit(/datum/outfit/job/roguetown/greater_skeleton)
			to_chat(user, span_notice("The crystal dissipates into dust."))
			user.flash_fullscreen("redflash1")
			new /obj/item/natural/glass/shard(get_turf(src))
			playsound(src, "shatter", 70, TRUE)
			qdel(src) 
		else
			target.visible_message(span_warning("[target]'s form crumbles into dust."))
			qdel(target)
		return TRUE
	to_chat(user, span_warning("The targeted location is blocked. My summon fails to come forth."))
	return FALSE

/obj/item/necro_relics/necro_crystal/Initialize()
	. = ..()
	set_light(2, 2, 1, l_color = "#551c1c")
