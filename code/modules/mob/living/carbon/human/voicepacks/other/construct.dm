/datum/voicepack/construct/get_sound(soundin, modifiers)
	var/used
	switch(soundin)
		if("attnwhistle")
			used = pick('sound/misc/bamf.ogg')
		if("rage")
			used = pick('sound/misc/smelter_fin.ogg')
		if("laugh")
			used = pick('sound/misc/elec (1).ogg','sound/misc/elec (2).ogg','sound/misc/elec (3).ogg')
		if("deathgurgle")
			used = pick('sound/items/smokebomb.ogg','sound/vo/mobs/skel/skeleton_scream (2).ogg','sound/vo/mobs/skel/skeleton_scream (3).ogg','sound/vo/mobs/skel/skeleton_scream (4).ogg','sound/vo/mobs/skel/skeleton_scream (5).ogg')
		if("firescream")
			used = pick('sound/misc/chain_snap.ogg')
		if("pain")
			used = pick('sound/misc/machineno.ogg')
		if("paincrit")
			used = pick('sound/misc/elec (1).ogg','sound/misc/elec (2).ogg','sound/misc/elec (3).ogg')
		if("scream")
			used = pick('sound/misc/smelter_sound.ogg')


	return used
