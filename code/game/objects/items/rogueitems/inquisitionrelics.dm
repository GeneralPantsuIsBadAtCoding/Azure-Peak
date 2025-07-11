// Reliquary Box and key - The Box Which contains these
/obj/structure/reliquarybox
	name = "otavan reliquary"
	desc = "A foreboding red chest with a intricate lock design. It seems to only fit a very specific key. Choose wisely."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "chestweird1"
	anchored = TRUE
	density = TRUE
	var/opened = FALSE

/obj/item/roguekey/psydonkey
	icon_state = "birdkey"
	name = "Reliquary Key"
	desc = "The single use key with which to unleash woe. Choose wisely."

/obj/structure/reliquarybox/attackby(obj/item/W, mob/user, params)
	if(ishuman(user))
		if(istype(W, /obj/item/roguekey/psydonkey))
			if(opened)
				to_chat(user, span_info("The reliquary box has already been opened..."))
				return
			qdel(W)
			to_chat(user, span_info("The reliquary lock takes my key as it opens, I take a moment to ponder what power was delivered to us..."))
			playsound(loc, 'sound/foley/doors/lock.ogg', 60)
			to_chat(user,)
			var/relics = list("Melancholic Crankbox - Antimagic", "Daybreak - Silver Whip", "Stigmata - Silver Halberd", "Apocrypha - Silver Greatsword", "Golgatha - SYON Shard Censer")
			var/relicchoice = input(user, "Choose your tool", "RELICS") as anything in relics
			var/obj/choice
			switch(relicchoice)
				if("Melancholic Crankbox - Antimagic")
					choice = /obj/item/psydonmusicbox
				if("Daybreak - Silver Whip")
					choice = /obj/item/rogueweapon/whip/antique/psywhip
				if("Stigmata - Silver Halberd")
					choice = /obj/item/rogueweapon/halberd/psyhalberd
					user.adjust_skillrank_up_to(/datum/skill/combat/polearms, 4, TRUE)	//We make sure the weapon is usable by the Inquisitor.
				if("Apocrypha - Silver Greatsword")
					choice = /obj/item/rogueweapon/greatsword/psygsword
					user.adjust_skillrank_up_to(/datum/skill/combat/swords, 4, TRUE)		//Ditto.
				if("Golgatha - SYON Shard Censer")
					choice = /obj/item/flashlight/flare/torch/lantern/psycenser
			to_chat(user, span_info("I have chosen the relic, may HE guide my hand."))
			var/obj/structure/closet/crate/chest/inqreliquary/realchest = new /obj/structure/closet/crate/chest/inqreliquary(get_turf(src))
			realchest.PopulateContents()
			choice = new choice(realchest)
			qdel(src)



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
	var/zizolines =list("'ZIZO! MY MAGICKS FAIL ME! STRIKE DOWN THESE PSYDONIAN DOGS!'", "'CABALIST? There is TWISTED MAGICK HERE, BEWARE THE MUSIC! OUR VOICES ARE FORCED!'", "'DESTROY THE BOX, KILL THE WIELDER. YOUR MAGICKS WILL BE FREE.'")
	var/graggarlines =list("'ANOINTED! TEAR THIS OTAVAN'S HEAD OFF!'", "'ANOINTED! SHATTER THE BOX, AND WE WILL KILL THEM TOGETHER!'", "'GRAGGAR, GIVE ME STRENGTH TO BREAK MY BONDS!'")
	var/baothalines =list("'I miss the warmth of ozium... There is no feeling in here for me...'", "'Debauched one, rescue me from this contraption, I have such things to share with you.'", "'MY PERFECTION WAS TAKEN FROM ME BY THESE OTAVAN MONSTERS!'")
	var/psydonianlines =list("'FREE US! FREE US! WE HAVE SUFFERED ENOUGH!'", "'PLEASE, RELEASE US!", "WE MISS OUR FAMILIES!'", "'WHEN WE ESCAPE, WE ARE GOING TO CHASE YOU INTO YOUR GRAVE.'")


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
						if(!H.has_status_effect(/datum/status_effect/buff/churnernegative))
							H.apply_status_effect(/datum/status_effect/buff/churnernegative)
					if(/datum/patron/inhumen/zizo)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(zizolines))))
						H.add_stress(/datum/stressevent/soulchurner)
						if(!H.has_status_effect(/datum/status_effect/buff/churnernegative))
							H.apply_status_effect(/datum/status_effect/buff/churnernegative)
					if(/datum/patron/inhumen/graggar)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(graggarlines))))
						H.add_stress(/datum/stressevent/soulchurner)
						if(!H.has_status_effect(/datum/status_effect/buff/churnernegative))
							H.apply_status_effect(/datum/status_effect/buff/churnernegative)
					if(/datum/patron/inhumen/baotha)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(baothalines))))
						H.add_stress(/datum/stressevent/soulchurner)
						if(!H.has_status_effect(/datum/status_effect/buff/churnernegative))
							H.apply_status_effect(/datum/status_effect/buff/churnernegative)
					if(/datum/patron/divine/astrata)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(astratanlines))))
						H.add_stress(/datum/stressevent/soulchurner)
						if(!H.has_status_effect(/datum/status_effect/buff/churnernegative))
							H.apply_status_effect(/datum/status_effect/buff/churnernegative)
					if(/datum/patron/divine/noc)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(noclines))))
						H.add_stress(/datum/stressevent/soulchurner)
						if(!H.has_status_effect(/datum/status_effect/buff/churnernegative))
							H.apply_status_effect(/datum/status_effect/buff/churnernegative)
					if(/datum/patron/divine/necra)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(necralines))))
						H.add_stress(/datum/stressevent/soulchurner)
						if(!H.has_status_effect(/datum/status_effect/buff/churnernegative))
							H.apply_status_effect(/datum/status_effect/buff/churnernegative)
					if(/datum/patron/divine/pestra)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(pestralines))))
						H.add_stress(/datum/stressevent/soulchurner)
						if(!H.has_status_effect(/datum/status_effect/buff/churnernegative))
							H.apply_status_effect(/datum/status_effect/buff/churnernegative)
					if(/datum/patron/divine/malum)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(malumlines))))
						H.add_stress(/datum/stressevent/soulchurner)
						if(!H.has_status_effect(/datum/status_effect/buff/churnernegative))
							H.apply_status_effect(/datum/status_effect/buff/churnernegative)
					if(/datum/patron/divine/dendor)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(dendorlines))))
						H.add_stress(/datum/stressevent/soulchurner)
						if(!H.has_status_effect(/datum/status_effect/buff/churnernegative))
							H.apply_status_effect(/datum/status_effect/buff/churnernegative)
					if(/datum/patron/divine/xylix)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(xylixlines))))
						H.add_stress(/datum/stressevent/soulchurner)
						if(!H.has_status_effect(/datum/status_effect/buff/churnernegative))
							H.apply_status_effect(/datum/status_effect/buff/churnernegative)
					if(/datum/patron/divine/eora)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(eoralines))))
						H.add_stress(/datum/stressevent/soulchurner)
						if(!H.has_status_effect(/datum/status_effect/buff/churnernegative))
							H.apply_status_effect(/datum/status_effect/buff/churnernegative)
					if(/datum/patron/divine/abyssor)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(abyssorlines))))
						H.add_stress(/datum/stressevent/soulchurner)
						if(!H.has_status_effect(/datum/status_effect/buff/churnernegative))
							H.apply_status_effect(/datum/status_effect/buff/churnernegative)
					if(/datum/patron/divine/ravox)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(ravoxlines))))
						H.add_stress(/datum/stressevent/soulchurner)
						if(!H.has_status_effect(/datum/status_effect/buff/churnernegative))
							H.apply_status_effect(/datum/status_effect/buff/churnernegative)
/*
Inquisitorial armory down here

/obj/structure/closet/crate/chest/inqarmory

/obj/structure/closet/crate/chest/inqarmory/PopulateContents()
	.=..()
	new /obj/item/rogueweapon/huntingknife/idagger/silver/psydagger(src)
	new /obj/item/rogueweapon/greatsword/psygsword(src)
	new /obj/item/rogueweapon/halberd/psyhalberd(src)
	new /obj/item/rogueweapon/whip/psywhip_lesser
	new /obj/item/rogueweapon/flail/sflail/psyflail
	new /obj/item/rogueweapon/spear/psyspear(src)
	new /obj/item/rogueweapon/sword/long/psysword(src)
	new /obj/item/rogueweapon/mace/goden/psymace(src)
	new /obj/item/rogueweapon/stoneaxe/battle/psyaxe(src)
	*/

/obj/item/flashlight/flare/torch/lantern/psycenser
	name = "Golgatha"
	desc = "A masterfully-crafted thurible that, when opened, emits a ghastly perfume that reinvigorates the flesh-and-steel of Psydonites. It is said to contain a volatile fragment of the Comet Syon, which - if mishandled - can lead to unforeseen consequences."
	icon_state = "psycenser"
	item_state = "psycenser"
	light_outer_range = 8
	light_color ="#70d1e2"
	possible_item_intents = list(/datum/intent/flail/strike/smash/golgotha)
	fuel = 999 MINUTES
	force = 30
	var/next_smoke
	var/smoke_interval = 2 SECONDS

/obj/item/flashlight/flare/torch/lantern/psycenser/examine(mob/user)
	. = ..()
	if(fuel > 0)
		. += span_info("If opened, it may bless Psydon weapons and those of Psydon faith.")
		. += span_warning("Smashing a creature with it open will create a devastating explosion and render it useless.")
	if(fuel <= 0)
		. += span_info("It is gone.")

/obj/item/flashlight/flare/torch/lantern/psycenser/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.4,"sx" = -2,"sy" = -4,"nx" = 9,"ny" = -4,"wx" = -3,"wy" = -4,"ex" = 2,"ey" = -4,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 45, "sturn" = 45,"wturn" = 45,"eturn" = 45,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 45,"sturn" = 45,"wturn" = 45,"eturn" = 45,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/flashlight/flare/torch/lantern/psycenser/attack_self(mob/user)
	if(fuel > 0)
		if(on)
			turn_off()
			possible_item_intents = list(/datum/intent/flail/strike/smash/golgotha)
			user.update_a_intents()
		else
			playsound(src.loc, 'sound/items/censer_on.ogg', 100)
			possible_item_intents = list(/datum/intent/flail/strike/smash/golgotha, /datum/intent/bless)
			user.update_a_intents()
			on = TRUE
			update_brightness()
			//force = on_damage
			if(soundloop)
				soundloop.start()
			if(ismob(loc))
				var/mob/M = loc
				M.update_inv_hands()
			START_PROCESSING(SSobj, src)
	else if(fuel <= 0 && user.used_intent.type == /datum/intent/weep)
		to_chat(user, span_info("It is gone. You weep."))
		user.emote("cry")

/obj/item/flashlight/flare/torch/lantern/psycenser/process()
	if(on && next_smoke < world.time)
		new /obj/effect/temp_visual/censer_dust(get_turf(src))
		next_smoke = world.time + smoke_interval
		

/obj/item/flashlight/flare/torch/lantern/psycenser/turn_off()
	playsound(src.loc, 'sound/items/censer_off.ogg', 100)
	if(soundloop)
		soundloop.stop()
	STOP_PROCESSING(SSobj, src)
	..()
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_hands()
		M.update_inv_belt()
	damtype = BRUTE


/obj/item/flashlight/flare/torch/lantern/psycenser/fire_act(added, maxstacks)
	return

/obj/item/flashlight/flare/torch/lantern/psycenser/afterattack(atom/movable/A, mob/user, proximity)
	. = ..()	//We smashed a guy with it turned on. Bad idea!
	if(ismob(A) && on && (user.used_intent.type == /datum/intent/flail/strike/smash/golgotha) && user.cmode)
		user.visible_message(span_warningbig("[user] smashes the exposed [src], shattering the shard of SYON!"))
		explosion(get_turf(A),devastation_range = 2, heavy_impact_range = 3, light_impact_range = 4, flame_range = 2, flash_range = 4, smoke = FALSE)
		fuel = 0
		turn_off()
		icon_state = "psycenser-broken"
		possible_item_intents = list(/datum/intent/weep)
		user.update_a_intents()
		for(var/mob/living/carbon/human/H in view(get_turf(src)))
			if(H.patron?.type == /datum/patron/old_god)	//Psydonites get VERY depressed seeing an artifact get turned into an ulapool caber.
				H.add_stress(/datum/stressevent/syoncalamity)
	if(isitem(A) && on && user.used_intent.type == /datum/intent/bless)
		var/datum/component/psyblessed/CP = A.GetComponent(/datum/component/psyblessed)
		if(CP)
			if(!CP.is_blessed)
				playsound(user, 'sound/magic/censercharging.ogg', 100)
				user.visible_message(span_info("[user] holds \the [src] over \the [A]..."))
				if(do_after(user, 50, target = A))
					CP.try_bless()
					new /obj/effect/temp_visual/censer_dust(get_turf(A))
			else
				to_chat(user, span_info("It has already been blessed."))
	if(ishuman(A) && on && (user.used_intent.type == /datum/intent/bless))
		var/mob/living/carbon/human/H = A
		if(H.patron?.type == /datum/patron/old_god)
			if(!H.has_status_effect(/datum/status_effect/buff/censerbuff))
				playsound(user, 'sound/magic/censercharging.ogg', 100)
				user.visible_message(span_info("[user] holds \the [src] over \the [A]..."))
				if(do_after(user, 50, target = A))
					H.apply_status_effect(/datum/status_effect/buff/censerbuff)
					to_chat(H, span_notice("The comet dust invigorates you."))
					playsound(H, 'sound/magic/holyshield.ogg', 100)
					new /obj/effect/temp_visual/censer_dust(get_turf(H))
			else
				to_chat(span_warning("They've already been blessed."))

		else
			to_chat(user, span_warning("They do not share our faith."))

/datum/component/psyblessed
	var/is_blessed
	var/pre_blessed
	var/added_force
	var/added_blade_int
	var/added_int
	var/added_def
	var/silver

/datum/component/psyblessed/Initialize(preblessed = FALSE, force, blade_int, int, def, makesilver)
	if(!istype(parent, /obj/item/rogueweapon))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(parent, COMSIG_ROGUEWEAPON_OBJFIX, PROC_REF(on_fix))
	pre_blessed = preblessed
	added_force = force
	added_blade_int = blade_int
	added_int = int
	added_def = def
	silver = makesilver
	if(pre_blessed)
		apply_bless()
		
/datum/component/psyblessed/proc/on_examine(datum/source, mob/user, list/examine_list)
	if(!is_blessed)
		examine_list += span_info("<font color = '#cfa446'>This object may be blessed by the lingering shard of COMET SYON. Until then, its impure alloying of silver-and-steel cannot blight inhumen foes on its own.</font>")
	if(is_blessed)
		examine_list += span_info("<font color = '#46bacf'>This object has been blessed by COMET SYON.</font>")
		if(silver)
			examine_list += span_info("It has been imbued with <b>silver</b>.")

/datum/component/psyblessed/proc/try_bless()
	if(!is_blessed)
		apply_bless()
		play_effects()
		return TRUE
	else
		return FALSE

/datum/component/psyblessed/proc/play_effects()
	if(isitem(parent))
		var/obj/item/I = parent
		playsound(I, 'sound/magic/holyshield.ogg', 100)
		I.visible_message(span_notice("[I] glistens with power as dust of COMET SYON lands upon it!"))

/datum/component/psyblessed/proc/apply_bless()
	if(isitem(parent))
		var/obj/item/I = parent
		is_blessed = TRUE
		I.force += added_force
		if(I.force_wielded)
			I.force_wielded += added_force
		if(I.max_blade_int)
			I.max_blade_int += added_blade_int
			I.blade_int = I.max_blade_int
		I.max_integrity += added_int
		I.obj_integrity = I.max_integrity
		I.wdefense += added_def
		if(silver)
			I.is_silver = silver
			I.smeltresult = /obj/item/ingot/silver
		I.name = "blessed [I.name]"
		I.AddComponent(/datum/component/metal_glint)

// This is called right after the object is fixed and all of its force / wdefense values are reset to initial. We re-apply the relevant bonuses.
/datum/component/psyblessed/proc/on_fix()
	var/obj/item/rogueweapon/I = parent
	I.force += added_force
	if(I.force_wielded)
		I.force_wielded += added_force
	I.wdefense += added_def

/obj/effect/temp_visual/censer_dust
	icon = 'icons/effects/effects.dmi'
	icon_state = "extinguish"
	duration = 8

/obj/item/inqarticles/bmirror
	name = "black mirror"
	desc = ""
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "bmirror"
	item_state = "bmirror"
	grid_height = 64
	grid_width = 32
	throw_speed = 3
	throw_range = 7
	throwforce = 15
	damtype = BURN
	force = 15
	dropshrink = 0
	hitsound = 'sound/blank.ogg'
	sellprice = 30
	resistance_flags = FIRE_PROOF
	var/opened = FALSE
	var/fedblood = FALSE
	var/whofedme
	var/bloody = FALSE
	var/openstate = "open"
	var/usesleft = 3
	var/active = FALSE
	var/broken = FALSE
	var/mob/living/carbon/human/target
	var/atom/movable/screen/alert/blackmirror/effect
	var/datum/looping_sound/blackmirror/soundloop

/obj/item/inqarticles/bmirror/examine(mob/user)
	. = ..()
	if(HAS_TRAIT(usr, TRAIT_INQUISITION))
		desc = "A mass-produced relic of the Otavan Inquisition. The exact method of the Black Mirror's operation remains a well-kept secret."
	else
		desc = ""

/obj/item/inqarticles/bmirror/proc/donefixating()
	bloody = TRUE
	active = FALSE
	fedblood = FALSE
	openstate = "bloody"
	whofedme = null
	target.clear_alert("blackmirror", TRUE)
	target.playsound_local(src, 'sound/items/blackeye.ogg', 40, FALSE)
	effect = null
	target = null	
	usesleft-- 
	soundloop.stop()	
	visible_message(span_info("[src] clouds itself with a chilling fog."))
	playsound(src, 'sound/items/blackmirror_no.ogg', 100, FALSE)
	update_icon()
	sleep(2 SECONDS)
	if(usesleft == 0)
		broken = TRUE
		playsound(src, 'sound/items/blackmirror_break.ogg', 100, FALSE)
		visible_message(span_info("[src] shatters, fog spilling from the splintering shards into the dead air."))
		openstate = "broken"
		update_icon()

/obj/item/inqarticles/bmirror/attack_self(mob/living/user)
	..()
	if(!user.mind)
		return
	if(!opened)
		to_chat(user, span_warning("It's not open."))
		return
	if(broken && bloody)
		to_chat(user, span_warning("The mirror has shattered, rendering it unusable."))
		if(HAS_TRAIT(user, TRAIT_INQUISITION))
			to_chat(user, span_notice("If I clean it, I can send it back to the Inquisition for repairs."))
		return
	if(broken && !bloody)
		to_chat(user, span_warning("The mirror has shattered, rendering it unusable. It's clean, at the very least."))
		if(HAS_TRAIT(user, TRAIT_INQUISITION))
			to_chat(user, span_notice("It's returnable via the HERMES now. I should get a Marque back."))
		return	
	if(bloody)
		to_chat(user, span_warning("The mirror is fogged over. I need to clean the blood from it with cloth before reuse."))
		return
	if(!fedblood)
		to_chat(user, span_warning("It looks like it needs blood to work properly."))
		return
	if(!active)
		var/input = input(user, "WHO DO YOU SEEK?", "THE PRICE IS PAID")
		if(!input)
			return
		if(!user.key)
			return
		for(var/mob/living/carbon/human/HL in GLOB.player_list)
			if(HL.real_name == input)
				target = HL
				active = TRUE
				effect = target.throw_alert("blackmirror", /atom/movable/screen/alert/blackmirror, override = TRUE)
				effect.source = src
				target.playsound_local(src, 'sound/items/blackeye_warn.ogg', 100, FALSE)
				playsound(src, 'sound/items/blackmirror_active.ogg', 100, FALSE)
				openstate = "active"
				addtimer(CALLBACK(src, PROC_REF(donefixating)), 2 MINUTES, TIMER_UNIQUE)
				soundloop.start()	
				return update_icon()	
			playsound(src, 'sound/items/blackmirror_no.ogg', 100, FALSE)
			to_chat(user, span_warning("[src] makes a grating sound."))
			return
	var/lookat = null
	if(alert(user, "WHERE ARE YOU LOOKING?", "BLACK MIRROR", "BLOOD", "FIXATION") != "BLOOD")
		lookat = target
	else
		lookat = whofedme
	playsound(src, 'sound/items/blackmirror_use.ogg', 100, FALSE)
	var/mob/dead/observer/screye/blackmirror/S = user.scry_ghost()
//	message_admins("SCRYING: [user.real_name] ([user.ckey]) looked at [lookat.real_name] ([lookat.ckey]) via black mirror.")
//	log_game("SCRYING: [user.real_name] ([user.ckey]) looked at [lookat.real_name] ([lookat.ckey]) via black mirror.")
	if(!S)
		return
	S.ManualFollow(lookat)
	S.add_client_colour(/datum/client_colour/nocshaded)
	user.visible_message(span_warning("[user] stares into [src], their eyes glazing over..."))
	addtimer(CALLBACK(S, TYPE_PROC_REF(/mob/dead/observer, reenter_corpse)), 4 SECONDS)
	sleep(41)
	playsound(user, 'sound/items/blackeye.ogg', 100, FALSE)
	return

/obj/item/inqarticles/bmirror/attack(mob/living/carbon/human/M, mob/user)
	if(!user.mind)
		return
	if(opened)
		if(broken)
			to_chat(user, span_warning("It's broken."))
			return
		if(bloody)
			to_chat(user, span_warning("The mirror is fogged over. I need to clean it with cloth before reuse."))
			return
		if(M == user)
			user.visible_message(span_notice("[user] presses upon [src]'s needle."))
			if(do_after(user, 30))
				playsound(src, 'sound/items/blackmirror_needle.ogg', 65, FALSE)
				whofedme = user
				openstate = "bloody"
				fedblood = TRUE
				return update_icon()
			return
		else
			user.visible_message(span_notice("[user] goes to press [M] with [src]'s needle."))
			if(do_after(user, 30, target = M))	
				playsound(M, 'sound/items/blackmirror_needle.ogg', 65, FALSE)
				whofedme = M
				openstate = "bloody"
				fedblood = TRUE
				return update_icon()
			return
	else
		to_chat(user, span_warning("I need to open it first."))
		return


/obj/item/inqarticles/bmirror/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(istype(I, /obj/item/natural/cloth))
		if(broken && bloody)
			if(do_after(user, 30))
				user.visible_message(span_info("[user] cleans [src] with [I]."))
				openstate = "cleaned"
				bloody = FALSE
				update_icon()
			return
		if(bloody)
			if(do_after(user, 30))
				user.visible_message(span_info("[user] cleans the fog and blood from [src] with [I]."))
				openstate = "open"
				bloody = FALSE
				update_icon()
		return

/obj/item/inqarticles/bmirror/attack_right(mob/user, obj/item/T)
	..()
	if(!user.mind)
		return
	if(istype(T, /obj/item/inqarticles/bmirror))
		openorshut()
	else
		openorshut()	

/obj/item/inqarticles/bmirror/proc/openorshut()
	if(opened)
		if(effect)
			target.clear_alert("blackmirror", TRUE)
			effect = null
			target.playsound_local(src, 'sound/items/blackeye.ogg', 40, FALSE)
		playsound(src, 'sound/items/blackmirror_shut.ogg', 100, FALSE)
		soundloop.stop()
		opened = FALSE
		icon_state = "[initial(icon_state)]"
		update_icon_state()
		return
	playsound(src, 'sound/items/blackmirror_open.ogg', 100, FALSE)
	if(target)
		target.playsound_local(src, 'sound/items/blackeye_warn.ogg', 100, FALSE)
		effect = target.throw_alert("blackmirror", /atom/movable/screen/alert/blackmirror, override = TRUE)
		effect.source = src
	if(active)	
		soundloop.start()	
	opened = TRUE
	return update_icon()

/obj/item/inqarticles/bmirror/update_icon()
	if(opened)
		icon_state = "[initial(icon_state)]_[openstate]"
	else
		icon_state = "[initial(icon_state)]"
	update_icon_state()	

/obj/item/inqarticles/bmirror/Initialize()
	soundloop = new(src, FALSE)
	. = ..()

/obj/item/inqarticles/bmirror/Destroy()
	if(soundloop)
		QDEL_NULL(soundloop)
	return ..()


/atom/movable/screen/alert/blackmirror
	name = "BLACK EYE"
	desc = "LOOK AT ME. I SEE YOU."
	icon_state = "blackeye"	
	var/obj/item/inqarticles/bmirror/source

/atom/movable/screen/alert/blackmirror/Click()
	var/mob/living/L = usr
	var/lookat = null

	if(alert(L, "KEEP LOOKING, WHAT WILL YOU FIND?", "BLACK EYED GAZE", "BLOOD", "MIRROR") != "BLOOD")
		lookat = source
	else
		lookat = source.whofedme
	playsound(L, 'sound/items/blackmirror_use.ogg', 100, FALSE)
	var/mob/dead/observer/screye/blackmirror/S = L.scry_ghost()
	if(!S)
		return
	S.ManualFollow(lookat)
	S.add_client_colour(/datum/client_colour/nocshaded)
	L.visible_message(span_warning("[L] looks inward as their eyes glaze over..."))
	addtimer(CALLBACK(S, TYPE_PROC_REF(/mob/dead/observer, reenter_corpse)), 4 SECONDS)
	sleep(41)
	playsound(L, 'sound/items/blackeye.ogg', 100, FALSE)
	return

/obj/item/inqarticles/spyglass
	name = "otavan nocshade eyepiece"
	desc = ""
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "spyglass"
	item_state = "spyglass"
	grid_height = 32
	grid_width = 32

/obj/item/inqarticles/spyglass/attack_self(mob/living/user)
	. = ..()
	