/datum/brewing_recipe/spidermead
	name = "Spider Honey Mead"
	category = "Other"
	reagent_to_brew = /datum/reagent/consumable/ethanol/mead/spider
	needed_reagents = list(/datum/reagent/water = 198)
	needed_items = list(/obj/item/reagent_containers/food/snacks/rogue/honey/spider = 6)
	brewed_amount = 6
	brew_time = 3 MINUTES
	sell_value = 75

/datum/brewing_recipe/mead
	name = "Mead"
	category = "Other"
	reagent_to_brew = /datum/reagent/consumable/ethanol/mead
	needed_reagents = list(/datum/reagent/water = 198)
	needed_items = list(/obj/item/reagent_containers/food/snacks/rogue/honey = 6)
	brewed_amount = 6
	brew_time = 3 MINUTES
	sell_value = 50
