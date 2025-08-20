/datum/anvil_recipe/weapons
	abstract_type = /datum/anvil_recipe/weapons
	appro_skill = /datum/skill/craft/weaponsmithing  // inheritance yay !!
	craftdiff = 1
	i_type = "Weapons"

// Decrepit Alloy and Purified Decrepit Alloy

/datum/anvil_recipe/weapons/aalloy/flail
	name = "Flail, Decrepit"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/aalloy
	created_item = /obj/item/rogueweapon/flail/aflail
	craftdiff = 0


/datum/anvil_recipe/weapons/paalloy/flail/
	name = "Flail, Ancient"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/purifiedaalloy
	created_item = /obj/item/rogueweapon/flail/sflail/paflail
	craftdiff = 0


/datum/anvil_recipe/weapons/aalloy/dagger
	name = "Dagger, Decrepit"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/aalloy
	created_item = /obj/item/rogueweapon/huntingknife/idagger/adagger
	craftdiff = 0


/datum/anvil_recipe/weapons/paalloy/dagger
	name = "Dagger, Ancient"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/purifiedaalloy
	created_item = /obj/item/rogueweapon/huntingknife/idagger/steel/padagger
	craftdiff = 0

/datum/anvil_recipe/weapons/aalloy/knuckles
	name = "Knuckles, Decrepit"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/aalloy
	created_item = /obj/item/rogueweapon/knuckles/aknuckles
	craftdiff = 0


/datum/anvil_recipe/weapons/paalloy/knuckles
	name = "Knuckles, Ancient"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/purifiedaalloy
	created_item = /obj/item/rogueweapon/knuckles/paknuckles
	craftdiff = 0

/datum/anvil_recipe/weapons/aalloy/gladius
	name = "Gladius, Decrepit"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/aalloy
	created_item = /obj/item/rogueweapon/sword/short/gladius/agladius
	craftdiff = 0


/datum/anvil_recipe/weapons/paalloy/gladius
	name = "Gladius, Ancient"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/purifiedaalloy
	created_item = /obj/item/rogueweapon/sword/short/gladius/pagladius
	craftdiff = 0

/datum/anvil_recipe/weapons/aalloy/shortsword
	name = "Shortsword, Decrepit"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/aalloy
	created_item = /obj/item/rogueweapon/sword/short/ashort
	craftdiff = 0


/datum/anvil_recipe/weapons/paalloy/shortsword
	name = "Shortsword, Ancient"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/purifiedaalloy
	created_item = /obj/item/rogueweapon/sword/short/pashortsword
	craftdiff = 0

/datum/anvil_recipe/weapons/aalloy/khopesh
	name = "Khopesh, Decrepit"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/aalloy
	created_item = /obj/item/rogueweapon/sword/sabre/alloy
	craftdiff = 0


/datum/anvil_recipe/weapons/paalloy/khopesh
	name = "Khopesh, Ancient"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/purifiedaalloy
	created_item = /obj/item/rogueweapon/sword/sabre/palloy
	craftdiff = 0

/datum/anvil_recipe/weapons/aalloy/handaxe
	name = "Axe, Decrepit"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/aalloy
	created_item = /obj/item/rogueweapon/stoneaxe/woodcut/aaxe
	craftdiff = 0


/datum/anvil_recipe/weapons/paalloy/handaxe
	name = "Axe, Ancient"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/purifiedaalloy
	created_item = /obj/item/rogueweapon/stoneaxe/woodcut/steel/paaxe
	craftdiff = 0

/datum/anvil_recipe/weapons/aalloy/mace
	name = "Mace, Decrepit"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/aalloy
	created_item = /obj/item/rogueweapon/mace/alloy
	craftdiff = 0


/datum/anvil_recipe/weapons/paalloy/mace
	name = "Mace, Ancient"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/purifiedaalloy
	created_item = /obj/item/rogueweapon/mace/steel/palloy
	craftdiff = 0

/datum/anvil_recipe/weapons/aalloy/warhammer
	name = "Warhammer, Decrepit"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/aalloy
	created_item = /obj/item/rogueweapon/mace/warhammer/alloy
	craftdiff = 0


/datum/anvil_recipe/weapons/paalloy/warhammer
	name = "Warhammer, Ancient"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/purifiedaalloy
	created_item = /obj/item/rogueweapon/mace/warhammer/steel/paalloy
	craftdiff = 0

/datum/anvil_recipe/weapons/aalloy/tossblade
	name = "Tossblades, Decrepit (x4)"
	req_bar = /obj/item/ingot/aalloy
	created_item = /obj/item/rogueweapon/huntingknife/throwingknife/aalloy
	craftdiff = 0
	createditem_num = 4

/datum/anvil_recipe/weapons/paalloy/tossblade
	name = "Tossblades, Ancient (x4)"
	req_bar = /obj/item/ingot/purifiedaalloy
	created_item = /obj/item/rogueweapon/huntingknife/throwingknife/steel/palloy
	craftdiff = 0
	createditem_num = 4

/datum/anvil_recipe/weapons/aalloy/gsw
	name = "Greatsword, Decrepit (+2 Alloy)"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/aalloy
	created_item = /obj/item/rogueweapon/greatsword/aalloy
	additional_items = list(/obj/item/ingot/aalloy, /obj/item/ingot/aalloy)
	craftdiff = 3


/datum/anvil_recipe/weapons/paalloy/gsw
	name = "Greatsword, Ancient (+2 Purified Alloy)"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/purifiedaalloy
	created_item = /obj/item/rogueweapon/greatsword/paalloy
	additional_items = list(/obj/item/ingot/purifiedaalloy, /obj/item/ingot/purifiedaalloy)
	craftdiff = 4


/datum/anvil_recipe/weapons/aalloy/bardiche
	name = "Bardiche, Decrepit (+1 log, +1 Alloy)"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/aalloy
	created_item = /obj/item/rogueweapon/halberd/bardiche/aalloy
	additional_items = list(/obj/item/ingot/iron, /obj/item/grown/log/tree/small)
	craftdiff = 0


/datum/anvil_recipe/weapons/paalloy/bardiche
	name = "Bardiche, Ancient (+1 log, +1 Purified Alloy)"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/purifiedaalloy
	created_item = /obj/item/rogueweapon/halberd/bardiche/paalloy
	additional_items = list(/obj/item/ingot/iron, /obj/item/grown/log/tree/small)
	craftdiff = 0

/datum/anvil_recipe/weapons/aalloy/grandmace
	name = "Grand Mace, Decrepit (+1 Alloy, +1 Small Log)"
	req_bar = /obj/item/ingot/aalloy
	additional_items = list(/obj/item/ingot/aalloy, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/mace/goden/aalloy
	craftdiff = 2

/datum/anvil_recipe/weapons/paalloy/grandmace
	name = "Grand Mace, Purified (+1 Purified Alloy, +1 Small Log)"
	req_bar = /obj/item/ingot/purifiedaalloy
	additional_items = list(/obj/item/ingot/purifiedaalloy, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/mace/goden/steel/paalloy
	craftdiff = 3

/datum/anvil_recipe/weapons/aalloy/spear
	name = "Spear, Decrepit(+1 Small Log)"
	req_bar = /obj/item/ingot/aalloy
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/spear/aalloy
	craftdiff = 0

/datum/anvil_recipe/weapons/paalloy/spear
	name = "Spear, Ancient (+1 Small Log)"
	req_bar = /obj/item/ingot/purifiedaalloy
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/spear/paalloy
	craftdiff = 0

/datum/anvil_recipe/weapons/aalloy/javelin
	name = "Javelin, Decrepit (+1 Small Log) (x2)"
	req_bar = /obj/item/ingot/aalloy
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/ammo_casing/caseless/rogue/javelin/aalloy
	createditem_num = 2
	craftdiff = 1

/datum/anvil_recipe/weapons/paalloy/javelin
	name = "Javelin, Ancient (+1 Small Log) (x2)"
	req_bar = /obj/item/ingot/purifiedaalloy
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/ammo_casing/caseless/rogue/javelin/steel/paalloy
	createditem_num = 2
	craftdiff = 1


/// COPPER WEAPONS
/datum/anvil_recipe/weapons/copper/caxe
	name = "Hatchet, Copper (+1 Copper)"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/copper
	additional_items = list(/obj/item/ingot/copper)
	created_item = /obj/item/rogueweapon/stoneaxe/handaxe/copper
	craftdiff = 0

/datum/anvil_recipe/weapons/copper/cbludgeon
	name = "Budgeon, Copper (+1 Stick)"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/copper
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/mace/cudgel/copper
	craftdiff = 0

/datum/anvil_recipe/weapons/copper/cdagger
	name = "Knife, Copper (x2)"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/copper
	created_item = /obj/item/rogueweapon/huntingknife/copper
	createditem_num = 2
	craftdiff = 0

/datum/anvil_recipe/weapons/copper/cmesser
	name = "Messer, Copper"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/copper
	created_item = /obj/item/rogueweapon/sword/short/messer/copper
	craftdiff = 0

/datum/anvil_recipe/weapons/copper/cspears
	name = "Spear, Copper (+1 Small Log) (x2)"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/copper
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/spear/stone/copper
	createditem_num = 2
	craftdiff = 0

/datum/anvil_recipe/weapons/copper/crhomphaia
	name = "Rhomphaia, Copper (+1 Copper)"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/copper
	additional_items = list(/obj/item/ingot/copper)
	created_item = /obj/item/rogueweapon/sword/long/rhomphaia/copper
	craftdiff = 0

/// IRON WEAPONS

/datum/anvil_recipe/weapons/iron/sword
	name = "Sword, Iron"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/sword/iron

/datum/anvil_recipe/weapons/iron/swordshort
	name = "Shortsword, Iron"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/sword/short/iron
	craftdiff = 0

/datum/anvil_recipe/weapons/iron/messer
	name = "Messer, Iron"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/sword/short/messer/iron
	craftdiff = 0

/datum/anvil_recipe/weapons/iron/dagger
	name = "Dagger, Iron"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/huntingknife/idagger
	createditem_num = 1
	craftdiff = 0

/datum/anvil_recipe/weapons/ironflail
	name = "Flail, Iron"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/flail

/datum/anvil_recipe/weapons/iron/huntknife
	name = "Hunting Knife, Iron"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/huntingknife
	createditem_num = 1

/datum/anvil_recipe/weapons/iron/zweihander
	name = "Zweihander, Iron (+2 Iron)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron, /obj/item/ingot/iron)
	created_item = /obj/item/rogueweapon/greatsword/zwei
	craftdiff = 3

/datum/anvil_recipe/weapons/iron/axe
	name = "Axe, Iron (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/stoneaxe/woodcut
	craftdiff = 0

/datum/anvil_recipe/weapons/iron/greataxe
	name = "Greataxe, Iron (+1 Iron, +1 Small Log)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/greataxe
	craftdiff = 3

/datum/anvil_recipe/weapons/iron/cudgel
	name = "Cudgel, Iron (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/mace/cudgel
	craftdiff = 0

/datum/anvil_recipe/weapons/iron/mace
	name = "Mace, Iron (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/mace
	craftdiff = 0

/datum/anvil_recipe/weapons/warhammer
	name = "Warhammer, Iron (+1 Stick)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/mace/warhammer
	i_type = "Weapons"

/datum/anvil_recipe/weapons/iron/spear
	name = "Spear, Iron (+1 Small Log)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/spear
	craftdiff = 0

/datum/anvil_recipe/weapons/iron/bardiche
	name = "Bardiche, Iron (+1 Iron, +1 Small Log)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/halberd/bardiche
	craftdiff = 2

/datum/anvil_recipe/weapons/iron/lucerne
	name = "Lucerne, Iron (+1 Iron, +1 Small Log)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/eaglebeak/lucerne
	craftdiff = 2

/datum/anvil_recipe/weapons/iron/polemace
	name = "Goedendag, Iron (+1 Small Log)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/mace/goden

/datum/anvil_recipe/weapons/iron/tossblade
	name = "Tossblades, Iron (x4)"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/huntingknife/throwingknife
	craftdiff = 0
	createditem_num = 4

/datum/anvil_recipe/weapons/iron/javelin
	name = "Javelin, Iron (+1 Small Log) (x2)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/ammo_casing/caseless/rogue/javelin
	createditem_num = 2
	craftdiff = 1

/// STEEL WEAPONS

/datum/anvil_recipe/weapons/steel/dagger
	name = "Dagger, Steel"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/huntingknife/idagger/steel
	createditem_num = 1

/datum/anvil_recipe/weapons/steel/daggerparrying
	name = "Parrying Dagger, Steel (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/huntingknife/idagger/steel/parrying
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/katar
	name = "Katar, Steel"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/katar
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/punchdagger
	name = "Punch Dagger"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/katar/punchdagger
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/steelknuckle
	name = "Knuckles, Steel"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/knuckles
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/hurlbat
	name = "Hurlbat"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/stoneaxe/hurlbat
	craftdiff = 4

/datum/anvil_recipe/weapons/steel/rapier
	name = "Rapier, Steel"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/rapier
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/cutlass
	name = "Cutlass, Steel"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/cutlass
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/swordshort
	name = "Shortsword, Steel"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/short
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/falchion
	name = "Falchion, Steel"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/short/falchion
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/messer
	name = "Messer, Steel"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/short/messer
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/sword
	name = "Sword, Steel"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/saber
	name = "Sabre, Steel"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/sabre
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/flail
	name = "Flail, Steel"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/flail/sflail
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/longsword
	name = "Longsword, Steel (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/sword/long
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/kriegmesser
	name = "Kriegmesser, Steel (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/sword/long/kriegmesser
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/battleaxe
	name = "Battle Axe, Steel (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/stoneaxe/battle
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/combatknife
	name = "Combat Knife, Steel (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/huntingknife/combat
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/mace
	name = "Mace, Steel (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/mace/steel
	craftdiff = 2

/datum/anvil_recipe/weapons/swarhammer
	name = "Warhammer, Steel (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/mace/warhammer/steel
	craftdiff = 2
	i_type = "Weapons"

/datum/anvil_recipe/weapons/steel/greatsword
	name = "Greatsword, Steel (+2 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/greatsword
	craftdiff = 4

/*datum/anvil_recipe/weapons/steel/steelzweihander //leaving this here for now; discussion with devgeneral.
	name = "Zweihander, Steel (+2 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/greatsword/grenz
	craftdiff = 4*/

/datum/anvil_recipe/weapons/estoc
	name = "Estoc, Steel (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/estoc
	craftdiff = 4

/datum/anvil_recipe/weapons/steel/axe
	name = "Axe, Steel (+1 Stick)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/stoneaxe/woodcut/steel
	craftdiff = 2

/*/datum/anvil_recipe/weapons/steel/pulaski // We left the other holy steel recipes in, so I'll leave this for now.
	name = "Pulaski axe (+1 Stick)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/stoneaxe/woodcut/pick */

/datum/anvil_recipe/weapons/steel/greataxe
	name = "Greataxe, Steel (+1 Steel, +1 Small Log)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/greataxe/steel
	craftdiff = 4

/datum/anvil_recipe/weapons/steel/greataxe/doublehead
	name = "Double-Headed Greataxe, Steel (+2 Steel, +1 Small Log)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/greataxe/steel/doublehead
	craftdiff = 4

/datum/anvil_recipe/weapons/steel/billhook
	name = "Billhook, Steel (+1 Small Log)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/spear/billhook
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/halberd
	name = "Halberd, Steel (+1 Steel, +1 Small Log)"
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
	name = "Grand Mace, Steel (+1 Steel, +1 Small Log)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/mace/goden/steel
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/partizan
	name = "Partizan, Steel (+1 Steel, +1 Small Log)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/spear/partizan
	craftdiff = 4

/datum/anvil_recipe/weapons/steel/naginata
	name = "Naginata, Steel (+1 Big Log)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/) //looong spear
	created_item = /obj/item/rogueweapon/spear/naginata
	craftdiff = 4

/datum/anvil_recipe/weapons/steel/boarspear
	name = "Boar Spear, Steel (+1 Steel, +1 Small Log)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/spear/boar
	craftdiff = 4

/datum/anvil_recipe/weapons/steel/lance
	name = "Lance, Steel (+1 Steel, +1 Small Log)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/spear/lance
	craftdiff = 4

/datum/anvil_recipe/weapons/steel/tossblade
	name = "Tossblade, Steel (x4)"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/huntingknife/throwingknife/steel
	craftdiff = 0
	createditem_num = 4

/datum/anvil_recipe/weapons/steel/javelin
	name = "Javelin, Steel (+1 Small Log) (x2)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/ammo_casing/caseless/rogue/javelin/steel
	createditem_num = 2
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/fishspear
	name = "Fishing Spear, Steel (+1 Steel, +1 Small Log)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/fishspear
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/rhomphaia
	name = "Rhomphaia, Steel (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/sword/long/rhomphaia
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/falx
	name = "Falx, Steel"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/sword/falx
	craftdiff = 2
/// UPGRADED WEAPONS

//GOLD
/datum/anvil_recipe/weapons/decsword
	name = "Sword, Decorated (+1 Steel Sword)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/rogueweapon/sword)
	created_item = /obj/item/rogueweapon/sword/decorated
	craftdiff = 2

/datum/anvil_recipe/weapons/decsaber
	name = "Sabre, Decorated (+1 Steel Sabre)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/rogueweapon/sword/sabre)
	created_item = /obj/item/rogueweapon/sword/sabre/dec
	craftdiff = 2

/datum/anvil_recipe/weapons/decrapier
	name = "Rapier, Decorated (+1 Steel Rapier)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/rogueweapon/sword/rapier)
	created_item = /obj/item/rogueweapon/sword/rapier/dec
	craftdiff = 2

/datum/anvil_recipe/weapons/declongsword
	name = "Longsword, Decorated (+1 Steel Longsword)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/rogueweapon/sword/long)
	created_item = /obj/item/rogueweapon/sword/long/dec
	craftdiff = 2

// SILVER
/datum/anvil_recipe/weapons/silver/elfsaber
	name = "Sabre, Elvish (+1 Silver)"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/ingot/silver)
	created_item = /obj/item/rogueweapon/sword/sabre/elf
	craftdiff = 3

/datum/anvil_recipe/weapons/silver/elfdagger
	name = "Dagger, Elvish"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/rogueweapon/huntingknife/idagger/silver/elvish
	craftdiff = 3

/datum/anvil_recipe/weapons/silver/dagger
	name = "Dagger, Silver"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/rogueweapon/huntingknife/idagger/silver
	craftdiff = 2

/datum/anvil_recipe/weapons/silver/sword
	name = "Sword, Silver (+1 Silver)"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/ingot/silver)
	created_item = /obj/item/rogueweapon/sword/silver
	craftdiff = 3

/datum/anvil_recipe/weapons/silver/waraxe
	name = "War Axe, Silver (+1 Silver, +1 Stick)"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/ingot/silver, /obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/stoneaxe/woodcut/silver
	craftdiff = 3

/datum/anvil_recipe/weapons/silver/warhammer
	name = "Warhammer, Silver (+1 Silver, +1 Stick)"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/ingot/silver, /obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/mace/silver
	craftdiff = 3

/datum/anvil_recipe/weapons/silver/tossblade
	name = "Tossblades, Silver (x4)"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/rogueweapon/huntingknife/throwingknife/psydon
	craftdiff = 3
	createditem_num = 4

/datum/anvil_recipe/weapons/silver/javelin
	name = "Javelin, Silver (+1 Small Log)"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/ammo_casing/caseless/rogue/javelin/silver
	craftdiff = 3


// ------ BRONZE ------

/datum/anvil_recipe/weapons/gladius
	name = "Gladius, Bronze"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/rogueweapon/sword/short/gladius
	craftdiff = 2

/datum/anvil_recipe/weapons/bronze/spear
	name = "Spear, Bronze (+1 Bronze, +1 Small Log)"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/ingot/bronze, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/spear/bronze
	craftdiff = 0

/datum/anvil_recipe/weapons/bronze/bronzeknuckle
	name = "Knuckles, Bronze"
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

/datum/anvil_recipe/weapons/alloy/shield
	name = "Shield, Decrepit (+1 Alloy, +1 Cured Leather)"
	req_bar = /obj/item/ingot/aalloy
	additional_items = list(/obj/item/ingot/aalloy, /obj/item/natural/hide/cured)
	created_item = /obj/item/rogueweapon/shield/tower/metal/alloy
	craftdiff = 1

/datum/anvil_recipe/weapons/alloy/shield
	name = "Shield, Ancient (+1 Purified Alloy, +1 Cured Leather)"
	req_bar = /obj/item/ingot/purifiedaalloy
	additional_items = list(/obj/item/ingot/purifiedaalloy, /obj/item/natural/hide/cured)
	created_item = /obj/item/rogueweapon/shield/tower/metal/palloy
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

/datum/anvil_recipe/weapons/iron/roundshield
	name = "Shield, Iron (+1 Iron)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/rogueweapon/shield/iron
	craftdiff = 2

/// CROSSBOWS
/datum/anvil_recipe/weapons/steel/xbow
	name = "Crossbow (+1 Small Log, +1 Fiber)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/small, /obj/item/natural/fibers)
	created_item = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow

/datum/anvil_recipe/weapons/iron/bolts
	name = "Crossbow Bolts (+2 Stick) (x10)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick, /obj/item/grown/log/tree/stick)
	created_item = /obj/item/ammo_casing/caseless/rogue/bolt
	createditem_num = 10
	i_type = "Ammo"

/datum/anvil_recipe/weapons/aalloy/bolts
	name = "Bolts, Decrepit (+2 Stick) (x10)"
	req_bar = /obj/item/ingot/aalloy
	additional_items = list(/obj/item/grown/log/tree/stick, /obj/item/grown/log/tree/stick)
	created_item = /obj/item/ammo_casing/caseless/rogue/bolt/aalloy
	createditem_num = 10
	i_type = "Ammo"

/datum/anvil_recipe/weapons/paalloy/bolts
	name = "Bolts, Ancient (+2 Stick) (x10)"
	req_bar = /obj/item/ingot/purifiedaalloy
	additional_items = list(/obj/item/grown/log/tree/stick, /obj/item/grown/log/tree/stick)
	created_item = /obj/item/ammo_casing/caseless/rogue/bolt/paalloy
	createditem_num = 10
	i_type = "Ammo"

/// BOWS
/datum/anvil_recipe/weapons/iron/arrows
	name = "Broadhead Arrows, Iron (+2 Stick) (x10)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick, /obj/item/grown/log/tree/stick)
	created_item = /obj/item/ammo_casing/caseless/rogue/arrow/iron
	createditem_num = 10
	i_type = "Ammo"
	craftdiff = 1

/datum/anvil_recipe/weapons/aalloy/arrows
	name = "Broadhead Arrows, Decrepit (+2 Stick) (x10)"
	req_bar = /obj/item/ingot/aalloy
	additional_items = list(/obj/item/grown/log/tree/stick, /obj/item/grown/log/tree/stick)
	created_item = /obj/item/ammo_casing/caseless/rogue/arrow/iron/aalloy
	createditem_num = 10
	i_type = "Ammo"
	craftdiff = 1

/datum/anvil_recipe/weapons/steel/arrows
	name = "Bodkin Arrows, Steel (+2 Stick) (x10)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/stick, /obj/item/grown/log/tree/stick)
	created_item = /obj/item/ammo_casing/caseless/rogue/arrow/steel
	createditem_num = 10
	i_type = "Ammo"
	craftdiff = 2

/datum/anvil_recipe/weapons/paalloy/arrows
	name = "Bodkin Arrows, Ancient (+2 Stick) (x10)"
	req_bar = /obj/item/ingot/purifiedaalloy
	additional_items = list(/obj/item/grown/log/tree/stick, /obj/item/grown/log/tree/stick)
	created_item = /obj/item/ammo_casing/caseless/rogue/arrow/steel/paalloy
	createditem_num = 10
	i_type = "Ammo"
	craftdiff = 2

/// SLINGS
/datum/anvil_recipe/weapons/iron/slingbullets
	name = "Sling Bullets, Iron (x10)"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/ammo_casing/caseless/rogue/sling_bullet/iron
	createditem_num = 10
	i_type = "Ammo"
	craftdiff = 0

/datum/anvil_recipe/weapons/aalloy/slingbullets
	name = "Sling Bullets, Decrepit (x10)"
	req_bar = /obj/item/ingot/aalloy
	created_item = /obj/item/ammo_casing/caseless/rogue/sling_bullet/aalloy
	createditem_num = 10
	i_type = "Ammo"
	craftdiff = 0

/datum/anvil_recipe/weapons/paalloy/slingbullets
	name = "Sling Bullets, Ancient (x10)"
	req_bar = /obj/item/ingot/purifiedaalloy
	created_item = /obj/item/ammo_casing/caseless/rogue/sling_bullet/paalloy
	createditem_num = 10
	i_type = "Ammo"
	craftdiff = 0

//Rarity
/datum/anvil_recipe/valuables/steel/execution
	name = "Execution Sword, Steel (+1 Steel, +1 Iron)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/iron, /obj/item/ingot/steel)
	created_item = /obj/item/rogueweapon/sword/long/exe
	i_type = "Weapons"

// BLACKSTEEL

/datum/anvil_recipe/weapons/blackflamb
	name = "Blacksteel Flamberge (+1 Blacksteel, +1 Ruby)"
	req_bar = /obj/item/ingot/blacksteel
	additional_items = list(/obj/item/ingot/blacksteel, /obj/item/roguegem/ruby)
	created_item = /obj/item/rogueweapon/sword/long/blackflamb
	craftdiff = 5

//Church Weapons forged from Holy Steel

/datum/anvil_recipe/weapons/holy/malum_sword
	name = "Forgefiend (+1 H. Steel)"
	req_bar = /obj/item/ingot/steelholy
	craftdiff = 3
	additional_items = list(/obj/item/ingot/steelholy)
	created_item = /obj/item/rogueweapon/sword/long/malumflamm
	i_type = "Weapons"
/*
/datum/anvil_recipe/weapons/holy/abyssor_katar
	name = "Barotrauma"
	req_bar = /obj/item/ingot/steelholy
	craftdiff = 3
	created_item = /obj/item/rogueweapon/katar/abyssor
	i_type = "Weapons"

/datum/anvil_recipe/weapons/holy/astrata_exe
	name = "Solar Judgement (+1 H. Steel)"
	req_bar = /obj/item/ingot/steelholy
	craftdiff = 3
	additional_items = list(/obj/item/ingot/steelholy)
	created_item = /obj/item/rogueweapon/sword/long/exe/astrata
	i_type = "Weapons"

/datum/anvil_recipe/weapons/holy/noc_kopesh
	name = "Moonlight Kopesh"
	req_bar = /obj/item/ingot/steelholy
	craftdiff = 3
	created_item = /obj/item/rogueweapon/sword/sabre/nockhopesh
	i_type = "Weapons"

/datum/anvil_recipe/weapons/holy/necra_flail
	name = "Swift End"
	req_bar = /obj/item/ingot/steelholy
	craftdiff = 3
	created_item = /obj/item/rogueweapon/flail/necraflail
	i_type = "Weapons"

/datum/anvil_recipe/weapons/holy/pestra_dagger
	name = "Plaguebringer Sickles"
	req_bar = /obj/item/ingot/steelholy
	craftdiff = 3
	created_item = /obj/item/rogueweapon/huntingknife/idagger/steel/pestrasickle
	i_type = "Weapons"

/datum/anvil_recipe/weapons/holy/dendor_scythe
	name = "Summer Scythe (+1 H. Steel, +1 Small Log)"
	req_bar = /obj/item/ingot/steelholy
	craftdiff = 3
	additional_items = list(/obj/item/ingot/steelholy, /obj/item/grown/log/tree/small)
	created_item = /obj/item/rogueweapon/halberd/bardiche/scythe
	i_type = "Weapons"

/datum/anvil_recipe/weapons/holy/xylix_whip
	name = "Cackle Lash"
	req_bar = /obj/item/ingot/steelholy
	craftdiff = 3
	created_item = /obj/item/rogueweapon/whip/xylix
	i_type = "Weapons"

/datum/anvil_recipe/weapons/holy/ravox_mace
	name = "Duel Settler (+1 H. Steel)"
	req_bar = /obj/item/ingot/steelholy
	craftdiff = 3
	additional_items = list(/obj/item/ingot/steelholy)
	created_item = /obj/item/rogueweapon/mace/goden/steel/ravox
	i_type = "Weapons"

/datum/anvil_recipe/weapons/holy/eora_knuckles
	name = "Close Caress"
	req_bar = /obj/item/ingot/steelholy
	craftdiff = 3
	created_item = /obj/item/rogueweapon/knuckles/eora
	i_type = "Weapons"
*/
//Psydonian weapon smithing
/datum/anvil_recipe/weapons/psy/axe
	name = "Psydonian War Axe (+1 B. Silver, +1 Stick)"
	req_bar = /obj/item/ingot/silverblessed
	craftdiff = 3
	created_item = /obj/item/rogueweapon/stoneaxe/battle/psyaxe
	additional_items = list(/obj/item/ingot/silverblessed, /obj/item/grown/log/tree/stick)
	i_type = "Weapons"

/datum/anvil_recipe/weapons/psy/mace
	name = "Psydonian Mace (+1 B. Silver, +1 Stick)"
	req_bar = /obj/item/ingot/silverblessed
	craftdiff = 3
	created_item = /obj/item/rogueweapon/mace/goden/psymace
	additional_items = list(/obj/item/ingot/silverblessed, /obj/item/grown/log/tree/stick)
	i_type = "Weapons"

/datum/anvil_recipe/weapons/psy/spear
	name = "Psydonian Spear (+1 Small Log)"
	req_bar = /obj/item/ingot/silverblessed
	craftdiff = 3
	created_item = /obj/item/rogueweapon/spear/psyspear
	additional_items = list(/obj/item/grown/log/tree/small)
	i_type = "Weapons"

/datum/anvil_recipe/weapons/psy/dagger
	name = "Psydonian Dagger"
	req_bar = /obj/item/ingot/silverblessed
	craftdiff = 3
	created_item = /obj/item/rogueweapon/huntingknife/idagger/silver/psydagger
	i_type = "Weapons"

/datum/anvil_recipe/weapons/psy/shortsword
	name = "Psydonian Shortsword"
	req_bar = /obj/item/ingot/silverblessed
	craftdiff = 3
	created_item = /obj/item/rogueweapon/sword/short/psy
	i_type = "Weapons"

/datum/anvil_recipe/weapons/psy/katar
	name = "Psydonian Katar"
	req_bar = /obj/item/ingot/silverblessed
	craftdiff = 3
	created_item = /obj/item/rogueweapon/katar/psydon
	i_type = "Weapons"

/datum/anvil_recipe/weapons/psy/knuckles
	name = "Psydonian Knuckles"
	req_bar = /obj/item/ingot/silverblessed
	craftdiff = 3
	created_item = /obj/item/rogueweapon/knuckles/psydon
	i_type = "Weapons"

/datum/anvil_recipe/weapons/psy/cudgel
	name = "Psydonian Handmace"
	req_bar = /obj/item/ingot/silverblessed
	craftdiff = 3
	created_item = /obj/item/rogueweapon/mace/cudgel/psy
	i_type = "Weapons"

/datum/anvil_recipe/weapons/psy/halberd
	name = "Psydonian Halberd (+1 B. Silver, +1 Small Log)"
	req_bar = /obj/item/ingot/silverblessed
	craftdiff = 3
	created_item = /obj/item/rogueweapon/halberd/psyhalberd
	additional_items = list(/obj/item/ingot/silverblessed, /obj/item/grown/log/tree/small)
	i_type = "Weapons"

/datum/anvil_recipe/weapons/psy/gsword
	name = "Psydonian Greatsword (+1 B. Silver)"
	req_bar = /obj/item/ingot/silverblessed
	craftdiff = 3
	created_item = /obj/item/rogueweapon/greatsword/psygsword
	additional_items = list(/obj/item/ingot/silverblessed)
	i_type = "Weapons"

/datum/anvil_recipe/weapons/psy/sword
	name = "Psydonian Sword"
	req_bar = /obj/item/ingot/silverblessed
	craftdiff = 3
	created_item = /obj/item/rogueweapon/sword/long/psysword
	i_type = "Weapons"

/datum/anvil_recipe/weapons/psy/whip
	name = "Psydonian Whip (+2 Cured Leather)"
	req_bar = /obj/item/ingot/silverblessed
	craftdiff = 3
	created_item = /obj/item/rogueweapon/whip/psywhip_lesser
	additional_items = list(/obj/item/natural/hide/cured, /obj/item/natural/hide/cured)
	i_type = "Weapons"

//Silver bullion

/datum/anvil_recipe/weapons/psy/axe/inq
	name = "Psydonian War Axe (+1 B. Silver, +1 Stick)"
	req_bar = /obj/item/ingot/silverblessed/bullion
	craftdiff = 3
	created_item = /obj/item/rogueweapon/stoneaxe/battle/psyaxe
	additional_items = list(/obj/item/ingot/silverblessed, /obj/item/grown/log/tree/stick)
	i_type = "Weapons"

/datum/anvil_recipe/weapons/psy/mace/inq
	name = "Psydonian Mace (+1 B. Silver, +1 Stick)"
	req_bar = /obj/item/ingot/silverblessed/bullion
	craftdiff = 3
	created_item = /obj/item/rogueweapon/mace/goden/psymace
	additional_items = list(/obj/item/ingot/silverblessed, /obj/item/grown/log/tree/stick)
	i_type = "Weapons"

/datum/anvil_recipe/weapons/psy/spear/inq
	name = "Psydonian Spear (+1 Small Log)"
	req_bar = /obj/item/ingot/silverblessed/bullion
	craftdiff = 3
	created_item = /obj/item/rogueweapon/spear/psyspear
	additional_items = list(/obj/item/grown/log/tree/small)
	i_type = "Weapons"

/datum/anvil_recipe/weapons/psy/dagger/inq
	name = "Psydonian Dagger"
	req_bar = /obj/item/ingot/silverblessed/bullion
	craftdiff = 3
	created_item = /obj/item/rogueweapon/huntingknife/idagger/silver/psydagger
	i_type = "Weapons"

/datum/anvil_recipe/weapons/psy/shortsword/inq
	name = "Psydonian Shortsword"
	req_bar = /obj/item/ingot/silverblessed/bullion
	craftdiff = 3
	created_item = /obj/item/rogueweapon/sword/short/psy
	i_type = "Weapons"

/datum/anvil_recipe/weapons/psy/katar/inq
	name = "Psydonian Katar"
	req_bar = /obj/item/ingot/silverblessed/bullion
	craftdiff = 3
	created_item = /obj/item/rogueweapon/katar/psydon
	i_type = "Weapons"

/datum/anvil_recipe/weapons/psy/knuckles/inq
	name = "Psydonian Knuckles"
	req_bar = /obj/item/ingot/silverblessed/bullion
	craftdiff = 3
	created_item = /obj/item/rogueweapon/knuckles/psydon
	i_type = "Weapons"

/datum/anvil_recipe/weapons/psy/cudgel/inq
	name = "Psydonian Handmace"
	req_bar = /obj/item/ingot/silverblessed/bullion
	craftdiff = 3
	created_item = /obj/item/rogueweapon/mace/cudgel/psy
	i_type = "Weapons"

/datum/anvil_recipe/weapons/psy/halberd/inq
	name = "Psydonian Halberd (+1 B. Silver, +1 Small Log)"
	req_bar = /obj/item/ingot/silverblessed/bullion
	craftdiff = 3
	created_item = /obj/item/rogueweapon/halberd/psyhalberd
	additional_items = list(/obj/item/ingot/silverblessed, /obj/item/grown/log/tree/small)
	i_type = "Weapons"

/datum/anvil_recipe/weapons/psy/gsword/inq
	name = "Psydonian Greatsword (+1 B. Silver)"
	req_bar = /obj/item/ingot/silverblessed/bullion
	craftdiff = 3
	created_item = /obj/item/rogueweapon/greatsword/psygsword
	additional_items = list(/obj/item/ingot/silverblessed)
	i_type = "Weapons"

/datum/anvil_recipe/weapons/psy/sword/inq
	name = "Psydonian Sword"
	req_bar = /obj/item/ingot/silverblessed/bullion
	craftdiff = 3
	created_item = /obj/item/rogueweapon/sword/long/psysword
	i_type = "Weapons"

/datum/anvil_recipe/weapons/psy/whip/inq
	name = "Psydonian Whip (+2 Cured Leather)"
	req_bar = /obj/item/ingot/silverblessed/bullion
	craftdiff = 3
	created_item = /obj/item/rogueweapon/whip/psywhip_lesser
	additional_items = list(/obj/item/natural/hide/cured, /obj/item/natural/hide/cured)
	i_type = "Weapons"
