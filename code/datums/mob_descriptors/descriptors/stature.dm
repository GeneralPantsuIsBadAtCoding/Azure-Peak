/datum/mob_descriptor/stature
	abstract_type = /datum/mob_descriptor/stature
	slot = MOB_DESCRIPTOR_SLOT_STATURE

/datum/mob_descriptor/stature/man
	name = "Man/Woman"

/datum/mob_descriptor/stature/man/get_description(mob/living/described)
	switch(described.pronouns)
		if(SHE_HER)
			return "woman"
		if(SHE_HER_M)
			return "woman"
		if(HE_HIM)
			return "man"
		if(HE_HIM_F)
			return "man"
		if(THEY_THEM)
			return "person"
		if(THEY_THEM_F)
			return "person"
		else
			return "creacher"

/datum/mob_descriptor/stature/gentleman
	name = "Gentleman/Gentlewoman"

/datum/mob_descriptor/stature/gentleman/get_description(mob/living/described)
	switch(described.pronouns)
		if(SHE_HER)
			return "gentlewoman"
		if(SHE_HER_M)
			return "gentlewoman"
		if(HE_HIM)
			return "gentleman"
		if(HE_HIM_F)
			return "gentleman"
		if(THEY_THEM)
			return "gentleperson"
		if(THEY_THEM_F)
			return "gentleperson"
		else
			return "gentlecreacher"

/datum/mob_descriptor/stature/thug
	name = "Thug"

/datum/mob_descriptor/stature/knave
	name = "Knave"

/datum/mob_descriptor/stature/wench
	name = "Wench"

/datum/mob_descriptor/stature/snob
	name = "Snob"

/datum/mob_descriptor/stature/slob
	name = "Slob"

/datum/mob_descriptor/stature/brute
	name = "Brute"

/datum/mob_descriptor/stature/highbrow
	name = "Highbrow"

/datum/mob_descriptor/stature/stooge
	name = "Stooge"

/datum/mob_descriptor/stature/fool
	name = "Fool"

/datum/mob_descriptor/stature/bookworm
	name = "Bookworm"

/datum/mob_descriptor/stature/lowlife
	name = "Lowlife"

/datum/mob_descriptor/stature/dignitary
	name = "Dignitary"
