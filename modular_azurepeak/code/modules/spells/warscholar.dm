/obj/effect/proc_holder/spell/targeted/touch/summonrogueweapon
	castdrain = 25
	school = "transmutation"

/obj/effect/proc_holder/spell/targeted/touch/summonrogueweapon/bladeofpsydon
	name = "Blade of Psydon"
	desc = "The manifestation of the higher concept of a blade itself. Said to be drawn upon from Noc's tresury of wisdom, each casting a poor facsimile of the perfect weapon They hold."
	clothes_req = FALSE
	drawmessage = "I imagine the perfect weapon, forged by arcyne knowledge, it's edge flawless. \
	I feel it in my mind's eye -- but it's just out of reach. I pull away it's shadow, a bad copy, and yet it is one of a great weapon nonetheless... "
	dropmessage = "Letting go, I watch the blade lose it's form, unable to stay stable without my energy rooting it to this world..."
	overlay_state = "boundkatar"
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	hand_path = /obj/item/melee/touch_attack/rogueweapon/bladeofpsydon

/obj/item/melee/touch_attack/rogueweapon/bladeofpsydon
	name = "\improper arcyne push dagger"
	desc = "This blade throbs, translucent and iridiscent, blueish arcyne energies running through it's translucent surface..."
	catchphrase = null
	icon = 'icons/mob/actions/roguespells.dmi'
	icon_state = "katar_bound"
	charges = 20
	force = 18
	possible_item_intents = list(/datum/intent/katar/cut, /datum/intent/katar/thrust)
	gripsprite = FALSE
	wlength = WLENGTH_SHORT
	w_class = WEIGHT_CLASS_HUGE
	parrysound = list('sound/combat/parry/bladed/bladedsmall (1).ogg','sound/combat/parry/bladed/bladedsmall (2).ogg','sound/combat/parry/bladed/bladedsmall (3).ogg')
	max_blade_int = 999
	max_integrity = 999
	swingsound = list('sound/combat/wooshes/bladed/wooshsmall (1).ogg','sound/combat/wooshes/bladed/wooshsmall (2).ogg','sound/combat/wooshes/bladed/wooshsmall (3).ogg')
	associated_skill = /datum/skill/combat/unarmed
	pickup_sound = 'sound/foley/equip/swordsmall2.ogg'
	wdefense = 4
	wbalance = WBALANCE_SWIFT

/obj/item/melee/touch_attack/rogueweapon/attack_self()
	attached_spell.remove_hand()

/obj/item/melee/touch_attack/rogueweapon/get_dismemberment_chance(obj/item/bodypart/affecting, mob/user)
	if(!get_sharpness() || !affecting.can_dismember(src))
		return 0

	var/total_dam = affecting.get_damage()
	var/nuforce = get_complex_damage(src, user)
	var/pristine_blade = TRUE
	if(max_blade_int && dismember_blade_int)
		var/blade_int_modifier = (blade_int / dismember_blade_int)
		//blade is about as sharp as a brick it won't dismember shit
		if(blade_int_modifier <= 0.15)
			return 0
		nuforce *= blade_int_modifier
		pristine_blade = (blade_int >= (dismember_blade_int * 0.95))

	if(user)
		if(istype(user.rmb_intent, /datum/rmb_intent/weak))
			nuforce = 0
		else if(istype(user.rmb_intent, /datum/rmb_intent/strong))
			nuforce *= 1.1

		if(user.used_intent.blade_class == BCLASS_CHOP) //chopping attacks always attempt dismembering
			nuforce *= 1.1
		else if(user.used_intent.blade_class == BCLASS_CUT)
			if(!pristine_blade && (total_dam < affecting.max_damage * 0.8))
				return 0
		else
			return 0

	if(nuforce < 10)
		return 0

	var/probability = nuforce * (total_dam / affecting.max_damage)
	var/hard_dismember = HAS_TRAIT(affecting, TRAIT_HARDDISMEMBER)
	var/easy_dismember = affecting.rotted || affecting.skeletonized || HAS_TRAIT(affecting, TRAIT_EASYDISMEMBER)
	if(affecting.owner)
		if(!hard_dismember)
			hard_dismember = HAS_TRAIT(affecting.owner, TRAIT_HARDDISMEMBER)
		if(!easy_dismember)
			easy_dismember = HAS_TRAIT(affecting.owner, TRAIT_EASYDISMEMBER)
	if(hard_dismember)
		return min(probability, 5)
	else if(easy_dismember)
		return probability * 1.5
	return probability
