/atom
	/// the datum handler for our contents - see create_storage() for creation method
	var/datum/component/storage/atom_storage

/// A quick and easy way to create a storage datum for an atom
/atom/proc/create_storage(
	max_items,
	max_w_class,
	max_combined_w_class,
	list/canhold,
	list/canthold,
	component_type = /datum/component/storage
)
	RETURN_TYPE(/datum/component/storage)

	if(atom_storage)
		QDEL_NULL(atom_storage)

	atom_storage = new component_type(src, max_items, max_w_class, max_combined_w_class)

	if(canhold || canthold)
		atom_storage.set_holdable(canhold, canthold)

	return atom_storage

/**
 * A quick and easy way to /clone/ a storage datum for an atom (does not copy over contents, only the datum details)
 *
 * Imperfect, does not copy over ALL variables, only important ones (max storage size, etc)
 */
/atom/proc/clone_storage(datum/component/storage/cloning)
	RETURN_TYPE(/datum/component/storage)

	if(atom_storage)
		QDEL_NULL(atom_storage)

	atom_storage = new cloning.type(src, cloning.max_items, cloning.max_w_class, cloning.max_combined_w_class)

	if(cloning.can_hold || cloning.cant_hold)
		if(!atom_storage.can_hold && !atom_storage.cant_hold) //In the event that the can/can't hold lists are already in place (such as from storage objects added on initialize).
			atom_storage.set_holdable(cloning.can_hold, cloning.cant_hold)

	return atom_storage
