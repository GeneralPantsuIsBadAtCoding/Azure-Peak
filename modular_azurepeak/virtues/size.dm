/datum/virtue/size/giant
	name = "Giant"
	desc = "I've always been larger, stronger and hardier than the average person. I tend to lumber around a lot, and my immense size can break down frail, wooden doors."
	added_stats = list(STAT_STRENGTH = 2, STAT_CONSTITUTION = 1, STAT_SPEED = -2)
	added_traits = list(TRAIT_BIGGUY)
	triumph_cost = 2

/datum/virtue/size/giant/apply_to_human(mob/living/carbon/human/recipient)
	recipient.transform = recipient.transform.Scale(1.25, 1.25)
	recipient.transform = recipient.transform.Translate(0, (0.25 * 16))
	recipient.update_transform()
