/datum/voicepack/male/goblin/get_sound(soundin, modifiers)
	var/used
	switch(modifiers)
		if("old")
			used = getmold(soundin)
		if("young")
			used = getmyoung(soundin)
		if("silenced")
			used = getmsilenced(soundin)
	if(!used)
		switch(soundin)
			if("chuckle")
				used = list('sound/vo/male/goblin/chuckle (1).ogg','sound/vo/male/goblin/chuckle (2).ogg','sound/vo/male/goblin/chuckle (3).ogg')
			if("giggle")
				used = list('sound/vo/male/goblin/giggle (1).ogg','sound/vo/male/goblin/giggle (2).ogg','sound/vo/male/goblin/giggle (3).ogg')
			if("laugh")
				used = list('sound/vo/male/goblin/laugh (1).ogg','sound/vo/male/goblin/laugh (2).ogg','sound/vo/male/goblin/laugh (3).ogg')


	if(!used) //we haven't found a racial specific sound so use generic
		used = ..(soundin)
	return used
