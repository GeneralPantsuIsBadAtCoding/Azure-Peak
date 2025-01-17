/datum/virtue/items/rich
	name = "Rich and Shrewd"
	desc = "Through a stroke of luck or shrewd planning, I've come into a considerable amount of mammon. I can tell the value of those I speak to, and what they offer."
	added_traits = list(TRAIT_SEEPRICES_SHITTY)
	added_skills = list(/datum/skill/misc/reading = 1)	//So the spell would work
	
/datum/virtue/items/rich/apply_to_human(mob/living/carbon/human/recipient)
	var/obj/item/pouch = new /obj/item/storage/belt/rogue/pouch/coins/rich(get_turf(recipient))
	recipient.put_in_hands(pouch, forced = TRUE)
	recipient.mind?.AddSpell(new /obj/effect/proc_holder/spell/invoked/appraise/secular)

/datum/virtue/items/arsonist
	name = "Arsonist"
	desc = "I like to watch the world burn, and I've stowed away two powerful firebombs to help me achieve that fact."
	added_skills = list(/datum/skill/misc/alchemy = 1)
	added_stashed_items = list("Firebomb #1" = /obj/item/bomb,
								"Firebomb #2" = /obj/item/bomb
	)
