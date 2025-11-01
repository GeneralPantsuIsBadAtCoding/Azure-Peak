/datum/ui_updater
	/// The viewer of this UI
	var/mob/viewer
	/// Browser window ID
	var/window_id
	/// The tracker monitoring changes
	var/datum/ui_tracker/tracker
	/// Map of property paths to JavaScript update functions
	var/list/property_js_map = list()

/datum/ui_updater/New(mob/target_viewer, target_window_id, datum/tracked_object, updates = TRUE)
	viewer = target_viewer
	window_id = target_window_id
	tracker = new /datum/ui_tracker(tracked_object, CALLBACK(src, PROC_REF(handle_changes)), updates)

/datum/ui_updater/Destroy()
	if(tracker)
		qdel(tracker)
	property_js_map.Cut()
	return ..()

/datum/ui_updater/proc/track_property(property_path, js_update_function, datum/callback/data_getter = null, variable = TRUE)
	tracker.track_property(property_path, data_getter, variable)
	property_js_map[property_path] = js_update_function

/datum/ui_updater/proc/start_updates()
	tracker.start_tracking()

/datum/ui_updater/proc/stop_updates()
	tracker.stop_tracking()

/datum/ui_updater/proc/push_data_change(property_path, new_value)
	if(tracker)
		tracker.push_data_change(property_path, new_value)

/datum/ui_updater/proc/handle_changes(list/changes)
	for(var/property_path in changes)
		var/list/change_data = changes[property_path]
		var/new_value = change_data["new"]
		var/js_function = property_js_map[property_path]

		if(js_function)
			var/params = list2params(list(new_value))
			viewer << output(params, "[window_id].browser:[js_function]")
