//#define LOWMEMORYMODE //uncomment this to load centcom and runtime station and thats it.

#include "map_files\generic\CentCom.dmm"

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		#include "map_files/coyote_bayou/Dungeons.dmm"
		#include "map_files/coyote_bayou/Texarkana_underground.dmm"
		#include "map_files/coyote_bayou/Nash_and_Texarkana.dmm"
		#include "map_files/coyote_bayou/Nash_and_Texarkana-Upper.dmm"
		#include "map_files/coyote_bayou/Nash_and_Texarkana-Upper-2.dmm"
		#include "map_files/coyote_bayou/Redwater.dmm"
		#include "map_files/coyote_bayou/Redwater-Upper.dmm"
		#include "map_files/coyote_bayou/Ashdown.dmm"
		#include "map_files/coyote_bayou/Ashdown-Upper.dmm"
		#include "map_files/coyote_bayou/Garland-City.dmm"
		#include "map_files/coyote_bayou/Newboston.dmm"
		#include "map_files/coyote_bayou/Newboston-Upper.dmm"
		#ifdef TRAVISBUILDING
			#include "templates.dm"
		#endif
	#endif
#endif
