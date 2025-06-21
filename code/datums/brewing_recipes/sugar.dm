/datum/brewing_recipe/molasses
	name = "Molasses"
	category = "Other"
	reagent_to_brew = /datum/reagent/consumable/sugar/molasses
	needed_items = list(/obj/item/reagent_containers/food/snacks/sugar = 6)
	brewed_amount = 6
	brew_time = 3 MINUTES
	sell_value = 30

/datum/brewing_recipe/rum
	name = "Rum"
	category = "Liquor"
	reagent_to_brew = /datum/reagent/consumable/ethanol/rum
	pre_reqs = /datum/reagent/consumable/sugar/molasses
	brewed_amount = 4
	brew_time = 4 MINUTES
	sell_value = 90
	heat_required = 380
