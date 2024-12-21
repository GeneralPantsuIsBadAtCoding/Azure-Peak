// Soul Churner - Music box which applies magic resistance to Inquisition members, greatly mood debuffs everyone not a Psydon worshipper.
/obj/item/psydonmusicbox
	name = "melancholic crankbox"
	desc = ""
	icon_state = "psydonmusicbox"
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_HUGE
	var/cranking = FALSE
	force = 15
	max_integrity = 100
	attacked_sound = 'sound/combat/hits/onwood/education2.ogg'
	gripped_intents = list(/datum/intent/hit)
	possible_item_intents = list(/datum/intent/hit)
	obj_flags = CAN_BE_HIT
	twohands_required = TRUE
	var/datum/looping_sound/psydonmusicboxsound/soundloop


/obj/item/psydonmusicbox/examine(mob/user)
	. = ..()
	if(HAS_TRAIT(usr, TRAIT_INQUISITION))
		desc = "A relic from the bowels of the Otavan cathedral's thaumaturgical workshops. Fourteen souls of heretics, all bound together, they will scream and protect us from magicks. It would be wise to not teach the heretics of its true nature, to only bring it to bear in dire circumstances."
	else
		desc = "A cranked music box, it has the seal of the Otavan Inquisition on the side. It carries a somber feeling to it..."

/obj/item/psydonmusicbox/attack_self(mob/living/user)
	. = ..()
	if(!HAS_TRAIT(usr, TRAIT_INQUISITION))
		user.add_stress(/datum/stressevent/soulchurnerhorror)
		to_chat(user, (span_cultsmall("I FEEL SUFFERING WITH EVERY CRANK, WHAT AM I DOING?!")))
	cranking = !cranking
	update_icon()
	if(cranking)
		user.apply_status_effect(/datum/status_effect/buff/cranking_soulchurner)
		soundloop.start()
		var/songhearers = view(7, user)
		for(var/mob/living/carbon/human/target in songhearers)
			to_chat(target,span_cultsmall("[user] begins cranking the soul churner..."))
	if(!cranking)
		soundloop.stop()
		user.remove_status_effect(/datum/status_effect/buff/cranking_soulchurner)

/obj/item/psydonmusicbox/Initialize()
	soundloop = new(src, FALSE)
	. = ..()

/obj/item/psydonmusicbox/Destroy()
	if(soundloop)
		QDEL_NULL(soundloop)
	src.visible_message(span_cult("A great deluge of souls escapes the shattered box!"))
	return ..()

/obj/item/psydonmusicbox/update_icon()
	if(cranking)
		icon_state = "psydonmusicbox_active"
	else
		icon_state = "psydonmusicbox"

/obj/item/psydonmusicbox/dropped(mob/living/user, silent)
	..()
	cranking = FALSE
	update_icon()
	if(soundloop)
		soundloop.stop()
		user.remove_status_effect(/datum/status_effect/buff/cranking_soulchurner)

/obj/item/psydonmusicbox/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -1,"sy" = 0,"nx" = 11,"ny" = 1,"wx" = 0,"wy" = 1,"ex" = 4,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 15,"sturn" = 0,"wturn" = 0,"eturn" = 39,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 8)

/atom/movable/screen/alert/status_effect/buff/cranking_soulchurner
	name = "Cranking Soulchurner"
	desc = "I am bringing the twisted device to life..."
	icon_state = "buff"

/datum/status_effect/buff/cranking_soulchurner
	id = "crankchurner"
	alert_type = /atom/movable/screen/alert/status_effect/buff/cranking_soulchurner
	var/effect_color
	var/pulse = 0
	var/ticks_to_apply = 10
	var/astratanlines =list("'HER LIGHT HAS LEFT ME! WHERE AM I?!'", "'SHATTER THIS CONTRAPTION, SO I MAY FEEL HER WARMTH ONE LAST TIME!'", "'I am royal.. Why did they do this to me...?'")
	var/noclines =list("'Colder than moonlight...'", "'No wisdom can reach me here...'", "'Please help me, I miss the stars...'")
	var/necralines =list("'They snatched me from her grasp, for eternal torment...'", "'Necra! Please! I am so tired! Release me!'", "'I am lost, lost in a sea of stolen ends.'")
	var/abyssorlines =list("'I cannot feel the coast's breeze...'", "'We churn tighter here than schooling fish...'", "'Free me, please, so I may return to the sea...'")
	var/ravoxlines =list("'Ravoxian kin! Tear this Otavan dog's head off! Free me from this damnable witchery!'", "'There is no justice nor glory to be found here, just endless fatigue...'", "'I begged for a death by the sword...'")
	var/pestralines =list("'I only wanted to perfect my cures...'", "'A thousand plagues upon the holder of this accursed machine! Pestra! Can you not hear me?!'", "'I can feel their suffering as they brush against me...'")
	var/eoralines =list("'Every caress feels like a thousand splintering bones...'", "'She was a heretic, but how could I hurt her?!'", "'I'm sorry! I only wanted peace! Please release me!'")
	var/dendorlines =list("'HIS MADNESS CALLS FOR ME! RRGHNN...'", "'SHATTER THIS BOX, SO WE MAY CHOKE THIS OTAVAN ON DIRT AND ROOTS!'", "'I miss His voice in the leaves... Free me, please...'")
	var/xylixlines =list("'ONE, TWO, THREE, FOUR- TWO, TWO, THREE, FOUR. --What do you mean, annoying?'", "'There are thirteen others in here, you know! What a good audience- they literally can't get out of their seats!'", "'Of course I went all-in! I thought he had an ace-high!'", "'No, the XYLIX'S FORTUNE was right- this definitely is quite bad.'")
	var/malumlines =list("'The structure of this cursed machine is malleable.. Shatter it, please...'", "'My craft could've changed the world...'", "'Free me, so I may return to my apprentice, please...'")
	var/matthioslines =list("'My final transaction... He will never receive my value... Stolen away by these monsters...'", "'Comrade, I have been shackled into this HORRIFIC CONTRAPTION, FREE ME!'", "'I feel our shackles twist with eachother's...'")
	var/zizolines =list("'ZAELORION! MY MAGICKS FAIL ME! STRIKE DOWN THESE PSYDONIAN DOGS!'", "'CABALIST? There is TWISTED MAGICK HERE, BEWARE THE MUSIC! OUR VOICES ARE FORCED!'", "'DESTROY THE BOX, KILL THE WIELDER. YOUR MAGICKS WILL BE FREE.'")
	var/graggarlines =list("'ANOINTED! TEAR THIS OTAVAN'S HEAD OFF!'", "'ANOINTED! SHATTER THE BOX, AND WE WILL KILL THEM TOGETHER!'", "'GRAGGAR, GIVE ME STRENGTH TO BREAK MY BONDS!'")
	var/baothalines =list("'I miss the warmth of ozium... There is no feeling in here for me...'", "'Debauched one, rescue me from this contraption, I have such things to share with you.'", "'MY PERFECTION WAS TAKEN FROM ME BY THESE OTAVAN MONSTERS!'")
	var/psydonianlines =list("'FREE US! FREE US! WE HAVE SUFFERED ENOUGH!'", "'PLEASE, RELEASE US!", "WE MISS OUR FAMILIES'", "'WHEN WE ESCAPE, WE ARE GOING TO CHASE YOU INTO YOUR GRAVE.'")


/datum/status_effect/buff/cranking_soulchurner/on_creation(mob/living/new_owner, stress, colour)
	effect_color = "#800000"
	return ..()

/datum/status_effect/buff/cranking_soulchurner/tick()
	var/obj/effect/temp_visual/music_rogue/M = new /obj/effect/temp_visual/music_rogue(get_turf(owner))
	M.color = "#800000"
	pulse += 1
	if (pulse >= ticks_to_apply)
		pulse = 0
		if(!HAS_TRAIT(owner, TRAIT_INQUISITION))
			owner.add_stress(/datum/stressevent/soulchurnerhorror)
		for (var/mob/living/carbon/human/H in hearers(7, owner))
			if (!H.client)
				continue
			if (!H.has_stress_event(/datum/stressevent/soulchurner))
				switch(H.patron?.type)
					if(/datum/patron/old_god)
						if (!H.has_stress_event(/datum/stressevent/soulchurnerpsydon))
							H.add_stress(/datum/stressevent/soulchurnerpsydon)
							to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
							to_chat(H, (span_cultsmall(pick(psydonianlines))))
						if(HAS_TRAIT(H, TRAIT_INQUISITION))
							H.apply_status_effect(/datum/status_effect/buff/churnerprotection)
					if(/datum/patron/inhumen/matthios)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(matthioslines))))
						H.add_stress(/datum/stressevent/soulchurner)
					if(/datum/patron/inhumen/zizo)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(zizolines))))
						H.add_stress(/datum/stressevent/soulchurner)
					if(/datum/patron/inhumen/graggar)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(graggarlines))))
						H.add_stress(/datum/stressevent/soulchurner)
					if(/datum/patron/inhumen/baotha)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(baothalines))))
						H.add_stress(/datum/stressevent/soulchurner)
					if(/datum/patron/divine/astrata)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(astratanlines))))
						H.add_stress(/datum/stressevent/soulchurner)
					if(/datum/patron/divine/noc)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(noclines))))
						H.add_stress(/datum/stressevent/soulchurner)
					if(/datum/patron/divine/necra)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(necralines))))
						H.add_stress(/datum/stressevent/soulchurner)
					if(/datum/patron/divine/pestra)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(pestralines))))
						H.add_stress(/datum/stressevent/soulchurner)
					if(/datum/patron/divine/malum)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(malumlines))))
						H.add_stress(/datum/stressevent/soulchurner)
					if(/datum/patron/divine/dendor)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(dendorlines))))
						H.add_stress(/datum/stressevent/soulchurner)
					if(/datum/patron/divine/xylix)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(xylixlines))))
						H.add_stress(/datum/stressevent/soulchurner)
					if(/datum/patron/divine/eora)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(eoralines))))
						H.add_stress(/datum/stressevent/soulchurner)
					if(/datum/patron/divine/abyssor)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(abyssorlines))))
						H.add_stress(/datum/stressevent/soulchurner)
					if(/datum/patron/divine/ravox)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(ravoxlines))))		
						H.add_stress(/datum/stressevent/soulchurner)
