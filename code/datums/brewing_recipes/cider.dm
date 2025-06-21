/datum/brewing_recipe/cider
	name = "Cider, Apple"
	category = "Fruit"
	reagent_to_brew = /datum/reagent/consumable/ethanol/cider
	needed_reagents = list(/datum/reagent/water = 198)
	needed_crops = list(/obj/item/reagent_containers/food/snacks/grown/apple = 6)
	brewed_amount = 6
	brew_time = 5 MINUTES
	sell_value = 50

/datum/brewing_recipe/cider/pear
	name = "Cider, Pear"
	reagent_to_brew = /datum/reagent/consumable/ethanol/cider/pear
	needed_crops = list(/obj/item/reagent_containers/food/snacks/grown/fruit/pear = 6)

/datum/brewing_recipe/cider/strawberry
	name = "Cider, Strawberry"
	reagent_to_brew = /datum/reagent/consumable/ethanol/cider/strawberry
	needed_items = list(/obj/item/reagent_containers/food/snacks/grown/fruit/strawberry = 6)
