//PUZZLE BOXES

//easy


/obj/item/mundane/puzzlebox/easy
	name = "\improper wooden puzzle-box"
	desc = "A puzzle box."
	icon = 'modular_azurepeak/icons/obj/items/mundanities.dmi'
	icon_state = "wood_box"
	var/fluff_desc = "Wow."
	var/list/finished_ckeys = list()
	var/dice_roll = null
	var/alert = null
	sellprice = 5

	grid_width = 32
	grid_height = 32

/obj/item/mundane/puzzlebox/easy/Initialize()
	. = ..()
	dice_roll = rand(6,15)
	fluff_desc = pick("It, frankly, looks rather depressing.","I can see an engraving of PSYDON sending the COMET down, on the side.","It doesn't look so difficult.","It's dusty and boring.","Why do I want to play with this for hours?","I could probably get a vagrant to solve this.","It looks like it was made for fools.")
	desc += "[fluff_desc]"


/obj/item/mundane/puzzlebox/easy/attack_self(mob/living/user)
	var/ckey = user.ckey
	if(ckey in finished_ckeys)
		to_chat(user, span_warning("I've already tried my hand at [src]."))
		return
	playsound(src.loc, 'sound/items/wood_sharpen.ogg', 75, TRUE)
	playsound(src.loc, 'sound/items/visor.ogg', 75, TRUE)
	if (alert(user, "My fingers trace the outside of this box. It looks of average difficulty. Do I try to solve it?", "ROGUETOWN", "Yes", "No") != "Yes")
		return
	if(do_after(user,70, target = src))
		if((dice_roll) <= user.STAINT)
			to_chat(user, span_notice("I solve [src] fairly easily. I feel rather satisfied."))
			user.add_stress(/datum/stressevent/puzzle_easy)
			finished_ckeys += ckey
			playsound(src.loc, 'sound/foley/doors/lock.ogg', 75, TRUE)
		else
			to_chat(user, span_warning("I can't solve \the [src]. Cack! Frustrated, I leave it alone."))
			user.add_stress(/datum/stressevent/puzzle_fail)
			finished_ckeys += ckey
			playsound(src.loc, 'sound/foley/doors/lockrattle.ogg', 75, TRUE)


//medium

/obj/item/mundane/puzzlebox/medium
	name = "\improper ebony puzzle-box"
	icon = 'modular_azurepeak/icons/obj/items/mundanities.dmi'
	icon_state = "ebon_box"
	var/fluff_desc = null
	var/list/finished_ckeys = list()
	var/dice_roll = null
	var/alert = null
	sellprice = 10

	grid_width = 32
	grid_height = 32

/obj/item/mundane/puzzlebox/medium/Initialize()
	. = ..()
	dice_roll = rand(6,20)
	fluff_desc = pick("Its surface shines with polished ebony.","I can see an engraving of a Snow-Elf on the side.","It looks like it could challenge an average man.","I wish my personality was like this box's.","Why do I want to play with this for hours?","I could probably sell this to a wizard's apprentice.","It looks...sufficient.")
	desc += "[fluff_desc]"

/obj/item/mundane/puzzlebox/medium/attack_self(mob/living/user)
	var/ckey = user.ckey
	if(ckey in finished_ckeys)
		to_chat(user, span_warning("I've already tried my hand at [src]."))
		return
	playsound(src.loc, 'sound/items/wood_sharpen.ogg', 75, TRUE)
	playsound(src.loc, 'sound/items/visor.ogg', 75, TRUE)
	if (alert(user, "My fingers trace the outside of this box. It looks of average difficulty. Do I try to solve it?", "ROGUETOWN", "Yes", "No") != "Yes")
		return
	if(do_after(user,70, target = src))
		if((dice_roll) <= user.STAINT)
			to_chat(user, span_notice("I solve [src] fairly easily. I feel rather satisfied."))
			user.add_stress(/datum/stressevent/puzzle_medium)
			finished_ckeys += ckey
			playsound(src.loc, 'sound/foley/doors/lock.ogg', 75, TRUE)
		else
			to_chat(user, span_warning("I can't solve [src]. Frustrated, I leave it alone."))
			user.add_stress(/datum/stressevent/puzzle_fail)
			finished_ckeys += ckey
			playsound(src.loc, 'sound/foley/doors/lockrattle.ogg', 75, TRUE)


//impossible. before you look at this and screech - even the highest int bonus jobs in the game start with a 0% chance assuming worst roll from this to beat this thing
//the only job that can 'consistently' crack this is archivist, who starts with a 30%-ish chance, assuming worst roll from this. but then ur stuck playing archivist so ??? stat-packs help, but you'll still end up worse off tbh


/obj/item/mundane/puzzlebox/impossible //literally nearly impossible to solve - if you do, you get a fairly lengthy buff and a stat boost.
	name = "\improper royal puzzle-box"
	icon = 'modular_azurepeak/icons/obj/items/mundanities.dmi'
	icon_state = "grimace_box"
	var/fluff_desc = null
	var/list/finished_ckeys = list()
	var/dice_roll = null
	sellprice = 150

	grid_width = 32
	grid_height = 32

/obj/item/mundane/puzzlebox/impossible/Initialize()
	. = ..()
	dice_roll = rand(11,20)
	fluff_desc = pick("It, frankly, looks nearly impossible.","Its centerpiece is that of Astrata banishing a heretic from this world.","Without doubt, this is rather befuddling.","It looks arcane and nearly-impossible.","Why do I feel like I could try for hours and not succeed at this?","Even a bored archivist would probably have trouble with this one.","It looks nearly impossible.")
	desc += "[fluff_desc]"

/obj/item/mundane/puzzlebox/impossible/attack_self(mob/living/user)
	var/ckey = user.ckey
	if(ckey in finished_ckeys)
		to_chat(user, span_warning("I've already tried my hand at [src]."))
		return
	playsound(src.loc, 'sound/items/wood_sharpen.ogg', 75, TRUE)
	playsound(src.loc, 'sound/items/visor.ogg', 75, TRUE)
	if (alert(user, "My fingers trace the outside of this box. It looks nearly impossible. Do I try to solve it?", "ROGUETOWN", "Yes", "No") != "Yes")
		return
	if(do_after(user,100, target = src))
		if((dice_roll) + 4 <= user.STAINT)
			to_chat(user, span_notice("After much deliberation, I solve \the [src]!"))
			user.add_stress(/datum/stressevent/puzzle_impossible)
			finished_ckeys += ckey
			playsound(src.loc, 'sound/foley/doors/lockrattle.ogg', 75, TRUE)
			to_chat(user, span_notice("As I pop open \the [src], I feel a tingling wave run from my head to my feet. A piece of an azure crystal tumbles out. When I grab it, it's gone- and I suddenly feel invigorated."))
			user.STAINT += rand(1,5)
			user.STASTR += rand(1,5)
			user.STASPD += rand(1,5)
			user.STACON += rand(1,5)
			user.STAEND += rand(1,5)
			finished_ckeys += ckey
			playsound(src.loc, 'sound/foley/doors/lock.ogg', 75, TRUE)
			playsound(src.loc, 'sound/items/visor.ogg', 75, TRUE)
		else
			to_chat(user, span_warning("I can't even start to solve [src]. Feeling like an absolute fool, I put it aside."))
			user.add_stress(/datum/stressevent/puzzle_fail)
			finished_ckeys += ckey
			playsound(src.loc, 'sound/foley/doors/lockrattle.ogg', 75, TRUE)

