/obj/structure/roguemachine/atm
	name = "MEISTER"
	desc = "Stores and withdraws currency for accounts managed by the Grand Duchy of Azuria."
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "atm"
	density = FALSE
	blade_dulling = DULLING_BASH
	pixel_y = 32
	var/mammonsiphoned = 0
	var/drilling = FALSE
	var/drilled = FALSE
	
/obj/structure/roguemachine/atm/attack_hand(mob/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(HAS_TRAIT(user, TRAIT_OUTLAW))
		to_chat(H, span_warning("The machine rejects you, sensing your status as an outlaw in these lands."))
		return
	if(drilled)
		if(HAS_TRAIT(H, TRAIT_NOBLE))
			if(!HAS_TRAIT(H, TRAIT_COMMIE))
				var/def_zone = "[(H.active_hand_index == 2) ? "r" : "l" ]_arm"
				playsound(src, 'sound/items/beartrap.ogg', 100, TRUE)
				to_chat(user, "<font color='red'>The meister craves my Noble blood!</font>")
				loc.visible_message(span_warning("The meister snaps onto [H]'s arm!"))
				H.Stun(80)
				H.apply_damage(50, BRUTE, def_zone)
				H.emote("agony")
				spawn(5)
				say("Blueblood for the Freefolk!")
				playsound(src, 'sound/vo/mobs/ghost/laugh (5).ogg', 100, TRUE)
				return	
	if(H in SStreasury.bank_accounts)
		var/amt = SStreasury.bank_accounts[H]
		if(!amt)
			say("Your balance is nothing.")
			return
		if(amt < 0)
			say("Your balance is NEGATIVE.")
			return
		var/list/choicez = list()
		if(amt > 10)
			choicez += "GOLD"
		if(amt > 5)
			choicez += "SILVER"
		choicez += "BRONZE"
		var/selection = input(user, "Make a Selection", src) as null|anything in choicez
		if(!selection)
			return
		amt = SStreasury.bank_accounts[H]
		var/mod = 1
		if(selection == "GOLD")
			mod = 10
		if(selection == "SILVER")
			mod = 5
		var/coin_amt = input(user, "There is [SStreasury.treasury_value] mammon in the treasury. You may withdraw [floor(amt/mod)] [selection] COINS from your account.", src) as null|num
		coin_amt = round(coin_amt)
		if(coin_amt < 1)
			return
		amt = SStreasury.bank_accounts[H]
		if(!Adjacent(user))
			return
		if((coin_amt*mod) > amt)
			playsound(src, 'sound/misc/machineno.ogg', 100, FALSE, -1)
			return
		if(!SStreasury.withdraw_money_account(coin_amt*mod, H))
			playsound(src, 'sound/misc/machineno.ogg', 100, FALSE, -1)
			return
		budget2change(coin_amt*mod, user, selection)
	else
		to_chat(user, span_warning("The machine bites my finger."))
		if(!drilled)
			icon_state = "atm-b"
		H.flash_fullscreen("redflash3")
		playsound(H, 'sound/combat/hits/bladed/genstab (1).ogg', 100, FALSE, -1)
		SStreasury.create_bank_account(H)
		if(H.mind)
			var/datum/job/target_job = SSjob.GetJob(H.mind.assigned_role)
			if(target_job && target_job.noble_income)
				SStreasury.noble_incomes[H] = target_job.noble_income
		spawn(5)
			say("New account created.")
			playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)

/*
/obj/structure/roguemachine/atm/attack_right(mob/user)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
*/

/obj/structure/roguemachine/atm/attackby(obj/item/P, mob/user, params)
	if(ishuman(user))
		if(istype(P, /obj/item/roguecoin))
			var/mob/living/carbon/human/H = user
			if(H in SStreasury.bank_accounts)
				SStreasury.generate_money_account(P.get_real_price(), H)
				if(!HAS_TRAIT(H, TRAIT_NOBLE))
					var/T = round(P.get_real_price() * SStreasury.tax_value)
					if(T != 0)
						say("Your deposit was taxed [T] mammon.")
				qdel(P)
				playsound(src, 'sound/misc/coininsert.ogg', 100, FALSE, -1)
				return
		if(istype(P, /obj/item/coveter))
			var/mob/living/carbon/human/H = user
			if(!HAS_TRAIT(H, TRAIT_COMMIE))
				to_chat(user, "<font color='red'>I don't know what I'm doing with this thing!</font>")
				return
			if(SStreasury.treasury_value <50)
				to_chat(user, "<font color='red'>These fools are completely broke. We'll get nothing out of this...</font>")
				return
			if(mammonsiphoned >499)
				to_chat(user, "<font color='red'>This one has already been siphoned dry...</font>")
				return
			else
				user.visible_message(span_warning("[user] is mounting the Crown onto the meister!"))
				if(do_after(user, 50))
					if(!drilling)
						user.visible_message(span_warning("[user] mounts the Crown atop the meister!"))
						icon_state = "crown_meister"
						drilling = TRUE
						drill(src)
						qdel(P)
						message_admins("[usr.key] has applied the Crustacean to a MEISTER.")
						return
		else
			say("No account found. Submit your fingers for inspection.")
	return ..()

/obj/structure/roguemachine/atm/examine(mob/user)
	. += ..()
	. += span_info("The current tax rate on deposits is [SStreasury.tax_value * 100] percent. Nobles exempt.")


/obj/structure/roguemachine/atm/proc/drill(obj/structure/roguemachine/atm)
	if(!drilling)
		return
	if(SStreasury.treasury_value <50)
		new /obj/item/coveter(loc)
		loc.visible_message(span_warning("The Crown grinds to a halt as the last of the treasury spills from the meister!"))
		playsound(src, 'sound/misc/DrillDone.ogg', 70, TRUE)
		icon_state = "atm"
		drilling = FALSE
		return
	if(mammonsiphoned >499) // The cap variable for siphoning. 
		new /obj/item/coveter(loc)
		loc.visible_message(span_warning("Maximum withdrawal reached! The meister weeps."))
		playsound(src, 'sound/misc/DrillDone.ogg', 70, TRUE)
		icon_state = "meister_broken"
		drilled = TRUE
		drilling = FALSE
		return
	else
		loc.visible_message(span_warning("A horrible scraping sound emanates from the Crown as it does its work..."))
		playsound(src, 'sound/misc/TheDrill.ogg', 70, TRUE)
		spawn(100) // The time it takes to complete an interval. If you adjust this, please adjust the sound too. It's 'about' perfect at 100. Anything less It'll start overlapping.
			loc.visible_message(span_warning("The meister spills its bounty!"))
			SStreasury.treasury_value -= 50 // Takes from the treasury
			mammonsiphoned += 50
			budget2change(50, null, "SILVER")
			playsound(src, 'sound/misc/coindispense.ogg', 70, TRUE)
			SStreasury.log_to_steward("-[50] exported mammon to the Freefolks!")
			drill(src)

/obj/structure/roguemachine/atm/attack_right(mob/living/carbon/human/user)
	if(drilling)
		to_chat(user,"<font color='yellow'>I begin dismounting the Crown from the meister...</font>" )
		if(do_after(user, 30, src))
			if(!drilling)
				return
			new /obj/item/coveter(loc)
			user.visible_message(span_warning("[user] dismounts the Crown!"))
			icon_state = "atm"
			drilling = !drilling
	else
		return

/obj/item/coveter
	name = "Covetous Crown"
	desc = "A Crown which craves the brow of meisters. The Covetous Crab"
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "crown_object"
	force = 10
	throwforce = 10
	dropshrink = 0.8
	w_class = WEIGHT_CLASS_NORMAL
	obj_flags = CAN_BE_HIT
	sellprice = 100


