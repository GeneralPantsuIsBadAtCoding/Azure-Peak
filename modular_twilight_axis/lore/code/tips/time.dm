GLOBAL_VAR_INIT(lore_overriden, FALSE)

/mob/living/do_time_change()
	if(!GLOB.lore_overriden)
		GLOB.time_change_tips = world.file2list("modular_twilight_axis/lore/strings/timechangetips.txt")
		GLOB.lore_overriden = TRUE
	. = ..()

