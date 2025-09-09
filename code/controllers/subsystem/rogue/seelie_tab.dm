/mob/living/carbon/human/proc/Turnlight()
	set name = "Seelie glow"
	set category = "Seelie"


	switch(src.light_power)
		if(!0)
			to_chat(src, span_notice("I stop glowing"))
			src.set_light(0, 0, null)
		if(0)
			to_chat(src, span_notice("I begin to glow once more"))
			src.set_light(3, 1, "#d4fcac")

/mob/living/carbon/proc/switchaura()
	set name = "Luck aura"
	set category = "Seelie"


	var/mob/living/carbon/User = src
	switch(User.aura)
		if(TRUE)
			to_chat(src, span_warning("My aura is now one of misery"))
			User.aura = FALSE
			src.log_message("[key_name(src)] has switched their aura to apply bad luck")
		if(FALSE)
			to_chat(src, span_warning("My aura is now one of blessing"))
			User.aura = TRUE
			src.log_message("[key_name(src)] has switched their aura to apply good luck")
