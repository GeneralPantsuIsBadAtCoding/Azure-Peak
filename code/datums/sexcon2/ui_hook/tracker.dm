/datum/ui_tracker
	/// The object being tracked
	var/datum/tracked_object
	/// Callback to execute when changes are detected
	var/datum/callback/on_change_callback
	/// List of property paths to track (e.g., "speed", "force", "collective.display_name")
	var/list/tracked_properties = list()
	/// List of data getter callbacks for dynamic properties
	var/list/data_getters = list()
	/// Cache of last known values
	var/list/cached_values = list()
	/// Update timer
	var/update_timer
	/// Update interval
	var/update_interval = 1 SECONDS
	/// Whether tracking is active
	var/active = FALSE

/datum/ui_tracker/New(datum/target_object, datum/callback/change_callback, updates)
	tracked_object = target_object
	on_change_callback = change_callback
	if(!updates)
		update_interval = 0

/datum/ui_tracker/Destroy()
	stop_tracking()
	tracked_properties.Cut()
	cached_values.Cut()
	return ..()

/datum/ui_tracker/proc/track_property(property_path, datum/callback/data_getter = null, variable = TRUE)
	if(property_path in tracked_properties)
		return
	tracked_properties += property_path
	if(data_getter)
		data_getters[property_path] = data_getter
	if(variable)
		cached_values[property_path] = get_property_value(property_path)

/datum/ui_tracker/proc/untrack_property(property_path)
	tracked_properties -= property_path
	cached_values -= property_path

/datum/ui_tracker/proc/start_tracking()
	if(active)
		return
	active = TRUE
	if(update_interval)
		update_timer = addtimer(CALLBACK(src, PROC_REF(check_for_changes)), update_interval, flags = TIMER_LOOP)

/datum/ui_tracker/proc/stop_tracking()
	active = FALSE
	if(update_timer)
		deltimer(update_timer)
		update_timer = null

/datum/ui_tracker/proc/check_for_changes()
	if(!active || !tracked_object)
		return

	var/list/changes = list()

	for(var/property_path in tracked_properties)
		var/current_value = get_property_value(property_path)
		var/cached_value = cached_values[property_path]

		if(!values_equal(cached_value, current_value))
			changes[property_path] = list("old" = cached_value, "new" = current_value)
			cached_values[property_path] = current_value

	if(length(changes) && on_change_callback)
		on_change_callback.Invoke(changes)

/datum/ui_tracker/proc/get_property_value(property_path)
	// Check if we have a custom data getter for this property
	if(data_getters[property_path])
		var/datum/callback/getter = data_getters[property_path]
		return getter.Invoke()

	// Default property getter for regular object properties
	var/list/path_parts = splittext(property_path, ".")
	var/atom/current_object = tracked_object

	for(var/part in path_parts)
		if(!current_object || !current_object.vars[part])
			return null
		current_object = current_object.vars[part]

	return current_object

/datum/ui_tracker/proc/values_equal(old_val, new_val)
	return old_val == new_val

/datum/ui_tracker/proc/push_data_change(property_path, new_value)
	if(!(property_path in tracked_properties))
		return

	var/cached_value = cached_values[property_path]

	if(!values_equal(cached_value, new_value))
		var/list/changes = list()
		changes[property_path] = list("old" = cached_value, "new" = new_value)
		cached_values[property_path] = new_value

		if(on_change_callback)
			on_change_callback.Invoke(changes)

/datum/ui_tracker/proc/force_check()
	check_for_changes()
