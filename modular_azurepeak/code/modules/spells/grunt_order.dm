/obj/effect/proc_holder/spell/invoked/grunt_order
	name = "Order Grunts"
	desc = "Cast once to order your Grunts to follow you. Cast it again to release them - at which point they'll attack anything unmarked as an ally."
	range = 12
	associated_skill = /datum/skill/misc/athletics
	chargedrain = 1
	chargetime = 0 SECONDS
	releasedrain = 0 
	recharge_time = 3 SECONDS
	var/order_range = 12
	overlay_state = "recruit_titlegrant"

	/*
	//FIXNOTE: 
	we want 2 options:
		switch aggression (aggressive to everyone but allies) (neutral to everyone)
		
		order them to follow you


	this spell doesn't work on complexmobs atm

	*/




/obj/effect/proc_holder/spell/invoked/grunt_order/cast(list/targets, mob/user)
    var/mob/caster = user
    var/target = targets[1]
    var/faction_tag = "[caster.mind.current.real_name]_faction"

    // grunts goto turf
    if(isturf(target))
        src.process_grunts(order_type = "goto", target_location = target, faction_tag = faction_tag)
        return

    // Target is the caster (set grunts to passive and follow)
    else if(target == caster)
        src.process_grunts(order_type = "follow", target = caster, faction_tag = faction_tag)
        return

    // Target is another mob
    else if(ismob(target))
        var/mob/living/mob_target = target
        if(caster.faction_check_mob(target) || (faction_tag in mob_target.faction))
            src.process_grunts(order_type = "aggressive", target = target, faction_tag = faction_tag)
            return
        else
            // Set all grunts to focus on the enemy target
            src.process_grunts(order_type = "attack", target = target, faction_tag = faction_tag)
            return
    else
        revert_cast()
        return

/obj/effect/proc_holder/spell/invoked/grunt_order/proc/process_grunts(order_type, turf/target_location = null, mob/living/target = null, faction_tag = null)
    var/mob/caster = usr
    var/count = 0
    var/msg = ""

    for (var/mob/other_mob in oview(src.order_range, caster))
        if (istype(other_mob, /mob/living/carbon/human/species/human/northern/grunt) && !other_mob.client)
            var/mob/living/carbon/human/species/human/northern/grunt/grunt = other_mob

            if((faction_tag && (faction_tag in grunt.faction)))

                grunt.ai_controller.clear_blackboard_key(BB_FOLLOW_TARGET)
                grunt.ai_controller.clear_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET)
                grunt.ai_controller.clear_blackboard_key(BB_TRAVEL_DESTINATION)
                grunt.ai_controller.clear_blackboard_key(BB_BASIC_MOB_RETALIATE_LIST)
                count += 1
                switch (order_type)
                    if ("goto")
                        grunt.ai_controller.set_blackboard_key(BB_TRAVEL_DESTINATION, target_location)
                        msg = "go to [target_location]"
                    if ("follow")
                        grunt.ai_controller.set_blackboard_key(BB_FOLLOW_TARGET, target)
                        msg = "follow you."
                    if ("aggressive")
                        msg = "roam free."
                    if ("attack")
                        grunt.ai_controller.set_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET, target)
                        msg = "attack [target.name]"
    if(count>0)
        to_chat(caster, "Ordered [count] grunts to " + msg)
    else
        to_chat(caster, "We weren't able to order anyone.")
