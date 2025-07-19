/datum/status_effect/buff
	status_type = STATUS_EFFECT_REFRESH


/datum/status_effect/buff/drunk
	id = "drunk"
	alert_type = /atom/movable/screen/alert/status_effect/buff/drunk
	effectedstats = list("intelligence" = -2, "endurance" = 1)
	duration = 5 MINUTES

/atom/movable/screen/alert/status_effect/buff/drunk
	name = "Drunk"
	desc = ""
	icon_state = "drunk"

/atom/movable/screen/alert/status_effect/buff/drunkmurk
	name = "Murk-Knowledge"
	desc = ""
	icon_state = "drunk"

/atom/movable/screen/alert/status_effect/buff/drunknoc
	name = "Noc-Shine Strength"
	desc = ""
	icon_state = "drunk"

/datum/status_effect/buff/murkwine
	id = "murkwine"
	alert_type = /atom/movable/screen/alert/status_effect/buff/drunkmurk
	effectedstats = list("intelligence" = 5)
	duration = 2 MINUTES

/datum/status_effect/buff/nocshine
	id = "nocshine"
	alert_type = /atom/movable/screen/alert/status_effect/buff/drunknoc
	effectedstats = list("strength" = 1, "endurance" = 1)
	duration = 2 MINUTES

/datum/status_effect/buff/foodbuff
	id = "foodbuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/foodbuff
	effectedstats = list("constitution" = 1,"endurance" = 1)
	duration = 15 MINUTES

/atom/movable/screen/alert/status_effect/buff/foodbuff
	name = "Great Meal"
	desc = ""
	icon_state = "foodbuff"

/datum/status_effect/buff/druqks
	id = "druqks"
	alert_type = /atom/movable/screen/alert/status_effect/buff/druqks
	effectedstats = list("intelligence" = 5,"speed" = 3,"fortune" = -5)
	duration = 2 MINUTES

/datum/status_effect/buff/druqks/baotha

/datum/status_effect/buff/druqks/baotha/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_CRACKHEAD, TRAIT_MIRACLE)

/datum/status_effect/buff/druqks/baotha/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_CRACKHEAD, TRAIT_MIRACLE)
	owner.visible_message("[owner]'s eyes appear to return to normal.")

/datum/status_effect/buff/druqks/on_apply()
	. = ..()
	owner.add_stress(/datum/stressevent/high)
	if(owner?.client)
		if(owner.client.screen && owner.client.screen.len)
			var/atom/movable/screen/plane_master/game_world/PM = locate(/atom/movable/screen/plane_master/game_world) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_fov_hidden) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_above) in owner.client.screen
			PM.backdrop(owner)

/datum/status_effect/buff/druqks/on_remove()
	owner.remove_stress(/datum/stressevent/high)
	if(owner?.client)
		if(owner.client.screen && owner.client.screen.len)
			var/atom/movable/screen/plane_master/game_world/PM = locate(/atom/movable/screen/plane_master/game_world) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_fov_hidden) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_above) in owner.client.screen
			PM.backdrop(owner)

	. = ..()

/atom/movable/screen/alert/status_effect/buff/druqks
	name = "High"
	desc = ""
	icon_state = "acid"

/datum/status_effect/buff/ozium
	id = "ozium"
	alert_type = /atom/movable/screen/alert/status_effect/buff/druqks
	effectedstats = list("speed" = -5, "perception" = 2)
	duration = 30 SECONDS

/datum/status_effect/buff/ozium/on_apply()
	. = ..()
	owner.add_stress(/datum/stressevent/ozium)
	ADD_TRAIT(owner, TRAIT_NOPAIN, TRAIT_GENERIC)

/datum/status_effect/buff/ozium/on_remove()
	owner.remove_stress(/datum/stressevent/ozium)
	REMOVE_TRAIT(owner, TRAIT_NOPAIN, TRAIT_GENERIC)
	. = ..()

/datum/status_effect/buff/moondust
	id = "moondust"
	alert_type = /atom/movable/screen/alert/status_effect/buff/druqks
	effectedstats = list("speed" = 2, "endurance" = 2, "intelligence" = -2)
	duration = 30 SECONDS

/datum/status_effect/buff/moondust/nextmove_modifier()
	return 0.8

/datum/status_effect/buff/moondust/on_apply()
	. = ..()
	owner.add_stress(/datum/stressevent/moondust)

/datum/status_effect/buff/moondust_purest
	id = "purest moondust"
	alert_type = /atom/movable/screen/alert/status_effect/buff/druqks
	effectedstats = list("speed" = 3, "endurance" = 3, "intelligence" = -2)
	duration = 40 SECONDS

/datum/status_effect/buff/moondust_purest/nextmove_modifier()
	return 0.8

/datum/status_effect/buff/moondust_purest/on_apply()
	. = ..()
	owner.add_stress(/datum/stressevent/moondust_purest)

/datum/status_effect/buff/herozium
	id = "herozium"
	alert_type = /atom/movable/screen/alert/status_effect/buff/druqks
	effectedstats = list("speed" = -5, "endurance" = 4, "intelligence" = -3, "constitution" = 3)
	duration = 80 SECONDS
	var/originalcmode = ""
	var/hadcritres = FALSE
	var/hadpainres = FALSE

/datum/status_effect/buff/herozium/nextmove_modifier()
	return 1.2

/datum/status_effect/buff/herozium/on_apply()
	. = ..()
	owner.add_stress(/datum/stressevent/ozium)
	if(!HAS_TRAIT(owner, TRAIT_NOPAIN))
		ADD_TRAIT(owner, TRAIT_NOPAIN, TRAIT_GENERIC)
	else
		hadpainres = TRUE
	if(!HAS_TRAIT(owner, TRAIT_CRITICAL_RESISTANCE))
		ADD_TRAIT(owner, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	else
		hadcritres = TRUE
	originalcmode = owner.cmode_music
	owner.cmode_music = 'sound/music/combat_ozium.ogg'

/datum/status_effect/buff/herozium/on_remove()
	owner.remove_stress(/datum/stressevent/ozium)
	if(!hadpainres)
		REMOVE_TRAIT(owner, TRAIT_NOPAIN, TRAIT_GENERIC)
	if(!hadcritres)
		REMOVE_TRAIT(owner, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	owner.cmode_music = originalcmode
	. = ..()

/datum/status_effect/buff/starsugar
	id = "starsugar"
	alert_type = /atom/movable/screen/alert/status_effect/buff/druqks
	effectedstats = list("speed" = 4, "endurance" = 4, "intelligence" = -3, "constitution" = -3)
	duration = 80 SECONDS
	var/originalcmode = ""
	var/haddodge = FALSE
	var/haddarkvision = FALSE

/datum/status_effect/buff/starsugar/nextmove_modifier()
	return 0.7

/datum/status_effect/buff/starsugar/on_apply()
	. = ..()
	owner.add_stress(/datum/stressevent/starsugar)
	if(!HAS_TRAIT(owner, TRAIT_DODGEEXPERT))
		ADD_TRAIT(owner, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	else
		haddodge = TRUE
	if(!HAS_TRAIT(owner, TRAIT_DARKVISION))
		ADD_TRAIT(owner, TRAIT_DARKVISION, TRAIT_GENERIC)
	else
		haddarkvision = TRUE
	if(owner.has_status_effect(/datum/status_effect/debuff/sleepytime))
		owner.remove_status_effect(/datum/status_effect/debuff/sleepytime)
	originalcmode = owner.cmode_music
	owner.cmode_music = 'sound/music/combat_starsugar.ogg'


/datum/status_effect/buff/starsugar/on_remove()
	if(!haddodge)
		REMOVE_TRAIT(owner, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	if(!haddarkvision)
		REMOVE_TRAIT(owner, TRAIT_DARKVISION, TRAIT_GENERIC)
	owner.remove_stress(/datum/stressevent/starsugar)
	owner.cmode_music = originalcmode
	. = ..()

/datum/status_effect/buff/weed
	id = "weed"
	alert_type = /atom/movable/screen/alert/status_effect/buff/weed
	effectedstats = list("intelligence" = 2,"speed" = -2,"fortune" = 2)
	duration = 10 SECONDS

/datum/status_effect/buff/weed/on_apply()
	. = ..()
	owner.add_stress(/datum/stressevent/weed)
	if(owner?.client)
		if(owner.client.screen && owner.client.screen.len)
			var/atom/movable/screen/plane_master/game_world/PM = locate(/atom/movable/screen/plane_master/game_world) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_fov_hidden) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_above) in owner.client.screen
			PM.backdrop(owner)

/datum/status_effect/buff/weed/on_remove()
	if(owner?.client)
		if(owner.client.screen && owner.client.screen.len)
			var/atom/movable/screen/plane_master/game_world/PM = locate(/atom/movable/screen/plane_master/game_world) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_fov_hidden) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_above) in owner.client.screen
			PM.backdrop(owner)

	. = ..()

/atom/movable/screen/alert/status_effect/buff/weed
	name = "Dazed"
	desc = ""
	icon_state = "weed"

/datum/status_effect/buff/vitae
	id = "druqks"
	alert_type = /atom/movable/screen/alert/status_effect/buff/vitae
	effectedstats = list("fortune" = 2)
	duration = 1 MINUTES

/datum/status_effect/buff/vitae/on_apply()
	. = ..()
	owner.add_stress(/datum/stressevent/high)
	SEND_SIGNAL(owner, COMSIG_LUX_TASTED)

/datum/status_effect/buff/vitae/on_remove()
	owner.remove_stress(/datum/stressevent/high)

	. = ..()

/atom/movable/screen/alert/status_effect/buff/vitae
	name = "Invigorated"
	desc = "I have supped on the finest of delicacies: life!"

/atom/movable/screen/alert/status_effect/buff/featherfall
	name = "Featherfall"
	desc = "I am somewhat protected against falling from heights."
	icon_state = "buff"

/datum/status_effect/buff/featherfall
	id = "featherfall"
	alert_type = /atom/movable/screen/alert/status_effect/buff/featherfall
	duration = 1 MINUTES

/datum/status_effect/buff/featherfall/on_apply()
	. = ..()
	to_chat(owner, span_warning("I feel lighter."))
	ADD_TRAIT(owner, TRAIT_NOFALLDAMAGE2, MAGIC_TRAIT)

/datum/status_effect/buff/featherfall/on_remove()
	. = ..()
	to_chat(owner, span_warning("The feeling of lightness fades."))
	REMOVE_TRAIT(owner, TRAIT_NOFALLDAMAGE2, MAGIC_TRAIT)

/atom/movable/screen/alert/status_effect/buff/darkvision
	name = "Darkvision"
	desc = "I can see in the dark somewhat."
	icon_state = "buff"

/datum/status_effect/buff/darkvision
	id = "darkvision"
	alert_type = /atom/movable/screen/alert/status_effect/buff/darkvision
	duration = 15 MINUTES

/datum/status_effect/buff/darkvision/on_apply(mob/living/new_owner, assocskill)
	if(assocskill)
		duration += 5 MINUTES * assocskill
	. = ..()
	to_chat(owner, span_warning("The darkness fades somewhat."))
	ADD_TRAIT(owner, TRAIT_DARKVISION, MAGIC_TRAIT)

/datum/status_effect/buff/darkvision/on_remove()
	. = ..()
	to_chat(owner, span_warning("The darkness returns to normal."))
	REMOVE_TRAIT(owner, TRAIT_DARKVISION, MAGIC_TRAIT)

/atom/movable/screen/alert/status_effect/buff/longstrider
	name = "Longstrider"
	desc = "I can easily walk through rough terrain."
	icon_state = "buff"

/datum/status_effect/buff/longstrider
	id = "longstrider"
	alert_type = /atom/movable/screen/alert/status_effect/buff/longstrider
	duration = 15 MINUTES

/datum/status_effect/buff/longstrider/on_apply()
	. = ..()
	to_chat(owner, span_warning("I am unburdened by the terrain."))
	ADD_TRAIT(owner, TRAIT_LONGSTRIDER, MAGIC_TRAIT)

/datum/status_effect/buff/longstrider/on_remove()
	. = ..()
	to_chat(owner, span_warning("The rough floors slow my travels once again."))
	REMOVE_TRAIT(owner, TRAIT_LONGSTRIDER, MAGIC_TRAIT)

/atom/movable/screen/alert/status_effect/buff/magearmor
	name = "Weakened Barrier"
	desc = "My magical barrier is weakened."
	icon_state = "stressvg"

/datum/status_effect/buff/magearmor
	id = "magearmor"
	alert_type = /atom/movable/screen/alert/status_effect/buff/magearmor

/datum/status_effect/buff/magearmor/on_apply()
	. = ..()
	playsound(owner, 'sound/magic/magearmordown.ogg', 75, FALSE)
	duration = (7-owner.get_skill_level(/datum/skill/magic/arcane)) MINUTES

/datum/status_effect/buff/magearmor/on_remove()
	. = ..()
	to_chat(owner, span_warning("My magical barrier reforms."))
	playsound(owner, 'sound/magic/magearmorup.ogg', 75, FALSE)
	owner.magearmor = 0

/atom/movable/screen/alert/status_effect/buff/guardbuffone
	name = "Vigilant Guardsman"
	desc = "My home. I watch vigilantly and respond swiftly."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/buff/barkeepbuff
	name = "Vigilant Tavernkeep"
	desc = "My home. I watch vigilantly and respond swiftly."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/buff/knightbuff
	name = "Sworn Defender"
	desc = "I've sworn an oath to defend this castle. My resolve will not waver."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/buff/wardenbuff
	name = "Woodsman"
	desc = "I've trekked these woods for some time now. I find traversal easier here."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/buff/dungeoneerbuff
	name = "Ruthless Jailor"
	desc = "This is my sanctuary. I can overpower any opposition that dares breach it."
	icon_state = "buff"

/datum/status_effect/buff/wardenbuff
	id = "wardenbuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/wardenbuff
	effectedstats = list("speed" = 1, "perception" = 3) 

/datum/status_effect/buff/barkeepbuff
	id = "barkeepbuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/barkeepbuff
	effectedstats = list("constitution" = 1,"endurance" = 1, "speed" = 1, "strength" = 3) 

/datum/status_effect/buff/barkeepbuff/process()

	.=..()
	var/area/rogue/our_area = get_area(owner)
	if(!(our_area.tavern_area))
		owner.remove_status_effect(/datum/status_effect/buff/barkeepbuff)

/datum/status_effect/buff/guardbuffone
	id = "guardbuffone"
	alert_type = /atom/movable/screen/alert/status_effect/buff/guardbuffone
	effectedstats = list("constitution" = 1,"endurance" = 1, "speed" = 1, "perception" = 2) 

/datum/status_effect/buff/dungeoneerbuff
	id = "dungeoneerbuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/dungeoneerbuff
	effectedstats = list("constitution" = 1,"endurance" = 1, "strength" = 2)//This only works in 2 small areas on the entire map

/datum/status_effect/buff/guardbuffone/process()

	.=..()
	var/area/rogue/our_area = get_area(owner)
	if(!(our_area.town_area))
		owner.remove_status_effect(/datum/status_effect/buff/guardbuffone)

/datum/status_effect/buff/wardenbuff/process()

	.=..()
	var/area/rogue/our_area = get_area(owner)
	if(!(our_area.warden_area))
		owner.remove_status_effect(/datum/status_effect/buff/wardenbuff)

/datum/status_effect/buff/wardenbuff/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_LONGSTRIDER, TRAIT_GENERIC)

/datum/status_effect/buff/wardenbuff/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_LONGSTRIDER, TRAIT_GENERIC)

/datum/status_effect/buff/dungeoneerbuff/process()

	.=..()
	var/area/rogue/our_area = get_area(owner)
	if(!(our_area.cell_area))
		owner.remove_status_effect(/datum/status_effect/buff/dungeoneerbuff)

/datum/status_effect/buff/dungeoneerbuff/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_CIVILIZEDBARBARIAN, TRAIT_GENERIC)

/datum/status_effect/buff/dungeoneerbuff/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_CIVILIZEDBARBARIAN, TRAIT_GENERIC)

/atom/movable/screen/alert/status_effect/buff/healing
	name = "Healing Miracle"
	desc = "Divine intervention relieves me of my ailments."
	icon_state = "buff"

#define MIRACLE_HEALING_FILTER "miracle_heal_glow"

/datum/status_effect/buff/healing
	id = "healing"
	alert_type = /atom/movable/screen/alert/status_effect/buff/healing
	duration = 10 SECONDS
	examine_text = "SUBJECTPRONOUN is bathed in a restorative aura!"
	var/healing_on_tick = 1
	var/outline_colour = "#c42424"

/datum/status_effect/buff/healing/on_creation(mob/living/new_owner, new_healing_on_tick)
	healing_on_tick = new_healing_on_tick
	return ..()

/datum/status_effect/buff/healing/on_apply()
	SEND_SIGNAL(owner, COMSIG_LIVING_MIRACLE_HEAL_APPLY, healing_on_tick, src)
	var/filter = owner.get_filter(MIRACLE_HEALING_FILTER)
	if (!filter)
		owner.add_filter(MIRACLE_HEALING_FILTER, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 60, "size" = 1))
	return TRUE

/datum/status_effect/buff/healing/tick()
	var/obj/effect/temp_visual/heal/H = new /obj/effect/temp_visual/heal_rogue(get_turf(owner))
	H.color = "#FF0000"
	var/list/wCount = owner.get_wounds()
	if(!owner.construct)
		if(owner.blood_volume < BLOOD_VOLUME_NORMAL)
			owner.blood_volume = min(owner.blood_volume+10, BLOOD_VOLUME_NORMAL)
		if(wCount.len > 0)
			owner.heal_wounds(healing_on_tick)
			owner.update_damage_overlays()
		owner.adjustBruteLoss(-healing_on_tick, 0)
		owner.adjustFireLoss(-healing_on_tick, 0)
		owner.adjustOxyLoss(-healing_on_tick, 0)
		owner.adjustToxLoss(-healing_on_tick, 0)
		owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, -healing_on_tick)
		owner.adjustCloneLoss(-healing_on_tick, 0)

/datum/status_effect/buff/healing/necras_vow
	id = "healing"
	alert_type = /atom/movable/screen/alert/status_effect/buff/healing
	duration = -1
	healing_on_tick = 3
	outline_colour = "#bbbbbb"

/datum/status_effect/buff/healing/necras_vow/on_apply()
	healing_on_tick = max(owner.get_skill_level(/datum/skill/magic/holy), 3)
	return TRUE

/datum/status_effect/buff/healing/necras_vow/tick()
	var/obj/effect/temp_visual/heal/H = new /obj/effect/temp_visual/heal_rogue(get_turf(owner))
	H.color = "#a5a5a5"
	var/list/wCount = owner.get_wounds()
	if(!owner.construct)
		if(owner.blood_volume < BLOOD_VOLUME_NORMAL)
			owner.blood_volume = min(owner.blood_volume + (healing_on_tick + 10), BLOOD_VOLUME_NORMAL)
		if(wCount.len > 0)
			owner.heal_wounds(healing_on_tick, list(/datum/wound/slash, /datum/wound/puncture, /datum/wound/bite, /datum/wound/bruise))
			owner.update_damage_overlays()
		owner.adjustBruteLoss(-healing_on_tick, 0)
		owner.adjustFireLoss(-healing_on_tick, 0)
		owner.adjustOxyLoss(-healing_on_tick, 0)
		owner.adjustToxLoss(-healing_on_tick, 0)
		owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, -healing_on_tick)
		owner.adjustCloneLoss(-healing_on_tick, 0)

/atom/movable/screen/alert/status_effect/buff/psyhealing
	name = "Enduring"
	desc = "I am awash with sentimentality."
	icon_state = "buff"

#define PSYDON_HEALING_FILTER "psydon_heal_glow"

/datum/status_effect/buff/psyhealing
	id = "psyhealing"
	alert_type = /atom/movable/screen/alert/status_effect/buff/psyhealing
	duration = 15 SECONDS
	examine_text = "SUBJECTPRONOUN stirs with a sense of ENDURING!"
	var/healing_on_tick = 1
	var/outline_colour = "#d3d3d3"

/datum/status_effect/buff/psyhealing/on_creation(mob/living/new_owner, new_healing_on_tick)
	healing_on_tick = new_healing_on_tick
	return ..()

/datum/status_effect/buff/psyhealing/on_apply()
	SEND_SIGNAL(owner, COMSIG_LIVING_MIRACLE_HEAL_APPLY, healing_on_tick, src)
	var/filter = owner.get_filter(PSYDON_HEALING_FILTER)
	if (!filter)
		owner.add_filter(PSYDON_HEALING_FILTER, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 60, "size" = 1))
	return TRUE

/datum/status_effect/buff/psyhealing/tick()
	var/obj/effect/temp_visual/heal/H = new /obj/effect/temp_visual/psyheal_rogue(get_turf(owner))
	H.color = "#d3d3d3"
	var/list/wCount = owner.get_wounds()
	if(!owner.construct)
		if(wCount.len > 0)
			owner.heal_wounds(healing_on_tick * 1.75)
			owner.update_damage_overlays()
		owner.adjustOxyLoss(-healing_on_tick, 0)
		owner.adjustToxLoss(-healing_on_tick, 0)
		owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, -healing_on_tick)
		owner.adjustCloneLoss(-healing_on_tick, 0)		

/datum/status_effect/buff/rockmuncher
	id = "rockmuncher"
	duration = 10 SECONDS
	var/healing_on_tick = 4

/datum/status_effect/buff/rockmuncher/on_creation(mob/living/new_owner, new_healing_on_tick)
	healing_on_tick = new_healing_on_tick
	return ..()

/datum/status_effect/buff/rockmuncher/tick()
	var/obj/effect/temp_visual/heal/H = new /obj/effect/temp_visual/heal_rogue(get_turf(owner))
	H.color = "#FF0000"
	var/list/wCount = owner.get_wounds()
	if(owner.construct)
		if(wCount.len > 0)
			owner.heal_wounds(healing_on_tick)
			owner.update_damage_overlays()
		owner.adjustBruteLoss(0.15*-healing_on_tick, 0)
		owner.adjustFireLoss(0.15*-healing_on_tick, 0)
		owner.adjustOxyLoss(0.15*-healing_on_tick, 0)
		owner.adjustToxLoss(0.15*-healing_on_tick, 0)
		owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.15*-healing_on_tick)
		owner.adjustCloneLoss(0.15*-healing_on_tick, 0)

/datum/status_effect/buff/healing/on_remove()
	owner.remove_filter(MIRACLE_HEALING_FILTER)
	owner.update_damage_hud()

/datum/status_effect/buff/psyhealing/on_remove()
	owner.remove_filter(PSYDON_HEALING_FILTER)
	owner.update_damage_hud()

/atom/movable/screen/alert/status_effect/buff/fortify
	name = "Fortifying Miracle"
	desc = "Divine intervention bolsters me and aids my recovery."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/buff/convergence
	name = "Convergence Miracle"
	desc = "My body converges to whence it found strength and health."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/buff/stasis
	name = "Stasis Miracle"
	desc = "A part of me has been put in stasis."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/buff/censerbuff
	name = "Inspired by SYON."
	desc = "The shard of the great comet had inspired me to ENDURE."
	icon_state = "censerbuff"

/datum/status_effect/buff/fortify //Increases all healing while it lasts.
	id = "fortify"
	alert_type = /atom/movable/screen/alert/status_effect/buff/fortify
	duration = 1 MINUTES

/datum/status_effect/buff/censerbuff
	id = "censer"
	alert_type = /atom/movable/screen/alert/status_effect/buff/censerbuff
	duration = 15 MINUTES
	effectedstats = list("endurance" = 1, "constitution" = 1)

/datum/status_effect/buff/convergence //Increases all healing while it lasts.
	id = "convergence"
	alert_type = /atom/movable/screen/alert/status_effect/buff/convergence
	duration = 1 MINUTES

/datum/status_effect/buff/stasis //Increases all healing while it lasts.
	id = "stasis"
	alert_type = /atom/movable/screen/alert/status_effect/buff/stasis
	duration = 10 SECONDS

#define CRANKBOX_FILTER "crankboxbuff_glow"
/atom/movable/screen/alert/status_effect/buff/churnerprotection
	name = "Magick Distorted"
	desc = "The wailing box is disrupting magicks around me!"
	icon_state = "buff"
/atom/movable/screen/alert/status_effect/buff/churnernegative
	name = "Magick Distorted"
	desc = "That infernal contraption is sapping my very arcyne essence!"
	icon_state = "buff"

/datum/status_effect/buff/churnerprotection
	var/outline_colour = "#fad55a"
	id = "soulchurnerprotection"
	alert_type = /atom/movable/screen/alert/status_effect/buff/churnerprotection
	duration = 20 SECONDS

/datum/status_effect/buff/churnerprotection/on_apply()
	. = ..()
	var/filter = owner.get_filter(CRANKBOX_FILTER)
	if (!filter)
		owner.add_filter(CRANKBOX_FILTER, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 200, "size" = 1))
	to_chat(owner, span_warning("I feel the wailing box distorting magicks around me!"))
	ADD_TRAIT(owner, TRAIT_ANTIMAGIC, MAGIC_TRAIT)

/datum/status_effect/buff/churnerprotection/on_remove()
	. = ..()
	to_chat(owner, span_warning("The wailing box's protection fades..."))
	owner.remove_filter(CRANKBOX_FILTER)
	REMOVE_TRAIT(owner, TRAIT_ANTIMAGIC, MAGIC_TRAIT)

#undef CRANKBOX_FILTER
#undef MIRACLE_HEALING_FILTER

/datum/status_effect/buff/churnernegative
	id ="soulchurnernegative"
	alert_type = /atom/movable/screen/alert/status_effect/buff/churnernegative
	duration = 23 SECONDS

/datum/status_effect/buff/churnernegative/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_SPELLCOCKBLOCK, MAGIC_TRAIT)
	ADD_TRAIT(owner, TRAIT_ANTIMAGIC, MAGIC_TRAIT)
	to_chat(owner, span_warning("I feel as if my connection to the Arcyne disappears entirely. The air feels still..."))
	owner.visible_message("[owner]'s arcyne aura seems to fade.")

/datum/status_effect/buff/churnernegative/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_SPELLCOCKBLOCK, MAGIC_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_ANTIMAGIC, MAGIC_TRAIT)
	to_chat(owner, span_warning("I feel my connection to the arcyne surround me once more."))
	owner.visible_message("[owner]'s arcyne aura seems to return once more.")

#define BLESSINGOFSUN_FILTER "sun_glow"
/atom/movable/screen/alert/status_effect/buff/guidinglight
	name = "Guiding Light"
	desc = "Astrata's gaze follows me, lighting the path!"
	icon_state = "stressvg"

/datum/status_effect/buff/guidinglight // Hey did u follow us from ritualcircles? Cool, okay this stuff is pretty simple yeah? Most ritual circles use some sort of status effects to get their effects ez.
	id = "guidinglight"
	alert_type = /atom/movable/screen/alert/status_effect/buff/guidinglight
	duration = 30 MINUTES // Lasts for 30 minutes, roughly an ingame day. This should be the gold standard for rituals, unless its some particularly powerul effect or one-time effect(Flylord's triage)
	status_type = STATUS_EFFECT_REFRESH
	effectedstats = list("perception" = 2) // This is for basic stat effects, I would consider these a 'little topping' and not what you should rlly aim for for rituals. Ideally we have cool flavor boons, rather than combat stims.
	examine_text = "SUBJECTPRONOUN walks with Her Light!"
	var/list/mobs_affected
	var/obj/effect/dummy/lighting_obj/moblight/mob_light_obj
	var/outline_colour = "#ffffff"

/datum/status_effect/buff/guidinglight/on_apply()
	. = ..()
	if (!.)
		return
	to_chat(owner, span_notice("Light blossoms into being around me!"))
	var/filter = owner.get_filter(BLESSINGOFSUN_FILTER)
	if (!filter)
		owner.add_filter(BLESSINGOFSUN_FILTER, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 60, "size" = 1))
	mob_light_obj = owner.mob_light("#fdfbd3", 10, 10)
	return TRUE


/datum/status_effect/buff/guidinglight/on_remove()
	. = ..()
	playsound(owner, 'sound/items/firesnuff.ogg', 75, FALSE)
	to_chat(owner, span_notice("The miraculous light surrounding me has fled..."))
	owner.remove_filter(BLESSINGOFSUN_FILTER)
	QDEL_NULL(mob_light_obj)

#undef BLESSINGOFSUN_FILTER
/datum/status_effect/buff/moonlightdance
	id = "Moonsight"
	alert_type = /atom/movable/screen/alert/status_effect/buff/moonlightdance
	effectedstats = list("intelligence" = 2)
	duration = 25 MINUTES

/atom/movable/screen/alert/status_effect/buff/moonlightdance
	name = "Moonlight Dance"
	desc = "Noc's stony touch lay upon my mind, bringing me wisdom."
	icon_state = "moonlightdance"


/datum/status_effect/buff/moonlightdance/on_apply()
	. = ..()
	to_chat(owner, span_warning("I see through the Moonlight. Silvery threads dance in my vision."))
	ADD_TRAIT(owner, TRAIT_DARKVISION, MAGIC_TRAIT)


/datum/status_effect/buff/moonlightdance/on_remove()
	. = ..()
	to_chat(owner, span_warning("Noc's silver leaves my"))
	REMOVE_TRAIT(owner, TRAIT_DARKVISION, MAGIC_TRAIT)




/atom/movable/screen/alert/status_effect/buff/flylordstriage
	name = "Flylord's Triage"
	desc = "Pestra's servants crawl through my pores and wounds!"
	icon_state = "buff"

/datum/status_effect/buff/flylordstriage
	id = "healing"
	alert_type = /atom/movable/screen/alert/status_effect/buff/healing
	duration = 20 SECONDS
	var/healing_on_tick = 40

/datum/status_effect/buff/flylordstriage/tick()
	playsound(owner, 'sound/misc/fliesloop.ogg', 100, FALSE, -1)
	owner.flash_fullscreen("redflash3")
	owner.emote("agony")
	new /obj/effect/temp_visual/flies(get_turf(owner))
	var/list/wCount = owner.get_wounds()
	if(owner.blood_volume < BLOOD_VOLUME_NORMAL)
		owner.blood_volume = min(owner.blood_volume+100, BLOOD_VOLUME_NORMAL)
	if(wCount.len > 0)
		owner.heal_wounds(healing_on_tick)
		owner.update_damage_overlays()
	owner.adjustBruteLoss(-healing_on_tick, 0)
	owner.adjustFireLoss(-healing_on_tick, 0)
	owner.adjustOxyLoss(-healing_on_tick, 0)
	owner.adjustToxLoss(-healing_on_tick, 0)
	owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, -healing_on_tick)
	owner.adjustCloneLoss(-healing_on_tick, 0)

/obj/effect/temp_visual/flies
	name = "Flylord's triage"
	icon_state = "flies"
	duration = 15
	plane = GAME_PLANE_UPPER
	layer = ABOVE_ALL_MOB_LAYER
	icon = 'icons/roguetown/mob/rotten.dmi'
	icon_state = "rotten"


/datum/status_effect/buff/flylordstriage/on_remove()
	to_chat(owner,span_userdanger("It's finally over..."))



/atom/movable/screen/alert/status_effect/buff/undermaidenbargain
	name = "Undermaiden's Bargain"
	desc = "A horrible deal was struck in my name..."
	icon_state = "buff"

/datum/status_effect/buff/undermaidenbargain
	id = "undermaidenbargain"
	alert_type = /atom/movable/screen/alert/status_effect/buff/undermaidenbargain
	duration = 30 MINUTES

/datum/status_effect/buff/undermaidenbargain/on_apply()
	. = ..()
	to_chat(owner, span_danger("You feel as though some horrible deal has been prepared in your name. May you never see it fulfilled..."))
	playsound(owner, 'sound/misc/bell.ogg', 100, FALSE, -1)
	ADD_TRAIT(owner, TRAIT_DEATHBARGAIN, TRAIT_GENERIC)

/datum/status_effect/buff/undermaidenbargain/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_DEATHBARGAIN, TRAIT_GENERIC)


/datum/status_effect/buff/undermaidenbargainheal/on_apply()
	. = ..()
	owner.remove_status_effect(/datum/status_effect/buff/undermaidenbargain)
	to_chat(owner, span_warning("You feel the deal struck in your name is being fulfilled..."))
	playsound(owner, 'sound/misc/deadbell.ogg', 100, FALSE, -1)
	ADD_TRAIT(owner, TRAIT_NODEATH, TRAIT_GENERIC)
	var/dirgeline = rand(1,6)
	spawn(15)
		switch(dirgeline)
			if(1)
				to_chat(owner, span_cultsmall("She watches the city skyline as her crimson pours into the drain."))
			if(2)
				to_chat(owner, span_cultsmall("He only wanted more for his family. He feels comfort on the pavement, the Watchman's blade having met its mark."))
			if(3)
				to_chat(owner, span_cultsmall("A sailor's leg is caught in naval rope. Their last thoughts are of home."))
			if(4)
				to_chat(owner, span_cultsmall("She sobbed over the vulpkian's corpse. The Brigand's mace stemmed her tears."))
			if(5)
				to_chat(owner, span_cultsmall("A farm son chokes up his last. At his bedside, a sister and mother weep."))
			if(6)
				to_chat(owner, span_cultsmall("A woman begs at a Headstone. It is your fault."))

/datum/status_effect/buff/undermaidenbargainheal/on_remove()
	. = ..()
	to_chat(owner, span_warning("The Bargain struck in my name has been fulfilled... I am thrown from Necra's embrace, another in my place..."))
	playsound(owner, 'sound/misc/deadbell.ogg', 100, FALSE, -1)
	REMOVE_TRAIT(owner, TRAIT_NODEATH, TRAIT_GENERIC)

/datum/status_effect/buff/undermaidenbargainheal
	id = "undermaidenbargainheal"
	alert_type = /atom/movable/screen/alert/status_effect/buff/undermaidenbargainheal
	duration = 10 SECONDS
	var/healing_on_tick = 20

/datum/status_effect/buff/undermaidenbargainheal/tick()
	var/list/wCount = owner.get_wounds()
	if(owner.blood_volume < BLOOD_VOLUME_NORMAL)
		owner.blood_volume = min(owner.blood_volume+60, BLOOD_VOLUME_NORMAL)
	if(wCount.len > 0)
		owner.heal_wounds(100) // we're gonna try really hard to heal someone's arterials and also stabilize their blood, so they don't instantly bleed out again. Ideally they should be 'just' alive.
		owner.update_damage_overlays()
	owner.adjustBruteLoss(-healing_on_tick, 0)
	owner.adjustFireLoss(-healing_on_tick, 0)
	owner.adjustOxyLoss(-healing_on_tick, 0)
	owner.adjustToxLoss(-healing_on_tick, 0)
	owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, -healing_on_tick)
	owner.adjustCloneLoss(-healing_on_tick, 0)

/atom/movable/screen/alert/status_effect/buff/undermaidenbargainheal
	name = "The Fulfillment"
	desc = "My bargain is being fulfilled..."
	icon_state = "buff"



/atom/movable/screen/alert/status_effect/buff/lesserwolf
	name = "Blessing of the Lesser Wolf"
	desc = "I swell with the embuement of a predator..."
	icon_state = "buff"

/datum/status_effect/buff/lesserwolf
	id = "lesserwolf"
	alert_type = /atom/movable/screen/alert/status_effect/buff/lesserwolf
	duration = 30 MINUTES

/datum/status_effect/buff/lesserwolf/on_apply()
	. = ..()
	to_chat(owner, span_warning("I feel my leg muscles grow taut, my teeth sharp, I am embued with the power of a predator. Branches and brush reach out for my soul..."))
	ADD_TRAIT(owner, TRAIT_LONGSTRIDER, TRAIT_GENERIC)
	ADD_TRAIT(owner, TRAIT_STRONGBITE, TRAIT_GENERIC)

/datum/status_effect/buff/lesserwolf/on_remove()
	. = ..()
	to_chat(owner, span_warning("I feel Dendor's blessing leave my body..."))
	REMOVE_TRAIT(owner, TRAIT_LONGSTRIDER, TRAIT_GENERIC)
	REMOVE_TRAIT(owner, TRAIT_STRONGBITE, TRAIT_GENERIC)

/atom/movable/screen/alert/status_effect/buff/pacify
	name = "Blessing of Eora"
	desc = "I feel my heart as light as feathers. All my worries have washed away."
	icon_state = "buff"

/datum/status_effect/buff/pacify
	id = "pacify"
	alert_type = /atom/movable/screen/alert/status_effect/buff/pacify
	duration = 30 MINUTES

/datum/status_effect/buff/pacify/on_apply()
	. = ..()
	to_chat(owner, span_green("Everything feels great!"))
	owner.add_stress(/datum/stressevent/pacified)
	ADD_TRAIT(owner, TRAIT_PACIFISM, TRAIT_GENERIC)
	playsound(owner, 'sound/misc/peacefulwake.ogg', 100, FALSE, -1)

/datum/status_effect/buff/pacify/on_remove()
	. = ..()
	to_chat(owner, span_warning("My mind is my own again, no longer awash with foggy peace!"))
	REMOVE_TRAIT(owner, TRAIT_PACIFISM, TRAIT_GENERIC)

/datum/status_effect/buff/call_to_arms
	id = "call_to_arms"
	alert_type = /atom/movable/screen/alert/status_effect/buff/call_to_arms
	duration = 2.5 MINUTES
	effectedstats = list("strength" = 1, "endurance" = 2, "constitution" = 1)

/atom/movable/screen/alert/status_effect/buff/call_to_arms
	name = "Call to Arms"
	desc = span_bloody("FOR GLORY AND HONOR!")
	icon_state = "call_to_arms"

/datum/status_effect/buff/call_to_slaughter
	id = "call_to_slaughter"
	alert_type = /atom/movable/screen/alert/status_effect/buff/call_to_slaughter
	duration = 2.5 MINUTES
	effectedstats = list("strength" = 1, "endurance" = 2, "constitution" = 1)

/atom/movable/screen/alert/status_effect/buff/call_to_slaughter
	name = "Call to Slaughter"
	desc = span_bloody("LAMBS TO THE SLAUGHTER!")
	icon_state = "call_to_slaughter"

/atom/movable/screen/alert/status_effect/buff/xylix_joy
	name = "Trickster's Joy"
	desc = "The sound of merriment fills me with fortune."
	icon_state = "buff"

/datum/status_effect/buff/xylix_joy
	id = "xylix_joy"
	alert_type = /atom/movable/screen/alert/status_effect/buff/xylix_joy
	effectedstats = list("fortune" = 1)
	duration = 5 MINUTES
	status_type = STATUS_EFFECT_REFRESH

/datum/status_effect/buff/xylix_joy/on_apply()
	. = ..()
	to_chat(owner, span_info("The sounds of joy fill me with fortune!"))

/datum/status_effect/buff/xylix_joy/on_remove()
	. = ..()
	to_chat(owner, span_info("My fortune returns to normal."))

/datum/status_effect/buff/vigorized
	id = "vigorized"
	alert_type = /atom/movable/screen/alert/status_effect/vigorized
	duration = 10 MINUTES
	effectedstats = list("speed" = 1, "intelligence" = 1)

/atom/movable/screen/alert/status_effect/vigorized
	name = "Vigorized"
	desc = "I feel a surge of energy inside, quickening my speed and sharpening my focus."
	icon_state = "drunk"

/datum/status_effect/buff/vigorized/on_apply()
	. = ..()
	to_chat(owner, span_warning("I feel a surge of energy inside me!"))

/datum/status_effect/buff/vigorized/on_remove()
	. = ..()
	to_chat(owner, span_warning("The surge of energy inside me fades..."))

/datum/status_effect/buff/seelie_drugs
	id = "seelie drugs"
	alert_type = /atom/movable/screen/alert/status_effect/buff/druqks
	effectedstats = list("intelligence" = 2, "endurance" = 4, "speed" = -3)
	duration = 20 SECONDS


/datum/status_effect/buff/clash
	id = "clash"
	duration = 6 SECONDS
	var/dur
	alert_type = /atom/movable/screen/alert/status_effect/buff/clash

/datum/status_effect/buff/clash/on_apply()
	. = ..()
	if(!ishuman(owner))
		return
	dur = world.time
	var/mob/living/carbon/human/H = owner
	H.play_overhead_indicator('icons/mob/overhead_effects.dmi', prob(50) ? "clash" : "clashr", duration, OBJ_LAYER, soundin = 'sound/combat/clash_initiate.ogg', y_offset = 28)

/datum/status_effect/buff/clash/tick()
	if(!owner.get_active_held_item() || !(owner.mobility_flags & MOBILITY_STAND))
		var/mob/living/carbon/human/H = owner
		H.bad_guard()

/datum/status_effect/buff/clash/on_remove()
	. = ..()
	owner.apply_status_effect(/datum/status_effect/debuff/clashcd)
	var/newdur = world.time - dur
	var/mob/living/carbon/human/H = owner
	if(newdur > (duration - 0.3 SECONDS))	//Not checking exact duration to account for lag and any other tick / timing inconsistencies.
		H.bad_guard(span_warning("I held my focus for too long. It's left me drained."))
	var/mutable_appearance/appearance = H.overlays_standing[OBJ_LAYER]
	H.clear_overhead_indicator(appearance)


/atom/movable/screen/alert/status_effect/buff/clash
	name = "Ready to Clash"
	desc = span_notice("I am on guard, and ready to clash. If I am hit, I will successfully defend. Attacking will make me lose my focus.")
	icon_state = "clash"

#define BLOODRAGE_FILTER "bloodrage"

/atom/movable/screen/alert/status_effect/buff/graggar_bloodrage
	name = "BLOODRAGE"
	desc = "GRAGGAR! GRAGGAR! GRAGGAR!"
	icon_state = "bloodrage"

/datum/status_effect/buff/bloodrage
	id = "bloodrage"
	alert_type = /atom/movable/screen/alert/status_effect/buff/graggar_bloodrage
	var/outline_color = "#ad0202"
	duration = 15 SECONDS

/datum/status_effect/buff/bloodrage/on_apply()
	ADD_TRAIT(owner, TRAIT_STRENGTH_UNCAPPED, TRAIT_MIRACLE)
	var/holyskill = owner.get_skill_level(/datum/skill/magic/holy)
	duration = ((15 SECONDS) * holyskill)
	var/filter = owner.get_filter(BLOODRAGE_FILTER)
	if(!filter)
		owner.add_filter(BLOODRAGE_FILTER, 2, list("type" = "outline", "color" = outline_color, "alpha" = 60, "size" = 2))
	if(!HAS_TRAIT(owner, TRAIT_DODGEEXPERT))
		if(owner.STASTR < STRENGTH_SOFTCAP)
			effectedstats = list("strength" = (STRENGTH_SOFTCAP - owner.STASTR))
			. = ..()
			return TRUE
	if(holyskill >= SKILL_LEVEL_APPRENTICE)
		effectedstats = list("strength" = 2)
	else
		effectedstats = list("strength" = 1)
	. = ..()
	return TRUE

/datum/status_effect/buff/bloodrage/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_STRENGTH_UNCAPPED, TRAIT_MIRACLE)
	owner.visible_message(span_warning("[owner] wavers, their rage simmering down."))
	owner.OffBalance(3 SECONDS)
	owner.remove_filter(BLOODRAGE_FILTER)
	owner.emote("breathgasp", forced = TRUE)
	owner.Slowdown(3)

/datum/status_effect/buff/psydonic_endurance
	id = "psydonic_endurance"
	alert_type = /atom/movable/screen/alert/status_effect/buff/psydonic_endurance
	effectedstats = list("constitution" = 1,"endurance" = 1) 

/datum/status_effect/buff/psydonic_endurance/on_apply()
	. = ..()
	if(HAS_TRAIT(owner, TRAIT_MEDIUMARMOR) && !HAS_TRAIT(owner, TRAIT_HEAVYARMOR))
		ADD_TRAIT(owner, TRAIT_HEAVYARMOR, src)

/datum/status_effect/buff/psydonic_endurance/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_HEAVYARMOR, src)

/atom/movable/screen/alert/status_effect/buff/psydonic_endurance
	name = "Psydonic Endurance"
	desc = "I am protected by blessed Psydonian plate armor."
	icon_state = "buff"

#undef BLOODRAGE_FILTER

/datum/status_effect/buff/sermon
	id = "sermon"
	alert_type = /atom/movable/screen/alert/status_effect/buff/sermon
	effectedstats = list("fortune" = 1, "constitution" = 1, "endurance" = 1, "intelligence" = 2)
	duration = 20 MINUTES

/atom/movable/screen/alert/status_effect/buff/sermon
	name = "sermon"
	desc = "I feel inspired by the sermon!"
	icon_state = "buff"
