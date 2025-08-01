/datum/crafting_recipe/roguetown/leather/container
	abstract_type = /datum/crafting_recipe/roguetown/leather/container
	category = "Container"

/datum/crafting_recipe/roguetown/leather/container/pouch
	name = "pouch x2 (1 fibers, 1 leather)"
	result = list(/obj/item/storage/belt/rogue/pouch,
				/obj/item/storage/belt/rogue/pouch)
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 1)
	sellprice = 6
	craftdiff = 0

/datum/crafting_recipe/roguetown/leather/container/magepouch
	name = "summoner's pouch"
	reqs = list(
		/obj/item/natural/hide/cured = 2,
		/obj/item/natural/fibers = 1,
	)
	result = /obj/item/storage/magebag
	craftdiff = 1

/datum/crafting_recipe/roguetown/leather/container/meatbag
	name = "game satchel"
	reqs = list(
		/obj/item/natural/hide/cured = 2,
		/obj/item/natural/cloth = 1,
	)
	result = /obj/item/storage/meatbag
	craftdiff = 1

/datum/crafting_recipe/roguetown/leather/container/satchel
	name = "satchel (1 fibers, 2 leather)"
	result = /obj/item/storage/backpack/rogue/satchel
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 1)

/datum/crafting_recipe/roguetown/leather/container/satchelshort
	name = "short satchel (1 fibers, 2 leather)"
	result = /obj/item/storage/backpack/rogue/satchel/short
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 1)
	sellprice = 15

/datum/crafting_recipe/roguetown/leather/container/backpack
	name = "backpack (1 fibers, 3 leather)"
	result = /obj/item/storage/backpack/rogue/backpack
	reqs = list(/obj/item/natural/hide/cured = 3,
				/obj/item/natural/fibers = 1)

/datum/crafting_recipe/roguetown/leather/container/waterskin
	name = "waterskin (2 fibers, 1 leather)"
	result = /obj/item/reagent_containers/glass/bottle/waterskin
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 2)

/datum/crafting_recipe/roguetown/leather/container/quiver
	name = "quiver (2 fibers, 2 leather)"
	result = /obj/item/quiver
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 2)

/datum/crafting_recipe/roguetown/leather/container/javelinbag
	name = "javelin bag (1 tallow, 1 rope)"
	result = /obj/item/quiver/javelin
	reqs = list(/obj/item/reagent_containers/food/snacks/tallow = 1,
				/obj/item/rope = 1)

/datum/crafting_recipe/roguetown/leather/container/gwstrap
	name = "greatweapon strap (2 leather, 1 rope)"
	result = /obj/item/gwstrap
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/rope = 1)

/datum/crafting_recipe/roguetown/leather/container/twstrap
	name = "bandolier (2 leather, 1 rope)"
	result = /obj/item/twstrap
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/rope = 1)

/datum/crafting_recipe/roguetown/leather/container/belt
	name = "leather belt (2 fibers, 2 leather)"
	result = /obj/item/storage/belt/rogue/leather
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 2)

/datum/crafting_recipe/roguetown/leather/container/belt/black
	name = "black leather belt (2 fibers, 2 leather)"
	result = /obj/item/storage/belt/rogue/leather/black
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 2)

/datum/crafting_recipe/roguetown/leather/container/belt/knifebelt
	name = "tossblade belt (2 fibers, 2 leather)"
	result = /obj/item/storage/belt/rogue/leather/knifebelt
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 2)

/datum/crafting_recipe/roguetown/leather/container/belt/surgicalbag
	name = "surgeon's bag (2 leather, 1 fiber)"
	result = list(/obj/item/storage/belt/rogue/surgery_bag/empty)
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/leather/container/scabbard/sword
	name = "sword scabbard (2 leather, 3 fiber, 1 small log, 1 rope)"
	result = list(/obj/item/rogueweapon/scabbard/sword)
	reqs = list(
		/obj/item/natural/hide/cured = 2,
		/obj/item/natural/fibers = 3,
		/obj/item/grown/log/tree/small = 1,
		/obj/item/rope = 1
	)
	craftdiff = 2

/datum/crafting_recipe/roguetown/leather/container/scabbard/dagger
	name = "dagger sheath (2 leather, 2 stick)"
	result = list(/obj/item/rogueweapon/scabbard/sheath)
	reqs = list(
		/obj/item/natural/hide/cured = 2,
		/obj/item/grown/log/tree/stick = 2,
	)
	craftdiff = 2
