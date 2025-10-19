//T1 Enchantments
/datum/magic_item/mundane/woodcut
	name = "woodcutting"
	description = "It is firm like an tree."
	var/last_used

/datum/magic_item/mundane/woodcut/on_hit_structure(var/obj/item/i, var/obj/target, var/mob/living/user)
	if(istype(target, /obj/structure/flora))
		var/obj/structure/flora/tree = target
		tree.obj_integrity -= 70
	. = ..()

/datum/magic_item/mundane/mining
	name = "mining"
	description = "It is coated with rock."
	var/active_item = FALSE
	var/max_skill = FALSE

/datum/magic_item/mundane/mining/on_hit_structure(var/obj/item/i, var/turf/target, var/mob/living/user)
	if(istype(target, /obj/item/natural/rock))
		var/obj/item/natural/rock/rocktarget = target
		rocktarget.obj_integrity -= 500 //smashs through boulders with ease
	. = ..()

/datum/magic_item/mundane/mining/on_equip(var/obj/item/i, var/mob/living/user, slot)
	. = ..()
	if(active_item)
		return
	if(slot == ITEM_SLOT_HANDS)
		user.change_stat(STATKEY_WIL, 1)
		if(user.get_skill_level(/datum/skill/labor/mining)== 6)
			max_skill = TRUE //they are max level, so we skip giving them skills
		else
			user.adjust_skillrank(/datum/skill/labor/mining, 1, TRUE)
		to_chat(user, span_notice("I feel ready to mine!"))
		active_item = TRUE
	else
		return

/datum/magic_item/mundane/mining/on_drop(var/obj/item/i, var/mob/living/user)
	. = ..()
	if(active_item)
		active_item = FALSE
		if (!max_skill)
			user.adjust_skillrank(/datum/skill/labor/mining, -1, TRUE) //stripping them a level since they weren't max
		user.change_stat(STATKEY_WIL, -1)
		to_chat(user, span_notice("I feel mundane once more"))



/datum/magic_item/mundane/xylix
	name = "Xylix's boon"
	description = "It almost seems to give off the faint sound of laughter."
	var/active_item = FALSE

/datum/magic_item/mundane/xylix/on_equip(var/obj/item/i, var/mob/living/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_HANDS)
		return
	if(active_item)
		return
	else
		user.STALUC += 1
		to_chat(user, span_notice("I feel rather lucky"))
		active_item = TRUE

/datum/magic_item/mundane/xylix/on_drop(var/obj/item/i, var/mob/living/user)
	if(active_item)
		active_item = FALSE
		user.STALUC -= 1
		to_chat(user, span_notice("I feel mundane once more"))

/datum/magic_item/mundane/unyieldinglight
	name = "unyielding light"
	description = "It emits a shining light."
	var/active = FALSE

/datum/magic_item/mundane/unyieldinglight/on_use(var/obj/item/i, var/mob/living/user)
	if(!active)
		active = TRUE

		i.light_color = "#3FBAFD"
		to_chat(user, span_notice("I grip [i] lightly, and it abruptly lights up with shining light"))
		i.set_light(TRUE)
		i.light_outer_range = 6
	. = ..()

/datum/magic_item/mundane/holding
	name = "storage"
	description = "It seems bigger on the inside."

/datum/magic_item/mundane/holding/on_apply(var/obj/item/i)
	.=..()
	var/obj/item/storage = i
	var/datum/component/storage/STR = storage.GetComponent(/datum/component/storage)
	if(STR.max_w_class == WEIGHT_CLASS_SMALL)
		STR.max_w_class++
	STR.screen_max_columns = STR.screen_max_columns + 2

/datum/magic_item/mundane/revealing
	name = "revealing"
	description = "It's light is painfully bright."
	var/active = FALSE

/datum/magic_item/mundane/revealing/on_apply(var/obj/item/i)
	.=..()
	var/obj/item/flashlight/flare/light = i
	light.light_outer_range = light.light_outer_range * 2
