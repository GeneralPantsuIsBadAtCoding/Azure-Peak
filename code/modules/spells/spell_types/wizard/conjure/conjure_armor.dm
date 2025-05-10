#define CONJURE_DURATION 15 MINUTES

/obj/effect/proc_holder/spell/invoked/conjure_armor
	name = "Conjure Armor"
	desc = "Conjure a full set of light armor and attempts to equip it on someone \n\
	The armor lasts for 15 minutes - but will refresh its duration infinitely when equipped on a Arcyne user.\n\
	At 12 int or above, conjure hardened leather grade armor for the body, otherwise conjure leather armor.\n\
	Armor will only be conjured where the target is not wearing any. Masks, Cloaks & Mouthpiece not included."
	overlay_state = "conjure_armor"
	sound = list('sound/magic/whiteflame.ogg')

	releasedrain = 60
	chargedrain = 1
	chargetime = 10 SECONDS // This is meant to make mid-combat summoning harder.
	no_early_release = TRUE
	recharge_time = 5 MINUTES // Not meant to be spammed or used as a mega support spell to outfit an entire party

	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = TRUE
	antimagic_allowed = FALSE
	charging_slowdown = 3
	cost = 2
	spell_tier = 2 // Spellblade tier.

	invocation = "Armatura Creetur!"
	invocation_type = "shout"
	glow_color = GLOW_COLOR_METAL
	glow_intensity = GLOW_INTENSITY_MEDIUM


/obj/effect/proc_holder/spell/invoked/conjure_armor/cast(list/targets, mob/living/user = usr)
	var/atom/A = targets[1]
	if(!ishuman(A))
		to_chat(user, span_warning("You need to target a living human with this spell!"))
		revert_cast()
		return
	
	var/mob/living/spelltarget = A
	user.visible_message("[user] conjures a set of light armor around [spelltarget]!")
	give_armor(user, spelltarget)
	return TRUE

// Not reusable code, because applying the conjured item component is necessary to look magicky + make sure it despawns / economy
/obj/effect/proc_holder/spell/invoked/conjure_armor/proc/give_armor(mob/living/user, mob/living/target)
	// Assoc list is not a thing in 515 forgive me for this atrocious copy paste

	var/helmet = user.STAINT >= 12 ? /obj/item/clothing/head/roguetown/helmet/leather/advanced : /obj/item/clothing/head/roguetown/helmet/leather
	var/shirt = user.STAINT >= 12 ? /obj/item/clothing/suit/roguetown/armor/gambeson/heavy : /obj/item/clothing/suit/roguetown/armor/gambeson
	var/wrists = user.STAINT >= 12 ? /obj/item/clothing/wrists/roguetown/bracers/leather/heavy : /obj/item/clothing/wrists/roguetown/bracers/leather
	var/gloves = user.STAINT >= 12 ? /obj/item/clothing/gloves/roguetown/angle : /obj/item/clothing/gloves/roguetown/leather
	var/neck = /obj/item/clothing/neck/roguetown/leather
	var/shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	var/armor = user.STAINT >= 12 ? /obj/item/clothing/suit/roguetown/armor/leather/studded : /obj/item/clothing/suit/roguetown/armor/leather
	var/pants = user.STAINT >= 12 ? /obj/item/clothing/under/roguetown/heavy_leather_pants : /obj/item/clothing/under/roguetown/trou/leather

	var/obj/item/new_helmet = new helmet(target)
	target.equip_to_slot_or_del(new_helmet, SLOT_HEAD)
	// Passing all these vars are necessary to override the owner because equip_to_slot_or_del don't actually assign an owner on equip
	new_helmet._AddComponent(/datum/component/conjured_item, CONJURE_DURATION, TRUE, /datum/skill/magic/arcane, GLOW_COLOR_ARCANE, target)
	
	var/obj/item/new_shirt = new shirt(target)
	target.equip_to_slot_or_del(new_shirt, SLOT_SHIRT)
	new_shirt._AddComponent(/datum/component/conjured_item, CONJURE_DURATION, TRUE, /datum/skill/magic/arcane, GLOW_COLOR_ARCANE, target)
	
	var/obj/item/new_wrists = new wrists(target)
	target.equip_to_slot_or_del(new_wrists, SLOT_WRISTS)
	new_wrists._AddComponent(/datum/component/conjured_item, CONJURE_DURATION, TRUE, /datum/skill/magic/arcane, GLOW_COLOR_ARCANE, target)

	var/obj/item/new_gloves = new gloves(target)
	target.equip_to_slot_or_del(new_gloves, SLOT_GLOVES)
	new_gloves._AddComponent(/datum/component/conjured_item, CONJURE_DURATION, TRUE, /datum/skill/magic/arcane, GLOW_COLOR_ARCANE, target)

	var/obj/item/new_neck = new neck(target)
	target.equip_to_slot_or_del(new_neck, SLOT_NECK)
	new_neck._AddComponent(/datum/component/conjured_item, CONJURE_DURATION, TRUE, /datum/skill/magic/arcane, GLOW_COLOR_ARCANE, target)

	var/obj/item/new_shoes = new shoes(target)
	target.equip_to_slot_or_del(new_shoes, SLOT_SHOES)
	new_shoes._AddComponent(/datum/component/conjured_item, CONJURE_DURATION, TRUE, /datum/skill/magic/arcane, GLOW_COLOR_ARCANE, target)

	var/obj/item/new_armor = new armor(target)
	target.equip_to_slot_or_del(new_armor, SLOT_ARMOR)
	new_armor._AddComponent(/datum/component/conjured_item, CONJURE_DURATION, TRUE, /datum/skill/magic/arcane, GLOW_COLOR_ARCANE, target)

	var/obj/item/new_pants = new pants(target)
	target.equip_to_slot_or_del(new_pants, SLOT_PANTS)
	new_pants._AddComponent(/datum/component/conjured_item, CONJURE_DURATION, TRUE, /datum/skill/magic/arcane, GLOW_COLOR_ARCANE, target)

#undef CONJURE_DURATION
