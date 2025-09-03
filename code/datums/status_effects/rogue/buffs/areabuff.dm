///////////////////////////
// Area Related Buffs    //
///////////////////////////

//Any Buffs related being in an area go here. 



//role related area buffs
//dungeoneer
/atom/movable/screen/alert/status_effect/buff/dungeoneerbuff
	name = "Ruthless Jailor"
	desc = "This is my sanctuary. I can overpower any opposition that dares breach it."
	icon_state = "buff"

/datum/status_effect/buff/dungeoneerbuff
	id = "dungeoneerbuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/dungeoneerbuff
	effectedstats = list("constitution" = 1,"endurance" = 1, "strength" = 2)//This only works in 2 small areas on the entire map

/datum/status_effect/buff/dungeoneerbuff/process()

	.=..()
	var/area/rogue/our_area = get_area(owner)
	if(!(our_area.cell_area))
		owner.remove_status_effect(/datum/status_effect/buff/dungeoneerbuff)

/datum/status_effect/buff/dungeoneerbuff/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_CIVILIZEDBARBARIAN, id)

/datum/status_effect/buff/dungeoneerbuff/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_CIVILIZEDBARBARIAN, id)

//gaurd
/atom/movable/screen/alert/status_effect/buff/guardbuffone
	name = "Vigilant Guardsman"
	desc = "My home. I watch vigilantly and respond swiftly."
	icon_state = "buff"

/datum/status_effect/buff/guardbuffone
	id = "guardbuffone"
	alert_type = /atom/movable/screen/alert/status_effect/buff/guardbuffone
	effectedstats = list("constitution" = 1,"endurance" = 1, "speed" = 1, "perception" = 2) 

/datum/status_effect/buff/guardbuffone/process()
	.=..()
	var/area/rogue/our_area = get_area(owner)
	if(!(our_area.town_area))
		owner.remove_status_effect(/datum/status_effect/buff/guardbuffone)

//barkeep
/atom/movable/screen/alert/status_effect/buff/barkeepbuff
	name = "Vigilant Tavernkeep"
	desc = "My home. I watch vigilantly and respond swiftly."
	icon_state = "buff"

/datum/status_effect/buff/barkeepbuff
	id = "barkeepbuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/barkeepbuff
	effectedstats = list("constitution" = 1,"endurance" = 1, "speed" = 1, "strength" = 3) 

/datum/status_effect/buff/barkeepbuff/process()

	.=..()
	var/area/rogue/our_area = get_area(owner)
	if(!(our_area.tavern_area))
		owner.remove_status_effect(/datum/status_effect/buff/barkeepbuff)

//knight
/atom/movable/screen/alert/status_effect/buff/knightbuff
	name = "Sworn Defender"
	desc = "I've sworn an oath to defend this castle. My resolve will not waver."
	icon_state = "buff"

//warden
/atom/movable/screen/alert/status_effect/buff/wardenbuff
	name = "Woodsman"
	desc = "I've trekked these woods for some time now. I find traversal easier here."
	icon_state = "buff"

/datum/status_effect/buff/wardenbuff
	id = "wardenbuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/wardenbuff
	effectedstats = list("speed" = 1, "perception" = 3) 

/datum/status_effect/buff/wardenbuff/process()

	.=..()
	var/area/rogue/our_area = get_area(owner)
	if(!(our_area.warden_area))
		owner.remove_status_effect(/datum/status_effect/buff/wardenbuff)

/datum/status_effect/buff/wardenbuff/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_LONGSTRIDER, id)

/datum/status_effect/buff/wardenbuff/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_LONGSTRIDER, id)
