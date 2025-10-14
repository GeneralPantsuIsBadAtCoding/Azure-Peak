/datum/crafting_recipe/roguetown/fleshcrafting
	abstract_type = /datum/crafting_recipe/roguetown/fleshcrafting
	req_table = FALSE
	verbage_simple = "assembles"
	skillcraft = /datum/skill/labor/butchering
	subtype_reqs = TRUE
	structurecraft = /obj/structure/roguemachine/chimeric_heart_beast

/datum/crafting_recipe/roguetown/fleshcrafting/decoy
	name = "flesh decoy (2x fresh meat)"
	category = "Flesh"
	result = list(/obj/item/flesh_decoy)
	reqs = list(/obj/item/reagent_containers/food/snacks/rogue/meat = 2)
	structurecraft = null
	craftdiff = 2
	required_tech_node = "FLESH_DECOYS"
	tech_unlocked = FALSE

/datum/crafting_recipe/roguetown/fleshcrafting/decoy_alt
	name = "flesh decoy (2x viscera)"
	category = "Flesh"
	result = list(/obj/item/flesh_decoy)
	reqs = list(/obj/item/alch/viscera = 2)
	structurecraft = null
	craftdiff = 2
	required_tech_node = "VISCERA_DECOYS"
	tech_unlocked = FALSE

/datum/crafting_recipe/roguetown/fleshcrafting/flesh_node
	name = "flesh node (1x rotten meat)"
	category = "Flesh"
	result = list(/obj/item/flesh_node)
	reqs = list(/obj/item/reagent_containers/food/snacks/rogue/meat_rotten = 1)
	craftdiff = 1
