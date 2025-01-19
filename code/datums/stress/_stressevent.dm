/datum/stressevent
	var/timer
	var/stressadd = 0
	var/desc
	var/time_added
	var/stacks = 0
	var/max_stacks = 1
	var/stressadd_per_extra_stack = 0

/datum/stressevent/proc/can_apply(mob/living/user)
	return TRUE

/datum/stressevent/proc/get_stress(mob/living/user)
	return stressadd + ((stacks - 1) * stressadd_per_extra_stack)

/datum/stressevent/test
	timer = 5 SECONDS
	stressadd = 3
	desc = span_red("This is a negative test event.")

/datum/stressevent/testr
	timer = 5 SECONDS
	stressadd = -3
	desc = span_green("This is a positive test event.")
