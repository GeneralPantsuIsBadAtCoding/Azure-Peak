
///books that teach things (intrinsic actions like bar flinging, spells like fireball or smoke, or martial arts)///

/obj/item/book/granter
	due_date = 0 // Game time in deciseconds
	unique = 1   // 0  Normal book, 1  Should not be treated as normal book, unable to be copied, unable to be modified
	var/list/remarks = list() //things to read about while learning.
	var/pages_to_mastery = 3 //Essentially controls how long a mob must keep the book in his hand to actually successfully learn
	var/reading = FALSE //sanity
	var/oneuse = TRUE //default this is true, but admins can var this to 0 if we wanna all have a pass around of the rod form book
	var/used = FALSE //only really matters if oneuse but it might be nice to know if someone's used it for admin investigations perhaps

/obj/item/book/granter/proc/turn_page(mob/user)
	playsound(user, pick('sound/blank.ogg'), 30, TRUE)
	if(do_after(user,50, user))
		if(remarks.len)
			to_chat(user, span_notice("[pick(remarks)]"))
		else
			to_chat(user, span_notice("I keep reading..."))
		return TRUE
	return FALSE

/obj/item/book/granter/proc/recoil(mob/user) //nothing so some books can just return

/obj/item/book/granter/proc/already_known(mob/user)
	return FALSE

/obj/item/book/granter/proc/on_reading_start(mob/user)
	to_chat(user, span_notice("I start reading [name]..."))

/obj/item/book/granter/proc/on_reading_stopped(mob/user)
	to_chat(user, span_notice("I stop reading..."))

/obj/item/book/granter/proc/on_reading_finished(mob/user)
	to_chat(user, span_notice("I finish reading [name]!"))

/obj/item/book/granter/proc/onlearned(mob/user)
	used = TRUE


/obj/item/book/granter/attack_self(mob/living/user)
	if(user.mind?.has_studied == TRUE)
		to_chat(user, span_notice("These symbols assault my mind -- I cannot control the book's power!"))
		recoil(user)
		return FALSE
	if(reading)
		to_chat(user, span_warning("I'm already reading this!"))
		return FALSE
	if(!user.can_read(src))
		return FALSE
	if(already_known(user))
		return FALSE
/*	AZURE PEAK REMOVAL -- UNUSED ANYWAY
	if(user.STAINT < 12)
			to_chat(user, span_warning("You can't make sense of the sprawling runes!"))
			return FALSE */
	if(used && oneuse)
		to_chat(user, span_warning("This fount of knowledge was not meant to be sipped from twice!"))
		recoil(user)
		return FALSE
	on_reading_start(user)
	reading = TRUE
	for(var/i=1, i<=pages_to_mastery, i++)
		if(!turn_page(user))
			reading = FALSE
			on_reading_stopped()
			return FALSE
	if(do_after(user, 50, user))
		reading = FALSE
		on_reading_finished(user)
		return TRUE
	reading = FALSE //failsafe
	return FALSE

/obj/item/book/granter/spell
	grid_width = 64
	grid_height = 32

	var/spell
	var/spellname = "conjure bugs"

/obj/item/book/granter/spell/already_known(mob/user)
	if(!spell)
		return TRUE
	for(var/obj/effect/proc_holder/spell/knownspell in user.mind.spell_list)
		if(knownspell.type == spell)
			if(user.mind)
				to_chat(user,span_warning("You've already read this one!"))
			return TRUE
	return FALSE

/obj/item/book/granter/spell/on_reading_start(mob/user)
	to_chat(user, span_notice("I start reading about casting [spellname]..."))

/obj/item/book/granter/spell/on_reading_finished(mob/user)
	to_chat(user, span_notice("I feel like you've experienced enough to cast [spellname]!"))
	var/obj/effect/proc_holder/spell/S = new spell
	user.mind.AddSpell(S)
	user.log_message("learned the spell [spellname] ([S])", LOG_ATTACK, color="orange")
	onlearned(user)

/obj/item/book/granter/spell/random
	icon_state = "random_book"

/obj/item/book/granter/spell/random/Initialize()
	. = ..()
	var/static/banned_spells = list(/obj/item/book/granter/spell/mimery_blockade)
	var/real_type = pick(subtypesof(/obj/item/book/granter/spell) - banned_spells)
	new real_type(loc)
	return INITIALIZE_HINT_QDEL

///ACTION BUTTONS///

/obj/item/book/granter/action
	var/granted_action
	var/actionname = "catching bugs" //might not seem needed but this makes it so you can safely name action buttons toggle this or that without it fucking up the granter, also caps

/obj/item/book/granter/action/already_known(mob/user)
	if(!granted_action)
		return TRUE
	for(var/datum/action/A in user.actions)
		if(A.type == granted_action)
			to_chat(user, span_warning("I already know all about [actionname]!"))
			return TRUE
	return FALSE

/obj/item/book/granter/action/on_reading_start(mob/user)
	to_chat(user, span_notice("I start reading about [actionname]..."))

/obj/item/book/granter/action/on_reading_finished(mob/user)
	to_chat(user, span_notice("I feel like you've got a good handle on [actionname]!"))
	var/datum/action/G = new granted_action
	G.Grant(user)
	onlearned(user)

//Crafting Recipe books

/obj/item/book/granter/crafting_recipe
	var/list/crafting_recipe_types = list()

/obj/item/book/granter/crafting_recipe/on_reading_finished(mob/user)
	. = ..()
	if(!user.mind)
		return
	for(var/crafting_recipe_type in crafting_recipe_types)
		var/datum/crafting_recipe/R = crafting_recipe_type
		user.mind.teach_crafting_recipe(crafting_recipe_type)
		to_chat(user,span_notice("I learned how to make [initial(R.name)]."))

//! --BLACKSTONE SCROLLS-- !/
/obj/item/book/granter/spell/blackstone/
    desc = "A scroll of potential known only to those that can decipher its secrets."
    icon = 'icons/roguetown/items/misc.dmi'
    oneuse = TRUE
    drop_sound = 'sound/foley/dropsound/paper_drop.ogg'
    pickup_sound =  'sound/blank.ogg'

/obj/item/book/granter/spell/blackstone/onlearned(mob/living/carbon/user)
	..()
	if(oneuse == TRUE)
		name = "siphoned scroll"
		desc = "A scroll once inscribed with magical scripture. The surface is now barren of knowledge, siphoned by someone else. It's utterly useless."
		icon_state = "scroll"
		user.visible_message(span_warning("[src] has had its magic ink ripped from the scroll!"))

/obj/item/book/granter/spell/blackstone/fireball
	name = "Scroll of Fireball"
	spell = /obj/effect/proc_holder/spell/invoked/projectile/fireball
	spellname = "fireball"
	icon_state ="scrollred"
	remarks = list("Ignis et oleum..", "Flammam continere ad momentum..", "Flammam iactare..", "Sit flamma constructum..")

/obj/item/book/granter/spell/blackstone/greaterfireball
	name = "Scroll of Greater Fireball"
	spell = /obj/effect/proc_holder/spell/invoked/projectile/fireball/greater
	spellname = "greater fireball"
	icon_state ="scrollred"
	remarks = list("Ignis et oleum..", "Flammam continere ad momentum..", "Flammam iactare..", "Sit flamma constructum..")

/obj/item/book/granter/spell/blackstone/lightning
	name = "Scroll of Lightning"
	spell = /obj/effect/proc_holder/spell/invoked/projectile/lightningbolt
	spellname = "lightning"
	icon_state ="scrollyellow"
	remarks = list("Essentia fulgurum digitorum..", "Fulgur de nubibus desuper..", "Fulgur eiecit digitos..", "Praecipe intus aedificatur..")

/obj/item/book/granter/spell/blackstone/fetch
	name = "Scroll of Fetch"
	spell = /obj/effect/proc_holder/spell/invoked/projectile/fetch
	spellname = "fetch"
	icon_state ="scrollpurple"
	remarks = list("Returnus Revico..", "Manus de reverti..", "Menus de returnus..")

/obj/item/book/granter/spell/blackstone/blindness
	name = "Scroll of Blindness"
	spell = /obj/effect/proc_holder/spell/invoked/blindness
	spellname = "blindness"
	icon_state ="scrollpurple"
	remarks = list("Occultare oculos..", "Vivus amoevtar..", "Visioner removan..")

/obj/item/book/granter/spell/blackstone/invisibility
	name = "Scroll of Invisibility"
	spell = /obj/effect/proc_holder/spell/invoked/invisibility
	spellname = "invisibility"
	icon_state ="scrollpurple"
	remarks = list("Pallium nihilum..", "Occultare veritatem..", "Veritatem removan menor..")

/obj/item/book/granter/spell/blackstone/skeleton
	name = "Scroll of Raise Skeleton"
	spell = /obj/effect/proc_holder/spell/invoked/raise_undead
	spellname = "Raise Skeleton"
	icon_state ="scrolldarkred"
	remarks = list("Redi damnatos..", "Exitio ad Necram scriptor exolvuntur..", "Ossa in propinquus..")

/obj/item/book/granter/spell/blackstone/sicknessray
	name = "Scroll of Sickness Ray"
	spell = /obj/effect/proc_holder/spell/invoked/projectile/sickness
	spellname = "Ray of Sickness"
	icon_state ="scrollgreen"
	remarks = list("Foe rubiginem meam..", "Pestilentia in terris..", "Trabes putrida..")

/obj/item/book/granter/spell/blackstone/bonechill
	name = "Scroll of Bone Chill"
	spell = /obj/effect/proc_holder/spell/invoked/bonechill
	spellname = "Bone Chill"
	icon_state ="scrolldarkred"
	remarks = list("Mediolanum ventis..", "Sana damnatorum..", "Frigidus ossa mortuorum..")

/obj/item/book/granter/spell/blackstone/acidsplash5e
	name = "Scroll of Acid Splash"
	spell = /obj/effect/proc_holder/spell/invoked/projectile/acidsplash5e
	spellname = "Acid Splash"
	icon_state ="scrolldarkred"
	remarks = list("Lapides corrodunt..", "Spuma venenosa..", "Guttae flavescentes..")

/obj/item/book/granter/spell/blackstone/spitfire
	name = "Scroll of Spitfire"
	spell = /obj/effect/proc_holder/spell/invoked/projectile/spitfire
	spellname = "Spitfire"
	icon_state ="scrollred"
	remarks = list("Ignis et oleum..", "Flammam continere ad momentum..", "Flammam iactare..", "Sit flamma constructum..")

/obj/item/book/granter/spell/blackstone/lesserknock
	name = "Scroll of Lesser Knock"
	spell = /obj/effect/proc_holder/spell/targeted/touch/lesserknock
	spellname = "Lesser Knock"
	icon_state ="scrollred"
	remarks = list("Clavis vetusta portam..", "Perdita numquam..", "Manus tremens..")

/obj/item/book/granter/spell/blackstone/repel
	name = "Scroll of Repel"
	spell = /obj/effect/proc_holder/spell/invoked/projectile/repel
	spellname = "Repel"
	icon_state ="scrolldarkred"
	remarks = list("Ventos adversos..", "Terra sibilat..", "Lapides vetusti..")


/obj/item/book/granter/spell/blackstone/poisonspray5e
	name = "Scroll of Aerosolize"
	spell = /obj/effect/proc_holder/spell/invoked/poisonspray5e
	spellname = "Aerosolize"
	icon_state ="scrolldarkred"
	remarks = list("Lapides corrodunt..", "Spuma venenosa..", "Guttae flavescentes..")
	

/obj/item/book/granter/spell/blackstone/guidance
	name = "Scroll of Guidance"
	spell = /obj/effect/proc_holder/spell/invoked/guidance
	spellname = "Guidance"
	icon_state ="scrolldarkred"
	remarks = list("Lux in tenebris..", "Passus certus umbras non timet..", "Anima viam scit..")

/obj/item/book/granter/spell/blackstone/frostbolt
	name = "Scroll of Frostbolt"
	spell = /obj/effect/proc_holder/spell/invoked/projectile/frostbolt
	spellname = "Frostbolt"
	icon_state ="scrolldarkred"
	remarks = list("Gelum serpentibus..", "Crystallum in silentio..", "Nullum ardor glaciem..")

/obj/item/book/granter/spell/blackstone/fortitude
	name = "Scroll of Fortitude"
	spell = /obj/effect/proc_holder/spell/invoked/fortitude
	spellname = "Fortitude"
	icon_state ="scrolldarkred"
	remarks = list("Animus in adversis..", "Gravitas oneris..", "Vita renascitur..")

/obj/item/book/granter/spell/blackstone/message
	name = "Scroll of Message"
	spell = /obj/effect/proc_holder/spell/self/message
	spellname = "Message"
	icon_state ="scrolldarkred"
	remarks = list("Verba volant..", "Vincula inter mentes..", "Inter verba et silentium..")

/obj/item/book/granter/spell/blackstone/ensnare
	name = "Scroll of Ensnare"
	spell = /obj/effect/proc_holder/spell/invoked/slowdown_spell_aoe
	spellname = "Ensnare"
	icon_state ="scrolldarkred"
	remarks = list("Qui intrat..", "Radices in tenebris..", "Nexus occultus..")

/obj/item/book/granter/spell/blackstone/forcewall_weak
	name = "Scroll of Forcewall"
	spell = /obj/effect/proc_holder/spell/invoked/forcewall_weak
	spellname = "Forcewall"
	icon_state ="scrolldarkred"
	remarks = list("Murus non solum hostem..", "Manus invisibiles saxa invicem..", "Infracta moenia..")

/obj/item/book/granter/spell/blackstone/featherfall
	name = "Scroll of Featherfall"
	spell = /obj/effect/proc_holder/spell/invoked/featherfall
	spellname = "Featherfall"
	icon_state ="scrolldarkred"
	remarks = list("In silentio cadit..", "Alis levitas..", "Plumis taciti dolores..")

/obj/item/book/granter/spell/blackstone/enlarge
	name = "Scroll of Enlarge"
	spell = /obj/effect/proc_holder/spell/invoked/enlarge
	spellname = "Enlarge"
	icon_state ="scrolldarkred"
	remarks = list("Immensum agitur..", "Montes tremunt..", "Quantitas expanditur..")

/obj/item/book/granter/spell/blackstone/leap
	name = "Scroll of Leap"
	spell = /obj/effect/proc_holder/spell/invoked/leap
	spellname = "Leap"
	icon_state ="scrolldarkred"
	remarks = list("Altitudinem revelat..", "Cuius pedes in aere volant..", "In levitate audacia..")

//scroll for giving the reader a spell point, this should be dungeon loot
/obj/item/book/granter/spell_points
	name = "Arcyne Insight"
	icon_state = "scrollpurple"
	icon = 'icons/roguetown/items/misc.dmi'
	oneuse = TRUE
	drop_sound = 'sound/foley/dropsound/paper_drop.ogg'
	pickup_sound =  'sound/blank.ogg'

/obj/item/book/granter/spell_points/on_reading_finished(mob/user)
	var/arcaneskill = user.mind.get_skill_level(/datum/skill/magic/arcane)
	if(arcaneskill >= SKILL_LEVEL_NOVICE) //Required arcane skill of NOVICE or higher to use the granter
		to_chat(user, span_notice("I absorb the insights on the scroll, and feel more adept at spellcraft!"))
		user.mind.adjust_spellpoints(1)
		onlearned(user)
	else
		to_chat(user, span_notice("I don't know what to make of this."))

/obj/item/book/granter/spell_points/onlearned(mob/living/carbon/user)
	..()
	if(oneuse == TRUE)
		name = "siphoned scroll"
		desc = "A scroll once inscribed with magical scripture. The surface is now barren of knowledge, siphoned by someone else. It's utterly useless."
		icon_state = "scroll"
		user.visible_message(span_warning("[src] has had its magic ink ripped from the scroll!"))
