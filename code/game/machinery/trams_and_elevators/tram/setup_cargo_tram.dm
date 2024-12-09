/proc/setup_cargo_boat()
	for(var/obj/structure/industrial_lift/tram/master in GLOB.lifts)
		var/datum/lift_master/tram/master_datum = master.lift_master_datum
		var/obj/effect/landmark/tram/queued_path/cargo_map_enter/located_enter = master_datum.idle_platform
		if(!istype(located_enter))
			continue
		SSmerchant.cargo_boat = master.lift_master_datum
		SSmerchant.cargo_boat.hide_tram()
		break

