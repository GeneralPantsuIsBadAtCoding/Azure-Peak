/datum/anvil_recipe/engineering
	i_type = "Engineering"
	appro_skill = /datum/skill/craft/engineering
	craftdiff = 1

// --------- IRON RECIPES -----------

/datum/anvil_recipe/engineering/jingle_bells
	name = "Jingling Bells"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/jingle_bells
	createditem_num = 5
	craftdiff = 1

/datum/anvil_recipe/engineering/flint
	name = "Flint x3 (+1 stone)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/natural/stone)
	created_item = /obj/item/flint
	createditem_num = 4
	craftdiff = 0

//Lockpicks and rings moved from blacksmithing, to fit with locks being engineered
/datum/anvil_recipe/engineering/lockpicks
	name = "Lockpicks x3"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/lockpick
	createditem_num = 3
	craftdiff = 2

/datum/anvil_recipe/engineering/lockpickring
	name = "Lockpickrings x3"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/lockpickring
	createditem_num = 3
	craftdiff = 0

/datum/anvil_recipe/engineering/chains
	name = "Chains"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rope/chain
	createditem_num = 1
	craftdiff = 0


// --------- BRONZE RECIPES -----------

/datum/anvil_recipe/engineering/bronze/locks
	name = "Lock 2x"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/customlock
	createditem_num = 2
	craftdiff = 1

/datum/anvil_recipe/engineering/bronze/keys
	name = "Keys 2x"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/customblank
	createditem_num = 2
	craftdiff = 1

/datum/anvil_recipe/engineering/bronze/cog
	name = "Cog 2x"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/roguegear
	createditem_num = 2
	craftdiff = 0

/datum/anvil_recipe/engineering/bronze/lamptern
	name = "Bronze Lamptern 3x"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/flashlight/flare/torch/lantern/bronzelamptern
	createditem_num = 3
	craftdiff = 3

/datum/anvil_recipe/engineering/bronze/waterpurifier
	name = "Self-Purifying Waterskin (+Waterskin)"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/reagent_containers/glass/bottle/waterskin/purifier
	additional_items = list(/obj/item/reagent_containers/glass/bottle/waterskin)
	craftdiff = 3

/datum/anvil_recipe/engineering/bronze/coolingbackpack
	name = "Cooling Backpack (+Cog, +Backpack)" // why are these recipes capitalized differently than every other crafting recipe my ocddddddddddd
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/storage/backpack/rogue/artibackpack
	additional_items = list(/obj/item/roguegear, /obj/item/storage/backpack/rogue/backpack)
	craftdiff = 5

/datum/anvil_recipe/engineering/bronze/mobilestove
	name = "Mobile Stove (+Cog +Tin)" // capitalized to fall in line with the rest of engineering recipes T_T
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/mobilestove
	additional_items = list(/obj/item/roguegear, /obj/item/ingot/tin)
	craftdiff = 4

/datum/anvil_recipe/engineering/bronze/smokebomb
	name = "Smoke Bomb 2x (+Cog, +Ash)"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/smokebomb
	additional_items = list(/obj/item/roguegear, /obj/item/ash)
	createditem_num = 2
	craftdiff = 3

/datum/anvil_recipe/engineering/bronze/grappler
	name = "Grappler"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/grapplinghook
	additional_items = list(/obj/item/rogueweapon/pick, /obj/item/roguegear, /obj/item/roguegear, /obj/item/roguegear, /obj/item/rope/chain)
	craftdiff = 5

// ------------ PROSTHETICS ----------------

/datum/anvil_recipe/engineering/bronze/prosthetic/bronzeleftarm
	name = "Bronze Left Arm (+2 Cogs)"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/roguegear, /obj/item/roguegear)
	created_item = /obj/item/bodypart/l_arm/prosthetic/bronzeleft
	craftdiff = 4

/datum/anvil_recipe/engineering/bronze/prosthetic/bronzerightarm
	name = "Bronze Right Arm (+2 Cogs)"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/roguegear, /obj/item/roguegear)
	created_item = /obj/item/bodypart/r_arm/prosthetic/bronzeright
	craftdiff = 4

/datum/anvil_recipe/engineering/bronze/prosthetic/bronzeleftleg
	name = "Bronze Left Leg (+2 Cogs)"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/roguegear, /obj/item/roguegear)
	created_item = /obj/item/bodypart/l_leg/prosthetic/bronzeleft
	craftdiff = 4

/datum/anvil_recipe/engineering/bronze/prosthetic/bronzerightleg
	name = "Bronze Right Leg (+2 Cogs)"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/roguegear, /obj/item/roguegear)
	created_item = /obj/item/bodypart/r_leg/prosthetic/bronzeright
	craftdiff = 4

// ------------ Rings ----------------
/datum/anvil_recipe/engineering/serfstone
	name = "Serf Stone (+1 cog, +1 Topar)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/roguegear, /obj/item/roguegem/yellow) //using topar since the description calls it a "dull gem"
	created_item = /obj/item/scomstone/bad
	craftdiff = 5

/*	For future updates, if people like the serfstones
/datum/anvil_recipe/engineering/houndstone
	name = "Houndstone (+1 cog, +1 Topar)"
	req_bar = /obj/item/ingot/Steel
	additional_items = list(/obj/item/roguegear, /obj/item/roguegem/yellow)
	created_item = /obj/item/scomstone/bad/garrison
	craftdiff = 5

/datum/anvil_recipe/engineering/scomstone
	name = "SCOM Stone (+1 cog, +1 Gemerald, Arcyne)"
	req_bar = /obj/item/ingot/Gold
	additional_items = list(/obj/item/roguegear, /obj/item/roguegem/green)
	created_item = /obj/item/scomstone
	skillcraft = /datum/skill/magic/arcane
	craftdiff = 5

/datum/anvil_recipe/engineering/emeraldchoker
	name = "emerald choker (+1 cog, +Gold, +1 Gemerald, Arcyne)"
	req_bar = /obj/item/ingot/Gold
	additional_items = list(/obj/item/roguegear, /obj/item/ingot/Gold, /obj/item/roguegem/green)
	created_item = /obj/item/listenstone
	skillcraft = /datum/skill/magic/arcane
	craftdiff = 5
	*/