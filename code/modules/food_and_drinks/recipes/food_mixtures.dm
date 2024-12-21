/datum/crafting_recipe/food
	var/real_parts
	category = CAT_NONE

/datum/crafting_recipe/food/New()
	real_parts = parts.Copy()
	parts |= reqs

//////////////////////////////////////////FOOD MIXTURES////////////////////////////////////

/datum/chemical_reaction/hot_coco
	name = "Hot Coco"
	id = /datum/reagent/consumable/hot_coco
	results = list(/datum/reagent/consumable/hot_coco = 5)
	required_reagents = list(/datum/reagent/water = 5, /datum/reagent/consumable/coco = 1)

/datum/chemical_reaction/coffee
	name = "Coffee"
	id = /datum/reagent/consumable/coffee
	results = list(/datum/reagent/consumable/coffee = 5)
	required_reagents = list(/datum/reagent/toxin/coffeepowder = 1, /datum/reagent/water = 5)

/datum/chemical_reaction/tea
	name = "Tea"
	id = /datum/reagent/consumable/tea
	results = list(/datum/reagent/consumable/tea = 5)
	required_reagents = list(/datum/reagent/toxin/teapowder = 1, /datum/reagent/water = 5)

/datum/chemical_reaction/soysauce
	name = "Soy Sauce"
	id = /datum/reagent/consumable/soysauce
	results = list(/datum/reagent/consumable/soysauce = 5)
	required_reagents = list(/datum/reagent/consumable/soymilk = 4, /datum/reagent/toxin/acid = 1)

/datum/chemical_reaction/corn_syrup
	name = /datum/reagent/consumable/corn_syrup
	id = /datum/reagent/consumable/corn_syrup
	results = list(/datum/reagent/consumable/corn_syrup = 5)
	required_reagents = list(/datum/reagent/consumable/corn_starch = 1, /datum/reagent/toxin/acid = 1)
	required_temp = 374

/datum/chemical_reaction/caramel
	name = "Caramel"
	id = /datum/reagent/consumable/caramel
	results = list(/datum/reagent/consumable/caramel = 1)
	required_reagents = list(/datum/reagent/consumable/sugar = 1)
	required_temp = 413.15
	mob_react = FALSE

/datum/chemical_reaction/caramel_burned
	name = "Caramel burned"
	id = "caramel_burned"
	results = list(/datum/reagent/carbon = 1)
	required_reagents = list(/datum/reagent/consumable/caramel = 1)
	required_temp = 483.15
	mob_react = FALSE

/datum/chemical_reaction/hot_ramen
	name = "Hot Ramen"
	id = /datum/reagent/consumable/hot_ramen
	results = list(/datum/reagent/consumable/hot_ramen = 3)
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/consumable/dry_ramen = 3)

/datum/chemical_reaction/hell_ramen
	name = "Hell Ramen"
	id = /datum/reagent/consumable/hell_ramen
	results = list(/datum/reagent/consumable/hell_ramen = 6)
	required_reagents = list(/datum/reagent/consumable/capsaicin = 1, /datum/reagent/consumable/hot_ramen = 6)

/datum/chemical_reaction/bbqsauce
	name = "BBQ Sauce"
	id = /datum/reagent/consumable/bbqsauce
	results = list(/datum/reagent/consumable/bbqsauce = 5)
	required_reagents = list(/datum/reagent/ash = 1, /datum/reagent/consumable/tomatojuice = 1, /datum/reagent/medicine/salglu_solution = 3, /datum/reagent/consumable/blackpepper = 1)
