/mob/living/simple_animal/hostile/retaliate
	var/list/enemies = list()

/mob/living/simple_animal/hostile/retaliate/attack_hand(mob/living/carbon/human/M)
	. = ..()
	if(M.used_intent.type == INTENT_HELP)
		if(enemies.len)
			if(tame)
				enemies = list()
				src.visible_message(span_notice("[src] calms down."))
				LoseTarget()

/mob/living/simple_animal/hostile/retaliate
	var/aggressive = 0

/mob/living/simple_animal/hostile/retaliate/ListTargets()
	if(!(AIStatus == AI_OFF))
		if(aggressive)
			return ..()
		else
			if(!enemies.len)
				return list()
			var/list/see = ..()
			see &= enemies // Remove all entries that aren't in enemies
			return see

/mob/living/simple_animal/hostile/retaliate/proc/Retaliate()
//	var/list/around = view(src, vision_range)
	toggle_ai(AI_ON)
	if(!(AIStatus == AI_OFF))
		var/list/around = hearers(vision_range, src)

		for(var/atom/movable/A in around)
			if(A == src)
				continue
			if(isliving(A))
				var/mob/living/M = A
				if(faction_check_mob(M) && attack_same || !faction_check_mob(M))
					enemies |= M

		for(var/mob/living/simple_animal/hostile/retaliate/H in around)
			if(faction_check_mob(H) && !attack_same && !H.attack_same)
				H.enemies |= enemies
		return 0
	

/mob/living/simple_animal/hostile/retaliate/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	. = ..()
	if(. > 0 && stat == CONSCIOUS)
		Retaliate()
