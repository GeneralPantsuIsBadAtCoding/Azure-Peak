// Unique class drip or something that might fit into another category
/datum/crafting_recipe/roguetown/leather/unique
	abstract_type = /datum/crafting_recipe/roguetown/leather/unique

/datum/crafting_recipe/roguetown/leather/unique/artipants
	name = "tinker trousers (1 cloth, 2 leather)"
	result = list(/obj/item/clothing/under/roguetown/trou/artipants)
	reqs = list(/obj/item/natural/cloth = 1,
	            /obj/item/natural/hide/cured = 2)
	tools = list(/obj/item/needle)
	craftdiff = 3
	sellprice = 11

/datum/crafting_recipe/roguetown/leather/unique/baggyleatherpants
	name = "pontifex's chaqchur (1 fibers, 1 cloth, 2 leather)"
	result = list(/obj/item/clothing/under/roguetown/trou/leather/pontifex)
	reqs = list(/obj/item/natural/cloth = 1,
	            /obj/item/natural/fibers = 1,
	            /obj/item/natural/hide/cured = 2)
	tools = list(/obj/item/needle)
	craftdiff = 5
	sellprice = 20
		
/datum/crafting_recipe/roguetown/leatherunique/gladsandals
	name = "gladiator sandals (1 fibers, 2 leather)"
	result = list(/obj/item/clothing/shoes/roguetown/gladiator)
	reqs = list(/obj/item/natural/hide/cured = 2,
	            /obj/item/natural/fibers = 1)
	tools = list(/obj/item/needle)
	craftdiff = 3
	sellprice = 12

/datum/crafting_recipe/roguetown/leather/unique/grenzelboots
	name = "grenzelhoftian boots (1 fibers, 1 leather, 1 fur, 1 tallow)"
	result = list(/obj/item/clothing/shoes/roguetown/grenzelhoft)
	reqs = list(/obj/item/natural/hide/cured = 1,
	            /obj/item/reagent_containers/food/snacks/tallow = 1,
				/obj/item/natural/fur = 1,
	            /obj/item/natural/fibers = 1)
	tools = list(/obj/item/needle)
	craftdiff = 6
	sellprice = 15
	
/datum/crafting_recipe/roguetown/leather/unique/otavanleatherpants
	name = "otavan leather trousers (1 fibers, 2 leather, 1 fur)"
	result = list(/obj/item/clothing/under/roguetown/heavy_leather_pants/otavan)
	reqs = list(/obj/item/reagent_containers/food/snacks/tallow = 1,
	            /obj/item/natural/fibers = 1,
	            /obj/item/natural/hide/cured = 2,
				/obj/item/natural/fur = 1)
	tools = list(/obj/item/needle)
	craftdiff = 6
	sellprice = 30

/datum/crafting_recipe/roguetown/leather/unique/otavanboots
	name = "otavan leather boots (1 fibers, 1 leather, 1 fur, 1 tallow)"
	result = list(/obj/item/clothing/shoes/roguetown/boots/otavan)
	reqs = list(/obj/item/natural/hide/cured = 1,
	            /obj/item/reagent_containers/food/snacks/tallow = 1,
				/obj/item/natural/fur = 1,
	            /obj/item/natural/fibers = 1)
	tools = list(/obj/item/needle)
	craftdiff = 6
	sellprice = 25

/datum/crafting_recipe/roguetown/leather/unique/buckleshoes
	name = "buckled shoes (2 fibers, 2 leather)"
	result = list(/obj/item/clothing/shoes/roguetown/simpleshoes/buckle)
	reqs = list(/obj/item/natural/hide/cured = 1,
	            /obj/item/natural/fibers = 2)
	tools = list(/obj/item/needle)
	craftdiff = 6
	sellprice = 25

/datum/crafting_recipe/roguetown/leather/unique/monkleather
	name = "pontifex's kaftan (1 cloth, 4 leather, 1 tallow)"
	result = list(/obj/item/clothing/suit/roguetown/armor/gambeson/heavy/pontifex)
	reqs = list(/obj/item/natural/hide/cured = 4,
	            /obj/item/natural/cloth = 1,
				/obj/item/reagent_containers/food/snacks/tallow = 1)
	tools = list(/obj/item/needle)
	craftdiff = 5
	sellprice = 23

/datum/crafting_recipe/roguetown/leather/unique/greatcoat
	name = "coat of the commander (1 cloth, 3 leather, 1 fur)"
	result = list(/obj/item/clothing/suit/roguetown/armor/brigandine/sheriff/coat)
	reqs = list(/obj/item/natural/hide/cured = 3,
				/obj/item/natural/fur = 1,
	            /obj/item/natural/cloth = 1)
	tools = list(/obj/item/needle)
	craftdiff = 5
	sellprice = 24

/datum/crafting_recipe/roguetown/leather/unique/furlinedjacket
	name = "artificer jacket (1 cloth, 2 leather, 1 fur)"
	result = list(/obj/item/clothing/suit/roguetown/armor/leather/jacket/artijacket)
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fur = 1,
	            /obj/item/natural/cloth = 1)
	tools = list(/obj/item/needle)
	craftdiff = 5
	sellprice = 21

/datum/crafting_recipe/roguetown/leather/unique/winterjacket
	name = "winter jacket (1 cloth, 2 leather, 2 fur)"
	result = list(/obj/item/clothing/suit/roguetown/armor/leather/vest/winterjacket)
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fur = 2,
	            /obj/item/natural/cloth = 1)
	tools = list(/obj/item/needle)
	craftdiff = 5
	sellprice = 24

/datum/crafting_recipe/roguetown/leather/unique/openrobes
	name = "shamanic coat (1 fibers, 1 cloth, 2 leather)"
	result = list(/obj/item/clothing/suit/roguetown/armor/leather/heavy/atgervi)
	reqs = list(/obj/item/natural/hide/cured = 2,
	            /obj/item/natural/fibers = 1,
	            /obj/item/natural/cloth = 1)
	tools = list(/obj/item/needle)
	craftdiff = 5
	sellprice = 20
