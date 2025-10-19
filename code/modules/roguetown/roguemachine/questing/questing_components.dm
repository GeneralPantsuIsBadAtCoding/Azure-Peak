GLOBAL_LIST_EMPTY(quest_components)

/datum/component/quest_object
	var/datum/weakref/quest_ref
	var/is_mob = FALSE
	var/outline_filter_id = "quest_item_outline"

/datum/component/quest_object/Initialize(datum/quest/target_quest)
	if(!isitem(parent) && !ismob(parent))
		return COMPONENT_INCOMPATIBLE
	
	quest_ref = WEAKREF(target_quest)
	is_mob = ismob(parent)
	
	if(is_mob)
		var/mob/M = parent
		M.add_filter(outline_filter_id, 2, list("type" = "outline", "color" = "#ff0000", "size" = 0.5))
		RegisterSignal(parent, COMSIG_MOB_DEATH, PROC_REF(on_target_death))
		RegisterSignal(parent, COMSIG_PARENT_EXAMINE, PROC_REF(on_mob_examine))
	else
		var/obj/item/I = parent
		I.add_filter(outline_filter_id, 2, list("type" = "outline", "color" = "#008cff", "size" = 0.5))
		RegisterSignal(parent, COMSIG_PARENT_EXAMINE, PROC_REF(on_examine))
		RegisterSignal(parent, COMSIG_ITEM_DROPPED, PROC_REF(on_item_dropped))
		RegisterSignal(parent, COMSIG_MOVABLE_MOVED, PROC_REF(on_item_dropped))
	
	RegisterSignal(target_quest, COMSIG_PARENT_QDELETING, PROC_REF(on_quest_deleted))
	GLOB.quest_components += src

/datum/component/quest_object/Destroy()
	GLOB.quest_components -= src
	if(QDELETED(parent))
		return ..()
		
	var/datum/quest/Q = quest_ref?.resolve()
	if(Q && !Q.complete && isitem(parent))
		var/obj/item/I = parent
		I.remove_filter(outline_filter_id)
		if(Q.quest_type == QUEST_COURIER && (Q.target_delivery_item && istype(I, Q.target_delivery_item)) && !QDELETED(I))
			Q.target_delivery_item = null
			qdel(I)
	
	return ..()

/datum/component/quest_object/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	var/datum/quest/Q = quest_ref.resolve()
	if(!Q || Q.complete)
		return
	
	var/list/user_scrolls = find_quest_scrolls(user)
	for(var/obj/item/paper/scroll/quest/scroll in user_scrolls)
		var/datum/quest/user_quest = scroll.assigned_quest
		if(user_quest && ((user_quest.quest_type == QUEST_RETRIEVAL && istype(parent, user_quest.target_item_type)) || \
						(user_quest.quest_type == QUEST_COURIER && istype(parent, user_quest.target_delivery_item))))
			examine_list += span_notice("This looks like an item you need for your quest: [user_quest.title]!")
			break

/datum/component/quest_object/proc/on_mob_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	var/datum/quest/Q = quest_ref.resolve()
	if(!Q || Q.complete)
		return

	var/list/user_scrolls = find_quest_scrolls(user)
	for(var/obj/item/paper/scroll/quest/scroll in user_scrolls)
		var/datum/quest/user_quest = scroll.assigned_quest
		if(user_quest && (user_quest.quest_type in list(QUEST_KILL, QUEST_CLEAR_OUT, QUEST_OUTLAW)) && istype(parent, user_quest.target_mob_type))
			examine_list += span_notice("This looks like the target of your quest: [user_quest.title]!")
			if(Q.target_spawn_area != get_area(get_turf(src)))
				examine_list += span_notice("It was last reported in the [Q.target_spawn_area] area, however.")
			break

/datum/component/quest_object/proc/find_quest_scrolls(atom/container)
	var/list/scrolls = list()
	for(var/obj/item/paper/scroll/quest/Q in container)
		scrolls += Q
	for(var/obj/item/storage/S in container)
		scrolls += find_quest_scrolls(S)
	return scrolls

/datum/component/quest_object/proc/on_target_death(mob/living/dead_mob, gibbed)
	SIGNAL_HANDLER
	
	var/datum/quest/Q = quest_ref.resolve()
	if(!Q || Q.complete || !istype(dead_mob, Q.target_mob_type))
		return

	Q.target_amount--
	dead_mob.remove_filter("quest_item_outline")

	var/obj/item/paper/scroll/quest/scroll = Q.quest_scroll_ref?.resolve() || Q.quest_scroll
	if(scroll)
		scroll.update_quest_text()
		if(Q.target_amount <= 0)
			Q.complete = TRUE
			scroll.update_quest_text()

/datum/component/quest_object/proc/on_item_dropped(obj/item/dropped_item, mob/user)
	SIGNAL_HANDLER

	var/datum/quest/Q = quest_ref.resolve()
	if(!Q || Q.complete)
		return

	var/turf/drop_turf = get_turf(dropped_item)
	
	// Handle fetch quests (dropping item on quest machine input)
	if(Q.quest_type == QUEST_RETRIEVAL)
		for(var/obj/structure/roguemachine/noticeboard/quest_machine in SSroguemachine.noticeboards)
			if(get_turf(quest_machine.input_point) == drop_turf)
				if(Q.target_item_type && istype(dropped_item, Q.target_item_type))
					Q.target_amount--
					if(Q.target_amount <= 0)
						Q.complete = TRUE
						var/obj/item/paper/scroll/quest/scroll = Q.quest_scroll_ref?.resolve()
						if(scroll)
							scroll.update_quest_text()
					do_sparks(3, TRUE, get_turf(dropped_item))
					qdel(dropped_item)
					return
	
	// Handle courier quests (dropping in target area)
	if(Q.quest_type == QUEST_COURIER)
		var/area/drop_area = get_area(drop_turf)
		if(!istype(drop_area, Q.target_delivery_location))
			return

		// Handle parcel delivery
		if(istype(dropped_item, /obj/item/parcel))
			var/obj/item/parcel/parcel = dropped_item
			if(parcel.contained_item && istype(parcel.contained_item, Q.target_delivery_item))
				Q.target_amount--
				if(Q.target_amount <= 0)
					Q.complete = TRUE
					parcel.remove_filter(outline_filter_id)
					if(parcel.contained_item)
						parcel.contained_item.remove_filter(outline_filter_id)
					var/obj/item/paper/scroll/quest/scroll = Q.quest_scroll_ref?.resolve()
					if(scroll)
						scroll.update_quest_text()
				return
		
		// Handle direct item delivery
		else if(istype(dropped_item, Q.target_delivery_item))
			Q.target_amount--
			if(Q.target_amount <= 0)
				Q.complete = TRUE
				dropped_item.remove_filter(outline_filter_id)
				var/obj/item/paper/scroll/quest/scroll = Q.quest_scroll_ref?.resolve()
				if(scroll)
					scroll.update_quest_text()
			return

/datum/component/quest_object/proc/on_quest_deleted(datum/source)
	SIGNAL_HANDLER

	if(QDELETED(parent))
		return
	
	var/datum/quest/Q = quest_ref?.resolve()
	
	if(ismob(parent))
		var/mob/M = parent
		M.remove_filter(outline_filter_id)
	else if(isitem(parent))
		var/obj/item/I = parent
		I.remove_filter(outline_filter_id)
		// Only delete the item if it's part of an incomplete fetch or courier quest
		if(Q && !Q.complete && ((Q.quest_type == QUEST_RETRIEVAL && istype(I, Q.target_item_type)) || (Q.quest_type == QUEST_COURIER && istype(I, Q.target_delivery_item))))
			qdel(I)
	qdel(src)
