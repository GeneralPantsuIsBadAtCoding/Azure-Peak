/datum/crafting_recipe/roguetown/leather/reinforcement
	abstract_type = /datum/crafting_recipe/roguetown/leather/reinforcement
	category = "Reinforcement"

/datum/crafting_recipe/roguetown/leather/reinforcement/crafteast
	name = "decorated dobo robe"
	result = list(/obj/item/clothing/suit/roguetown/armor/basiceast/crafteast)
	reqs = list(
		/obj/item/natural/hide/cured = 2,
		/obj/item/reagent_containers/food/snacks/tallow = 1,
		/obj/item/natural/fibers = 2,
		/obj/item/clothing/suit/roguetown/armor/basiceast = 1,
		)
	tools = list(/obj/item/needle)
	craftdiff = 3
