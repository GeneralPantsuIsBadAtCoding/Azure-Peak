/*
* these chests roll a semi-randomized number of loot objects from their tables. based on paxilloot ฅ^•ﻌ•^ฅ
* you can mix and match lootspawners but the dice roll will spawn from each in the list. meaning if your loot_weighted_list
* has lots of entries the loot_spawn_dice_string should be small or you'll create giant client murdering piles of stuff
*
* in addition to using these prebakes you can use varediting either as a mapper or as an admin to change the loot_weighted_list and
* loot_spawn_dice_string, among other things like lock strength and integrity, to tweak them to your needs. remember that if you plan
* to use a variant a lot, it's a little more performant to add a prebake for it here.
*/

/obj/structure/closet/crate/chest/loot_chest
	storage_capacity = 100
	anchored = TRUE
	/// our lootspawners. the spawner's lootcount var works additively with our dice string below and must be at least 1.
	var/list/loot_weighted_list = list(
		/obj/effect/spawner/lootdrop/general_loot_hi = 5,
		/obj/effect/spawner/lootdrop/general_loot_mid = 5,
		/obj/effect/spawner/lootdrop/valuable_candle_spawner = 1,
		/obj/effect/spawner/lootdrop/valuable_tableware_spawner = 1,
	)
	/// a string of dice to use when rolling number of contents.
	var/loot_spawn_dice_string = "1d3+1"

/obj/structure/closet/crate/chest/loot_chest/Initialize()
	. = ..()
	var/random_loot_amount = roll(loot_spawn_dice_string)
	for(var/loot_spawn in 1 to random_loot_amount)
		var/obj/new_loot = pickweight(loot_weighted_list)
		new new_loot(src)

/obj/structure/closet/crate/chest/loot_chest/locked
	locked = TRUE
	max_integrity = 1000
	loot_weighted_list = list(
		/obj/effect/spawner/lootdrop/general_loot_hi = 4,
		/obj/effect/spawner/lootdrop/general_loot_mid = 1,
		/obj/effect/spawner/lootdrop/valuable_candle_spawner = 2,
		/obj/effect/spawner/lootdrop/valuable_clutter_spawner = 2,
		/obj/effect/spawner/lootdrop/valuable_jewelry_spawner = 1,
	)
	loot_spawn_dice_string = "1d2+1"

/obj/structure/closet/crate/chest/loot_chest/locked/indestructible //party up with rogues NOW
	max_integrity = 2000 //Changed from 'INFINITY'. Still greatly encourages taking a rogue or lockpick, but doesn't make it impossible to crack, in a pinch, with enough time and stamina.
	lock_strength = 200
	loot_weighted_list = list(
		/obj/effect/spawner/lootdrop/valuable_jewelry_spawner = 1,
		/obj/effect/spawner/lootdrop/general_loot_hi = 4,
		/obj/effect/spawner/lootdrop/general_loot_mid = 1,
	)

/obj/effect/landmark/chest_or_mimic/loot_chest
	chest_type = /obj/structure/closet/crate/chest/loot_chest

/obj/effect/landmark/chest_or_mimic/loot_chest/locked
	chest_type = /obj/structure/closet/crate/chest/loot_chest/locked
