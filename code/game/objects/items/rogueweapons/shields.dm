#define SHIELD_BASH		/datum/intent/shield/bash
#define SHIELD_BLOCK		/datum/intent/shield/block
#define SHIELD_BASH_METAL 	/datum/intent/shield/bash/metal
#define SHIELD_BLOCK_METAL 	/datum/intent/shield/block/metal
#define SHIELD_SMASH 		/datum/intent/shield/smash
#define SHIELD_SMASH_METAL 	/datum/intent/shield/smash/metal
#define SHIELD_BANG_COOLDOWN (3 SECONDS)

/obj/item/rogueweapon/shield
	name = ""
	desc = ""
	icon_state = ""
	icon = 'icons/roguetown/weapons/32.dmi'
	slot_flags = ITEM_SLOT_BACK
	flags_1 = null
	armor = ARMOR_SHIELD
	force = 10
	throwforce = 5
	throw_speed = 1
	throw_range = 3
	w_class = WEIGHT_CLASS_BULKY
	possible_item_intents = list(SHIELD_BASH, SHIELD_BLOCK, SHIELD_SMASH)
	block_chance = 0
	sharpness = IS_BLUNT
	wlength = WLENGTH_SHORT
	resistance_flags = FLAMMABLE
	can_parry = TRUE
	associated_skill = /datum/skill/combat/shields		//Trained via blocking or attacking dummys with; makes better at parrying w/ shields.
	wdefense = 10										//should be pretty baller
	var/coverage = 50
	parrysound = list('sound/combat/parry/shield/towershield (1).ogg','sound/combat/parry/shield/towershield (2).ogg','sound/combat/parry/shield/towershield (3).ogg')
	parrysound = list('sound/combat/parry/shield/towershield (1).ogg','sound/combat/parry/shield/towershield (2).ogg','sound/combat/parry/shield/towershield (3).ogg')
	max_integrity = 150
	blade_dulling = DULLING_SHAFT_WOOD
	anvilrepair = /datum/skill/craft/weaponsmithing
	COOLDOWN_DECLARE(shield_bang)


/obj/item/rogueweapon/shield/attackby(obj/item/attackby_item, mob/user, params)

	// Shield banging
	if(src == user.get_inactive_held_item())
		if(istype(attackby_item, /obj/item/rogueweapon))
			if(!COOLDOWN_FINISHED(src, shield_bang))
				return
			user.visible_message(span_danger("[user] bangs [src] with [attackby_item]!"))
			playsound(user.loc, 'sound/combat/shieldbang.ogg', 50, TRUE)
			COOLDOWN_START(src, shield_bang, SHIELD_BANG_COOLDOWN)
			return

	return ..()

/obj/item/rogueweapon/shield/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the projectile", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	SEND_SIGNAL(src, COMSIG_ITEM_HIT_REACT, args)
	var/mob/attacker
	var/obj/item/I
	if(attack_type == THROWN_PROJECTILE_ATTACK)
		if(istype(hitby, /obj/item)) // can't trust mob -> item assignments
			I = hitby
		if(I?.thrownby)
			attacker = I.thrownby
	if(attack_type == PROJECTILE_ATTACK)
		var/obj/projectile/P = hitby
		if(P?.firer)
			attacker = P.firer
	if(attacker && istype(attacker))
		if (!owner.can_see_cone(attacker))
			return FALSE
		if((owner.client?.chargedprog == 100 && owner.used_intent?.tranged) || prob(coverage))
			owner.visible_message(span_danger("[owner] expertly blocks [hitby] with [src]!"))
			return TRUE
	return FALSE

/datum/intent/shield/bash
	name = "bash"
	icon_state = "inbash"
	hitsound = list('sound/combat/shieldbash_wood.ogg')
	chargetime = 0
	penfactor = BLUNT_DEFAULT_PENFACTOR
	item_d_type = "blunt"

/datum/intent/shield/bash/metal
	hitsound = list('sound/combat/parry/shield/metalshield (1).ogg')

/datum/intent/shield/block
	name = "block"
	icon_state = "inblock"
	tranged = 1 //we can't attack directly with this intent, but we can charge it
	tshield = 1
	chargetime = 1
	hitsound = list('sound/combat/shieldbash_wood.ogg')
	warnie = "shieldwarn"
	item_d_type = "blunt"

/datum/intent/shield/block/metal
	hitsound = list('sound/combat/parry/shield/metalshield (1).ogg')

/datum/intent/shield/smash
	name = "smash"
	blade_class = BCLASS_SMASH
	attack_verb = list("smashes")
	icon_state = "insmash"
	hitsound = list('sound/combat/shieldbash_wood.ogg')
	penfactor = BLUNT_DEFAULT_PENFACTOR
	damfactor = 1.5
	swingdelay = 10

/datum/intent/shield/smash/metal
	hitsound = list('sound/combat/parry/shield/metalshield (1).ogg')

/obj/item/rogueweapon/shield/wood
	name = "wooden shield"
	desc = "A sturdy wooden shield. Will block anything you can imagine."
	icon_state = "woodsh"
	dropshrink = 0.8
	anvilrepair = /datum/skill/craft/carpentry
	coverage = 30

/obj/item/rogueweapon/shield/attack_right(mob/user)
	if(overlays.len)
		..()
		return

	var/icon/J = new('icons/roguetown/weapons/shield_heraldry.dmi')
	var/list/istates = J.IconStates()
	for(var/icon_s in istates)
		if(!findtext(icon_s, "[icon_state]_"))
			istates.Remove(icon_s)
			continue
		istates.Add(replacetextEx(icon_s, "[icon_state]_", ""))
		istates.Remove(icon_s)

	if(!istates.len)
		..()
		return

	var/picked_name = input(user, "Choose a Heraldry", "ROGUETOWN", name) as null|anything in sortList(istates)
	if(!picked_name)
		picked_name = "none"
	var/mutable_appearance/M = mutable_appearance('icons/roguetown/weapons/shield_heraldry.dmi', "[icon_state]_[picked_name]")
	M.appearance_flags = NO_CLIENT_COLOR
	add_overlay(M)
	if(alert("Are you pleased with your heraldry?", "Heraldry", "Yes", "No") != "Yes")
		cut_overlays()
	
	update_icon()

/obj/item/rogueweapon/shield/wood/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -5,"sy" = -1,"nx" = 6,"ny" = -1,"wx" = 0,"wy" = -2,"ex" = 0,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = 1,"sy" = 4,"nx" = 1,"ny" = 2,"wx" = 3,"wy" = 3,"ex" = 0,"ey" = 2,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)

/obj/item/rogueweapon/shield/tower
	name = "tower shield"
	desc = "A gigantic, iron reinforced shield that covers the entire body, a design-copy of the Aasimar shields of an era gone by."
	icon_state = "shield_tower"
	force = 6
	throwforce = 10
	throw_speed = 1
	throw_range = 3
	wlength = WLENGTH_NORMAL
	resistance_flags = FLAMMABLE
	blade_dulling = DULLING_SHAFT_REINFORCED
	wdefense = 10
	coverage = 40
	parrysound = list('sound/combat/parry/shield/towershield (1).ogg','sound/combat/parry/shield/towershield (2).ogg','sound/combat/parry/shield/towershield (3).ogg')
	max_integrity = 200

/obj/item/rogueweapon/shield/tower/holysee
	name = "decablessed shield"
	desc = "Protection of the Ten upon the wielder. A final, staunch line against the darkness. For it's not what is before the shield-carrier that matters, but the home behind them."
	icon_state = "gsshield"
	wdefense = 13
	max_integrity = 300
	coverage = 50
	wlength = WLENGTH_NORMAL
	resistance_flags = null
	flags_1 = CONDUCT_1
	force = 20
	blade_dulling = DULLING_SHAFT_METAL
	sellprice = 30

/obj/item/rogueweapon/shield/tower/holysee/dark
	icon_state = "gsshielddark"


/obj/item/rogueweapon/shield/tower/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -5,"sy" = -1,"nx" = 6,"ny" = -1,"wx" = 0,"wy" = -2,"ex" = 0,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = 1,"sy" = 4,"nx" = 1,"ny" = 2,"wx" = 3,"wy" = 3,"ex" = 0,"ey" = 2,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)

/obj/item/rogueweapon/shield/tower/metal
	name = "kite shield"
	desc = "A kite-shaped iron shield. Reliable and sturdy."
	icon_state = "kitesh"
	force = 20
	throwforce = 10
	throw_speed = 1
	throw_range = 3
	possible_item_intents = list(SHIELD_BASH_METAL, SHIELD_BLOCK, SHIELD_SMASH_METAL)
	wlength = WLENGTH_NORMAL
	resistance_flags = null
	flags_1 = CONDUCT_1
	wdefense = 11
	coverage = 50
	attacked_sound = list('sound/combat/parry/shield/metalshield (1).ogg','sound/combat/parry/shield/metalshield (2).ogg','sound/combat/parry/shield/metalshield (3).ogg')
	parrysound = list('sound/combat/parry/shield/metalshield (1).ogg','sound/combat/parry/shield/metalshield (2).ogg','sound/combat/parry/shield/metalshield (3).ogg')
	max_integrity = 300
	blade_dulling = DULLING_SHAFT_METAL
	sellprice = 30

/obj/item/rogueweapon/shield/tower/metal/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -5,"sy" = -1,"nx" = 6,"ny" = -1,"wx" = 0,"wy" = -2,"ex" = 0,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = 1,"sy" = 4,"nx" = 1,"ny" = 2,"wx" = 3,"wy" = 3,"ex" = 0,"ey" = 2,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
	return ..()

/obj/item/rogueweapon/shield/tower/metal/psy
	name = "Covenant"
	desc = "A Psydonian endures. A Psydonian preserves themselves. A Psydonian preserves His flock."
	icon_state = "psyshield"
	force = 20
	throwforce = 10
	throw_speed = 1
	throw_range = 3
	possible_item_intents = list(SHIELD_BASH_METAL, SHIELD_BLOCK, SHIELD_SMASH_METAL)
	wlength = WLENGTH_NORMAL
	resistance_flags = null
	flags_1 = CONDUCT_1
	wdefense = 11
	coverage = 50
	attacked_sound = list('sound/combat/parry/shield/metalshield (1).ogg','sound/combat/parry/shield/metalshield (2).ogg','sound/combat/parry/shield/metalshield (3).ogg')
	parrysound = list('sound/combat/parry/shield/metalshield (1).ogg','sound/combat/parry/shield/metalshield (2).ogg','sound/combat/parry/shield/metalshield (3).ogg')
	max_integrity = 300
	blade_dulling = DULLING_SHAFT_METAL

/obj/item/rogueweapon/shield/tower/metal/psy/ComponentInitialize()
	. = ..()							//+0 force, +100 int, +1 def, make silver
	AddComponent(/datum/component/psyblessed, TRUE, 0, FALSE, 100, 1, TRUE)	

/obj/item/rogueweapon/shield/tower/metal/alloy
	name = "decrepit shield"
	desc = "A decrepit, worn out shield. Aeon's grasp is upon it."
	max_integrity = 150
	wdefense = 9
	icon_state = "ancientsh"
	smeltresult = /obj/item/ingot/aalloy
	blade_dulling = DULLING_SHAFT_CONJURED

/obj/item/rogueweapon/shield/tower/metal/palloy
	name = "ancient shield"
	desc = "A ancient, venerable shield. Aeon's grasp has been lifted from it."
	icon_state = "ancientsh"
	smeltresult = /obj/item/ingot/purifiedaalloy
	blade_dulling = DULLING_SHAFT_METAL

/obj/item/rogueweapon/shield/tower/raneshen
	name = "rider shield"
	desc = "A shield of Raneshen design. Clever usage of wood, iron, and leather make an impressive match for any weapon."
	icon_state = "desert_rider"
	possible_item_intents = list(SHIELD_BASH_METAL, SHIELD_BLOCK)
	force = 25
	throwforce = 25 //for cosplaying captain raneshen
	wdefense = 11
	max_integrity = 250 //not fully metal but not fully wood either

/obj/item/rogueweapon/shield/tower/raneshen/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -5,"sy" = -1,"nx" = 6,"ny" = -1,"wx" = 0,"wy" = -2,"ex" = 0,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 1,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = 1,"sy" = 4,"nx" = 1,"ny" = 2,"wx" = 3,"wy" = 3,"ex" = 0,"ey" = 2,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)

/obj/item/rogueweapon/shield/buckler
	name = "buckler shield"
	desc = "A sturdy buckler shield. Will block anything you can imagine."
	icon_state = "bucklersh"
	slot_flags = ITEM_SLOT_HIP | ITEM_SLOT_BACK
	force = 20
	throwforce = 10
	dropshrink = 0.8
	resistance_flags = null
	possible_item_intents = list(SHIELD_BASH_METAL, SHIELD_BLOCK, SHIELD_SMASH_METAL)
	wdefense = 9
	coverage = 10
	attacked_sound = list('sound/combat/parry/shield/metalshield (1).ogg','sound/combat/parry/shield/metalshield (2).ogg','sound/combat/parry/shield/metalshield (3).ogg')
	parrysound = list('sound/combat/parry/shield/metalshield (1).ogg','sound/combat/parry/shield/metalshield (2).ogg','sound/combat/parry/shield/metalshield (3).ogg')
	max_integrity = 180
	blade_dulling = DULLING_SHAFT_CONJURED
	associated_skill = /datum/skill/combat/shields
	grid_width = 32
	grid_height = 64

/obj/item/rogueweapon/shield/buckler/examine(mob/living/user)
	. = ..()
	. += "Buckler uses the skill of your active weapon to parry. Otherwise it uses your shields skill."

/obj/item/rogueweapon/shield/buckler/proc/bucklerskill(mob/living/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/bucklerer = user
	var/obj/item/mainhand = bucklerer.get_active_held_item()
	var/weapon_parry = FALSE
	if(mainhand)
		if(mainhand.can_parry)
			weapon_parry = TRUE
	if(istype(mainhand, /obj/item/rogueweapon/shield/buckler))
		associated_skill = /datum/skill/combat/shields
	if(weapon_parry && mainhand.associated_skill)
		associated_skill = mainhand.associated_skill
	else
		associated_skill = /datum/skill/combat/shields

/obj/item/rogueweapon/shield/buckler/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -5,"sy" = -1,"nx" = 6,"ny" = -1,"wx" = 0,"wy" = -2,"ex" = 0,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 1,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = 1,"sy" = 4,"nx" = 1,"ny" = 2,"wx" = 3,"wy" = 3,"ex" = 0,"ey" = 2,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)

/obj/item/rogueweapon/shield/buckler/palloy
	name = "ancient buckler"
	desc = "An object once before its time, now out of it. The artisan's hammerstrikes are still visible in the mottled surface, yet \
	the encroach of rust and rot threatens even this memory."
	icon_state = "ancient_buckler"
	max_integrity = 80
	smeltresult = /obj/item/ingot/purifiedaalloy

/obj/item/rogueweapon/shield/heater
	name = "heater shield"
	desc = "A sturdy wood and leather shield. Made to not be too encumbering while still providing good protection."
	icon_state = "heatersh"
	force = 15
	throwforce = 10
	dropshrink = 0.8
	coverage = 30
	attacked_sound = list('sound/combat/parry/shield/towershield (1).ogg','sound/combat/parry/shield/towershield (2).ogg','sound/combat/parry/shield/towershield (3).ogg')
	parrysound = list('sound/combat/parry/shield/towershield (1).ogg','sound/combat/parry/shield/towershield (2).ogg','sound/combat/parry/shield/towershield (3).ogg')
	max_integrity = 200

/obj/item/rogueweapon/shield/heater/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -5,"sy" = -1,"nx" = 6,"ny" = -1,"wx" = 0,"wy" = -2,"ex" = 0,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = 1,"sy" = 4,"nx" = 1,"ny" = 2,"wx" = 3,"wy" = 3,"ex" = 0,"ey" = 2,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)


/obj/item/rogueweapon/shield/iron
	name = "iron shield"
	desc = "A heavy iron shield. It's cheaper than steel, but more encumbering."
	icon_state = "ironsh"
	force = 20
	throwforce = 25 // "I can do this all day."
	dropshrink = 0.8
	coverage = 30
	attacked_sound = list('sound/combat/parry/shield/metalshield (1).ogg','sound/combat/parry/shield/metalshield (2).ogg','sound/combat/parry/shield/metalshield (3).ogg')
	parrysound = list('sound/combat/parry/shield/metalshield (1).ogg','sound/combat/parry/shield/metalshield (2).ogg','sound/combat/parry/shield/metalshield (3).ogg')
	possible_item_intents = list(SHIELD_SMASH_METAL, SHIELD_BLOCK) // No SHIELD_BASH. Too heavy to swing quickly, or something.
	max_integrity = 200

/obj/item/rogueweapon/shield/iron/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -5,"sy" = -1,"nx" = 6,"ny" = -1,"wx" = 0,"wy" = -2,"ex" = 0,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = 1,"sy" = 4,"nx" = 1,"ny" = 2,"wx" = 3,"wy" = 3,"ex" = 0,"ey" = 2,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)

#undef SHIELD_BANG_COOLDOWN

/*/obj/item/rogueweapon/shield/buckler/freelancer
	name = "fencer's wrap"
	desc = "A traditional Etruscan quilted cloth square with a woolen cover. It can be used to daze and distract people with its bright colours and hanging steel balls."
	force = 10
	throwforce = 10
	coverage = 15
	max_integrity = 200
	possible_item_intents = list(SHIELD_BLOCK, FENCER_DAZE) */
