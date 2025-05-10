// If there's ever more than 10 drinks maybe split this file OK?
/obj/item/reagent_containers/food/snacks/grown/rogue/rosa_petals
	name = "fresh rosa petals"
	desc = "Crushed rosa petals. Edible."
	icon = 'modular/Neu_Food/icons/drinks.dmi'
	icon_state = "rosamatter"
	tastes = list("mild sweetness" = 1)
	bitesize = 1
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	rotprocess = null
	w_class = WEIGHT_CLASS_TINY

/obj/item/reagent_containers/food/snacks/grown/rogue/rosa_petals_dried
	name = "dried rosa petals"
	desc = "Dried rosa petals, can be used to brew tea."
	icon = 'modular/Neu_Food/icons/drinks.dmi'
	icon_state = "rosamatter_dried"
	tastes = list("mild sweetness" = 1)
	bitesize = 1
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	rotprocess = null
	w_class = WEIGHT_CLASS_TINY

/obj/item/reagent_containers/food/snacks/grown/coffeebeans
	name = "coffee beans"
	desc = "Freshly extracted coffee beans, with a hard texture. Should be roasted first."
	icon = 'modular/Neu_Food/icons/drinks.dmi'
	icon_state = "coffeebeans"
	tastes = list("unpleasant bitterness" = 1)
	bitesize = 1
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	cooked_type = /obj/item/reagent_containers/food/snacks/grown/coffeebeansroasted
	rotprocess = null
	w_class = WEIGHT_CLASS_TINY

/obj/item/reagent_containers/food/snacks/grown/coffeebeansroasted
	name = "roasted coffee beans"
	desc = "Roasted coffee beans, with a much deeper flavor. Can be used to brew coffee. The variant grown in Azuria can be brewed without being ground."
	icon = 'modular/Neu_Food/icons/drinks.dmi'
	icon_state = "coffeebeans_roasted"
	tastes = list("rich caramel smoothness" = 1)
	bitesize = 1
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	rotprocess = null
	w_class = WEIGHT_CLASS_TINY
