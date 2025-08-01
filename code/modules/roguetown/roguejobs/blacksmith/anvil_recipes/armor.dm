/datum/anvil_recipe/armor
	abstract_type = /datum/anvil_recipe/armor
	appro_skill = /datum/skill/craft/armorsmithing
	i_type = "Armor"
	craftdiff = 1

//For the sake of keeping the code modular with the introduction of new metals, each recipe has had it's main resource added to it's datum
//This way, we can avoid having to name things in strange ways and can simply have iron/cuirass, stee/cuirass, blacksteel/cuirass->
//-> and not messy names like ibreastplate and hplate

// --------- COPPER RECIPES -----------
/datum/anvil_recipe/armor/copper/
	abstract_type = /datum/anvil_recipe/armor/copper

/datum/anvil_recipe/armor/copper/mask
	name = "Copper Mask"
	req_bar = /obj/item/ingot/copper
	created_item = /obj/item/clothing/mask/rogue/facemask/copper
	craftdiff = 0

/datum/anvil_recipe/armor/copper/bracers
	name = "Copper Bracers"
	req_bar = /obj/item/ingot/copper
	created_item = /obj/item/clothing/wrists/roguetown/bracers/copper
	craftdiff = 0

/datum/anvil_recipe/armor/copper/cap
	name = "Lamellar Cap"
	req_bar = /obj/item/ingot/copper
	created_item = /obj/item/clothing/head/roguetown/helmet/coppercap
	craftdiff = 0

/datum/anvil_recipe/armor/copper/gorget
	name = "Copper Neck Protector"
	req_bar = /obj/item/ingot/copper
	created_item = /obj/item/clothing/neck/roguetown/gorget/copper
	craftdiff = 0

/datum/anvil_recipe/armor/copper/chest
	name = "Copper Heart Protector"
	req_bar = /obj/item/ingot/copper
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/half/copper
	craftdiff = 0


// --------- Decrepit Alloy RECIPES -----------

/datum/anvil_recipe/armor/aalloy/barbute
	name = "Decrepit Alloy Barbute(+1 Alloy)"
	req_bar = /obj/item/ingot/aalloy
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/aalloy
	craftdiff = 1

/datum/anvil_recipe/armor/paalloy/barbute
	name = "Purified Alloy Barbute(+1 Alloy)"
	req_bar = /obj/item/ingot/purifiedaalloy
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/paalloy
	additional_items = /obj/item/ingot/aalloy
	craftdiff = 3


/datum/anvil_recipe/armor/aalloy/savoyard
	name = "Decrepit Alloy Savoyard(+1 Alloy)"
	req_bar = /obj/item/ingot/aalloy
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/guard/aalloy
	craftdiff = 1

/datum/anvil_recipe/armor/paalloy/savoyard
	name = "Purified Alloy Savoyard(+1 Purified Alloy)"
	req_bar = /obj/item/ingot/purifiedaalloy
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/guard/paalloy
	additional_items = /obj/item/ingot/purifiedaalloy
	craftdiff = 3

/datum/anvil_recipe/armor/aalloy/mask
	name = "Decrepit Alloy Mask"
	req_bar = /obj/item/ingot/aalloy
	created_item = /obj/item/clothing/mask/rogue/facemask/aalloy
	craftdiff = 1

/datum/anvil_recipe/armor/paalloy/mask
	name = "Purified Alloy Mask"
	req_bar = /obj/item/ingot/purifiedaalloy
	created_item = /obj/item/clothing/mask/rogue/facemask/steel/paalloy
	craftdiff = 3

/datum/anvil_recipe/armor/aalloy/coif
	name = "Decrepit Alloy Coif"
	req_bar = /obj/item/ingot/aalloy
	created_item = /obj/item/clothing/neck/roguetown/chaincoif/iron/aalloy
	craftdiff = 1

/datum/anvil_recipe/armor/paalloy/coif
	name = "Purified Alloy Coif"
	req_bar = /obj/item/ingot/purifiedaalloy
	created_item = /obj/item/clothing/neck/roguetown/chaincoif/paalloy
	craftdiff = 3

/datum/anvil_recipe/armor/aalloy/gorget
	name = "Decrepit Alloy Gorget"
	req_bar = /obj/item/ingot/aalloy
	created_item = /obj/item/clothing/neck/roguetown/gorget/aalloy
	craftdiff = 1

/datum/anvil_recipe/armor/paalloy/gorget
	name = "Purified Alloy Gorget"
	req_bar = /obj/item/ingot/purifiedaalloy
	created_item = /obj/item/clothing/neck/roguetown/gorget/paalloy
	craftdiff = 3

/datum/anvil_recipe/armor/aalloy/cuirass
	name = "Decrepit Alloy Cuirass (+1 Alloy)"
	req_bar = /obj/item/ingot/aalloy
	additional_items = list(/obj/item/ingot/aalloy)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/half/aalloy
	craftdiff = 1

/datum/anvil_recipe/armor/paalloy/cuirass
	name = "Purified Alloy Cuirass (+1 Purified Alloy)"
	req_bar = /obj/item/ingot/purifiedaalloy
	additional_items = list(/obj/item/ingot/purifiedaalloy)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/half/paalloy
	craftdiff = 3

/datum/anvil_recipe/armor/aalloy/halfplate
	name = "Decrepit Alloy Half-Plate Armour (+2 Alloy, +1 Cured Leather)"
	req_bar = /obj/item/ingot/aalloy
	additional_items = list(/obj/item/ingot/aalloy,/obj/item/ingot/aalloy,/obj/item/natural/hide/cured)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/aalloy
	craftdiff = 1

/datum/anvil_recipe/armor/paalloy/halfplate
	name = "Purified Alloy Half-Plate Armour (+2 Purified Alloy, +1 Cured Leather)"
	req_bar = /obj/item/ingot/purifiedaalloy
	additional_items = list(/obj/item/ingot/purifiedaalloy,/obj/item/ingot/purifiedaalloy,/obj/item/natural/hide/cured)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/paalloy
	craftdiff = 3

/datum/anvil_recipe/armor/aalloy/chainmail
	name = "Decrepit Alloy Chainmail"
	req_bar = /obj/item/ingot/aalloy
	created_item = /obj/item/clothing/suit/roguetown/armor/chainmail/aalloy
	craftdiff = 1

/datum/anvil_recipe/armor/paalloy/chainmail
	name = "Purified Alloy Chainmail"
	req_bar = /obj/item/ingot/purifiedaalloy
	created_item = /obj/item/clothing/suit/roguetown/armor/chainmail/paalloy
	craftdiff = 3

/datum/anvil_recipe/armor/aalloy/hauberk
	name = "Decrepit Alloy Hauberk(+1 Alloy)"
	req_bar = /obj/item/ingot/aalloy
	created_item = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk/aalloy
	additional_items = list(/obj/item/ingot/aalloy)
	craftdiff = 1

/datum/anvil_recipe/armor/paalloy/hauberk
	name = "Purified Alloy Hauberk(+1 Purified Alloy)"
	req_bar = /obj/item/ingot/purifiedaalloy
	created_item = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk/paalloy
	additional_items = list(/obj/item/ingot/purifiedaalloy)
	craftdiff = 3

/datum/anvil_recipe/armor/aalloy/bracers
	name = "Decrepit Alloy Bracers"
	req_bar = /obj/item/ingot/aalloy
	created_item = /obj/item/clothing/wrists/roguetown/bracers/aalloy
	craftdiff = 1

/datum/anvil_recipe/armor/paalloy/bracers
	name = "Purified Alloy Bracers"
	req_bar = /obj/item/ingot/purifiedaalloy
	created_item = /obj/item/clothing/wrists/roguetown/bracers/paalloy
	craftdiff = 3

/datum/anvil_recipe/armor/aalloy/chaingaunts
	name = "Decrepit Alloy Chain Gauntlets"
	req_bar = /obj/item/ingot/aalloy
	created_item = /obj/item/clothing/gloves/roguetown/chain/aalloy
	craftdiff = 1

/datum/anvil_recipe/armor/paalloy/chaingaunts
	name = "Purified Alloy Chain Gauntlets"
	req_bar = /obj/item/ingot/purifiedaalloy
	created_item = /obj/item/clothing/gloves/roguetown/chain/paalloy
	craftdiff = 3

/datum/anvil_recipe/armor/aalloy/plategaunts
	name = "Decrepit Alloy Plate Gauntlets"
	req_bar = /obj/item/ingot/aalloy
	created_item = /obj/item/clothing/gloves/roguetown/plate/aalloy
	craftdiff = 1

/datum/anvil_recipe/armor/paalloy/plategaunts
	name = "Purified Alloy Plate Gauntlets"
	req_bar = /obj/item/ingot/purifiedaalloy
	created_item = /obj/item/clothing/gloves/roguetown/plate/paalloy
	craftdiff = 3

/datum/anvil_recipe/armor/aalloy/chainkilt
	name = "Decrepit Alloy Chainkilt"
	req_bar = /obj/item/ingot/aalloy
	created_item = /obj/item/clothing/under/roguetown/chainlegs/kilt/aalloy
	craftdiff = 1

/datum/anvil_recipe/armor/paalloy/chainkilt
	name = "Purified Alloy Chainkilt"
	req_bar = /obj/item/ingot/purifiedaalloy
	created_item = /obj/item/clothing/under/roguetown/chainlegs/kilt/paalloy
	craftdiff = 3

/datum/anvil_recipe/armor/aalloy/platelegs
	name = "Decrepit Alloy Plated Chausses (+1 Steel)"
	req_bar = /obj/item/ingot/aalloy
	additional_items = list(/obj/item/ingot/aalloy)
	created_item = /obj/item/clothing/under/roguetown/platelegs/aalloy
	craftdiff = 1

/datum/anvil_recipe/armor/paalloy/platelegs
	name = "Purified Alloy Plated Chausses (+1 Steel)"
	req_bar = /obj/item/ingot/purifiedaalloy
	additional_items = list(/obj/item/ingot/purifiedaalloy)
	created_item = /obj/item/clothing/under/roguetown/platelegs/paalloy
	craftdiff = 3

// --------- IRON RECIPES -----------

/datum/anvil_recipe/armor/iron/haubergeon
	name = "Haubergeon"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/suit/roguetown/armor/chainmail/iron

/datum/anvil_recipe/armor/iron/hauberk
	name = "Hauberk (+1 Iron)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk/iron

/datum/anvil_recipe/armor/iron/chaincoif
	name = "Chain Coif"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/neck/roguetown/chaincoif/iron
	createditem_num = 1
	craftdiff = 0

/datum/anvil_recipe/armor/iron/gorget
	name = "Gorget"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/neck/roguetown/gorget
	createditem_num = 1
	craftdiff = 0

/datum/anvil_recipe/armor/iron/bevor
	name = "Bevor"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/neck/roguetown/bevor/iron

/datum/anvil_recipe/armor/iron/breastplate
	name = "Breastplate (+1 Iron)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/half/iron

/datum/anvil_recipe/armor/iron/halfplate
	name = "Half-Plate Armour (+2 Iron, +1 Cured Leather)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron, /obj/item/ingot/iron, /obj/item/natural/hide/cured)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/iron
	craftdiff = 2

/datum/anvil_recipe/armor/iron/fullplate
	name = "Full-Plate Armour (+3 Iron, +1 Cured Leather)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron, /obj/item/ingot/iron, /obj/item/ingot/iron, /obj/item/natural/hide/cured)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/full/iron
	craftdiff = 3

/datum/anvil_recipe/armor/iron/chainglove
	name = "Chain Gauntlets"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/gloves/roguetown/chain/iron
	craftdiff = 0

/datum/anvil_recipe/armor/iron/plategauntlets
	name = "Plate Gauntlet"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/gloves/roguetown/plate/iron
	craftdiff = 0

/datum/anvil_recipe/armor/iron/chainleg
	name = "Chain Chausses"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/under/roguetown/chainlegs/iron
	craftdiff = 0

/datum/anvil_recipe/armor/iron/chainleg/kilt
	name = "Chain Kilt"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/under/roguetown/chainlegs/iron/kilt
	craftdiff = 0

/datum/anvil_recipe/armor/iron/splintlegs
	name = "Splinted Chausses (+1 leather pants)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/clothing/under/roguetown/trou/leather)//basically you just add a lot of iron bits to the pants
	created_item = /obj/item/clothing/under/roguetown/splintlegs/iron

/datum/anvil_recipe/armor/iron/platelegs
	name = "Plate Chausses (+1 Bar)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/under/roguetown/platelegs/iron

/datum/anvil_recipe/armor/iron/mask
	name = "Iron Mask"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/mask/rogue/facemask
	createditem_num = 1
	craftdiff = 0

/datum/anvil_recipe/armor/iron/mask/hound
	name = "Mask (Hound)"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/mask/rogue/facemask/hound
	createditem_num = 1
	craftdiff = 0

/datum/anvil_recipe/armor/iron/wildguard
	name = "Wild guard Mask"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/mask/rogue/wildguard
	createditem_num = 1
	craftdiff = 0

/datum/anvil_recipe/armor/iron/splintarms
	name = "Splinted Bracers (+1 leather bracers)" //you modify the bracers to have splints and cover the arm way more
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/clothing/wrists/roguetown/bracers/leather)
	created_item = /obj/item/clothing/wrists/roguetown/splintarms/iron
	
/datum/anvil_recipe/armor/iron/bracers
	name = "Plate Bracers"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/wrists/roguetown/bracers/iron
	createditem_num = 1
	craftdiff = 0
	
/datum/anvil_recipe/armor/iron/jackchain
	name = "Jack Chain, 2x"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/wrists/roguetown/bracers/jackchain
	createditem_num = 2
	craftdiff = 0

/datum/anvil_recipe/armor/iron/boot
	name = "Light Plated Boots"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/shoes/roguetown/boots/armor/iron
	createditem_num = 1
	craftdiff = 0

/datum/anvil_recipe/armor/iron/skullcap
	name = "Skullcap"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/head/roguetown/helmet/skullcap

/datum/anvil_recipe/armor/iron/kettle
	name = "Kettle Helmet"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/head/roguetown/helmet/kettle/iron

/datum/anvil_recipe/armor/iron/sallet
	name = "Sallet Helmet"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/head/roguetown/helmet/sallet/iron

/datum/anvil_recipe/armor/iron/sallet/visor
	name = "Visored Sallet (+1 Iron)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/head/roguetown/helmet/sallet/visored/iron

/datum/anvil_recipe/armor/iron/knighthelmet
	name = "Knight's Helmet (+1 Iron)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/knight/iron

/datum/anvil_recipe/armor/iron/bucket
	name = "Iron Bucket Helmet (+1 Iron)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/bucket/iron

/datum/anvil_recipe/armor/iron/studded
	name = "Studded Leather Armor (+ Leather Armor)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/clothing/suit/roguetown/armor/leather)
	created_item = /obj/item/clothing/suit/roguetown/armor/leather/studded

/datum/anvil_recipe/armor/studdedbikini
	name = "Studded Leather Corslet (+ Leather Corslet)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/clothing/suit/roguetown/armor/leather)
	created_item = /obj/item/clothing/suit/roguetown/armor/leather/studded/bikini

/datum/anvil_recipe/armor/iron/helmethorned
	name = "Horned Helmet"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/head/roguetown/helmet/horned
	craftdiff = 2
	
/*
/datum/anvil_recipe/armor/helmetgoblin
	name = "Goblin Helmet (+1 Iron)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/head/roguetown/helmet/goblin
	craftdiff = 2

/datum/anvil_recipe/armor/plategoblin
	name = "Goblin Mail (+1 Iron)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/half/iron/goblin
	craftdiff = 2
*/
// --------- STEEL RECIPES -----------

/datum/anvil_recipe/armor/steel/lbrigandine
	name = "Light Brigandine (+1 cured leather)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/natural/hide/cured)
	created_item = /obj/item/clothing/suit/roguetown/armor/brigandine/light
	i_type = "Armor"
	craftdiff = 2 //not any random can make it

/datum/anvil_recipe/armor/steel/haubergeon
	name = "Haubergeon"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/suit/roguetown/armor/chainmail
	craftdiff = 2

/datum/anvil_recipe/armor/steel/chainkini
	name = "Chainmail Corslet (+1 Cloth)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/natural/cloth)
	created_item = /obj/item/clothing/suit/roguetown/armor/chainmail/bikini

/datum/anvil_recipe/armor/steel/hauberk
	name = "Hauberk (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	craftdiff = 3

/datum/anvil_recipe/armor/steel/halfplate
	name = "Half-Plate Armour (+2 Steel, +1 Cured Leather)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel,/obj/item/ingot/steel,/obj/item/natural/hide/cured)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate
	craftdiff = 3

/datum/anvil_recipe/armor/steel/halfplate/fluted
	name = "Fluted Half-Plate Armour (+2 Steel, +1 Iron, +1 Cured Leather)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel, /obj/item/ingot/iron, /obj/item/natural/hide/cured)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/fluted
	craftdiff = 3

/datum/anvil_recipe/armor/steel/halfplate/fluted/ornate
	name = "Psydonian Half-Plate Armour (+ P.Cuirass, +1 Steel, +1 Blessed Silver, +1 Cured Leather)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/clothing/suit/roguetown/armor/plate/half/fluted/ornate, /obj/item/ingot/steel, /obj/item/ingot/silverblessed, /obj/item/natural/hide/cured)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/fluted/ornate
	craftdiff = 3

/datum/anvil_recipe/armor/steel/fullplate
	name = "Full-Plate Armour (+3 Steel, +1 Cured Leather)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel, /obj/item/ingot/steel, /obj/item/natural/hide/cured)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/full
	craftdiff = 4

/datum/anvil_recipe/armor/steel/fullplate/fluted
	name = "Fluted Full-Plate Armour (+3 Steel, +1 Iron, +1 Cured Leather)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel, /obj/item/ingot/steel, /obj/item/ingot/iron, /obj/item/natural/hide/cured)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/full/fluted
	craftdiff = 4

/datum/anvil_recipe/armor/steel/fullplate/fluted/ornate
	name = "Psydonian Full-Plate Armour (+ P.Half-Plate, +1 Blessed Silver, +1 Cured Leather)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/clothing/suit/roguetown/armor/plate/fluted/ornate, /obj/item/ingot/silverblessed, /obj/item/natural/hide/cured)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/full/fluted/ornate
	craftdiff = 4

/datum/anvil_recipe/armor/steel/fullplate/fluted/ornate/alt
	name = "Psydonian Full-Plate Armour (+ P.Hauberk, +1 Steel, +2 Blessed Silver, +1 Cured Leather)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/clothing/suit/roguetown/armor/chainmail/hauberk/ornate, /obj/item/ingot/steel, /obj/item/ingot/silverblessed, /obj/item/ingot/silverblessed, /obj/item/natural/hide/cured)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/full/fluted/ornate
	craftdiff = 4

/datum/anvil_recipe/armor/steel/platebikini
	name = "Half-Plate Corslet (+1 Steel, +1 Cured Leather)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/natural/hide/cured)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/bikini
	craftdiff = 3

/datum/anvil_recipe/armor/steel/fullplatebikini
	name = "Full-Plate Corslet (+2 Steel, +1 Cured Leather)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel, /obj/item/natural/hide/cured)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/full/bikini
	craftdiff = 4

/datum/anvil_recipe/armor/steel/coatplates
	name = "Coat Of Plates (+1 Steel, +1 Cured Leather)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel,/obj/item/natural/hide/cured)
	created_item = /obj/item/clothing/suit/roguetown/armor/brigandine/coatplates
	craftdiff = 2

/datum/anvil_recipe/armor/steel/steel/brigandine
	name = "Brigandine (+1 Steel, +2 Cloth)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/natural/cloth, /obj/item/natural/cloth)
	created_item = /obj/item/clothing/suit/roguetown/armor/brigandine
	craftdiff = 3

/datum/anvil_recipe/armor/steel/chaincoif
	name = "Chain Coif"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/neck/roguetown/chaincoif
	createditem_num = 1
	craftdiff = 2

/datum/anvil_recipe/armor/steel/chainmantle
	name = "Chain Mantle"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/neck/roguetown/chaincoif/chainmantle
	createditem_num = 1
	craftdiff = 2

/datum/anvil_recipe/armor/steel/fullchaincoif
	name = "Full Chain Coif"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/neck/roguetown/chaincoif/full
	craftdiff = 2

/datum/anvil_recipe/armor/steel/chainglove
	name = "Chain Gauntlets"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/gloves/roguetown/chain
	craftdiff = 2

/datum/anvil_recipe/armor/steel/plateglove
	name = "Plate Gauntlets"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/gloves/roguetown/plate
	createditem_num = 1
	craftdiff = 3

/datum/anvil_recipe/armor/steel/chainleg
	name = "Chain Chausses"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/under/roguetown/chainlegs
	craftdiff = 2

/datum/anvil_recipe/armor/steel/chainlegs/kilt
	name = "Chain Kilt"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/under/roguetown/chainlegs/kilt
	craftdiff = 2

/datum/anvil_recipe/armor/steel/brayette
	name = "Brayette"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/under/roguetown/brayette

/datum/anvil_recipe/armor/steel/chainskirt
	name = "Chain Skirt"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/under/roguetown/chainlegs/skirt

/datum/anvil_recipe/armor/steel/plateskirt
	name = "Plate Tassets (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/under/roguetown/platelegs/skirt
	craftdiff = 2

/datum/anvil_recipe/armor/steel/platelegs
	name = "Plated Chausses (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/under/roguetown/platelegs
	craftdiff = 2

/datum/anvil_recipe/armor/steel/cuirass
	name = "Cuirass (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/half
	craftdiff = 3

/datum/anvil_recipe/armor/steel/lightcuirass
	name = "Fencing Cuirass (+1 Fur, +1 Tallow, +3 Cured Leather)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/natural/fur, /obj/item/reagent_containers/food/snacks/tallow, /obj/item/natural/hide/cured, /obj/item/natural/hide/cured, /obj/item/natural/hide/cured)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/half/fencer
	craftdiff = 5

/datum/anvil_recipe/armor/steel/cuirass/fluted
	name = "Fluted Cuirass (+1 Steel, +1 Iron)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/iron)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/half/fluted
	craftdiff = 3

/datum/anvil_recipe/armor/steel/cuirass/fluted/ornate
	name = "Psydonian Cuirass (+1 Blessed Silver)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/silverblessed)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/half/fluted/ornate
	craftdiff = 3

/datum/anvil_recipe/armor/steel/scalemail
	name = "Scalemail (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/scale
	craftdiff = 3

/datum/anvil_recipe/armor/steel/platebracer
	name = "Plate Bracers"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/wrists/roguetown/bracers
	createditem_num = 1

/datum/anvil_recipe/armor/steel/helmetnasal
	name = "Nasal Helmet"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet
	craftdiff = 2

/datum/anvil_recipe/armor/steel/helmetwinged
	name = "Winged Helmet"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/winged
	craftdiff = 2

/datum/anvil_recipe/armor/steel/helmetkettle
	name = "Kettle Helmet"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/kettle
	craftdiff = 2

/datum/anvil_recipe/armor/steel/widehelmetkettle
	name = "Wide Kettle Helmet"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/kettle/wide
	craftdiff = 2


/datum/anvil_recipe/armor/steel/bevor
	name = "Bevor"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/neck/roguetown/bevor
	craftdiff = 2

/datum/anvil_recipe/armor/steel/sgorget
	name = "Steel gorget"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/neck/roguetown/gorget/steel
	craftdiff = 2

/datum/anvil_recipe/armor/iron/cursed_collar
	name = "Cursed Collar"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/neck/roguetown/gorget/cursed_collar
	craftdiff = 1

/datum/anvil_recipe/armor/steel/helmetsall
	name = "Sallet"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/sallet
	craftdiff = 2

/datum/anvil_recipe/armor/steel/helmetsallv
	name = "Sallet Visored (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/sallet/visored
	craftdiff = 2

/datum/anvil_recipe/armor/steel/helmetbuc
	name = "Bucket Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/bucket
	craftdiff = 2

/datum/anvil_recipe/armor/steel/helmetpig
	name = "Pigface Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/bascinet/pigface
	craftdiff = 2

/datum/anvil_recipe/armor/steel/helmethounskull
	name = "Hounskull Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/bascinet/pigface/hounskull
	craftdiff = 2

/datum/anvil_recipe/armor/steel/bascinet
	name = "Bascinet Helmet"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/bascinet
	craftdiff = 2

/datum/anvil_recipe/armor/steel/etruscanbascinet
	name = "Etruscan Bascinet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/bascinet/etruscan
	craftdiff = 3

/datum/anvil_recipe/armor/steel/helmetknight
	name = "Knight's Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/knight
	craftdiff = 3

/datum/anvil_recipe/armor/steel/helmetarmet
	name = "Armet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/knight/armet
	craftdiff = 3

/datum/anvil_recipe/armor/steel/slittedkettle
	name = "Slitted Kettle (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/knight/skettle
	craftdiff = 3

/datum/anvil_recipe/armor/steel/savoyard
	name = "Savoyard Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/guard
	craftdiff = 3

/datum/anvil_recipe/armor/steel/barredhelm
	name = "Barred Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/sheriff
	craftdiff = 3

/datum/anvil_recipe/armor/helmetvolf
	name = "Volf Face Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/volfplate
	craftdiff = 3
	i_type = "Armor"

/datum/anvil_recipe/armor/steel/plateboot
	name = "Plated Boots"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/shoes/roguetown/boots/armor
	createditem_num = 1
	craftdiff = 2

/datum/anvil_recipe/armor/steel/mask
	name = "Steel Mask"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/mask/rogue/facemask/steel
	createditem_num = 1
	craftdiff = 2

/datum/anvil_recipe/armor/steel/mask/hound
	name = "Mask (Hound)"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/mask/rogue/facemask/steel/hound
	createditem_num = 1
	craftdiff = 2

/datum/anvil_recipe/armor/steel/astratahelm
	name = "Astrata Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/astratahelm
	craftdiff = 3

/datum/anvil_recipe/armor/steel/abyssorhelm
	name = "Abyssor Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/abyssorgreathelm
	craftdiff = 3

/datum/anvil_recipe/armor/steel/necrahelm
	name = "Necra Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/necrahelm
	craftdiff = 3

/datum/anvil_recipe/armor/steel/nochelm
	name = "Noc Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/nochelm
	craftdiff = 3

/datum/anvil_recipe/armor/steel/dendorhelm
	name = "Dendor Helmet (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/dendorhelm
	craftdiff = 3

/datum/anvil_recipe/armor/steel/frogmouth
	name = "Froggemund Helmet (+2 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/frogmouth
	craftdiff = 3

/datum/anvil_recipe/armor/steel/belt
	name = "Steel Plated Belt"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/storage/belt/rogue/leather/steel
	craftdiff = 2

/datum/anvil_recipe/armor/steel/belt/tasset
	name = "Tasseted Steel Plated Belt"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/storage/belt/rogue/leather/steel/tasset
	craftdiff = 2

/datum/anvil_recipe/armor/steel/splintarms
	name = "Brigandine Bracers (+1 leather bracers)" 
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/clothing/wrists/roguetown/bracers/leather)
	created_item = /obj/item/clothing/wrists/roguetown/splintarms

/datum/anvil_recipe/armor/steel/splintlegs
	name = "Brigandine Chausses (+1 leather pants)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/clothing/under/roguetown/trou/leather)//basically you just add a lot of iron bits to the pants
	created_item = /obj/item/clothing/under/roguetown/splintlegs

// --------- SILVER RECIPES-----------

/datum/anvil_recipe/armor/silver/belt
	name = "Silver Plated Belt"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/storage/belt/rogue/leather/plaquesilver
	craftdiff = 3

// --------- GOLD RECIPES-----------

/datum/anvil_recipe/armor/gold/belt
	name = "Gold Plated Belt"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/storage/belt/rogue/leather/plaquegold
	craftdiff = 3

/datum/anvil_recipe/armor/gold/mask
	name = "Gold Mask"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/clothing/mask/rogue/facemask/goldmask
	craftdiff = 3

// --------- BLACKSTEEL RECIPES-----------

/datum/anvil_recipe/armor/blacksteel/cuirass
	name = "Blacksteel Cuirass (+1 B.Steel)"
	req_bar = /obj/item/ingot/blacksteel
	additional_items = list(/obj/item/ingot/blacksteel)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/blacksteel_half_plate
	craftdiff = 5

/datum/anvil_recipe/armor/blacksteel/modern/platechest
	name = "Blacksteel Plate Armor (+3 B.Steel)"
	req_bar = /obj/item/ingot/blacksteel
	additional_items = list(/obj/item/ingot/blacksteel, /obj/item/ingot/blacksteel, /obj/item/ingot/blacksteel)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/modern/blacksteel_full_plate
	craftdiff = 5


/datum/anvil_recipe/armor/blacksteel/modern/plategloves
	name = "Blacksteel Plate Gauntlets"
	req_bar = /obj/item/ingot/blacksteel
	created_item = /obj/item/clothing/gloves/roguetown/blacksteel/modern/plategloves
	craftdiff = 5

/datum/anvil_recipe/armor/blacksteel/modern/platelegs
	name = "Blacksteel Plate Chausses (+1 B.Steel)"
	req_bar = /obj/item/ingot/blacksteel
	additional_items = list(/obj/item/ingot/blacksteel)
	created_item = /obj/item/clothing/under/roguetown/platelegs/blacksteel/modern
	craftdiff = 5

/datum/anvil_recipe/armor/blacksteel/modern/armet
	name = "Blacksteel Armet (+1 B.Steel)"
	req_bar = /obj/item/ingot/blacksteel
	additional_items = list(/obj/item/ingot/blacksteel)
	created_item = /obj/item/clothing/head/roguetown/helmet/blacksteel/modern/armet
	craftdiff = 5

/datum/anvil_recipe/armor/blacksteel/modern/plateboots
	name = "Blacksteel Plate Boots"
	req_bar = /obj/item/ingot/blacksteel
	created_item = /obj/item/clothing/shoes/roguetown/boots/blacksteel/modern/plateboots
	craftdiff = 5


/datum/anvil_recipe/armor/blacksteel/platechest
	name = "Ancient Blacksteel Plate Armor (+3 B.Steel)"
	req_bar = /obj/item/ingot/blacksteel
	additional_items = list(/obj/item/ingot/blacksteel, /obj/item/ingot/blacksteel, /obj/item/ingot/blacksteel)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/blacksteel_full_plate
	craftdiff = 5

/datum/anvil_recipe/armor/blacksteel/platelegs
	name = "Ancient Blacksteel Plate Chausses (+1 B.Steel)"
	req_bar = /obj/item/ingot/blacksteel
	additional_items = list(/obj/item/ingot/blacksteel)
	created_item = /obj/item/clothing/under/roguetown/platelegs/blacksteel
	craftdiff = 5

/datum/anvil_recipe/armor/blacksteel/bucket
	name = "Ancient Blacksteel Bucket Helmet (+1 B.Steel)"
	req_bar = /obj/item/ingot/blacksteel
	additional_items = list(/obj/item/ingot/blacksteel)
	created_item = /obj/item/clothing/head/roguetown/helmet/blacksteel/bucket
	craftdiff = 5

/datum/anvil_recipe/armor/blacksteel/plategloves
	name = "Ancient Blacksteel Plate Gauntlets"
	req_bar = /obj/item/ingot/blacksteel
	created_item = /obj/item/clothing/gloves/roguetown/blacksteel/plategloves
	craftdiff = 5

/datum/anvil_recipe/armor/blacksteel/plateboots
	name = "Ancient Blacksteel Plate Boots"
	req_bar = /obj/item/ingot/blacksteel
	created_item = /obj/item/clothing/shoes/roguetown/boots/blacksteel/plateboots
	craftdiff = 5
