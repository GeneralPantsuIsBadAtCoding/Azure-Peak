/datum/customizer/bodypart_feature/teeth
	name = "Teeth"
	customizer_choices = list(
		/datum/customizer_choice/bodypart_feature/teeth
		
	)
	allows_disabling = FALSE
	default_disabled = FALSE

/datum/customizer_choice/bodypart_feature/teeth
	name = "Teeth"
	allows_accessory_color_customization = FALSE //Customized through hair color
	customizer_entry_type = /datum/customizer_entry/teeth

/datum/customizer_choice/bodypart_feature/teeth/generate_pref_choices(list/dat, datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	..()
	var/datum/customizer_entry/teeth/teeth_entry = entry
	dat += "<br><b>Normal teeth:</b><a href='?_src_=prefs;task=change_customizer;customizer=[customizer_type];customizer_task=normal_teeth'>[teeth_entry.normal_teeth_amt]</a>"
	dat += "<br><b>Fangs:</b><a href='?_src_=prefs;task=change_customizer;customizer=[customizer_type];customizer_task=fangs'>[teeth_entry.fangs_amt]/4</a>"
	dat += "<br><b>Golden teeth:</b><a href='?_src_=prefs;task=change_customizer;customizer=[customizer_type];customizer_task=golden_teeth'>[teeth_entry.golden_teeth_amt]</a>"
	dat += "<br><b>Golden fangs:</b><a href='?_src_=prefs;task=change_customizer;customizer=[customizer_type];customizer_task=golden_fangs'>[teeth_entry.golden_fangs_amt]/4</a>"
	dat += "<br><b>Wooden teeth:</b><a href='?_src_=prefs;task=change_customizer;customizer=[customizer_type];customizer_task=wooden_teeth'>[teeth_entry.wooden_teeth_amt]</a>"

/datum/customizer_choice/bodypart_feature/teeth/handle_topic(mob/user, list/href_list, datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	..()
	var/datum/customizer_entry/teeth/teeth_entry = entry
	switch(href_list["customizer_task"])
		if("normal_teeth")
			var/new_teeth_amt = input(
				user, 
				"Choose your desired amount of normal teeth", 
				"Character Preference", 
				teeth_entry.normal_teeth_amt
			) as num|null
			teeth_entry.set_teeth_and_sanitize("normal_teeth_amt", new_teeth_amt, prefs.pref_species.max_teeth_count)
		if("fangs")
			var/new_teeth_amt = input(
				user, 
				"Choose your desired amount of fangs (max 4)", 
				"Character Preference", 
				teeth_entry.fangs_amt
			) as num|null
			teeth_entry.set_teeth_and_sanitize("fangs_amt", new_teeth_amt, prefs.pref_species.max_teeth_count)
		if("golden_teeth")
			var/new_teeth_amt = input(
				user, 
				"Choose your desired amount of golden teeth", 
				"Character Preference", 
				teeth_entry.golden_teeth_amt
			) as num|null
			teeth_entry.set_teeth_and_sanitize("golden_teeth_amt", new_teeth_amt, prefs.pref_species.max_teeth_count)
		if("golden_fangs")
			var/new_teeth_amt = input(
				user, 
				"Choose your desired amount of golden fangs (max 4)", 
				"Character Preference", 
				teeth_entry.golden_fangs_amt
			) as num|null
			teeth_entry.set_teeth_and_sanitize("golden_fangs_amt", new_teeth_amt, prefs.pref_species.max_teeth_count)
		if("wooden_teeth")
			var/new_teeth_amt = input(
				user, 
				"Choose your desired amount of wooden teeth", 
				"Character Preference", 
				teeth_entry.wooden_teeth_amt
			) as num|null
			teeth_entry.set_teeth_and_sanitize("wooden_teeth_amt", new_teeth_amt, prefs.pref_species.max_teeth_count)

/datum/customizer_choice/bodypart_feature/teeth/apply_customizer_to_character(mob/living/carbon/human/human, datum/preferences/prefs, datum/customizer_entry/entry)
	var/datum/customizer_entry/teeth/teeth_entry = entry
	var/obj/item/bodypart/head/head = human.get_bodypart(BODY_ZONE_HEAD)
	head.install_tooth(/obj/item/natural/tooth, teeth_entry.normal_teeth_amt)
	head.install_tooth(/obj/item/natural/tooth/fang, teeth_entry.fangs_amt)
	head.install_tooth(/obj/item/natural/tooth/golden, teeth_entry.golden_teeth_amt)
	head.install_tooth(/obj/item/natural/tooth/fang/golden, teeth_entry.golden_fangs_amt)
	head.install_tooth(/obj/item/natural/tooth/woooden, teeth_entry.wooden_teeth_amt)

/datum/customizer_entry/teeth
	var/normal_teeth_amt = 32
	var/fangs_amt = 0
	var/golden_teeth_amt = 0
	var/golden_fangs_amt = 0
	var/wooden_teeth_amt = 0

/datum/customizer_entry/teeth/proc/set_teeth_and_sanitize(teeth_type, amt, max_teeth_count)
	switch(teeth_type)
		if("normal_teeth_amt")
			var/teeth_to_set = max_teeth_count - (fangs_amt + golden_teeth_amt + golden_fangs_amt + wooden_teeth_amt)
			normal_teeth_amt = min(teeth_to_set, amt)
		if("fangs_amt")
			var/teeth_to_set = max_teeth_count - (normal_teeth_amt + golden_teeth_amt + golden_fangs_amt + wooden_teeth_amt)
			teeth_to_set = min(teeth_to_set, 4)
			fangs_amt = min(teeth_to_set, amt)
		if("golden_teeth_amt")
			var/teeth_to_set = max_teeth_count - (normal_teeth_amt + fangs_amt + golden_fangs_amt + wooden_teeth_amt)
			golden_teeth_amt = min(teeth_to_set, amt)
		if("golden_fangs_amt")
			var/teeth_to_set = max_teeth_count - (normal_teeth_amt + fangs_amt + golden_teeth_amt + wooden_teeth_amt)
			teeth_to_set = min(teeth_to_set, 4)
			golden_fangs_amt = min(teeth_to_set, amt)
		if("wooden_teeth_amt")
			var/teeth_to_set = max_teeth_count - (normal_teeth_amt + fangs_amt + golden_teeth_amt + golden_fangs_amt)
			wooden_teeth_amt = min(teeth_to_set, amt)
