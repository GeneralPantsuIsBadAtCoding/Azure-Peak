/datum/crafting_recipe/food
	var/real_parts
	category = CAT_NONE

/datum/crafting_recipe/food/New()
	real_parts = parts.Copy()
	parts |= reqs
