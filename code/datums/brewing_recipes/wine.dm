/datum/brewing_recipe/jack_wine
	name = "Wine, Jacksberry"
	category = "Fruit"
	reagent_to_brew = /datum/reagent/consumable/ethanol/jackberrywine
	needed_reagents = list(/datum/reagent/water = 198)
	needed_crops = list(/obj/item/reagent_containers/food/snacks/grown/berries/rogue = 6)
	brewed_amount = 6
	brew_time = 5 MINUTES // Wine will have a standard brew time of 5 minutes
	sell_value = 50

	ages = TRUE
	age_times = list(
		/datum/reagent/consumable/ethanol/jackberrywine/aged = 10 MINUTES,
		/datum/reagent/consumable/ethanol/jackberrywine/delectable = 20 MINUTES
	)

/datum/brewing_recipe/plum_wine
	name = "Wine, Umeshu (Plum)"
	category = "Fruit"
	reagent_to_brew = /datum/reagent/consumable/ethanol/plum_wine
	needed_reagents = list(/datum/reagent/water = 198)
	needed_items = list(/obj/item/reagent_containers/food/snacks/grown/fruit/plum = 4, /obj/item/reagent_containers/food/snacks/sugar = 2)
	brewed_amount = 6
	brew_time = 5 MINUTES
	sell_value = 50
	age_times = list(
		/datum/reagent/consumable/ethanol/plum_wine/aged = 10 MINUTES,
		/datum/reagent/consumable/ethanol/plum_wine/delectable = 20 MINUTES
	)

/datum/brewing_recipe/tangerine_wine
	name = "Wine, Tangerine"
	category = "Fruit"
	reagent_to_brew = /datum/reagent/consumable/ethanol/tangerine
	needed_reagents = list(/datum/reagent/water = 198)
	needed_items = list(/obj/item/reagent_containers/food/snacks/grown/fruit/tangerine = 4, /obj/item/reagent_containers/food/snacks/sugar = 2)
	brewed_amount = 6
	brew_time = 5 MINUTES
	sell_value = 50
	age_times = list(
		/datum/reagent/consumable/ethanol/tangerine/aged = 10 MINUTES,
		/datum/reagent/consumable/ethanol/tangerine/delectable = 20 MINUTES
	)

/datum/brewing_recipe/raspberry_wine
	name = "Wine, Raspberry"
	category = "Fruit"
	reagent_to_brew = /datum/reagent/consumable/ethanol/raspberry
	needed_reagents = list(/datum/reagent/water = 198)
	needed_items = list(/obj/item/reagent_containers/food/snacks/grown/fruit/raspberry = 4, /obj/item/reagent_containers/food/snacks/sugar = 2)
	brewed_amount = 6
	brew_time = 5 MINUTES
	sell_value = 50
	age_times = list(
		/datum/reagent/consumable/ethanol/raspberry/aged = 10 MINUTES,
		/datum/reagent/consumable/ethanol/raspberry/delectable = 20 MINUTES
	)

/datum/brewing_recipe/blackberry_wine
	name = "Wine, Blackberry"
	category = "Fruit"
	reagent_to_brew = /datum/reagent/consumable/ethanol/blackberry
	needed_reagents = list(/datum/reagent/water = 198)
	needed_items = list(/obj/item/reagent_containers/food/snacks/grown/fruit/blackberry = 4, /obj/item/reagent_containers/food/snacks/sugar = 2)
	brewed_amount = 6
	brew_time = 5 MINUTES
	sell_value = 50
	age_times = list(
		/datum/reagent/consumable/ethanol/blackberry/aged = 10 MINUTES,
		/datum/reagent/consumable/ethanol/blackberry/delectable = 20 MINUTES
	)
