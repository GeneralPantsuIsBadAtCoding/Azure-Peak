/datum/runeritual/other
	abstract_type = /datum/runeritual/other
	category = "Other"

/datum/runeritual/other/wall
	name = "lesser arcyne wall"
	tier = 1
	blacklisted = FALSE
	required_atoms = list(/obj/item/magic/elemental/mote = 2, /obj/item/magic/manacrystal = 1, /obj/item/magic/melded/t1 = 1)

/datum/runeritual/other/wall/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	return 1

/datum/runeritual/other/wall/t2
	name = "greater arcyne wall"
	tier = 2
	required_atoms = list(/obj/item/magic/elemental/mote = 4, /obj/item/magic/manacrystal = 2, /obj/item/magic/melded/t1 = 1)

/datum/runeritual/other/wall/t2/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	return 2

/datum/runeritual/other/wall/t3
	name = "arcyne fortress"
	tier = 3
	required_atoms = list(/obj/item/magic/artifact = 3, /obj/item/magic/manacrystal = 3, /obj/item/magic/melded/t3 = 1)

/datum/runeritual/teleport
	name = "planar convergence"
	tier = 3
	required_atoms = list(/obj/item/magic/artifact = 1, /obj/item/magic/leyline = 1, /obj/item/magic/melded/t2 = 1) //adjust this later

/datum/runeritual/teleport/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	return TRUE