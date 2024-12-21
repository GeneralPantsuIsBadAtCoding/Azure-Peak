/datum/game_mode/extended
	name = "secret extended"
	config_tag = "secret_extended"
	report_type = "extended"
	false_report_weight = 5
	required_players = 0

	announce_span = "notice"
	announce_text = "Just have fun and enjoy the game!"

/datum/game_mode/extended/pre_setup()
	return 1

/datum/game_mode/extended/generate_report()
	return "The transmission mostly failed to mention your sector. It is possible that there is nothing in the Syndicate that could threaten your station during this shift."

/datum/game_mode/extended/announced
	name = "extended"
	config_tag = "extended"
	false_report_weight = 0

/datum/game_mode/extended/announced/send_intercept(report = 0)
	priority_announce("Thanks to the tireless efforts of our security and intelligence divisions, there are currently no credible threats to [station_name()]. All station construction projects have been authorized. Have a secure shift!", "Security Report", 'sound/blank.ogg')

/datum/game_mode/extended/check_finished()
	var/ttime = world.time - SSticker.round_start_time

	if(ttime >= GLOB.round_timer)
		if(roundvoteend)
			if(ttime >= (GLOB.round_timer + ROUND_END_TIME) )
				return TRUE
		else
			if(!SSvote.mode && SSticker.autovote)
				SSvote.initiate_vote("endround", "Psydon")
