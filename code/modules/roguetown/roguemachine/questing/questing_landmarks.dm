/obj/effect/landmark/quest_spawner
	name = "quest landmark"
	icon = 'code/modules/roguetown/roguemachine/questing/questing.dmi'
	icon_state = "quest_marker"
	var/quest_difficulty = list(QUEST_DIFFICULTY_EASY, QUEST_DIFFICULTY_MEDIUM, QUEST_DIFFICULTY_HARD)
	var/quest_type = list(QUEST_RETRIEVAL, QUEST_COURIER, QUEST_CLEAR_OUT, QUEST_KILL, QUEST_BEACON, QUEST_OUTLAW)
	var/list/fetch_items = list(
		/obj/item/rogueweapon/huntingknife/throwingknife/steel,
		/obj/item/rogueweapon/huntingknife,
		/obj/item/reagent_containers/glass/bottle/rogue/whitewine
	)
	var/list/kill_mobs = list(
		/mob/living/carbon/human/species/goblin/npc/ambush/sea,
		/mob/living/carbon/human/species/skeleton/npc/medium,
		/mob/living/carbon/human/species/human/northern/searaider/ambush
	)
	var/miniboss_mobs = list(
		/mob/living/carbon/human/species/human/northern/deranged_knight
	)

/obj/effect/landmark/quest_spawner/Initialize()
	. = ..()
	GLOB.quest_landmarks_list += src

/obj/effect/landmark/quest_spawner/Destroy()
	GLOB.quest_landmarks_list -= src
	return ..()

// Note: generate_quest has been removed - quest generation is now handled by quest datum subtypes
// Each quest type (retrieval, kill, courier, etc.) has its own generate() method

// Note: spawn_fetch_items, spawn_kill_mob, spawn_clear_out_mobs have been removed
// These are now handled directly in quest datum subtypes via their generate() method

/obj/effect/landmark/quest_spawner/proc/add_quest_faction_to_nearby_mobs(turf/center)
	for(var/mob/living/M in view(7, center))
		if(!M.ckey && !("quest" in M.faction))
			M.faction |= "quest"

/obj/effect/landmark/quest_spawner/proc/get_safe_spawn_turf()
	var/list/possible_landmarks = list()
	for(var/obj/effect/landmark/quest_spawner/landmark in GLOB.quest_landmarks_list)
		if((quest_difficulty in landmark.quest_difficulty) || (landmark.quest_difficulty in quest_difficulty))
			possible_landmarks += landmark

	if(!length(possible_landmarks))
		possible_landmarks += src
	
	var/obj/effect/landmark/quest_spawner/selected_landmark = pick(possible_landmarks)
	var/list/possible_turfs = list()

	for(var/turf/open/T in view(7, selected_landmark))
		if(T.density || istransparentturf(T))
			continue

		for(var/mob/M in view(9, T))
			if(!M.ckey)
				possible_turfs += T
				break

	return length(possible_turfs) ? pick(possible_turfs) : get_turf(src)

/obj/effect/landmark/quest_spawner/proc/spawn_courier_item(datum/quest/quest, area/delivery_area)
	if(!quest || !delivery_area)
		return null

	var/turf/spawn_turf = get_safe_spawn_turf()
	if(!spawn_turf)
		return

	var/obj/item/parcel/delivery_parcel = new(spawn_turf)
	var/static/list/area_delivery_items = list(
		/area/rogue/indoors/town/tavern = list(
			/obj/item/cooking/pan,
			/obj/item/reagent_containers/glass/bottle/rogue/beer/aurorian,
			/obj/item/reagent_containers/food/snacks/rogue/cheddar,
		),
		/area/rogue/indoors/town/bath = list(
			/obj/item/reagent_containers/glass/bottle/rogue/beer/aurorian,
			/obj/item/reagent_containers/food/snacks/rogue/pie/cooked/crab,
			/obj/item/perfume/random,
		),
		/area/rogue/indoors/town/church = list(
			/obj/item/natural/cloth,
			/obj/item/reagent_containers/powder/ozium,
			/obj/item/reagent_containers/food/snacks/rogue/crackerscooked,
		),
		/area/rogue/indoors/town/dwarfin = list(
			/obj/item/ingot/iron,
			/obj/item/ingot/bronze,
			/obj/item/rogueore/coal,
		),
		/area/rogue/indoors/town/shop = list(
			/obj/item/roguecoin/gold,
			/obj/item/clothing/ring/silver,
			/obj/item/scomstone/bad,
		),
		/area/rogue/indoors/town/manor = list(
			/obj/item/clothing/cloak/raincloak/furcloak,
			/obj/item/reagent_containers/glass/bottle/rogue/whitewine,
			/obj/item/reagent_containers/food/snacks/rogue/cheddar/aged,
			/obj/item/perfume/random,
		),
		/area/rogue/indoors/town/magician = list(
			/obj/item/book/spellbook,
			/obj/item/roguegem/yellow,
			/obj/item/reagent_containers/glass/bottle/rogue/manapot,
		),
		/area/rogue/indoors/town = list(
			/obj/item/ration,
		)
	)

	var/list/possible_items = area_delivery_items[delivery_area] || list(
		/obj/item/natural/cloth,
		/obj/item/ration,
		/obj/item/reagent_containers/food/snacks/rogue/crackerscooked,
	)

	var/contained_item_type = pick(possible_items)
	var/obj/item/contained_item = new contained_item_type(delivery_parcel)
	delivery_parcel.contained_item = contained_item
	delivery_parcel.delivery_area_type = delivery_area
	delivery_parcel.allowed_jobs = delivery_parcel.get_area_jobs(delivery_area)
	delivery_parcel.name = "Delivery for [initial(delivery_area.name)]"
	delivery_parcel.desc = "A securely wrapped parcel addressed to [initial(delivery_area.name)]. [pick("Handle with care.", "Do not bend.", "Confidential contents.", "Urgent delivery.")]"
	delivery_parcel.icon_state = contained_item.w_class >= WEIGHT_CLASS_NORMAL ? "ration_large" : "ration_small"
	delivery_parcel.dropshrink = 1
	delivery_parcel.update_icon()

	quest.target_delivery_item = contained_item_type
	delivery_parcel.AddComponent(/datum/component/quest_object/courier, quest)
	contained_item.AddComponent(/datum/component/quest_object/courier, quest)
	quest.add_tracked_atom(delivery_parcel)

	return delivery_parcel

// Note: spawn_clear_out_mobs and spawn_miniboss have been removed
// These are now handled directly in quest datum subtypes (clearout, outlaw) via their generate() method

/obj/effect/landmark/quest_spawner/easy
	name = "easy quest landmark"
	icon_state = "quest_marker_low"
	quest_difficulty = "Easy"
	quest_type = list(QUEST_RETRIEVAL, QUEST_COURIER, QUEST_KILL, QUEST_BEACON)

/obj/effect/landmark/quest_spawner/medium
	name = "medium quest landmark"
	icon_state = "quest_marker_mid"
	quest_difficulty = "Medium"
	quest_type = list(QUEST_KILL, QUEST_CLEAR_OUT, QUEST_BEACON)

/obj/effect/landmark/quest_spawner/hard
	name = "hard quest landmark"
	icon_state = "quest_marker_high"
	quest_difficulty = "Hard"
	quest_type = list(QUEST_CLEAR_OUT, QUEST_BEACON, QUEST_OUTLAW)
