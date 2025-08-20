/obj/effect/proc_holder/spell/self/conjure_armor
	name = "Conjure Armor"
	desc = "Conjure a fate weaver, a full-body protecting ring that breaks easily. Cannot be summoned if wearing anything heavier than light armor.\n\
	The ring lasts until it is broken, a new one is summoned, or the spell is forgotten."
	overlay_state = "conjure_armor"
	sound = list('sound/magic/whiteflame.ogg')

	releasedrain = 50
	chargedrain = 1
	chargetime = 3 SECONDS
	no_early_release = TRUE
	recharge_time = 3 MINUTES // Not meant to be spammed any lower and it starts to compete with stoneskin

	warnie = "spellwarning"
	no_early_release = TRUE
	antimagic_allowed = FALSE
	charging_slowdown = 3
	cost = 2
	spell_tier = 2 // Spellblade tier.

	invocations = list("Cladum Fati!") //destiny's defeat!
	invocation_type = "shout"
	glow_color = GLOW_COLOR_METAL
	glow_intensity = GLOW_INTENSITY_MEDIUM

	var/obj/item/clothing/conjured_armor = null

/obj/effect/proc_holder/spell/self/conjure_armor/cast(list/targets, mob/living/user = usr)
	var/mob/living/carbon/human/H = user
	var/targetac = H.highest_ac_worn()
	if(targetac > 1)
		to_chat(user, span_warning("I must be wearing lighter armor!"))
		revert_cast()
		return FALSE
	if(user.get_num_arms() <= 0)
		to_chat(user, span_warning("I don't have any usable hands!"))
		revert_cast()
		return FALSE
	if(src.conjured_armor)
		qdel(src.conjured_armor)
	if(H.wear_ring)
		to_chat(user, span_warning("My ring finger must be free!"))
		revert_cast()
		return FALSE

	user.visible_message("[user]'s existence briefly jitters, conjuring protection from doomed fates!")
	var/ring = /obj/item/clothing/ring/fate_weaver
	conjured_armor = new ring(user)
	user.equip_to_slot_or_del(conjured_armor, SLOT_RING)
	if(!QDELETED(conjured_armor))
		conjured_armor.AddComponent(/datum/component/conjured_item, GLOW_COLOR_ARCANE)
	return TRUE

/obj/effect/proc_holder/spell/self/conjure_armor/miracle
	associated_skill = /datum/skill/magic/holy

/obj/effect/proc_holder/spell/self/conjure_armor/Destroy()
	if(src.conjured_armor)
		conjured_armor.visible_message(span_warning("The [conjured_armor]'s borders begin to shimmer and fade, before it vanishes entirely!"))
		qdel(conjured_armor)
	return ..()
