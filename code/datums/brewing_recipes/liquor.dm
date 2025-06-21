/datum/brewing_recipe/liquor
	name = "Gin"
	category = "Liquor"
	reagent_to_brew = /datum/reagent/consumable/ethanol/gin
	pre_reqs = /datum/reagent/consumable/ethanol/voddena
	needed_items = list(/obj/item/reagent_containers/food/snacks/grown/berries/rogue = 2)
	brewed_amount = 4
	brew_time = 5 MINUTES
	sell_value = 100
	heat_required = 370

/datum/brewing_recipe/liquor/ricespirit
	name = "Rice Spirit"
	reagent_to_brew = /datum/reagent/consumable/ethanol/ricespirit
	pre_reqs = /datum/reagent/consumable/ethanol/ricewine
	needed_items = null
	brewed_amount = 4
	sell_value = 90
