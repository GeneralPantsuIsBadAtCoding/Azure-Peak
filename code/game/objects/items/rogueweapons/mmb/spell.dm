/datum/intent/spell
	name = "spell"
	tranged = 1
	chargedrain = 0
	chargetime = 0
	warnie = "aimwarn"
	warnoffset = 0

/datum/intent/spell/on_mmb(atom/target, mob/living/user, params)
	if(user.ranged_ability?.InterceptClickOn(user, params, target))
		user.changeNext_move(clickcd)
		if(releasedrain)
			user.stamina_add(releasedrain)
