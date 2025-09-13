// Component for giving a mental breakdown to the victim if they see their killer.
// This is achieved by a player mob (with a trait) extracting a lux strand from another player mob's body. This gives them this component.
// Once a mob has this component, they can't have more lux strands removed until it expires. It only starts expiring once the lux thief decides to consume the strand.
// Lasts 45 minutes by design-default, but is obviously adjustable.
// It'd be better off being a status effect but those are purged by various other methods (including dying).
/datum/component/revival_trauma
	/// Owner of the component. Typed for ease of reference.
	var/mob/living/carbon/human/victim

	/// Valid killer reference.
	var/mob/living/carbon/human/killer

	var/is_active = FALSE
	var/duration = 30 MINUTES
	var/trauma_cd = 90 SECONDS
	var/next_trauma_time
	var/expires_on

	var/killer_real_name

	var/is_anon = FALSE
	var/anon_helmet
	var/anon_armor
	var/anon_name

/datum/component/revival_trauma/Initialize(mob/living/carbon/human/initiator)
	if(!ishuman(parent) || !ishuman(initiator))
		return COMPONENT_INCOMPATIBLE
	victim = parent
	killer = initiator
	killercleanup()
	START_PROCESSING(SSdcs, src)

/datum/component/revival_trauma/proc/killercleanup()
	if(killer.real_name != killer.name)
		is_anon = TRUE
		anon_name = killer.name
		if(killer.wear_armor)
			anon_armor = killer.wear_armor.name
		if(killer.head)
			anon_helmet = killer.head.name
	else
		killer_real_name = killer.real_name

/datum/component/revival_trauma/process()
	if(!is_active || !victim || victim.stat != CONSCIOUS)
		return
		
	if(expires_on < world.time)
		deactivate()
		return

	if(next_trauma_time > world.time)
		return
	
	for(var/mob/living/carbon/human/H in get_hearers_in_LOS(5, victim, RECURSIVE_CONTENTS_CLIENT_MOBS))
		if(is_anon)
			if(H.name != anon_name)
				continue
			if(H.wear_armor && anon_armor)
				if(H.wear_armor.name != anon_armor)
					continue
			if(H.head && anon_helmet)
				if(H.head.name != anon_helmet)
					continue
			//We're left with a matching masked name, matching (or absent) helmet, 
			//matching (or absent) outer armor -- this is very likely our killer (Or a funny false positive).
			if(H.stat != DEAD)
				traumatize(H)
				break
		else
			if(H.name == killer_real_name && H.stat != DEAD)
				traumatize(H)
				break

/datum/component/revival_trauma/proc/traumatize(mob/target)
	if(victim)
		victim.freak_out_targeted(target)
		victim.playsound_local(victim, 'sound/misc/trauma_jumpscare.ogg', 100, TRUE)
		victim.Stun(150)
		victim.Knockdown(150)
		if(prob(20))
			victim.emote("scream")
		else if(prob(80))
			victim.emote("whimper")
		var/msg = pick(list("IT'S THEM! I NEED TO GET AWAY!", "MY ANATHEMA!", "MY SOUL WEEPS AT THE SIGHT OF THEM!", "DAEMON!", "I NEED TO FLEE!", "I CANNOT LINGER!", "ECHO OF MY DEATH! I MUST BEGONE!"))
		send_msg_to_victim(span_crit("[msg]"))
		next_trauma_time = world.time + trauma_cd

/datum/component/revival_trauma/proc/activate()
	if(!isnull(victim))
		is_active = TRUE
		expires_on = world.time + duration
		victim.playsound_local(victim, 'sound/misc/trauma_notification.ogg', 100, TRUE)
		addtimer(CALLBACK(src, PROC_REF(send_msg_to_victim), span_userdanger("<i>A chill runs down my spine...</i>")), 1 SECONDS)
		addtimer(CALLBACK(src, PROC_REF(send_msg_to_victim), span_userdanger("<i>Visions flash before my eyes...</i>")), 5 SECONDS)
		var/msg
		if(is_anon)
			msg = "[anon_name]..."
			if(anon_armor)
				msg += " wearing... [anon_armor]..."
			if(anon_helmet)
				msg += " ...[anon_helmet]..."
		else
			msg = "[killer_real_name]'s face..."
		addtimer(CALLBACK(src, PROC_REF(send_msg_to_victim), span_userdanger("<i>[msg]</i>")), 9 SECONDS)

/datum/component/revival_trauma/proc/send_msg_to_victim(msg)
	to_chat(victim, msg)

/datum/component/revival_trauma/proc/deactivate()
	is_active = FALSE
	victim.playsound_local(victim, 'sound/misc/trauma_notification_good.ogg', 100, TRUE)
	send_msg_to_victim(span_green("The weight of trauma lifts off your chest. You feel at peace."))
	victim = null
	killer = null
	Destroy()

/obj/item/luxstrand
	name = "Lux Strand"
	desc = "A vile, torn piece of someone's lyfelux. Used by villainous sort to incur fear in their victims, should they ever return. It is bound to whoever torn it out of the deceased victim."
	icon = 'icons/roguetown/items/natural.dmi'
	icon_state = "lux_strand"
	var/mob/living/carbon/human/victim
	var/mob/living/carbon/human/killer

/obj/item/luxstrand/Initialize(mapload, mob/living/carbon/human/arg_victim, mob/living/carbon/human/arg_killer)
	. = ..()
	victim = arg_victim
	killer = arg_killer
	name = "Lux Strand ([victim?.real_name])"

/obj/item/luxstrand/attack_self(mob/user)
	. = ..()
	if(!victim || !(victim in GLOB.player_list))
		to_chat(user, "The strand to whom this belongs is no longer around or is too far. The strand shrivels up.\n<i>They have either far travelled, went SSD or it's a bug.</i>.")
		victim = null
		killer = null
		qdel(src)
		return
	if(user == killer)
		var/datum/component/revival_trauma/revcomp = victim?.GetComponent(/datum/component/revival_trauma)
		if(revcomp)
			revcomp.activate()
		visible_message(span_warning("<b>[user] consumes the strand!</b>"), span_warning("They will shrivel up at the sight of me. For a good length of a dae."))
		victim = null
		killer = null
		qdel(src)
	else if(user == victim)
		var/datum/component/revival_trauma/revcomp = victim?.GetComponent(/datum/component/revival_trauma)
		if(revcomp)
			revcomp.deactivate()
		visible_message(span_green("[user] rejoins themselves with their Lux Strand!"))
		victim = null
		killer = null
		qdel(src)
	else
		to_chat(user, span_warning("This strand is neither bound to you or from you."))
		return
