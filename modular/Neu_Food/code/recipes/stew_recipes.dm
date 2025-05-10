#define STEW_COOKING_TIME 60 SECONDS // Default time to cook in seconds

/datum/stew_recipe
	var/list/obj/inputs = null // The valid inputs for the recipe
	var/datum/reagent/output = null // The reagent to be used as output for the recipe
	var/cooktime = STEW_COOKING_TIME // The time to cook the recipe

// DO NOT SORT the list unless you know what you're doing (refactor it) - I ordered specific recipe before generic one for a reason!!

/datum/stew_recipe/porridge
	inputs = list(/obj/item/reagent_containers/food/snacks/grown/wheat)
	output = /datum/reagent/consumable/soup/porridge
	cooktime = STEW_COOKING_TIME / 2

/datum/stew_recipe/oatmeal
	inputs = list(/obj/item/reagent_containers/food/snacks/grown/oat)
	output = /datum/reagent/consumable/soup/porridge/oatmeal
	cooktime = STEW_COOKING_TIME / 2

/datum/stew_recipe/congee
	inputs = list(/obj/item/reagent_containers/food/snacks/grown/rice)
	output = /datum/reagent/consumable/soup/porridge/congee
	cooktime = STEW_COOKING_TIME / 2 

/datum/stew_recipe/potato
	inputs = list(/obj/item/reagent_containers/food/snacks/rogue/veg/potato_sliced)
	output = /datum/reagent/consumable/soup/veggie/potato

/datum/stew_recipe/onion
	inputs = list(/obj/item/reagent_containers/food/snacks/rogue/veg/onion_sliced)
	output = /datum/reagent/consumable/soup/veggie/onion

/datum/stew_recipe/cabbage
	inputs = list(/obj/item/reagent_containers/food/snacks/rogue/veg/cabbage_sliced)
	output = /datum/reagent/consumable/soup/veggie/cabbage

/datum/stew_recipe/fish
	inputs = list(/obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish)
	output = /datum/reagent/consumable/soup/stew/fish

/datum/stew_recipe/rabbit
	inputs = list(/obj/item/reagent_containers/food/snacks/rogue/meat/mince/rabbit)
	output = /datum/reagent/consumable/soup/stew/rabbit

/datum/stew_recipe/spider
	inputs = list(/obj/item/reagent_containers/food/snacks/rogue/meat/spider)
	output = /datum/reagent/consumable/soup/stew/yucky

/datum/stew_recipe/chicken
	inputs = list(/obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet, /obj/item/reagent_containers/food/snacks/rogue/meat/mince/poultry)
	output = /datum/reagent/consumable/soup/stew/chicken

/datum/stew_recipe/bisque
	inputs = list(/obj/item/reagent_containers/food/snacks/rogue/meat/crab, /obj/item/reagent_containers/food/snacks/fish/lobster)
	output = /datum/reagent/consumable/soup/stew/bisque
	
// Don't alphabetically sort this list this is meant to be reached last. (You are free to change when you find a better way to do a fallback recipe)
/datum/stew_recipe/meat
	inputs = list(/obj/item/reagent_containers/food/snacks/rogue/meat)
	output = /datum/reagent/consumable/soup/stew/meat

// Yet another order issue - specific berries must go before generic. Sigh.
/datum/stew_recipe/berry_poisoned
	inputs = list(/obj/item/reagent_containers/food/snacks/grown/berries/rogue/poison)
	output = /datum/reagent/consumable/soup/stew/berry_poisoned

/datum/stew_recipe/berry
	inputs = list(/obj/item/reagent_containers/food/snacks/grown/berries/rogue)
	output = /datum/reagent/consumable/soup/stew/berry

// DRINKS
/datum/stew_recipe/rose_tea
	inputs = list(/obj/item/reagent_containers/food/snacks/grown/rogue/rosa_petals_dried)
	output = /datum/reagent/water/rosewater
	cooktime = STEW_COOKING_TIME / 4 // Ultra fast

/datum/stew_recipe/coffee
	inputs = list(/obj/item/reagent_containers/food/snacks/grown/coffeebeansroasted)
	output = /datum/reagent/consumable/caffeine/coffee
	cooktime = STEW_COOKING_TIME / 4

#undef STEW_COOKING_TIME
