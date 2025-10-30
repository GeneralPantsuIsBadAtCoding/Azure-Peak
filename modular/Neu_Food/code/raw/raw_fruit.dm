/obj/item/reagent_containers/food/snacks/rogue/fruit/apple_sliced
	name = "apple slice"
	icon = 'modular/Neu_Food/icons/raw/raw_fruit.dmi'
	icon_state = "apple_sliced"
	desc = "A neatly sliced bit of apple. Nicer to eat. Refined, even."
	faretype = FARE_FINE
	tastes = list("airy apple" = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)

/obj/item/reagent_containers/food/snacks/rogue/fruit/pumpkin_sliced
	name = "pumpkin slice"
	icon = 'modular/Neu_Food/icons/raw/raw_fruit.dmi'
	icon_state = "pumpkin_sliced"
	desc = "A neatly sliced bit of pumpkin. Typically cooked first."
	faretype = FARE_POOR
	tastes = list("raw pumpkin" = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	rotprocess = SHELFLIFE_LONG
