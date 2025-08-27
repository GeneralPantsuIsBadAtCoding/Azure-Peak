/obj/effect/proc_holder/spell/targeted/wildshape
	name = "Beast Form"
	desc = "Take on the form of one of Dendor's sacred beasts."
	overlay_state = "tamebeast"
	clothes_req = FALSE
	human_req = FALSE
	range = -1
	include_user = TRUE
	releasedrain = 60
	recharge_time = 30 SECONDS
	cooldown_min = 50
	invocations = list("Treefather grant me your form!")
	invocation_type = "shout"
	action_icon_state = "shapeshift"
	associated_skill = /datum/skill/magic/holy
	devotion_cost = 80
	miracle = TRUE
	clothes_req = FALSE
	human_req = FALSE


	var/list/possible_shapes = list(
		/mob/living/carbon/human/species/wildshape/volf,
		/mob/living/carbon/human/species/wildshape/cat,
		/mob/living/carbon/human/species/wildshape/saiga,
		/mob/living/carbon/human/species/wildshape/spider
	)

/obj/effect/proc_holder/spell/targeted/wildshape/cast(list/targets, mob/user = usr)
	. = ..()
	for(var/mob/living/carbon/human/M in targets)
		if (M.has_status_effect(/datum/status_effect/debuff/submissive))
			to_chat(user, span_warning("Your will is too broken to change form."))
			return FALSE
		if(!istype(M, /mob/living/carbon/human/species/wildshape)) //If we aren't a wildshaped species, we can use this
			var/list/animal_list = list()
			
			for(var/path in possible_shapes) //First pass for the names
				var/mob/living/carbon/human/species/wildshape/A = path
				animal_list[initial(A.name)] = path

			var/new_wildshape_type = input(M, "Choose Your Animal Form!", "It's Morphing Time!", null) as null|anything in sortList(animal_list)

			for(var/crecher in possible_shapes) //Second pass to fetch the mob type itself and send it on wildshape_transformation
				var/mob/living/carbon/human/species/wildshape/B = crecher
				if(new_wildshape_type == B.name)
					M.Stun(30)
					M.Knockdown(30)
					M.wildshape_transformation(B)

		else //If we are a wildshaped species, we simply un-transform
			M.wildshape_untransform()

	return

// Mob itself
/mob/living/carbon/human/species/wildshape
	var/datum/language_holder/stored_language
	var/list/stored_skills
	var/list/stored_experience
	var/list/stored_spells

/mob/living/carbon/human/species/wildshape/proc/gain_inherent_skills()
	if(src.mind)
		src.adjust_skillrank(/datum/skill/magic/holy, 3, TRUE) //Any dendorite using this should be a holy magic user

		var/datum/devotion/C = new /datum/devotion(src, src.patron) //If we don't do this, Dendorites can't be clerics and they can't revert back to their true forms
		C.grant_miracles(src, cleric_tier = CLERIC_T2, passive_gain = CLERIC_REGEN_MAJOR)	//Major regen as no matter the previous level, it gets reset on transform. More connection to dendor I guess? Can level up to T4.

/mob/living/carbon/human/species/wildshape/update_inv_gloves() //Prevents weird blood overlays
	remove_overlay(GLOVES_LAYER)
	remove_overlay(GLOVESLEEVE_LAYER)

/mob/living/carbon/human/species/wildshape/update_inv_shoes() //Prevents weird blood overlays
	remove_overlay(SHOES_LAYER)
	remove_overlay(SHOESLEEVE_LAYER)
