/datum/brewing_recipe/brandy
	name = "Brandy, Apple"
	category = "Liquor"
	reagent_to_brew = /datum/reagent/consumable/ethanol/brandy
	pre_reqs = /datum/reagent/consumable/ethanol/cider
	brewed_amount = 6
	brew_time = 4 MINUTES
	sell_value = 90
	heat_required = 360

/datum/brewing_recipe/brandy/pear
	name = "Brandy, Pear"
	pre_reqs = /datum/reagent/consumable/ethanol/cider/pear
	reagent_to_brew = /datum/reagent/consumable/ethanol/brandy/pear

/datum/brewing_recipe/brandy/strawberry
	name = "Brandy, Strawberry"
	pre_reqs = /datum/reagent/consumable/ethanol/cider/strawberry
	reagent_to_brew = /datum/reagent/consumable/ethanol/brandy/strawberry

/datum/brewing_recipe/brandy/tangerine
	name = "Brandy, Tangerine"
	pre_reqs = /datum/reagent/consumable/ethanol/tangerine
	reagent_to_brew = /datum/reagent/consumable/ethanol/brandy/tangerine

/datum/brewing_recipe/brandy/plum
	name = "Brandy, Plum"
	pre_reqs = /datum/reagent/consumable/ethanol/plum_wine
	reagent_to_brew = /datum/reagent/consumable/ethanol/brandy/plum
