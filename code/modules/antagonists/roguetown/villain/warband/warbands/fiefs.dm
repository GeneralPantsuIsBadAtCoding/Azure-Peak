////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////
/*
	this entire system is, as a whole, a placeholder/flavor for warband treaties


*/


#define FIEF_TERRORBOG /datum/territory/terrorbog
#define FIEF_ENCLAVE /datum/territory/enclave
#define FIEF_PASS /datum/territory/azure_pass
#define FIEF_HIGHLANDS /datum/territory/azure_highlands
#define FIEF_HEARTFELT /datum/territory/heartfelt
#define FIEF_RELIC /datum/territory/reliquary

#define TFACTION_AZURE /datum/territory_faction/azure
#define TFACTION_CHURCH /datum/territory_faction/church
#define TFACTION_HEARTFELT /datum/territory_faction/heartfelt
#define TFACTION_ORTHODOX /datum/territory_faction/orthodoxy

#define DEFAULT_FIEFS list(FIEF_ENCLAVE, FIEF_TERRORBOG, FIEF_PASS, FIEF_HIGHLANDS, FIEF_HEARTFELT, FIEF_RELIC)
#define DEFAULT_FACTIONS list(TFACTION_AZURE, TFACTION_CHURCH, TFACTION_HEARTFELT, TFACTION_ORTHODOX)


/datum/mind
	var/list/personal_territories = list()
	var/list/associated_factions = list()



////////////////////////////////////////////////////////////////
///////////////////////////////////////////////// PRESET FACTION
/*
	
*/
/datum/territory_faction
	var/name
	var/desc		// appears when hovered in a treaty
	var/job_owner 	// a job name given to the faction to determine ownership | used in preset factions	
	var/owner		// a real_name given to the faction to determine ownership | used in generated factions
	var/list/territories = list()
	var/icon = 'icons/roguetown/weapons/shields32.dmi'
	var/icon_state = "ironsh"

/datum/territory_faction/azure
	name = "The Grand Duchy of Azuria"
	desc = "It is the year 1513, and within the ruins of the Holy Land there yet stands a Grand Duchy."
	job_owner = "Grand Duke"
	territories = list(FIEF_HIGHLANDS, FIEF_ENCLAVE, FIEF_TERRORBOG)
	icon = 'icons/roguetown/weapons/shield_heraldry.dmi'
	icon_state = "ironsh_azure peak"

/datum/territory_faction/heartfelt
	name = "Heartfelt"
	desc = ""
	job_owner = "The Lord of Heartfelt"
	territories = list(FIEF_HEARTFELT)
	icon = 'icons/roguetown/weapons/shield_heraldry.dmi'
	icon_state = "woodsh_peacemaker"


/datum/territory_faction/church
	name = "The Holy See"
	desc = ""
	job_owner = "Bishop"
	territories = list(FIEF_RELIC)
	icon = 'icons/roguetown/weapons/shields32.dmi'
	icon_state = "gsshield"


/datum/territory_faction/orthodoxy
	name = "The Orthodoxy"
	desc = ""
	job_owner = "Inquisitor"
	territories = list()
	icon = 'icons/roguetown/weapons/shields32.dmi'
	icon_state = "psyshield"


/datum/territory_faction/farm
	name = "The Soilfolk"
	desc = "Several families of land-tending yeomen, graciously granted workable soil by the Crown."
	job_owner = "Soilson"
	territories = list(FIEF_PASS)



//////////// TERRITORIES
/datum/territory
	var/name
	var/desc = "A distant tract of land."	// shown while hovered
	var/vault = 0							//	accessed via treaties
	var/maintenance = 0						//	a territory with a vault below its maintenance threshold has a delayed import speed for its prized good
	var/job_owner = list()					//	jobs that have authority over the territory at roundstart
	var/inheritor	 						//	after an authority dies & rots, the territory's inheritor becomes the authority
	var/scale = 1	  						//	multiplies benefits of goods & the impact of a noble's mood loss if they're dispossessed
	var/distance = 1						//  import value is divided by distance
	var/aspects								//  extra modifiers
	var/prized_good							// 	when a chest from the territory's vault is imported, it contains items from the related "prized good" of a total value near the expected import


/datum/territory/proc/generate_territory(mob/user, territory_name)
	var/datum/territory/generated_territory = new /datum/territory


	if(territory_name)
		name = "[territory_name]"
	else
		name = "[user.real_name]'s Estate"

	generated_territory.maintenance = rand(100, 500)
	generated_territory.scale = rand(1, 10)
	generated_territory.distance = rand(1, 10)
	generated_territory.vault = rand(100, 900)
	generated_territory.job_owner = list(user)
	generated_territory.inheritor = user

	if(generated_territory.distance < 4)
		var/list/regular_goods = list(
			/datum/goods/scum/ozium,
			/datum/goods/scum/spice,
			/datum/goods/food/fish,
			/datum/goods/food/grain,
			/datum/goods/food/tea,
			/datum/goods/materials/copper,
			/datum/goods/materials/gold,
			/datum/goods/misc/rocks,
			/datum/goods/misc/arms
		)
		generated_territory.prized_good = pick(regular_goods)
		generated_territory.aspects += /datum/territory/aspect/rot
	else
		var/list/exotic_goods = list(
			/datum/goods/scum/exotic/moondust,
			/datum/goods/food/exotic/coffee,
			/datum/goods/food/exotic/rice,
			/datum/goods/food/exotic/spiderhoney,
			/datum/goods/materials/exotic/gems
		)
		generated_territory.prized_good = pick(exotic_goods)
		generated_territory.aspects += /datum/territory/aspect/weirding

	return generated_territory



/datum/territory_faction/proc/generate_faction(mob/user, faction_name)
	// owner = user
	// if(faction_name)
	// 	name = "[faction_name]"
	// else
	// 	name = "[user.real_name]'s Domain"


/////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////// TERRITORY MODIFIERS
/*
	
*/
/datum/territory/aspect

//// atm, both of these just function as distance signifiers
//// if someone sees "the weirding", the prized good is pulling from the exotic loot pool
/datum/territory/aspect/rot 
	name = "The Rot and the Hunger"
	desc = ""

/datum/territory/aspect/weirding
	name = "The Weirding"
	desc = ""


/////////////////////////////////////////////////////////////
///////////////////////////////////////////////// TERRITORIES
/*
	pre-generated territories
*/
/datum/territory/azure_highlands
	name = "The Azure Highlands"
	desc = "A tract of grand farmland, nested upon the crest of the steep cliffs surrounding the southern bay."
	job_owner = list("Grand Duke","Hand")
	aspects = list(/datum/territory/aspect/rot)
	prized_good = /datum/goods/food/grain
	vault = 200
	maintenance = 150


/datum/territory/terrorbog
	name = "The Terrorbog"
	desc = "To be proclaimed Warden of the Terrorbog is a condemnation. It's land, yes - but it's a burden. Cursed earth."
	job_owner = list("Grand Duke","Hand")
	aspects = list(/datum/territory/aspect/rot)
	maintenance = 500
	vault = 0
	prized_good = /datum/goods/food/exotic/spiderhoney


/datum/territory/enclave
	name = "The Azure Enclave"
	desc = "In the woods westward lies a husk of an old Imperial fortress, once left unmanned in the hour of the Sundering. \
	Centuries later, within its decayed marble halls and upon its overgrowth-choked bulkheads, a new guard has taken up the watch."
	job_owner = list("Grand Duke","Hand","Marshal")
	aspects = list(/datum/territory/aspect/rot)
	prized_good = /datum/goods/misc/arms
	vault = 500
	maintenance = 100


/datum/territory/azure_pass
	name = "The Azure Pass"
	desc = "Just beyond the Basin, simple folk ply their trades in quiet villages."
	job_owner = list("Grand Duke","Hand")
	aspects = list(/datum/territory/aspect/rot)
	prized_good = /datum/goods/food/tea
	vault = 200
	maintenance = 40


/datum/territory/heartfelt
	name = "Heartfelt"
	aspects = list(/datum/territory/aspect/rot)
	job_owner = list("The Lord of Heartfelt")
	vault = 4	/// https://media.tenor.com/aj47iJzWZgwAAAAM
	maintenance = 200
	prized_good = /datum/goods/misc/rocks


/datum/territory/reliquary
	name = "Tomb of Psyvalus"
	job_owner = list("Bishop","Vice Priest")
	vault = 3500
	prized_good = /datum/goods/materials/gold


///////////////////////////////////////////////////////
///////////////////////////////////////////////// GOODS
/*
	during a territory's vault import, it draws from the item pool of its associated "prized good"


*/

/datum/goods
	var/name
	var/desc
	var/list/items = list()			
	var/bagged = TRUE				// if the items are imported in sacks
	var/unique_import_value			// gives each item a unique value during the import calculation, unassociated the item's actual value



//////////// DRUGS
/datum/goods/scum/ozium
	name = "Ozium"
	items = list(/obj/item/reagent_containers/powder/ozium)

/datum/goods/scum/spice
	name = "Spice"
	items = list(/obj/item/reagent_containers/powder/spice)

/datum/goods/scum/exotic/moondust
	name = "Moondust"
	items = list(/obj/item/reagent_containers/powder/moondust)


//////////// FOOD
/datum/goods/food/fish
	name = "Fish"
	items = list(/obj/item/reagent_containers/food/snacks/fish/lobster, /obj/item/reagent_containers/food/snacks/fish/carp, /obj/item/reagent_containers/food/snacks/fish/cod)

/datum/goods/food/grain
	name = "Grain"
	items = list(/obj/item/reagent_containers/food/snacks/grown/wheat)

/datum/goods/food/tea
	name = "Tea"
	items = list(/obj/item/reagent_containers/food/snacks/grown/rogue/tealeaves_dry)

/datum/goods/food/exotic/coffee
	name = "Coffee"
	items = list(/obj/item/reagent_containers/food/snacks/grown/coffeebeans)

/datum/goods/food/exotic/rice
	name = "Rice"
	items = list(/obj/item/reagent_containers/food/snacks/grown/rice)

/datum/goods/food/exotic/spiderhoney
	name = "Spider Honey"
	items = list(/obj/item/reagent_containers/food/snacks/rogue/honey/spider)


//////////// MATERIALS
/datum/goods/materials/copper
	name = "Copper"
	items = list(/obj/item/ingot/copper)
	bagged = FALSE

/datum/goods/materials/gold
	name = "Gold"
	items = list(/obj/item/ingot/gold, /obj/item/candle/candlestick/gold, /obj/item/candle/gold, /obj/item/clothing/ring/gold, /obj/item/reagent_containers/glass/bowl/gold, \
	/obj/item/roguestatue/gold, /obj/item/cooking/platter/gold, /obj/item/reagent_containers/glass/cup/golden, /obj/item/reagent_containers/glass/cup/golden/small, /obj/item/clothing/ring/signet)
	bagged = FALSE

/datum/goods/materials/exotic/gems
	name = "Jewels"
	items = list(/obj/item/roguegem/green, /obj/item/roguegem/diamond, /obj/item/roguegem/violet, /obj/item/roguegem/ruby, /obj/item/roguegem/yellow)
	bagged = FALSE


//////////// MISC
/datum/goods/misc/rocks
	name = "Rocks"
	items = list(/obj/item/natural/bundle/stoneblock)


/datum/goods/misc/arms
	name = "Arms"
	items = list(/obj/item/rogueweapon/sword/saber/iron, /obj/item/rogueweapon/sword/iron, /obj/item/rogueweapon/sword/short/iron/chipped, /obj/item/rogueweapon/sword/short/messer/iron)




//////////// TERRITORY EVENTS

/datum/territory/proc/spawn_import(spawnloc)

// FIXNOTE: make a dock on the east coast of the azure grove
// can either spawn it there for no tax, or suffer a 50% tax to use the city's dock
// if there's an active blockade the dock tax is 80% and the grove tax is 30%

	// var/good = src.prized_good
	// var/object_limit = 80	// how many items can be spawned | value in excess spawns as silver coins
	// var/incoming_value
	// var/spawn_loc
	// var/city_tax = 50
	// var/grove_tax = 0

	// var/chest

	// check for active warbands, then check if they have the Blockade aspect active
	// if(SSwarbands.warband_managers)
	// 	for(var/warband_manager/found_warband)
	// 		if(found_warband.selected_aspects.length)
	// 			for(var/warband/aspect/found_aspect in found_warband.selected_aspects)
	// 				if(istype(found_aspect /datum/warbands/aspects/blockade))
	// 					grove_tax = 30
	// 					city_tax = 90
	// 					break


	// switch
	// 	if("Groveside ([grove_tax]% TAX)")
	// 		//apply the grove tax then build the chest with the final value
	// 		//teleport the chest to the grove landmark loc
	
	// 		for(var/obj/item/mattcoin/bandit_ring in SSroguemachine.scomm_machines)
	// 			if(loc.type == /mob/living/carbon/human && listening)
	// 				var/wearer = bandit_ring.loc
	// 				to_chat(wearer, span_warning("The gem within my [bandit_ring.name] burns hot. Somewhere in the Duchy, treasure flows."))




	// 	if("City Docks ([city_tax]% TAX)")


