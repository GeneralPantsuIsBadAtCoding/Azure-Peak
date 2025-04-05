/obj/structure/ritualcircle
	name = "ritual circle"
	desc = ""
	icon = 'icons/roguetown/misc/rituals.dmi'
	icon_state = "ritual_base"
	layer = BELOW_OBJ_LAYER
	density = FALSE
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/structure/ritualcircle/attack_right(mob/living/carbon/human/user)
	user.visible_message(span_warning("[user] begins wiping away the rune"))
	if(do_after(user, 15))
		playsound(loc, 'sound/foley/cloth_wipe (1).ogg', 100, TRUE)
		qdel(src)

// This'll be our tutorial ritual for those who want to make more later, let's go into details in comments, mm? - Onutsio 
/obj/structure/ritualcircle/astrata
	name = "Rune of the Sun" // defines name of the circle itself
	icon_state = "astrata_chalky" // the icon state, so, the sprite the runes use on the floor. As of making, we have 6, each needs an active/inactive state. 
	desc = "A Holy Rune of Astrata" // description on examine
	var/solarrites = list("Guiding Light") // This is important - This is the var which stores every ritual option available to a ritualist - Ideally, we'd have like, 3 for each God. Right now, just 1.

/obj/structure/ritualcircle/astrata/attack_hand(mob/living/user) 
	if((user.patron?.type) != /datum/patron/divine/astrata)
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user,span_smallred("I don't know the proper rites for this...")) // You need ritualist to use them
		return
	if(user.has_status_effect(/datum/status_effect/debuff/ritesexpended))
		to_chat(user,span_smallred("I have performed enough rituals for the day... I must rest before communing more.")) // If you have already done a ritual in the last 30 minutes, you cannot do another.
		return
	var/riteselection = input(user, "Rituals of the Sun", src) as null|anything in solarrites // When you use a open hand on a rune, It'll give you a selection of all the rites available from that rune
	switch(riteselection) // rite selection goes in this section, try to do something fluffy. Presentation is most important here, truthfully.
		if("Guiding Light") // User selects Guiding Light, begins the stuff for it
			if(do_after(user, 50)) // just flavor stuff before activation
				user.say("I beseech the she-form of the Twinned God!!")
				if(do_after(user, 50))
					user.say("To bring Order to a world of naught!!")
					if(do_after(user, 50))
						user.say("Place your gaze upon me, oh Radiant one!!")
						to_chat(user,span_danger("You feel the eye of Astrata turned upon you. Her warmth dances upon your cheek. You feel yourself warming up...")) // A bunch of flavor stuff, slow incanting.
						icon_state = "astrata_active"
						if(!HAS_TRAIT(user, TRAIT_CHOSEN)) //Priests don't burst into flames.
							loc.visible_message(span_warning("[user]'s bursts to flames! Embraced by Her Warmth wholly!"))
							playsound(loc, 'sound/combat/hits/burn (1).ogg', 100, FALSE, -1)
							user.adjust_fire_stacks(10)
							user.IgniteMob()
							user.flash_fullscreen("redflash3")
							user.emote("firescream")
						guidinglight(src) // Actually starts the proc for applying the buff
						user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)
						spawn(120)
							icon_state = "astrata_chalky"

/obj/structure/ritualcircle/astrata/proc/guidinglight(src)
	var/ritualtargets = view(7, loc) // Range of 7 from the source, which is the rune
	for(var/mob/living/carbon/human/target in ritualtargets) // defines the target as every human in this range
		target.apply_status_effect(/datum/status_effect/buff/guidinglight) // applies the status effect
		to_chat(target,span_cultsmall("Astrata's light guides me forward, drawn to me by the Ritualist's pyre!"))
		playsound(target, 'sound/magic/holyshield.ogg', 80, FALSE, -1) // Cool sound!
// If you want to review a more complicated one, Undermaiden's Bargain is probs the most complicated of the starting set. - Have fun! - Onutsio 🏳️‍⚧️


/obj/structure/ritualcircle/noc
	name = "Rune of the Moon"
	icon_state = "noc_chalky"
	desc = "A Holy Rune of Noc"
	var/lunarrites = list("Moonlight Dance") // list for more to be added later

/obj/structure/ritualcircle/noc/attack_hand(mob/living/user)
	if((user.patron?.type) != /datum/patron/divine/noc)
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(user.has_status_effect(/datum/status_effect/debuff/ritesexpended))
		to_chat(user,span_smallred("I have performed enough rituals for the day... I must rest before communing more."))
		return
	var/riteselection = input(user, "Rituals of the Moon", src) as null|anything in lunarrites
	switch(riteselection) // put ur rite selection here
		if("Moonlight Dance")
			if(do_after(user, 50))
				user.say("I beseech the he-form of the Twinned God!!")
				if(do_after(user, 50))
					user.say("To bring Wisdom to a world of naught!!")
					if(do_after(user, 50))
						user.say("Place your gaze upon me, oh wise one!!")
						to_chat(user,span_cultsmall("The waning half of the Twin-God carries but one eye. With some effort, it can be drawn upon supplicants."))
						playsound(loc, 'sound/magic/holyshield.ogg', 80, FALSE, -1)
						moonlightdance(src)
						user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)

/obj/structure/ritualcircle/noc/proc/moonlightdance(src)
	var/ritualtargets = view(7, loc)
	for(var/mob/living/carbon/human/target in ritualtargets)
		target.apply_status_effect(/datum/status_effect/buff/moonlightdance)

/obj/structure/ritualcircle/xylix
	name = "Rune of Trickery"
	desc = "A Holy Rune of Xylix"

/obj/structure/ritualcircle/ravox
	name = "Rune of the Warrior"
	desc = "A Holy Rune of Ravox"

/obj/structure/ritualcircle/pestra
	name = "Rune of Plague"
	desc = "A Holy Rune of Pestra"
	icon_state = "pestra_chalky"
	var/plaguerites = list("Flylord's Triage")


/obj/structure/ritualcircle/pestra/attack_hand(mob/living/user)
	if((user.patron?.type) != /datum/patron/divine/pestra)
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(user.has_status_effect(/datum/status_effect/debuff/ritesexpended))
		to_chat(user,span_smallred("I have performed enough rituals for the day... I must rest before communing more."))
		return
	var/riteselection = input(user, "Rituals of Plague", src) as null|anything in plaguerites
	switch(riteselection) // put ur rite selection here
		if("Flylord's Triage")
			if(do_after(user, 50))
				user.say("Buboes, phlegm, blood and guts!!")
				if(do_after(user, 50))
					user.say("Boils, bogeys, rots and pus!!")
					if(do_after(user, 50))
						user.say("Blisters, fevers, weeping sores!!")
						to_chat(user,span_danger("You feel something crawling up your throat, humming and scratching..."))
						if(do_after(user, 30))
							icon_state = "pestra_active"
							user.say("From your wounds, the fester pours!!")
							to_chat(user,span_cultsmall("My devotion to the Plague Queen allowing, her servants crawl up from my throat. Come now, father fly..."))
							loc.visible_message(span_warning("[user] opens their mouth, disgorging a great swarm of flies!"))
							playsound(loc, 'sound/misc/fliesloop.ogg', 100, FALSE, -1)
							flylordstriage(src)
							user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)
							spawn(120)
								icon_state = "pestra_chalky"

/obj/structure/ritualcircle/pestra/proc/flylordstriage(src)
	var/ritualtargets = view(0, loc)
	for(var/mob/living/carbon/human/target in ritualtargets)
		to_chat(target,span_userdanger("You feel them crawling into your wounds and pores. Their horrific hum rings through your ears as they do their work!"))
		target.flash_fullscreen("redflash3")
		target.emote("agony")
		target.Stun(200)
		target.Knockdown(200)
		to_chat(target, span_userdanger("UNIMAGINABLE PAIN!"))
		target.apply_status_effect(/datum/status_effect/buff/flylordstriage)

/obj/structure/ritualcircle/dendor
	name = "Rune of Beasts"
	desc = "A Holy Rune of Dendor"
	icon_state = "dendor_chalky"
	var/bestialrites = list("Rite of the Lesser Wolf")

/obj/structure/ritualcircle/dendor/attack_hand(mob/living/user)
	if((user.patron?.type) != /datum/patron/divine/dendor)
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(user.has_status_effect(/datum/status_effect/debuff/ritesexpended))
		to_chat(user,span_smallred("I have performed enough rituals for the day... I must rest before communing more."))
		return
	var/riteselection = input(user, "Rituals of Beasts", src) as null|anything in bestialrites
	switch(riteselection) // put ur rite selection here
		if("Rite of the Lesser Wolf")
			if(do_after(user, 50))
				user.say("RRRGH GRRRHHHG GRRRRRHH!!")
				playsound(loc, 'sound/vo/mobs/vw/idle (1).ogg', 100, FALSE, -1)
				if(do_after(user, 50))
					user.say("GRRRR GRRRRHHHH!!")
					playsound(loc, 'sound/vo/mobs/vw/idle (4).ogg', 100, FALSE, -1)
					if(do_after(user, 50))
						loc.visible_message(span_warning("[user] snaps and snarls at the rune. Drool runs down their lip..."))
						playsound(loc, 'sound/vo/mobs/vw/bark (1).ogg', 100, FALSE, -1)
						if(do_after(user, 30))
							icon_state = "dendor_active"
							loc.visible_message(span_warning("[user] snaps their head upward, they let out a howl!"))
							playsound(loc, 'sound/vo/mobs/wwolf/howl (2).ogg', 100, FALSE, -1)
							lesserwolf(src)
							user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)
							spawn(120)
								icon_state = "dendor_chalky"

/obj/structure/ritualcircle/dendor/proc/lesserwolf(src)
	var/ritualtargets = view(1, loc)
	for(var/mob/living/carbon/human/target in ritualtargets)
		target.apply_status_effect(/datum/status_effect/buff/lesserwolf)


/obj/structure/ritualcircle/malum
	name = "Rune of Forge"
	desc = "A Holy Rune of Malum"
	icon_state = "malum_chalky"
var/forgerites = list("Ritual of Blessed Reforgance")

/obj/structure/ritualcircle/malum/attack_hand(mob/living/user)
	if((user.patron?.type) != /datum/patron/divine/malum)
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(user.has_status_effect(/datum/status_effect/debuff/ritesexpended))
		to_chat(user,span_smallred("I have performed enough rituals for the day... I must rest before communing more."))
		return
	var/riteselection = input(user, "Rituals of Creation", src) as null|anything in forgerites
	switch(riteselection) // put ur rite selection here
		if("Ritual of Blessed Reforgance")
			if(do_after(user, 50))
				user.say("God of craft and heat of the forge!!")
				if(do_after(user, 50))
					user.say("Take forth these metals and rebirth them in your furnaces!")
					if(do_after(user, 50))
						user.say("Grant unto me the metals in which to forge great works!")
						to_chat(user,span_danger("You feel a sudden heat rising within you, burning within your chest.."))
						if(do_after(user, 30))
							icon_state = "malum_active"
							user.say("From your forge, may these creations be remade!!")
							loc.visible_message(span_warning("A wave of heat rushes out from the ritual circle before [user]. The metal is reforged in a flash of light!"))
							playsound(loc, 'sound/magic/churn.ogg', 100, FALSE, -1)
							holyreforge(src)
							user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)
							spawn(120)
								icon_state = "malum_chalky"

/obj/structure/ritualcircle/malum/proc/holyreforge(src)
	var/ritualtargets = view(7, loc)
	for(var/mob/living/carbon/human/target in ritualtargets)
		target.flash_fullscreen("whiteflash") //Cool effect!
	for (var/obj/item/ingot/silver/I in loc)
		qdel(I)
		new /obj/item/ingot/silverblessed(loc)
	for (var/obj/item/ingot/steel/I in loc)
		qdel(I)
		new /obj/item/ingot/steelholy(loc)

/obj/structure/ritualcircle/abyssor
	name = "Rune of Storm"
	desc = "A Holy Rune of Abyssor"

/obj/structure/ritualcircle/necra
	name = "Rune of Death"
	desc = "A Holy Rune of Necra"
	icon_state = "necra_chalky"
	var/deathrites = list("Undermaiden's Bargain")

/obj/structure/ritualcircle/necra/attack_hand(mob/living/user)
	if((user.patron?.type) != /datum/patron/divine/necra)
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(user.has_status_effect(/datum/status_effect/debuff/ritesexpended))
		to_chat(user,span_smallred("I have performed enough rituals for the day... I must rest before communing more."))
		return
	var/riteselection = input(user, "Rituals of Death", src) as null|anything in deathrites
	switch(riteselection) // put ur rite selection here
		if("Undermaiden's Bargain")
			loc.visible_message(span_warning("[user] sways before the rune, they open their mouth, though no words come out..."))
			playsound(user, 'sound/vo/mobs/ghost/whisper (3).ogg', 100, FALSE, -1)
			if(do_after(user, 60))
				loc.visible_message(span_warning("[user] silently weeps, yet their tears do not flow..."))
				playsound(user, 'sound/vo/mobs/ghost/whisper (1).ogg', 100, FALSE, -1)
				if(do_after(user, 60))
					loc.visible_message(span_warning("[user] locks up, as though someone had just grabbed them..."))
					to_chat(user,span_danger("You feel cold breath on the back of your neck..."))
					playsound(user, 'sound/vo/mobs/ghost/death.ogg', 100, FALSE, -1)
					if(do_after(user, 20))
						icon_state = "necra_active"
						user.say("Forgive me, the bargain is intoned!!")
						to_chat(user,span_cultsmall("My devotion to the Undermaiden has allowed me to strike a bargain for these souls...."))
						playsound(loc, 'sound/vo/mobs/ghost/moan (1).ogg', 100, FALSE, -1)
						undermaidenbargain(src)
						user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)
						spawn(120)
							icon_state = "necra_chalky"

/obj/structure/ritualcircle/necra/proc/undermaidenbargain(src)
	var/ritualtargets = view(7, loc)
	for(var/mob/living/carbon/human/target in ritualtargets)
		target.apply_status_effect(/datum/status_effect/buff/undermaidenbargain)
	

/obj/structure/ritualcircle/eora
	name = "Rune of Love"
	desc = "A Holy Rune of Eora"
	icon_state = "eora_chalky"

	var/peacerites = list("Rite of Pacification")

/obj/structure/ritualcircle/eora/attack_hand(mob/living/user)
	if((user.patron?.type) != /datum/patron/divine/eora)
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(user.has_status_effect(/datum/status_effect/debuff/ritesexpended))
		to_chat(user,span_smallred("I have performed enough rituals for the day... I must rest before communing more."))
		return
	var/riteselection = input(user, "Rituals of Love", src) as null|anything in peacerites
	switch(riteselection) // put ur rite selection here
		if("Rite of Pacification")
			if(do_after(user, 50))
				user.say("#Blessed be your weary head...")
				if(do_after(user, 50))
					user.say("#Full of strife and pain...")
					if(do_after(user, 50))
						user.say("#Let Her ease your fear...")
						if(do_after(user, 50))
							icon_state = "eora_active"
							pacify(src)
							user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)
							spawn(120)
								icon_state = "eora_chalky"

/obj/structure/ritualcircle/eora/proc/pacify(src)
	var/ritualtargets = view(0, loc)
	for(var/mob/living/carbon/human/target in ritualtargets)
		loc.visible_message(span_warning("[target] sways like windchimes in the wind..."))
		target.visible_message(span_green("I feel the burdens of my heart lifting. Something feels very wrong... I don't mind at all..."))
		target.apply_status_effect(/datum/status_effect/buff/pacify)

// TIME FOR THE ASCENDANT. These can be stronger. As they are pretty much antag exclusive - Iconoclast for Matthios, Lich for ZIZO. ZIZO!


/obj/structure/ritualcircle/zizo
	name = "Rune of Progress"
	desc = "A Holy Rune of ZIZO"
	icon_state = "zizo_chalky"
	var/zizorites = list("Rite of Armaments")

/obj/structure/ritualcircle/zizo/attack_hand(mob/living/user)
	if((user.patron?.type) != /datum/patron/inhumen/zizo)
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(user.has_status_effect(/datum/status_effect/debuff/ritesexpended))
		to_chat(user,span_smallred("I have performed enough rituals for the day... I must rest before communing more."))
		return
	var/riteselection = input(user, "Rituals of Progress", src) as null|anything in zizorites
	switch(riteselection) // put ur rite selection here
		if("Rite of Armaments")
			if(do_after(user, 50))
				user.say("ZIZO! ZIZO! DAME OF PROGRESS!!")
				if(do_after(user, 50))
					user.say("ZIZO! ZIZO! HEED MY CALL!!")
					if(do_after(user, 50))
						user.say("ZIZO! ZIZO! ARMS TO SLAY THE IGNORANT!!")
						if(do_after(user, 50))
							icon_state = "zizo_active"
							user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)
							zizoarmaments(src)
							spawn(120)
								icon_state = "zizo_chalky"

/obj/structure/ritualcircle/zizo/proc/zizoarmaments(src)
	var/onrune = view(0, loc)
	var/list/possible_targets = list()
	for(var/mob/living/carbon/human/persononrune in onrune)
		possible_targets += persononrune
	var/mob/living/carbon/human/target = pick(possible_targets)
	if(!HAS_TRAIT(target, TRAIT_CABAL))
		loc.visible_message(span_cult("THE RITE REJECTS ONE NOT OF THE CABAL"))
		return
	target.Stun(60)
	target.Knockdown(60)
	to_chat(target, span_userdanger("UNIMAGINABLE PAIN!"))
	target.emote("Agony")
	playsound(loc, 'sound/combat/newstuck.ogg', 50)
	loc.visible_message(span_cult("Great hooks come from the rune, embedding into [target]'s ankles, pulling them onto the rune. Then, into their wrists. Their lux is torn from their chest, and reforms into armor. "))
	spawn(20)
		playsound(loc, 'sound/combat/hits/onmetal/grille (2).ogg', 50)
		target.equipOutfit(/datum/outfit/job/roguetown/darksteelrite)
		target.apply_status_effect(/datum/status_effect/debuff/devitalised)
		spawn(40)
			to_chat(target, span_purple("They are ignorant, backwards, without hope. You. You will be powerful."))

/datum/outfit/job/roguetown/darksteelrite/pre_equip(mob/living/carbon/human/H)
	..()
	var/list/items = list()
	items |= H.get_equipped_items(TRUE)
	for(var/I in items)
		H.dropItemToGround(I, TRUE)
	H.drop_all_held_items()
	armor = /obj/item/clothing/suit/roguetown/armor/plate/full/zizo
	pants = /obj/item/clothing/under/roguetown/platelegs/zizo
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor/zizo
	gloves = /obj/item/clothing/gloves/roguetown/plate/zizo
	head = /obj/item/clothing/head/roguetown/helmet/heavy/zizo
	backr = /obj/item/rogueweapon/sword/long/zizo
	neck = /obj/item/clothing/neck/roguetown/bevor




/obj/structure/ritualcircle/matthios
	name = "Rune of Transaction"
	desc = "A Holy Rune of Matthios."
	icon_state = "matthios_chalky"
	var/matthiosrites = list("Rite of Armaments")


/obj/structure/ritualcircle/matthios/attack_hand(mob/living/user)
	if((user.patron?.type) != /datum/patron/inhumen/matthios)
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(user.has_status_effect(/datum/status_effect/debuff/ritesexpended))
		to_chat(user,span_smallred("I have performed enough rituals for the day... I must rest before communing more."))
		return
	var/riteselection = input(user, "Rituals of Transaction", src) as null|anything in matthiosrites
	switch(riteselection) // put ur rite selection here
		if("Rite of Armaments")
			if(do_after(user, 50))
				user.say("Gold and Silver, he feeds!!")
				if(do_after(user, 50))
					user.say("Pieces Tens, Hundreds, Thousands. The transactor feeds 'pon them all!!")
					if(do_after(user, 50))
						user.say("Arms to claim, Arms to take!!")
						if(do_after(user, 50))
							icon_state = "matthios_active"
							user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)
							matthiosarmaments(src)
							spawn(120)
								icon_state = "matthios_chalky"

/obj/structure/ritualcircle/matthios/proc/matthiosarmaments(src)
	var/onrune = view(0, loc)
	var/list/possible_targets = list()
	for(var/mob/living/carbon/human/persononrune in onrune)
		possible_targets += persononrune
	var/mob/living/carbon/human/target = pick(possible_targets)
	if(!HAS_TRAIT(target, TRAIT_COMMIE))
		loc.visible_message(span_cult("THE RITE REJECTS ONE WITHOUT GREED IN THEIR HEART!!"))
		return
	target.Stun(60)
	target.Knockdown(60)
	to_chat(target, span_userdanger("UNIMAGINABLE PAIN!"))
	target.emote("Agony")
	playsound(loc, 'sound/misc/smelter_fin.ogg', 50)
	loc.visible_message(span_cult("[target]'s lux pours from their nose, into the rune, gleaming golds sizzles. Molten gold and metals swirl into armor, seered to their skin."))
	spawn(20)
		playsound(loc, 'sound/combat/hits/onmetal/grille (2).ogg', 50)
		target.equipOutfit(/datum/outfit/job/roguetown/gildedrite)
		target.apply_status_effect(/datum/status_effect/debuff/devitalised)
		spawn(40)
			to_chat(target, span_cult("More to the maw, this shall help feed our greed."))


/datum/outfit/job/roguetown/gildedrite/pre_equip(mob/living/carbon/human/H)
	..()
	var/list/items = list()
	items |= H.get_equipped_items(TRUE)
	for(var/I in items)
		H.dropItemToGround(I, TRUE)
	H.drop_all_held_items()
	armor = /obj/item/clothing/suit/roguetown/armor/plate/full/matthios
	pants = /obj/item/clothing/under/roguetown/platelegs/matthios
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor/matthios
	gloves = /obj/item/clothing/gloves/roguetown/plate/matthios
	head = /obj/item/clothing/head/roguetown/helmet/heavy/matthios
	neck = /obj/item/clothing/neck/roguetown/chaincoif/chainmantle
