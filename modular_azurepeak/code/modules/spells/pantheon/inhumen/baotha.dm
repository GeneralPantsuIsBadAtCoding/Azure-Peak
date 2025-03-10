//Baotha's Blessings - T1, reverses overdose effect on a target + soothing moodlet. (Medieval narcan..... #BanNarcan)

/obj/effect/proc_holder/spell/invoked/baothablessings
	name = "Baotha's Blessings"
	overlay_state = "lesserheal"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 4
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/magic/heal.ogg'
	invocation_type = "none"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 10 SECONDS
	miracle = TRUE
	devotion_cost = 10

/obj/effect/proc_holder/spell/invoked/baothablessings/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/carbon/target = targets[1]
		if(istype(target.patron, /datum/patron/inhumen/baotha))
			to_chat(user, span_warning("They already possess Baotha's blessings.."))
			return FALSE										//This stops us from accidently removing another Baothan's anti-overdose trait.
		target.apply_status_effect(/datum/status_effect/buff/druqks)
		ADD_TRAIT(target, TRAIT_CRACKHEAD, TRAIT_GENERIC)		//Gets the trait temorarily, basically will just stop any active/upcoming ODs.
		target.visible_message("<span class='info'>[target]'s eyes appear to gloss over!</span>", "<span class='notice'>I feel.. at ease.</span>")
		addtimer(CALLBACK(src, PROC_REF(remove_buff), target), wait = 15 SECONDS)	//Should be long enough to prevent an overdose. If not, maybe up to 20 or so.

/obj/effect/proc_holder/spell/invoked/baothablessings/proc/remove_buff(mob/living/carbon/target)
	REMOVE_TRAIT(target, TRAIT_CRACKHEAD, TRAIT_GENERIC)							
	to_chat(target, span_warning("I see everything clearly once more.."))
	target.visible_message("[target]'s eyes appear to return to normal.")

//Enrapturing Powder - T2, basically a crackhead blowing cocaine in your face.

/obj/effect/proc_holder/spell/invoked/projectile/blowingdust
	name = "Enrapturing Powder"
	desc = "Baotha's presence is always known, finding her blessings gathering on you like dust. With a good swipe, I could make others indulge in her fruits.."
	clothes_req = FALSE
	range = 3	//It's literally blowing coke in their face, basically.
	associated_skill = /datum/skill/magic/holy
	projectile_type = /obj/projectile/magic/blowingdust
	chargedloop = /datum/looping_sound/invokeholy
	releasedrain = 30
	chargedrain = 0
	chargetime = 15
	charge_max = 10 SECONDS
	invocation = "Have a taste of the maiden's pure-bliss!"

/obj/projectile/magic/blowingdust
	name = "unholy dust"
	icon_state = "spark"
	nodamage = TRUE	//No effect because it's drugs.

/obj/projectile/magic/blowingdust/on_hit(target, mob/living/M)
	if(!istype(M))
		return
	if(target)
		to_chat(target, span_warning("Gah! Something.. got in my - eyes.."))
		M.blur_eyes(2)
		poisontype = /datum/reagent/ozium
		poisonfeel = "burning" //Would make sense for your eyes or nose to burn, I guess.
		poisonamount = 7 //Decent bit of high, second dose would cause flat-out overdose.

//Numbing Pleasure - T3, removes all pain from self for a period of time. (Similar to Ravox's without any blood-clotting and better pain suppression + good mood buff.)
/obj/effect/proc_holder/spell/invoked/painkiller
	name = "Numbing Pleasure"
	overlay_state = "astrata"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 7
	warnie = "sydwarning"
	sound = 'sound/magic/timestop.ogg'
	invocation = "May you find bliss through your pain!"
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 20 SECONDS
	miracle = TRUE
	devotion_cost = 75

/obj/effect/proc_holder/spell/invoked/painkiller/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		var/mob/living/carbon/human/human_target = target
		var/datum/physiology/phy = human_target.physiology
		if(target.mob_biotypes & MOB_UNDEAD)
			return FALSE	//No, you don't get to feel good. You're a undead mob. Feel bad.
		target.visible_message(span_info("[target] begins to twitch as warmth radiates from them!"), span_notice("The pain from my wounds fade, every new one being a mere, pleasent warmth!"))
		phy.pain_mod *= 0.5	//Literally halves your pain modifier.
		addtimer(VARSET_CALLBACK(phy, pain_mod, phy.pain_mod /= 0.5), 20 SECONDS)	//Adds back the 0.5 of pain, basically setting it back to 1.
		target.apply_status_effect(/datum/status_effect/buff/vitae)					//Basically lowers fortune by 2 but +3 speed, it's powerful. Drugs cus Baotha.


