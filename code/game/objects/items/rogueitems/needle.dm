/obj/item/needle
	name = "needle"
	icon_state = "needle"
	desc = "This sharp needle can sew wounds, cloth and can be used for self defence if you're crazy."
	icon = 'icons/roguetown/items/misc.dmi'
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	force = 0
	throwforce = 0
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_MOUTH
	max_integrity = 20
	anvilrepair = /datum/skill/craft/blacksmithing
	tool_behaviour = TOOL_SUTURE
	experimental_inhand = FALSE
	/// Amount of uses left
	var/stringamt = 20
	var/maxstring = 20
	/// If this needle is infinite
	var/infinite = FALSE
	/// If this needle can be used to repair items
	var/can_repair = TRUE
	grid_width = 32
	grid_height = 32

/obj/item/needle/examine()
	. = ..()
	if(!infinite)
		if(stringamt > 0)
			. += span_bold("It has [stringamt] uses left.")
		else
			. += span_bold("It has no uses left.")
	else
		. += "Can be used indefinitely."

/obj/item/needle/Initialize()
	. = ..()
	update_icon()

/obj/item/needle/update_overlays()
	. = ..()
	if(stringamt <= 0)
		return
	. += "[icon_state]string"

/obj/item/needle/get_belt_overlay()
	return mutable_appearance('icons/roguetown/items/surgery_bag.dmi', "needle")

/obj/item/needle/use(used)
	if(infinite)
		return TRUE
	stringamt = stringamt - used
//	if(stringamt <= 0)
//		qdel(src)

/obj/item/needle/attack(mob/living/M, mob/user)
	sew(M, user)

/obj/item/needle/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/natural/fibers))
		if(infinite || maxstring - stringamt <= 0) //is the needle infinite OR does it have all of its uses left
			to_chat(user, span_warning("The needle has no need to be refilled."))
			return

		to_chat(user, "I begin threading the needle with additional fibers...")
		if(do_after(user, 6 SECONDS - user.mind.get_skill_level(/datum/skill/misc/sewing), target = I))
			var/refill_amount
			refill_amount = min(5, (maxstring - stringamt))
			stringamt += refill_amount
			to_chat(user, "I replenish the needle's thread by [refill_amount] uses!")
			qdel(I)
		return
	return ..()

/obj/item/needle/attack_obj(obj/O, mob/living/user)
	if(!isitem(O))
		return
	var/obj/item/I = O
	if(can_repair)
		if(stringamt < 1)
			to_chat(user, span_warning("The needle has no thread left!"))
			return
		if(I.sewrepair && I.max_integrity)
			if(I.obj_integrity == I.max_integrity)
				to_chat(user, span_warning("This is not broken."))
				return
			if(!I.ontable())
				to_chat(user, span_warning("I should put this on a table first."))
				return
			playsound(loc, 'sound/foley/sewflesh.ogg', 100, TRUE, -2)
			var/skill = (user.mind.get_skill_level(/datum/skill/misc/sewing) + user.mind.get_skill_level(/datum/skill/craft/tanning)) * 10
			var/repairskill = (user.mind.get_skill_level(/datum/skill/misc/sewing) + user.mind.get_skill_level(/datum/skill/craft/tanning)) * 5
			var/sewtime = max(5, (60 - skill))
			if(HAS_TRAIT(user, TRAIT_SQUIRE_REPAIR))
				skill = skill < 30 ? 30 : skill // Make sure they can't fail but let them suffer sewtime
			if(!do_after(user, sewtime, target = I))
				return
			if(prob(max(0, 60 - (skill * 2)))) //The more knowlegeable we are the less chance we damage the object
				I.obj_integrity = max(0, I.obj_integrity - (30 - repairskill))
				user.visible_message(span_info("[user] damages [I] due to a lack of skill!"))
				playsound(src, 'sound/foley/cloth_rip.ogg', 50, TRUE)
				user.mind.add_sleep_experience(/datum/skill/misc/sewing, (user.STAINT) / 2) // Only failing a repair teaches us something
				if(do_after(user, CLICK_CD_MELEE, target = I))
					attack_obj(I, user)
				return
			else
				playsound(loc, 'sound/foley/sewflesh.ogg', 50, TRUE, -2)
				user.visible_message(span_info("[user] repairs [I]!"))
				if(I.body_parts_covered != I.body_parts_covered_dynamic)
					user.visible_message(span_info("[user] repairs [I]'s coverage!"))
					I.repair_coverage()
				I.obj_integrity = min(I.obj_integrity + 10 + skill, I.max_integrity)
				if(I.obj_broken && istype(I, /obj/item/clothing) && I.obj_integrity >= I.max_integrity)
					var/obj/item/clothing/cloth = I
					cloth.obj_fix()
					return
				if(do_after(user, CLICK_CD_MELEE, target = I))
					attack_obj(I, user)
		return
	return ..()

/obj/item/needle/proc/sew(mob/living/target, mob/living/user)
	if(!istype(user))
		return FALSE
	var/mob/living/doctor = user
	var/mob/living/carbon/human/patient = target
	if(stringamt < 1)
		to_chat(user, span_warning("The needle has no thread left!"))
		return
	var/list/sewable
	var/obj/item/bodypart/affecting
	if(iscarbon(patient))
		affecting = patient.get_bodypart(check_zone(doctor.zone_selected))
		if(!affecting)
			to_chat(doctor, span_warning("That limb is missing."))
			return FALSE
		sewable = affecting.get_sewable_wounds()
	else
		sewable = patient.get_sewable_wounds()
	if(!length(sewable))
		to_chat(doctor, span_warning("There aren't any wounds to be sewn."))
		return FALSE
	var/datum/wound/target_wound = sewable.len > 1 ? input(doctor, "Which wound?", "[src]") as null|anything in sewable : sewable[1]
	if(!target_wound)
		return FALSE

	var/moveup = 10
	if(doctor.mind)
		moveup = ((doctor.mind.get_skill_level(/datum/skill/misc/medicine)+1) * 5)
	while(!QDELETED(target_wound) && !QDELETED(src) && \
		!QDELETED(user) && (target_wound.sew_progress < target_wound.sew_threshold) && \
		stringamt >= 1)
		if(!do_after(doctor, 20, target = patient))
			break
		playsound(loc, 'sound/foley/sewflesh.ogg', 100, TRUE, -2)
		target_wound.sew_progress = min(target_wound.sew_progress + moveup, target_wound.sew_threshold)
		if(target_wound.sew_progress < target_wound.sew_threshold)
			continue
		if(doctor.mind)
			doctor.mind.add_sleep_experience(/datum/skill/misc/medicine, doctor.STAINT * 2.5)
		use(1)
		target_wound.sew_wound()
		if(patient == doctor)
			doctor.visible_message(span_notice("[doctor] sews \a [target_wound.name] on [doctor.p_them()]self."), span_notice("I stitch \a [target_wound.name] on my [affecting]."))
		else
			if(affecting)
				doctor.visible_message(span_notice("[doctor] sews \a [target_wound.name] on [patient]'s [affecting]."), span_notice("I stitch \a [target_wound.name] on [patient]'s [affecting]."))
			else
				doctor.visible_message(span_notice("[doctor] sews \a [target_wound.name] on [patient]."), span_notice("I stitch \a [target_wound.name] on [patient]."))
		log_combat(doctor, patient, "sew", "needle")
		return TRUE
	return FALSE

/obj/item/needle/thorn
	name = "needle"
	icon_state = "thornneedle"
	desc = "This rough needle can be used to sew cloth and wounds."
	stringamt = 5
	maxstring = 5
	anvilrepair = null

/obj/item/needle/pestra
	name = "needle of pestra"
	desc = span_green("This needle has been blessed by the goddess of medicine herself!")
	infinite = TRUE

/obj/item/needle/aalloy
	name = "decrepit needle"
	icon_state = "aneedle"
	desc = "This decrepit old needle doesn't seem helpful for much."
	stringamt = 5
	maxstring = 5
