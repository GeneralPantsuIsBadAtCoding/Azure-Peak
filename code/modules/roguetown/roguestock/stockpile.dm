/datum/roguestock/stockpile/wood
	name = "Wood"
	desc = "Wooden logs cut short for transport."
	item_type = /obj/item/grown/log/tree/small
	held_items = list(2, 2)
	payout_price = 3
	withdraw_price = 5
	transport_fee = 3
	export_price = 5
	importexport_amt = 10
	passive_generation = 5

/datum/roguestock/stockpile/coal
	name = "Coal"
	desc = "Chunks of coal used for fuel and alloying."
	item_type = /obj/item/rogueore/coal
	held_items = list(5, 0)
	payout_price = 4
	withdraw_price = 6
	transport_fee = 4
	export_price = 6
	importexport_amt = 10
	passive_generation = 2

/datum/roguestock/stockpile/iron
	name = "Raw Iron"
	desc = "Chunks of iron used for smithing."
	item_type = /obj/item/rogueore/iron
	held_items = list(6, 0)
	payout_price = 5
	withdraw_price = 8
	transport_fee = 6
	export_price = 8
	importexport_amt = 10
	passive_generation = 2

/datum/roguestock/stockpile/copper
	name = "Raw Copper"
	desc = "Chunks of copper used for smithing and alloying."
	item_type = /obj/item/rogueore/copper
	held_items = list(6, 0)
	payout_price = 3
	withdraw_price = 5
	transport_fee = 3
	export_price = 5
	importexport_amt = 10
	passive_generation = 2

/datum/roguestock/stockpile/tin
	name = "Raw Tin"
	desc = "Chunks of tin used for smithing and alloying."
	item_type = /obj/item/rogueore/tin
	held_items = list(6, 0)
	payout_price = 4
	withdraw_price = 5
	transport_fee = 4
	export_price = 5
	importexport_amt = 10
	passive_generation = 2

/datum/roguestock/stockpile/gold
	name = "Raw Gold"
	desc = "Chunks of unrefined gold."
	item_type = /obj/item/rogueore/gold
	held_items = list(0, 0)
	payout_price = 50
	withdraw_price = 75
	transport_fee = 10
	export_price = 75
	importexport_amt = 10

/datum/roguestock/stockpile/silver
	name = "Raw Silver"
	desc = "Chunks of unrefined silver."
	item_type = /obj/item/rogueore/silver
	held_items = list(0, 0)
	payout_price = 75
	withdraw_price = 100
	transport_fee = 10
	export_price = 100
	importexport_amt = 10

/datum/roguestock/stockpile/cloth
	name = "Cloth"
	desc = "Lengths of cloth for sewing and tailoring."
	item_type = /obj/item/natural/cloth
	held_items = list(0, 2)
	payout_price = 3
	withdraw_price = 5
	transport_fee = 2
	export_price = 5
	importexport_amt = 10
	passive_generation = 2

/datum/roguestock/stockpile/fibers
	name = "Fibers"
	desc = "Strands used to make cloth and other items."
	item_type = /obj/item/natural/fibers
	held_items = list(0, 2)
	payout_price = 1
	withdraw_price = 3
	transport_fee = 1
	export_price = 3
	importexport_amt = 10
	passive_generation = 4

/datum/roguestock/stockpile/hide
	name = "Hide"
	desc = "Stripped hide from animals."
	item_type = /obj/item/natural/hide
	held_items = list(0, 0)
	payout_price = 5
	withdraw_price = 15
	transport_fee = 2
	export_price = 8
	importexport_amt = 5
	passive_generation = 2

/datum/roguestock/stockpile/fur
	name = "Fur"
	desc = "Hide with a long winter coat from animals."
	item_type = /obj/item/natural/fur
	held_items = list(0, 0)
	payout_price = 10
	withdraw_price = 20
	transport_fee = 4
	export_price = 15
	importexport_amt = 5
	passive_generation = 1

/datum/roguestock/stockpile/salt
	name = "Salt"
	desc = "Rock salt useful for curing and cooking."
	item_type = /obj/item/reagent_containers/powder/salt
	held_items = list(2,4)
	payout_price = 4
	withdraw_price = 6
	export_price = 8
	importexport_amt = 5
	passive_generation = 3

/datum/roguestock/stockpile/grain
	name = "Grain"
	desc = "Spelt grain."
	item_type = /obj/item/reagent_containers/food/snacks/grown/wheat
	held_items = list(0, 4)
	payout_price = 2
	withdraw_price = 3
	transport_fee = 1
	export_price = 3
	importexport_amt = 10
	passive_generation = 3

/datum/roguestock/stockpile/oat
	name = "Oats"
	desc = "A cereal grain."
	item_type = /obj/item/reagent_containers/food/snacks/grown/oat
	held_items = list(0, 4)
	payout_price = 2
	withdraw_price = 3
	transport_fee = 1
	export_price = 3
	importexport_amt = 10
	passive_generation = 3

/datum/roguestock/stockpile/apple
	name = "Apple"
	desc = "Harvested produce."
	item_type = /obj/item/reagent_containers/food/snacks/grown/apple
	held_items = list(0, 0)
	payout_price = 3
	withdraw_price = 5
	transport_fee = 1
	export_price = 5
	importexport_amt = 5
	passive_generation = 3

/datum/roguestock/stockpile/meat
	name = "Meat"
	desc = "Edible flesh harvested from animals."
	item_type = /obj/item/reagent_containers/food/snacks/rogue/meat/steak
	held_items = list(0, 0)
	payout_price = 5
	withdraw_price = 8
	transport_fee = 2
	export_price = 8
	importexport_amt = 5
	passive_generation = 2

/datum/roguestock/stockpile/fishmince
	name = "Fish Mince"
	desc = "Descaled and ground fish meat."
	item_type = /obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish
	held_items = list(0, 0)
	payout_price = 2
	withdraw_price = 4
	transport_fee = 1
	export_price = 3
	importexport_amt = 10
	passive_generation = 2

/datum/roguestock/stockpile/poultry
	name = "Bird Meat"
	desc = "Edible flesh harvested from birds."
	item_type = /obj/item/reagent_containers/food/snacks/rogue/meat/poultry
	held_items = list(0, 0)
	payout_price = 5
	withdraw_price = 8
	transport_fee = 2
	export_price = 8
	importexport_amt = 5
	passive_generation = 1

/datum/roguestock/stockpile/egg
	name = "Egg"
	desc = "Egg laid by a hen."
	item_type = /obj/item/reagent_containers/food/snacks/egg
	held_items = list(0, 0)
	payout_price = 3
	withdraw_price = 5
	transport_fee = 2
	export_price = 5
	importexport_amt = 5
	passive_generation = 2

/datum/roguestock/stockpile/fat
	name = "Fat"
	desc = "Greasy flesh from an animal."
	item_type = /obj/item/reagent_containers/food/snacks/fat
	held_items = list(0, 0)
	payout_price = 3
	withdraw_price = 5
	transport_fee = 1
	export_price = 5
	importexport_amt = 5
	passive_generation = 2

/datum/roguestock/stockpile/tallow
	name = "Tallow"
	desc = "Shelf-stabilized fatty tissue."
	item_type = /obj/item/reagent_containers/food/snacks/tallow
	held_items = list(0, 0)
	payout_price = 1
	withdraw_price = 2
	transport_fee = 1
	export_price = 2
	importexport_amt = 5
	passive_generation = 2

/datum/roguestock/stockpile/butter
	name = "Butter"
	desc = "The product of milk and salt."
	item_type = /obj/item/reagent_containers/food/snacks/butter
	held_items = list(0, 0)
	payout_price = 9
	withdraw_price = 13
	transport_fee = 3
	export_price = 13
	importexport_amt = 5
	passive_generation = 1

/datum/roguestock/stockpile/cheese
	name = "Cheese"
	desc = "The product of milk and salt."
	item_type = /obj/item/reagent_containers/food/snacks/rogue/cheese
	held_items = list(0, 0)
	payout_price = 3
	withdraw_price = 5
	transport_fee = 3
	export_price = 5
	importexport_amt = 5
	passive_generation = 1

/datum/roguestock/stockpile/jacksberry
	name = "Jacksberries"
	desc = "Sweet berries, prime for winemaking."
	item_type = /obj/item/reagent_containers/food/snacks/grown/berries/rogue
	held_items = list(0, 0)
	payout_price = 2
	withdraw_price = 3
	transport_fee = 1
	export_price = 3
	importexport_amt = 10
	passive_generation = 2

/datum/roguestock/stockpile/onion
	name = "Onion"
	desc = "A bulb vegetable."
	item_type = /obj/item/reagent_containers/food/snacks/grown/onion/rogue
	held_items = list(0, 0)
	payout_price = 2
	withdraw_price = 3
	transport_fee = 1
	export_price = 3
	importexport_amt = 10
	passive_generation = 2

/datum/roguestock/stockpile/cabbage
	name = "Cabbage"
	desc = "A leafy vegetable."
	item_type = /obj/item/reagent_containers/food/snacks/grown/cabbage/rogue
	held_items = list(0, 0)
	payout_price = 2
	withdraw_price = 3
	transport_fee = 1
	export_price = 3
	importexport_amt = 10
	passive_generation = 2

/datum/roguestock/stockpile/potato
	name = "Potato"
	desc = "An interesting tuber."
	item_type = /obj/item/reagent_containers/food/snacks/grown/potato/rogue
	held_items = list(0, 0)
	payout_price = 2
	withdraw_price = 3
	transport_fee = 1
	export_price = 3
	importexport_amt = 10
	passive_generation = 2
