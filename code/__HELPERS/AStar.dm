/*
A Star pathfinding algorithm
Returns a list of tiles forming a path from A to B, taking dense objects as well as walls, and the orientation of
windows along the route into account.
Use:
your_list = AStar(start location, end location, moving atom, distance proc, max nodes, maximum node depth, minimum distance to target, adjacent proc, atom id, turfs to exclude, check only simulated)

Optional extras to add on (in order):
Distance proc : the distance used in every A* calculation (length of path and heuristic)
MaxNodes: The maximum number of nodes the returned path can be (0 = infinite)
Maxnodedepth: The maximum number of nodes to search (default: 30, 0 = infinite)
Mintargetdist: Minimum distance to the target before path returns, could be used to get
near a target, but not right to it - for an AI mob with a gun, for example.
Adjacent proc : returns the turfs to consider around the actually processed node
Simulated only : whether to consider unsimulated turfs or not (used by some Adjacent proc)

Also added 'exclude' turf to avoid travelling over; defaults to null

*/
#define PF_TIEBREAKER 0.005
//tiebreker weight.To help to choose between equal paths
//////////////////////
//datum/PathNode object
//////////////////////


//A* nodes variables
/datum/PathNode
	var/turf/source //turf associated with the PathNode
	var/datum/PathNode/prevNode //link to the parent PathNode
	var/f		//A* Node weight (f = g + heuristic)
	var/g		//A* movement cost variable
	var/heuristic		//A* heuristic variable
	var/nodes_traversed //count the number of Nodes traversed
	var/bf		//bitflag for dir to expand.Some sufficiently advanced motherfuckery

/datum/PathNode/New(s,p,pg,ph,pnt,_bf)
	source = s
	setp(p, pg, ph, pnt)
	bf = _bf

/datum/PathNode/proc/setp(p,pg,ph,pnt)
	prevNode = p
	g = pg
	heuristic = ph
	calc_f()
	nodes_traversed = pnt

/datum/PathNode/proc/calc_f()
	f = g + heuristic*(1 + PF_TIEBREAKER)

//////////////////////
//A* procs
//////////////////////

//the weighting function, used in the A* algorithm
/proc/PathWeightCompare(datum/PathNode/a, datum/PathNode/b)
	return a.f - b.f

//reversed so that the Heap is a MinHeap rather than a MaxHeap
/proc/HeapPathWeightCompare(datum/PathNode/a, datum/PathNode/b)
	return b.f - a.f

//wrapper that returns an empty list if A* failed to find a path
/proc/get_path_to(traveler, end, dist, maxnodes, maxnodedepth = 30, mintargetdist, adjacent = TYPE_PROC_REF(/turf, reachableTurftest), id=null, turf/exclude=null, allow_multiz = TRUE)
	var/l = SSpathfinder.mobs.getfree(traveler)
	while(!l)
		stoplag(3)
		l = SSpathfinder.mobs.getfree(traveler)
	var/list/path = AStar(traveler, end, dist, maxnodes, maxnodedepth, mintargetdist, adjacent,id, exclude)

	SSpathfinder.mobs.found(l)
	if(!path)
		path = list()
	return path

/proc/cir_get_path_to(traveler, end, dist, maxnodes, maxnodedepth = 30, mintargetdist, adjacent = TYPE_PROC_REF(/turf, reachableTurftest), id=null, turf/exclude=null, allow_multiz = TRUE)
	var/l = SSpathfinder.circuits.getfree(traveler)
	while(!l)
		stoplag(3)
		l = SSpathfinder.circuits.getfree(traveler)
	var/list/path = AStar(traveler, end, dist, maxnodes, maxnodedepth, mintargetdist, adjacent, id, exclude, allow_multiz)
	SSpathfinder.circuits.found(l)
	if(!path)
		path = list()
	return path

/proc/AStar(traveler, _end, dist, maxnodes, maxnodedepth = 30, mintargetdist, adjacent = TYPE_PROC_REF(/turf, reachableTurftest), id=null, turf/exclude=null, allow_multiz = TRUE)
	//sanitation
	var/turf/end = get_turf(_end)
	var/turf/start = get_turf(traveler)
	if(!start || !end)
		stack_trace("Invalid A* start or destination")
		return FALSE
	if(start == end) // pointless!
		return FALSE
	if(!allow_multiz && start.z != end.z) //no pathfinding between z levels with multiz off
		return FALSE
	if(maxnodes)
		//if start turf is farther than maxnodes from end turf, no need to do anything
		if(call(start, dist)(end, traveler) > maxnodes)
			return FALSE
		maxnodedepth = maxnodes //no need to consider path longer than maxnodes
	var/datum/Heap/open = new /datum/Heap(/proc/HeapPathWeightCompare) //the open list
	var/list/openc = new() //open list for node check
	var/list/path = null //the returned path, if any
	//initialization
	var/const/ALL_DIRS = NORTH|SOUTH|EAST|WEST
	var/datum/PathNode/cur = new /datum/PathNode(start,null,0,call(start,dist)(end, traveler),0,ALL_DIRS,1)//current processed turf
	open.Insert(cur)
	openc[start] = cur
	//then run the main loop
	while(traveler && !open.IsEmpty() && !path)
		cur = open.Pop() //get the lower f turf in the open list
		//get the lower f node on the open list
		//if we only want to get near the target, check if we're close enough
		var/closeenough
		if(mintargetdist) // we let you stop early if you aren't on the same z-level because that enables fun shenanigans like taunting and climbing
			// I lied, this one is also hardcoded; we don't want to use the heuristic for our termination condition,
			// only the actual distance.
			closeenough = cur.source.Distance_cardinal_3d(end, traveler) <= mintargetdist



		//found the target turf (or close enough), let's create the path to it
		if(cur.source == end || closeenough)
			path = list(cur.source)
			while(cur.prevNode)
				cur = cur.prevNode
				path.Add(cur.source)
			break
		if(maxnodedepth && (cur.nodes_traversed > maxnodedepth)) //if too many steps, don't process that path
			cur.bf = 0
			CHECK_TICK
			continue
		//get adjacents turfs using the adjacent proc, checking for access with id
		for(var/dir_to_check in GLOB.cardinals)
			if(!(cur.bf & dir_to_check)) // we can't proceed in this direction
				continue
			if(cur.source.LinkSelfBlocked(dir_to_check, traveler, id)) // check if this dir is blocked moving out of our current turf
				cur.bf &= dir_to_check // don't check this dir again for this node
				continue
			// get the turf we end up at if we move in dir_to_check; this may have special handling for multiz moves
			var/T = get_step(cur.source, dir_to_check)
			// when leaving a turf with stairs on it, we can change Z, so take that into account
			// this handles both upwards and downwards moves depending on the dir
			var/obj/structure/stairs/source_stairs = locate(/obj/structure/stairs) in cur.source
			if(source_stairs)
				T = source_stairs.get_transit_destination(dir_to_check)
			if(T != exclude)
				var/datum/PathNode/CN = openc[T]  //current checking turf
				var/reverse = GLOB.reverse_dir[dir_to_check]
				var/newg = cur.g + call(cur.source,dist)(T, traveler) // add the travel distance between these two tiles to the distance so far
				if(CN)
				//is already in open list, check if it's a better way from the current turf
					CN.bf &= ALL_DIRS^reverse //we have no closed, so just cut off exceed dir.00001111 ^ reverse_dir.We don't need to expand to checked turf.
					if((newg < CN.g))
						if(call(cur.source,adjacent)(traveler, T, id))
							CN.setp(cur,newg,CN.heuristic,cur.nodes_traversed+1)
							open.ReSort(CN)//reorder the changed element in the list
				else
				//is not already in open list, so add it
					if(call(cur.source,adjacent)(traveler, T, id)) 
						CN = new(T,cur,newg,call(T,dist)(end, traveler),cur.nodes_traversed+1, ALL_DIRS^reverse)
						open.Insert(CN)
						openc[T] = CN
		cur.bf = 0
		CHECK_TICK
	//reverse the path to get it from start to finish
	if(path)
		for(var/i = 1 to round(0.5*path.len))
			path.Swap(i,path.len-i+1)
	openc = null
	//cleaning after us
	return path

/// returns TRUE if there exists a way for traveler to (safely) move from src to T. non-z-aware
/turf/proc/reachableTurftest(traveler, turf/T, ID)
	if(T && !T.density && T.can_traverse_safely(traveler) && !LinkBlockedWithAccess(T,traveler, ID))
		return TRUE

/// returns TRUE if there exists a way for traveler to (safely) move from src to T. z-aware
/turf/proc/reachableTurftest3d(traveler, turf/T, ID, recursive_call = 0)
	if(!T || T.density)
		return FALSE
	if(!T.can_traverse_safely(traveler)) // dangerous turf! lava or openspace (or others in the future)
		// If we can jump, jump over it!
		if(!ishuman(traveler)) // sorry, only humanmobs can jump atm
			return FALSE
		var/mob/living/carbon/human/human_traveler = traveler
		if(!human_traveler.npc_jump_chance) // If we can't jump at all, don't bother.
			return FALSE
		var/turf/landing_turf = get_step_away(T, src) // this is the turf we'd want to land on
		// currently we'll only try to jump 2-tile gaps
		if(recursive_call < 2 && T.reachableTurftest3d(traveler, landing_turf, ID, recursive_call + 1))
			return TRUE // jumpable
		return FALSE
	var/z_distance = abs(T.z - z)
	if(!z_distance) // standard check for same-z pathing
		return !LinkBlockedWithAccess(T, traveler, ID)
	if(z_distance != 1) // no single movement lets you move more than one z-level at a time (currently; update if this changes)
		return FALSE
	var/obj/structure/stairs/source_stairs = locate(/obj/structure/stairs) in src
	var/mob/mob_traveler = traveler
	if(ismob(traveler) && HAS_TRAIT(mob_traveler, TRAIT_ZJUMP)) // where we're going, we don't need stairs!
		return TRUE
	if(T.z < z) // going down
		if(source_stairs?.get_target_loc(GLOB.reverse_dir[source_stairs.dir]) == T)
			return TRUE
	else // heading DOWN stairs was handled earlier, so now handle going UP stairs
		if(source_stairs?.get_target_loc(source_stairs.dir) == T)
			return TRUE
	return FALSE

/turf/proc/LinkSelfBlocked(travel_dir, traveler, ID)
	if(travel_dir & (travel_dir - 1)) // diagonal dir, split it into cardinals
		var/in_dir = GLOB.reverse_dir[travel_dir] // for some reason TG chooses to go from target->src instead of src->target
		var/first_step_dir = in_dir & (NORTH|SOUTH) // vertical component
		var/second_step_dir = in_dir & (EAST|WEST) // horizontal component
		// fail only if both are blocked. todo: is this desirable? maybe we want to block if only one fails
		return LinkSelfBlocked(first_step_dir, traveler, ID) && LinkSelfBlocked(second_step_dir, traveler, ID)
	var/turf/next_turf = get_step(src, travel_dir)
	for(var/obj/O in src)
		if(!O.CanAStarPass(ID, travel_dir, traveler) && O != traveler)
			return TRUE
	for(var/mob/living/M in src)
		if(!M.CanPass(traveler, next_turf) && M != traveler)
			return TRUE
	return FALSE

/turf/proc/LinkBlockedWithAccess(turf/target, traveler, ID)
	if(target.x != x && target.y != y) // split diagonals into cardinals here
		var/in_dir = get_dir(target, src) // for some reason TG chooses to go from target->src instead of src->target
		var/first_step_dir = in_dir & (NORTH|SOUTH) // vertical component
		var/second_step_dir = in_dir & (EAST|WEST) // horizontal component
		// we only need to succeed on one for it to pass
		var/turf/first_midstep_turf = get_step(target, first_step_dir)
		var/turf/second_midstep_turf = get_step(target, second_step_dir)
		#define WAY_IS_BLOCKED(TURF) (TURF.density || LinkBlockedWithAccess(TURF, traveler, ID) || TURF.LinkBlockedWithAccess(target, traveler, ID))
		// only block if BOTH are blocked
		return WAY_IS_BLOCKED(first_midstep_turf) && WAY_IS_BLOCKED(second_midstep_turf)
		#undef WAY_IS_BLOCKED
	var/travel_dir = get_dir(src, target)
	var/reverse_dir = GLOB.reverse_dir[travel_dir] // dir from target to src, to check destination blockers.
	// ^^ this assumes movement is always two-way and will break on cliffs/one-way blockers, afaik
	for(var/obj/O in target)
		if(!O.CanAStarPass(ID, reverse_dir, traveler))
			return TRUE
	for(var/mob/living/M in target)
		if(!M.CanPass(traveler, target))
			return TRUE
	return FALSE
