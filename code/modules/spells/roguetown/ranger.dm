/obj/effect/proc_holder/spell/targeted/conjure_item/conjure_bait
	name = "Conjure Bait"
	desc = "Prepares a bag of bait to attract wild game."
	charge_max = 300 SECONDS // 5 minute cooldown
	clothes_req = FALSE
	invocation_type = "none"
	include_user = TRUE
	range = -1
	action_icon = 'icons/mob/actions/roguespells.dmi'
	action_icon_state = "bait"
	action_background_icon_state = ""
	item_type = /obj/item/bait/sweet // The type of item to create
	delete_old = TRUE // Delete previous bait when conjuring new one
	associated_skill = /datum/skill/misc/tracking

/obj/effect/proc_holder/spell/targeted/conjure_item/conjure_bait/cast(list/targets, mob/user = usr)
	if(delete_old && item && !QDELETED(item))
		QDEL_NULL(item)
	user.visible_message(span_notice("[user] quickly prepares some hunting bait..."), \
						span_notice("You swiftly mix together some fresh bait."))
	playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 50, TRUE)
	
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		C.put_in_hands(make_item(), TRUE)
