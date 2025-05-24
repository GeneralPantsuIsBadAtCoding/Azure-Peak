/datum/crafting_recipe/roguetown/leather
	abstract_type = /datum/crafting_recipe/roguetown/leather
	tools = list(/obj/item/needle)
	structurecraft = /obj/machinery/tanningrack
	skillcraft = /datum/skill/craft/tanning
	subtype_reqs = TRUE		//Makes it so fur-subtypes work. Basically if anything is just 'obj/item/natural/fur' - it'll take any fur. If it specifies 'natural/fur/direbear' - it will still require direbear.

/datum/crafting_recipe/roguetown/leather/bedroll
	name = "bedroll (2 leather, 1 rope)"
	result = /obj/item/bedroll
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/rope = 1)
	tools = list(/obj/item/needle)
	verbage_simple = "construct"
	verbage = "constructs"
	craftdiff = 2

/datum/crafting_recipe/roguetown/leather/corset
	name = "corset (1 fibers, 1 leather)"
	result = /obj/item/clothing/suit/roguetown/armor/corset
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 1)
	tools = list(/obj/item/needle)
	sellprice = 15
	craftdiff = 2

/datum/crafting_recipe/roguetown/leather/gloves
	name = "leather gloves (1 leather)"
	result = list(/obj/item/clothing/gloves/roguetown/leather,
	/obj/item/clothing/gloves/roguetown/leather)
	reqs = list(/obj/item/natural/hide/cured = 1)
	sellprice = 10

/datum/crafting_recipe/roguetown/leather/heavygloves
	name = "heavy leather gloves (1 fur)"
	result = /obj/item/clothing/gloves/roguetown/angle
	reqs = list(/obj/item/natural/fur = 1)
	sellprice = 20

/datum/crafting_recipe/roguetown/leather/fingerless_leather_gloves
	name = "fingerless leather gloves (1 fibers, 1 leather, 1 tallow)"
	result = /obj/item/clothing/gloves/roguetown/fingerless_leather
	reqs = list(
		/obj/item/natural/hide/cured = 1,
		/obj/item/reagent_containers/food/snacks/tallow = 1,
		/obj/item/natural/fibers = 1,
		)
	sellprice = 20

/datum/crafting_recipe/roguetown/leather/bandana
	name = "leather bandana (1 leather)"
	result = /obj/item/clothing/head/roguetown/helmet/bandana
	reqs = list(/obj/item/natural/hide/cured = 1)
	sellprice = 27
	craftdiff = 0

/datum/crafting_recipe/roguetown/leather/tricorn
	name = "leather tricorn (1 leather)"
	result = /obj/item/clothing/head/roguetown/helmet/tricorn
	reqs = list(/obj/item/natural/hide/cured = 1)
	sellprice = 27

/datum/crafting_recipe/roguetown/leather/hood
	name = "leather hood (1 leather)"
	result = /obj/item/clothing/head/roguetown/roguehood
	reqs = list(/obj/item/natural/hide/cured = 1)
	sellprice = 26

/datum/crafting_recipe/roguetown/leather/vest
	name = "leather vest (2 leather)"
	result = /obj/item/clothing/suit/roguetown/armor/leather/vest
	reqs = list(/obj/item/natural/hide/cured = 2)

/datum/crafting_recipe/roguetown/leather/bikini
	name = "leather corslet (2 leather)"
	result = /obj/item/clothing/suit/roguetown/armor/leather/bikini
	reqs = list(/obj/item/natural/hide/cured = 2)
	sellprice = 26

/datum/crafting_recipe/roguetown/leather/hidebikini
	name = "hide corslet (2 leather, 1 tallow)"
	result = /obj/item/clothing/suit/roguetown/armor/leather/hide/bikini
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fur = 1)
	sellprice = 26

/datum/crafting_recipe/roguetown/leather/cloak
	name = "rain cloak (2 leather)"
	result = /obj/item/clothing/cloak/raincloak/brown
	reqs = list(/obj/item/natural/hide/cured = 2)

/datum/crafting_recipe/roguetown/leather/apron/blacksmith
	name = "leather apron (1 fibers, 2 leather)"
	result = /obj/item/clothing/cloak/apron/blacksmith
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 1)

/datum/crafting_recipe/roguetown/leather/cloakfur
	name = "fur cloak (2 leather, 1 fur)"
	result = /obj/item/clothing/cloak/raincloak/furcloak/crafted
	reqs = list(/obj/item/natural/hide/cured = 2,/obj/item/natural/fur = 1)

/obj/item/clothing/cloak/raincloak/furcloak/crafted
	sellprice = 55

/datum/crafting_recipe/roguetown/leather/papakha
	name = "papakha hat (2 fibers, 1 fur)"
	result = /obj/item/clothing/head/roguetown/papakha/crafted
	reqs = list(/obj/item/natural/fur = 1, /obj/item/natural/fibers = 2)

/obj/item/clothing/head/roguetown/papakha/crafted
	sellprice = 10

/datum/crafting_recipe/roguetown/leather/saddle
	name = "saddle (2 leather)"
	result = /obj/item/natural/saddle
	reqs = list(/obj/item/natural/hide/cured = 2)

/datum/crafting_recipe/roguetown/leather/whip
	name = "leather whip (2 leather, 1 stone)"
	result = /obj/item/rogueweapon/whip
	reqs = list(/obj/item/natural/hide/cured = 2,/obj/item/natural/stone = 1)
	sellprice = 39

/datum/crafting_recipe/roguetown/leather/drum
	name = "Drum (2 leather, 1 log)"
	result = /obj/item/rogue/instrument/drum
	reqs = list(/obj/item/natural/hide/cured = 1,/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/roguetown/leather/vest/sailor
	name = "leather sea jacket (2 leather)"
	result = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor
	reqs = list(/obj/item/natural/hide/cured = 2)

/datum/crafting_recipe/roguetown/leather/darkcloak
	name = "dark cloak (4 leather, 2 fur)"
	result = list(/obj/item/clothing/cloak/darkcloak)
	reqs = list(/obj/item/natural/fur = 2,
				/obj/item/natural/hide/cured = 4)
	craftdiff = 5
	sellprice = 80

/datum/crafting_recipe/roguetown/leather/bearcloak
	name = "direbear cloak (4 leather, 1 direbear fur)"
	result = list(/obj/item/clothing/cloak/darkcloak/bear)
	reqs = list(/obj/item/natural/fur/direbear = 1,
				/obj/item/natural/hide/cured = 4)
	craftdiff = 3
	sellprice = 80

/datum/crafting_recipe/roguetown/leather/lightbearcloak
	name = "light direbear cloak (4 leather, 1 direbear fur)"
	result = list(/obj/item/clothing/cloak/darkcloak/bear/light)
	reqs = list(/obj/item/natural/fur/direbear = 1,
				/obj/item/natural/hide/cured = 4)
	craftdiff = 3
	sellprice = 80

/datum/crafting_recipe/roguetown/leather/leathertights
	name = "leather tights (2 leather)"
	result = list(/obj/item/clothing/under/roguetown/trou/leathertights)
	reqs = list(/obj/item/natural/hide/cured = 2)
	tools = list(/obj/item/needle)
	craftdiff = 3
	sellprice = 10

