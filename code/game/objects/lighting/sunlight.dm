/obj/effect/sunlight
	var/brightness = 10
	light_power = 1
	light_color = "#2f1313"
	layer = BELOW_MOB_LAYER
	icon = 'icons/effects/effects.dmi'
	icon_state = "electricity2"
#ifndef TESTING
	name = ""
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
#else
	name = "sunlight"
#endif
	var/mode = "day"
	light_depth = 0
	light_height = 0

/obj/effect/sunlight/Initialize()
	light_color = pick("#dbbfbf", "#ddd7bd", "#add1b0", "#a4c0ca", "#ae9dc6", "#d09fbf")
	..()
	if(istype(loc, /turf/open/transparent/openspace))
		var/turf/target = get_step_multiz(src, DOWN)
		if(!isclosedturf(target))
			new type(target)
	mode = GLOB.tod
	GLOB.sunlights += src
#ifndef FASTLOAD
	update()
#endif
/obj/effect/sunlight/Destroy()
	STOP_PROCESSING(SStodchange,src)
	GLOB.sunlights -= src
	. = ..()

/obj/effect/sunlight/Initialize(mapload)
	. = ..()
#ifdef TESTING
	icon_state = "electricity2"
#else
	icon_state = null
#endif

/obj/effect/sunlight/proc/update()
	if(mode == GLOB.tod)
		return
	mode = GLOB.tod
	switch(mode)
		if("night")
			light_color = pick("#100a18", "#0c0412", "#0f0012")
		if("dusk")
			light_color = pick("#c26f56", "#c05271", "#b84933")
		if("dawn")
			light_color = pick("#394579", "#49385d", "#3a1537")
		if("day")
			light_color = pick("#dbbfbf", "#ddd7bd", "#add1b0", "#a4c0ca", "#ae9dc6", "#d09fbf")
	set_light(brightness, brightness, light_power, l_color = light_color)

/obj/effect/sunlight/ultra
	brightness = 30

//genstuff
/obj/effect/landmark/mapGenerator/sunlights
	mapGeneratorType = /datum/mapGenerator/sunlights
	endTurfX = 255
	endTurfY = 255
	startTurfX = 1
	startTurfY = 1

/obj/effect/landmark/mapGenerator/sunlights/Initialize(mapload)
	GLOB.sky_z |= z
	return ..()

/datum/mapGenerator/sunlights
	modules = list(/datum/mapGeneratorModule/sunlights)

/datum/mapGeneratorModule/sunlights
	spawnableAtoms = list(/obj/effect/sunlight = 100)
	spawnableTurfs = list()
	clusterMax = 10
	clusterMin = 10
	checkdensity = FALSE
	allowed_areas = list(/area/rogue/outdoors)
