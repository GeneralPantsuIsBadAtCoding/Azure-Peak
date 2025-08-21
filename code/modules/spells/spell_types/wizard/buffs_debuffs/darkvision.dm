/obj/effect/proc_holder/spell/targeted/touch/darkvision
	name = "Darkvision"
	desc = "Enhance the night vision of a target you touch for 15 minutes."
	overlay_state = "darkvision"
	clothes_req = FALSE
	drawmessage = "I prepare to grant Darkvision."
	dropmessage = "I release my arcyne focus."
	school = "transmutation"
	recharge_time = 1 MINUTES
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	hand_path = /obj/item/melee/touch_attack/darkvision
	spell_tier = 1
	invocations = list("Nox Oculus")
	invocation_type = "whisper"
	hide_charge_effect = TRUE
	xp_gain = TRUE
	cost = 2

/obj/effect/proc_holder/spell/targeted/touch/darkvision/miracle
	cost = 0
	spell_tier = 0
	associated_skill = /datum/skill/magic/holy

/obj/item/melee/touch_attack/darkvision
	name = "\improper arcyne focus"
	desc = "Touch a creature to grant them Darkvision for 15 minutes."
	catchphrase = null
	possible_item_intents = list(INTENT_HELP)
	icon = 'icons/mob/roguehudgrabs.dmi'
	icon_state = "pulling"
	icon_state = "grabbing_greyscale"
	color = "#3FBAFD"

/obj/item/melee/touch_attack/darkvision/attack_self()
	attached_spell.remove_hand()

/obj/item/melee/touch_attack/darkvision/afterattack(atom/target, mob/living/carbon/user, proximity)
	if(isliving(target))
		var/mob/living/spelltarget = target
		if(!do_after(user, 5 SECONDS, target = spelltarget))
			return
		spelltarget.apply_status_effect(/datum/status_effect/buff/darkvision, user.get_skill_level(associated_skill))
		user.stamina_add(80)
		if(spelltarget != user)
			user.visible_message("[user] draws a glyph in the air and touches [spelltarget] with an arcyne focus.")
		else
			user.visible_message("[user] draws a glyph in the air and touches themselves with an arcyne focus.")
		attached_spell.remove_hand()
	return
