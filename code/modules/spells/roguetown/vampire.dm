
/obj/effect/proc_holder/spell/targeted/shapeshift/bat
	name = "Bat Form"
	desc = ""
	invocation = ""
	recharge_time = 50
	cooldown_min = 50
	die_with_shapeshifted_form =  FALSE
	do_gib = FALSE
	shapeshift_type = /mob/living/simple_animal/hostile/retaliate/bat

/obj/effect/proc_holder/spell/targeted/shapeshift/gaseousform
	name = "Mist Form"
	desc = ""
	invocation = ""
	recharge_time = 50
	cooldown_min = 50
	die_with_shapeshifted_form =  FALSE
	shapeshift_type = /mob/living/simple_animal/hostile/retaliate/gaseousform

/obj/effect/proc_holder/spell/targeted/shapeshift/crow
	name = "Zad Form"
	overlay_state = "zad"
	desc = ""
	invocation = ""
	gesture_required = TRUE
	chargetime = 5 SECONDS
	recharge_time = 50
	cooldown_min = 50
	die_with_shapeshifted_form =  FALSE
	do_gib = FALSE
	shapeshift_type = /mob/living/simple_animal/hostile/retaliate/bat/crow
	sound = 'sound/vo/mobs/bird/birdfly.ogg'
