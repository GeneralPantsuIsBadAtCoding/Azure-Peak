/datum/intent/dagger/chop/necra
	damfactor = 1.2
	intent_intdamage_factor = 1.35 // I HAVE NO PICK BUT I MUST KILL
	swingdelay = 10
	clickcd = 10
	penfactor = 30

/datum/intent/dagger/cut/dendor // me like cut
	damfactor = 1.1
	clickcd = 8

/datum/intent/dagger/thrust/dendor // me no like stab
	damfactor = 0.8

/datum/intent/dagger/thrust/pick/abyssor
	damfactor = 1.2

/datum/intent/dagger/thrust/malum // hits slower but harder slight DPM buff
	damfactor = 1.3
	clickcd = 10

/obj/item/rogueweapon/huntingknife/idagger/steel/devilsknife
	name ="devilsknife"
	desc = "More a sickle than a knife. It is said that Xylix once won these in a game of chance against an archdevil. These are simple reproductions, with jingling bells attached to the blades."
	icon_state = "devilsknife"
	icon = 'modular_twilight_axis/icons/roguetown/weapons/32.dmi'
	force = 22 // 10% - This is a 8 clickCD weapon
	max_integrity = 200

/obj/item/rogueweapon/huntingknife/throwingknife/steel/noc
	name = "twilight fang"
	desc = "Large tossblade meant for both fighting and throwing. Perfect for striking from the shadows of Noc."
	item_state = "bone_dagger"
	possible_item_intents = list(/datum/intent/dagger/thrust, /datum/intent/dagger/cut, /datum/intent/dagger/thrust/pick, /datum/intent/dagger/sucker_punch)
	force = 21
	throwforce = 28
	throw_speed = 4
	max_integrity = 200
	armor_penetration = 40
	icon_state = "noc_dagger"
	icon = 'modular_twilight_axis/icons/roguetown/weapons/32.dmi'
	embedding = list("embedded_pain_multiplier" = 4, "embed_chance" = 30, "embedded_fall_chance" = 5)

/obj/item/rogueweapon/huntingknife/idagger/steel/astrata
	name ="dawnbringer"
	desc = "A blade forged in the name of Astrata herself. It glistens under the light reminding your foes what is coming."
	icon_state = "astrata_dagger"
	icon = 'modular_twilight_axis/icons/roguetown/weapons/32.dmi'
	force = 22
	max_integrity = 200

/obj/item/rogueweapon/huntingknife/idagger/steel/parrying/eora
	name = "misericorde"
	icon_state = "eora_dagger"
	icon = 'modular_twilight_axis/icons/roguetown/weapons/32.dmi'
	force = 10
	throwforce = 10
	desc = "A parrying dagger created to be used in the free hand and deliver mercy to the foes you've bested."
	sheathe_icon = "spdagger"
	wdefense = 9 // Eoran rapier has 8 def so I had to bump it to 9 in order to parry with a dagger
	max_integrity = 200

/obj/item/rogueweapon/huntingknife/idagger/steel/ravox
	name ="echo of triumph"
	desc = "Once, it was a greatsword wielded by the chosen of Ravox. After centuries of battles, the blade finally broke. However, the remaining pieces were reforged into a dagger that reminds battles of the past."
	icon_state = "ravox_dagger"
	icon = 'modular_twilight_axis/icons/roguetown/weapons/32.dmi'
	force = 22
	max_integrity = 200

/obj/item/rogueweapon/huntingknife/idagger/steel/abyssor
	name ="darkwater ripper"
	desc = "Fierce dagger quenched in the abyssal depths. If you listen closely, you can hear the clashing of waves during high tide."
	icon_state = "abyssor_dagger"
	icon = 'modular_twilight_axis/icons/roguetown/weapons/32.dmi'
	possible_item_intents = list(/datum/intent/dagger/thrust, /datum/intent/dagger/cut, /datum/intent/dagger/thrust/pick/abyssor, /datum/intent/dagger/sucker_punch)
	force = 22
	max_integrity = 200

/obj/item/rogueweapon/huntingknife/idagger/steel/dendor
	name ="maddening thorn"
	desc = "Simple yet wickedly sharp blade fixed to the handle grown whole. The hilt is covered by tiny prickly thorns that slowly madden the wielder."
	icon_state = "dendor_dagger"
	icon = 'modular_twilight_axis/icons/roguetown/weapons/32.dmi'
	possible_item_intents = list(/datum/intent/dagger/thrust/dendor, /datum/intent/dagger/cut/dendor, /datum/intent/dagger/thrust/pick, /datum/intent/dagger/sucker_punch)
	force = 22
	max_integrity = 200

/obj/item/rogueweapon/huntingknife/idagger/steel/malum
	name ="embertongue"
	desc = "Wavy flamelike blade forged in the name of Malum himself."
	icon_state = "malum_dagger"
	icon = 'modular_twilight_axis/icons/roguetown/weapons/32.dmi'
	possible_item_intents = list(/datum/intent/dagger/thrust/malum, /datum/intent/dagger/cut, /datum/intent/dagger/thrust/pick, /datum/intent/dagger/sucker_punch)
	force = 22
	wdefense = 2
	max_integrity = 200

/obj/item/rogueweapon/huntingknife/idagger/steel/necra
	name ="osteotome"
	desc = "A macabre cleaver. The hilt is made from a humen spine reinforced with a steel tang."
	icon_state = "necra_dagger"
	icon = 'modular_twilight_axis/icons/roguetown/weapons/32.dmi'
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/chop/necra) // chop chop chop
	force = 23
	max_integrity = 200