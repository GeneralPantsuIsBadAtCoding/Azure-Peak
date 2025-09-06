/datum/crafting_recipe/roguetown/survival/twilight_arquebus_bayonet
	name = "bayonet"
	category = "Ranged"
	result = /obj/item/gun/ballistic/twilight_firearm/arquebus/bayonet
	reqs = list(/obj/item/rogueweapon/huntingknife, /obj/item/gun/ballistic/twilight_firearm/arquebus = 1)
	verbage_simple = "fix"
	verbage = "fixes"
	craftdiff = 0

/datum/crafting_recipe/roguetown/survival/twilight_arquebus_bayonet/dagger_steel
	reqs = list(/obj/item/rogueweapon/huntingknife/idagger/steel, /obj/item/gun/ballistic/twilight_firearm/arquebus = 1)

/datum/crafting_recipe/roguetown/survival/twilight_arquebus_bayonet/dagger
	reqs = list(/obj/item/rogueweapon/huntingknife/idagger, /obj/item/gun/ballistic/twilight_firearm/arquebus = 1)

/datum/crafting_recipe/roguetown/leather/container/belt/twilight_holsterbelt
    name = "holster belt (2 leather, 2 fibers; APPRENTICE)"
    result = /obj/item/storage/belt/rogue/leather/twilight_holsterbelt
    reqs = list(/obj/item/natural/hide/cured = 2,
                /obj/item/natural/fibers = 2)
    craftdiff = 2

/datum/crafting_recipe/roguetown/leather/container/twilight_ammoholder
	name = "ammo bag (cured leather, 1 fibers)"
	result = /obj/item/quiver/twilight_bullet
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 1)
	sellprice = 6
	craftdiff = 0

/datum/crafting_recipe/roguetown/leather/twilight_powderflask
	name = "empty powderflask (cured leather, 2 fibers)"
	result = /obj/item/twilight_powderflask_empty
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 2)
	sellprice = 15
	craftdiff = 0

/datum/crafting_recipe/roguetown/engineering/twilight_powderflask/basic
	name = "engineer black gunpowder (4 coaldust, 1 fire essentia, powderflask)"
	result = /obj/item/twilight_powderflask
	reqs = list(/obj/item/twilight_powderflask_empty = 1,
				/obj/item/alch/coaldust = 4,
				/obj/item/alch/firedust = 1)
	verbage_simple = "work on"
	verbage = "finishes"
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 2

/datum/crafting_recipe/roguetown/engineering/twilight_powderflask/fyre
	name = "engineer fyrepowder (4 fire essentia, 1 silverdust, powderflask)"
	result = /obj/item/twilight_powderflask/fyre
	reqs = list(/obj/item/twilight_powderflask_empty = 1,
				/obj/item/alch/firedust = 4,
				/obj/item/alch/silverdust = 1)
	verbage_simple = "work on"
	verbage = "finishes"
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 3

/datum/crafting_recipe/roguetown/engineering/twilight_powderflask/thunder
	name = "engineer thunderpowder (6 coal dust, 4 air essentia, powderflask)"
	result = /obj/item/twilight_powderflask/thunder
	reqs = list(/obj/item/twilight_powderflask_empty = 1,
				/obj/item/alch/coaldust = 6,
				/obj/item/alch/airdust = 4)
	verbage_simple = "work on"
	verbage = "finishes"
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 3

/datum/crafting_recipe/roguetown/engineering/twilight_powderflask/terror
	name = "engineer terrorpowder (6 coal dust, 15 oz elixir of mana, powderflask)"
	result = /obj/item/twilight_powderflask/terror
	reqs = list(/obj/item/twilight_powderflask_empty = 1,
				/obj/item/alch/coaldust = 6,
				/datum/reagent/medicine/manapot = 15)
	verbage_simple = "work on"
	verbage = "finishes"
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 2

/datum/crafting_recipe/roguetown/engineering/twilight_powderflask/corrosive
	name = "engineer corrosive gunpowder (4 fire essentia, 3 earth essentia, powderflask)"
	result = /obj/item/twilight_powderflask/corrosive
	reqs = list(/obj/item/twilight_powderflask_empty = 1,
				/obj/item/alch/firedust = 4,
				/obj/item/alch/earthdust = 3)
	verbage_simple = "work on"
	verbage = "finishes"
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 3

/datum/crafting_recipe/roguetown/engineering/twilight_powderflask/arcyne
	name = "engineer arcyne gunpowder (4 fire essentia, 2 pure essentia, 30 oz elixir of mana, powderflask)"
	result = /obj/item/twilight_powderflask/arcyne
	reqs = list(/obj/item/twilight_powderflask_empty = 1,
				/obj/item/alch/firedust = 4,
				/obj/item/alch/magicdust = 2,
				/datum/reagent/medicine/manapot = 30)
	verbage_simple = "work on"
	verbage = "finishes"
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/twilight_powderflask
	name = "mix black gunpowder (4 coaldust, 1 fire essentia, powderflask)"
	result = /obj/item/twilight_powderflask
	reqs = list(/obj/item/twilight_powderflask_empty = 1,
				/obj/item/alch/coaldust = 4,
				/obj/item/alch/firedust = 1)
	verbage_simple = "work on"
	verbage = "finishes"
	category = "Table"
	skillcraft = /datum/skill/craft/alchemy
	craftdiff = 2

/datum/crafting_recipe/roguetown/alchemy/twilight_powderflask/fyre
	name = "mix fyrepowder (4 fire essentia, 1 silverdust, powderflask)"
	result = /obj/item/twilight_powderflask/fyre
	reqs = list(/obj/item/twilight_powderflask_empty = 1,
				/obj/item/alch/firedust = 4,
				/obj/item/alch/silverdust = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/twilight_powderflask/thunder
	name = "mix thunderpowder (6 coal dust, 4 air essentia, powderflask)"
	result = /obj/item/twilight_powderflask/thunder
	reqs = list(/obj/item/twilight_powderflask_empty = 1,
				/obj/item/alch/coaldust = 6,
				/obj/item/alch/airdust = 4)
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/twilight_powderflask/terror
	name = "mix terrorpowder (6 coal dust, 15 oz elixir of mana, powderflask)"
	result = /obj/item/twilight_powderflask/terror
	reqs = list(/obj/item/twilight_powderflask_empty = 1,
				/obj/item/alch/coaldust = 6,
				/datum/reagent/medicine/manapot = 15)
	craftdiff = 2

/datum/crafting_recipe/roguetown/alchemy/twilight_powderflask/corrosive
	name = "mix corrosive gunpowder (4 fire essentia, 3 earth essentia, powderflask)"
	result = /obj/item/twilight_powderflask/corrosive
	reqs = list(/obj/item/twilight_powderflask_empty = 1,
				/obj/item/alch/firedust = 4,
				/obj/item/alch/earthdust = 3)
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/twilight_powderflask/arcyne
	name = "mix arcyne gunpowder (4 fire essentia, 2 pure essentia, 30 oz elixir of mana, powderflask)"
	result = /obj/item/twilight_powderflask/arcyne
	reqs = list(/obj/item/twilight_powderflask_empty = 1,
				/obj/item/alch/firedust = 4,
				/obj/item/alch/magicdust = 2,
				/datum/reagent/medicine/manapot = 30)
	craftdiff = 3
