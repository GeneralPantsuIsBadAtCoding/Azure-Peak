/datum/anvil_recipe/weapons
	appro_skill = /datum/skill/craft/weaponsmithing  // inheritance yay !!
	craftdiff = 1
	i_type = "Weapons"

/// IRON WEAPONS

/datum/anvil_recipe/weapons/iron/sword
	name = "Sword"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/sword/iron

/datum/anvil_recipe/weapons/iron/swordshort
	name = "Short sword"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/sword/iron/short
	craftdiff = 0

/datum/anvil_recipe/weapons/iron/messer
	name = "Messer"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/sword/iron/messer
	craftdiff = 0

/datum/anvil_recipe/weapons/iron/dagger
	name = "Dagger"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/huntingknife/idagger
	createditem_num = 1
	craftdiff = 0

/datum/anvil_recipe/weapons/ironflail
	name = "Flail"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/flail

/datum/anvil_recipe/weapons/iron/huntknife
	name = "Hunting knife"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/huntingknife
	createditem_num = 1

/datum/anvil_recipe/weapons/iron/zweihander
	name = "Zweihander (+2 Iron)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron, /obj/item/ingot/iron)
	created_item = /obj/item/rogueweapon/greatsword/zwei
	craftdiff = 3

/datum/anvil_recipe/weapons/iron/axe
	name = "Axe (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/stoneaxe/woodcut
	craftdiff = 0

/datum/anvil_recipe/weapons/iron/cudgel
	name = "Cudgel (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/mace/cudgel
	craftdiff = 0

/datum/anvil_recipe/weapons/iron/mace
	name = "Mace (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/mace
	craftdiff = 0

/datum/anvil_recipe/weapons/iron/spear
	name = "Spear (+1 Small Log)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/spear
	craftdiff = 0

/datum/anvil_recipe/weapons/iron/bardiche
	name = "Bardiche (+1 Iron, +1 Small Log)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/halberd/bardiche
	craftdiff = 2

/datum/anvil_recipe/weapons/iron/lucerne
	name = "Lucerne (+1 Iron, +1 Small Log)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/eaglebeak/lucerne
	craftdiff = 2

/datum/anvil_recipe/weapons/iron/polemace
	name = "Warclub (+1 Small Log)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/mace/goden

/datum/anvil_recipe/weapons/iron/tossblade
	name = "Iron Tossblades 4x"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/huntingknife/throwingknife/iron
	craftdiff = 0
	createditem_num = 4

/datum/anvil_recipe/weapons/iron/javelin
	name = "Iron Javelin (+1 Small Log)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/ammo_casing/caseless/rogue/javelin
	craftdiff = 1

/// STEEL WEAPONS

/datum/anvil_recipe/weapons/steel/dagger
	name = "Dagger"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/huntingknife/idagger/steel
	createditem_num = 1

/datum/anvil_recipe/weapons/steel/daggerparrying
	name = "Parrying Dagger (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/huntingknife/idagger/steel/parrying
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/katar
	name = "Katar"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/katar
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/steelknuckle
	name = "Steel Knuckle"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/knuckles
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/rapier
	name = "Rapier"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/rapier
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/cutlass
	name = "Cutlass"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/cutlass
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/swordshort
	name = "Steel Short Sword"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/short
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/falchion
	name = "Falchion"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/falchion
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/sword
	name = "Sword"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/saber
	name = "Sabre"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/sabre
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/flail
	name = "Flail"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/flail/sflail
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/bastardsword
	name = "Bastard Sword (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/sword/long
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/battleaxe
	name = "Battle Axe (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/stoneaxe/battle
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/combatknife
	name = "Combat Knife (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/huntingknife/combat
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/mace
	name = "Mace (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/mace/steel
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/greatsword
	name = "Greatsword (+2 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/greatsword
	craftdiff = 4

/datum/anvil_recipe/weapons/steel/steelzweihander
	name = "Zweihander (+2 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/greatsword/grenz
	craftdiff = 4

/datum/anvil_recipe/weapons/estoc
	name = "Estoc (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/estoc
	craftdiff = 4

/datum/anvil_recipe/weapons/buckler
	name = "Buckler (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/greatsword/grenz
	craftdiff = 4

/datum/anvil_recipe/weapons/steel/axe
	name = "Axe (+1 Stick)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/stoneaxe/woodcut/steel
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/pulaski
	name = "Pulaski axe (+1 Stick)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/stoneaxe/woodcut/pick

/datum/anvil_recipe/weapons/steel/billhook
	name = "Billhook (+1 Small Log)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/spear/billhook
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/halberd
	name = "Halberd (+1 Steel, +1 Small Log)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/halberd
	craftdiff = 4

/datum/anvil_recipe/weapons/steel/eaglebeak
	name = "Eagle's Beak (+1 Steel, +1 Small Log)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/eaglebeak
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/grandmace
	name = "Grand Mace (+1 Steel, +1 Small Log)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/mace/goden/steel
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/tossblade
	name = "Steel Tossblades 4x"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/huntingknife/throwingknife/steel
	craftdiff = 0
	createditem_num = 4

/datum/anvil_recipe/weapons/steel/javelin
	name = "Steel Javelin (+1 Small Log)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/ammo_casing/caseless/rogue/javelin/steel
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/fishspear
	name = "Fishing Spear (+1 Steel, +1 Small Log)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/fishspear
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/romphaia
	name = "Romphaia (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/sword/long/romphaia
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/falx
	name = "Falx"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/falx
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/glaive
	name = "Glaive (+2 Steel, +1 Small Log)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/halberd/glaive
/// UPGRADED WEAPONS

//GOLD
/datum/anvil_recipe/weapons/decsword
	name = "Decorated Sword (+1 Gold)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/gold)
	created_item = /obj/item/rogueweapon/sword/decorated
	craftdiff = 2

/datum/anvil_recipe/weapons/decsword
	name = "Decorated Sword (+1 Steel Sword)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/rogueweapon/sword)
	created_item = /obj/item/rogueweapon/sword/decorated
	craftdiff = 2

/datum/anvil_recipe/weapons/decsaber
	name = "Decorated Sabre (+1 Gold)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/gold)
	created_item = /obj/item/rogueweapon/sword/sabre/dec
	craftdiff = 2

/datum/anvil_recipe/weapons/decsaber
	name = "Decorated Sabre (+1 Steel Sabre)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/rogueweapon/sword/sabre)
	created_item = /obj/item/rogueweapon/sword/sabre/dec
	craftdiff = 2

/datum/anvil_recipe/weapons/decrapier
	name = "Decorated Rapier (+1 Gold)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/gold)
	created_item = /obj/item/rogueweapon/sword/rapier/dec
	craftdiff = 2

/datum/anvil_recipe/weapons/decrapier
	name = "Decorated Rapier (+1 Steel Rapier)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/rogueweapon/sword/rapier)
	created_item = /obj/item/rogueweapon/sword/rapier/dec
	craftdiff = 2

// SILVER
/datum/anvil_recipe/weapons/silver/elfsaber
	name = "Elvish Saber (+1 Silver)"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/ingot/silver)
	created_item = /obj/item/rogueweapon/sword/sabre/elf
	craftdiff = 3

/datum/anvil_recipe/weapons/silver/elfdagger
	name = "Elvish Dagger"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/rogueweapon/huntingknife/idagger/silver/elvish
	craftdiff = 3

/datum/anvil_recipe/weapons/silver/dagger
	name = "Silver Dagger"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/rogueweapon/huntingknife/idagger/silver
	craftdiff = 2

/datum/anvil_recipe/weapons/silver/sword
	name = "Silver Sword (+1 Silver)"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/ingot/silver)
	created_item = /obj/item/rogueweapon/sword/silver
	craftdiff = 3

/datum/anvil_recipe/weapons/silver/waraxe
	name = "Silver War Axe (+1 Silver, +1 Stick)"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/ingot/silver, /obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/stoneaxe/silver
	craftdiff = 3

/datum/anvil_recipe/weapons/silver/warhammer
	name = "Silver War Hammer (+1 Silver, +1 Stick)"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/ingot/silver, /obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/mace/silver
	craftdiff = 3

/datum/anvil_recipe/weapons/silver/tossblade
	name = "Silver Tossblades 4x"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/rogueweapon/huntingknife/throwingknife/psydon
	craftdiff = 3
	createditem_num = 4

/datum/anvil_recipe/weapons/silver/javelin
	name = "Silver Javelin (+1 Small Log)"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/ammo_casing/caseless/rogue/javelin/silver
	craftdiff = 3


// ------ BRONZE ------

/datum/anvil_recipe/weapons/gladius
	name = "Gladius"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/rogueweapon/sword/gladius
	craftdiff = 2

/datum/anvil_recipe/weapons/bronze/spear
	name = "Bronze Spear (+1 Bronze, +1 Small Log)"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/ingot/bronze, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/spear/bronze
	craftdiff = 0

/datum/anvil_recipe/weapons/bronze/bronzeknuckle
	name = "Bronze Knuckle"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/rogueweapon/knuckles/bronzeknuckles
	craftdiff = 2

/// SHIELDS
/datum/anvil_recipe/weapons/steel/kiteshield
	name = "Kite Shield (+1 Steel, +1 Cured Leather)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/natural/hide/cured)
	created_item = /obj/item/rogueweapon/shield/tower/metal
	craftdiff = 3

/datum/anvil_recipe/weapons/iron/towershield
	name = "Tower Shield (+1 Small Log)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/shield/tower
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/buckler
	name = "Buckler (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/shield/buckler
	craftdiff = 2

/// CROSSBOWS
/datum/anvil_recipe/weapons/steel/xbow
	name = "Crossbow (+1 Small Log, +1 Fiber)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/small, /obj/item/natural/fibers)
	created_item = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow

/datum/anvil_recipe/weapons/iron/bolts
	name = "Crossbow Bolts 10x (+2 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick, /obj/item/grown/log/tree/stick)
	created_item = /obj/item/ammo_casing/caseless/rogue/bolt
	createditem_num = 10
	i_type = "Ammo"

/// BOWS
/datum/anvil_recipe/weapons/iron/arrows
	name = "Arrows 10x (+2 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick, /obj/item/grown/log/tree/stick)
	created_item = /obj/item/ammo_casing/caseless/rogue/arrow/iron
	createditem_num = 10
	i_type = "Ammo"
	craftdiff = 0

/// SLINGS
/datum/anvil_recipe/weapons/iron/slingbullets
	name = "Iron Sling Bullets 10x"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/ammo_casing/caseless/rogue/sling_bullet/iron
	createditem_num = 10
	i_type = "Ammo"
	craftdiff = 0

//Rarity
/datum/anvil_recipe/valuables/steel/execution
	name = "Execution Sword (+1 Steel, +1 Iron)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/iron, /obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/sword/long/exe
	i_type = "Weapons"

// BLACKSTEEL

/datum/anvil_recipe/weapons/blackflamb
	name = "Flamberge"
	req_bar = /obj/item/ingot/blacksteel
	additional_items = list(/obj/item/ingot/blacksteel, /obj/item/roguegem)
	created_item = /obj/item/rogueweapon/sword/long/blackflamb
	craftdiff = 5


/datum/anvil_recipe/weapons/swarhammer
	name = "Warhammer (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/mace/warhammer/steel
	craftdiff = 2
	i_type = "Weapons"

/datum/anvil_recipe/weapons/warhammer
	name = "Warhammer (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/mace/warhammer
	i_type = "Weapons"
