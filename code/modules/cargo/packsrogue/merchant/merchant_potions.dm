// Merchant Potions. Merchant potions are meant to be relatively cost ineffective and set a CEILING for potion prices
// Normal potion brewer can and should undercut these prices. However this gives merchants more things to sell to fulfill their role as "adventurer shop"
// And hopefully generate demands for potions from other brewer who can offer it cheaper while improving access
// Yes, they are meant to have access to the high tier stat buff potion but not the second tier health or mana potions or any of the poison.
/datum/supply_pack/rogue/potions
	group = "Potions"
	crate_name = "merchant guild's crate"
	crate_type = /obj/structure/closet/crate/chest/merchant

//Only two since that's 4 uses total; two sips each. You only need one sip for cure.
/datum/supply_pack/rogue/potions/rotcure
	name = "Rot Cure Potion"
	cost = 300
	contains = list(
					/obj/item/reagent_containers/glass/bottle/alchemical/rogue/rotcure,
					/obj/item/reagent_containers/glass/bottle/alchemical/rogue/rotcure,
				)

/datum/supply_pack/rogue/potions/healthpot
	name = "Healing Potion"
	cost = 100
	contains = list(
					/obj/item/reagent_containers/glass/bottle/rogue/healthpot,
					/obj/item/reagent_containers/glass/bottle/rogue/healthpot,
					/obj/item/reagent_containers/glass/bottle/rogue/healthpot,
					/obj/item/reagent_containers/glass/bottle/rogue/healthpot,
					/obj/item/reagent_containers/glass/bottle/rogue/healthpot,
				)


/datum/supply_pack/rogue/potions/manapot
	name = "Mana Potion"
	cost = 100
	contains = list(
					/obj/item/reagent_containers/glass/bottle/rogue/manapot,
					/obj/item/reagent_containers/glass/bottle/rogue/manapot,
					/obj/item/reagent_containers/glass/bottle/rogue/manapot,
					/obj/item/reagent_containers/glass/bottle/rogue/manapot,
					/obj/item/reagent_containers/glass/bottle/rogue/manapot,
				)

/datum/supply_pack/rogue/potions/stamina
	name = "Stamina Potion"
	cost = 100
	contains = list(
					/obj/item/reagent_containers/glass/bottle/rogue/stampot,
					/obj/item/reagent_containers/glass/bottle/rogue/stampot,
					/obj/item/reagent_containers/glass/bottle/rogue/stampot,
					/obj/item/reagent_containers/glass/bottle/rogue/stampot,
					/obj/item/reagent_containers/glass/bottle/rogue/stampot,
				)

/datum/supply_pack/rogue/potions/antidote
	name = "Poison Antidote"
	cost = 100
	contains = list(
					/obj/item/reagent_containers/glass/bottle/rogue/antidote,
					/obj/item/reagent_containers/glass/bottle/rogue/antidote,
					/obj/item/reagent_containers/glass/bottle/rogue/antidote,
					/obj/item/reagent_containers/glass/bottle/rogue/antidote,
					/obj/item/reagent_containers/glass/bottle/rogue/antidote,
				)

// Stat potion are bought in packs of 2
/datum/supply_pack/rogue/potions/strpot
	name = "Strength Potion"
	cost = 80
	contains = list(
					/obj/item/reagent_containers/glass/bottle/alchemical/strpot,
					/obj/item/reagent_containers/glass/bottle/alchemical/strpot,
				)

// lower cost due to it being more situational, even though duration is 2x as long
/datum/supply_pack/rogue/potions/perpot
	name = "Perception Potion"
	cost = 50
	contains = list(
					/obj/item/reagent_containers/glass/bottle/alchemical/perpot,
					/obj/item/reagent_containers/glass/bottle/alchemical/perpot,
				)

// lower cost again, not as powerful as strength or speed.
/datum/supply_pack/rogue/potions/endpot
	name = "Endurance Potion"
	cost = 50
	contains = list(
					/obj/item/reagent_containers/glass/bottle/alchemical/endpot,
					/obj/item/reagent_containers/glass/bottle/alchemical/endpot,
				)

// also lower cost
/datum/supply_pack/rogue/potions/conpot
	name = "Constitution Potion"
	cost = 50
	contains = list(
					/obj/item/reagent_containers/glass/bottle/alchemical/conpot,
					/obj/item/reagent_containers/glass/bottle/alchemical/conpot,
				)
			
// Not THAT useful tbh			
/datum/supply_pack/rogue/potions/intpot
	name = "Intelligence Potion"
	cost = 40
	contains = list(
					/obj/item/reagent_containers/glass/bottle/alchemical/intpot,
					/obj/item/reagent_containers/glass/bottle/alchemical/intpot,
				)

// Speed potion are cheap af to make despite being one of the stronger potions
/datum/supply_pack/rogue/potions/spdpot
	name = "Speed Potion"
	cost = 40
	contains = list(
					/obj/item/reagent_containers/glass/bottle/alchemical/spdpot,
					/obj/item/reagent_containers/glass/bottle/alchemical/spdpot,
				)

/datum/supply_pack/rogue/potions/lucpot
	name = "Luck Potion"
	cost = 50
	contains = list(
					/obj/item/reagent_containers/glass/bottle/alchemical/lucpot,
					/obj/item/reagent_containers/glass/bottle/alchemical/lucpot,
				)
