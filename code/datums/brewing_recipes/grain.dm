/datum/brewing_recipe/beer
	name = "Wheat Beer"
	category = "Grain"
	reagent_to_brew = /datum/reagent/consumable/ethanol/beer
	needed_reagents = list(/datum/reagent/water = 198)
	needed_items = list(/obj/item/reagent_containers/food/snacks/grown/wheat = 6)
	brewed_amount = 6
	brew_time = 2 MINUTES
	sell_value = 30

/datum/brewing_recipe/beer/oat
	name = "Oat Ale"
	reagent_to_brew = /datum/reagent/consumable/ethanol/ale
	needed_items = list(/obj/item/reagent_containers/food/snacks/grown/oat = 6)

/datum/brewing_recipe/beer/rice
	name = "Rice Wine"
	reagent_to_brew = /datum/reagent/consumable/ethanol/ricewine
	needed_items = list(/obj/item/reagent_containers/food/snacks/grown/rice = 6)
