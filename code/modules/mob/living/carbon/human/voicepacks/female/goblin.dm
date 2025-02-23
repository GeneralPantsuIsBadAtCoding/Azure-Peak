/datum/voicepack/female/goblin/get_sound(soundin, modifiers)
	var/used
	switch(modifiers)
		if("old")
			used = getfold(soundin)
		if("young")
			used = getfyoung(soundin)
		if("silenced")
			used = getfsilenced(soundin)
	if(!used)
		switch(soundin)
			if("chuckle")
				used = list('sound/vo/female/goblin/chuckle (1).ogg','sound/vo/female/goblin/chuckle (2).ogg','sound/vo/female/goblin/chuckle (3).ogg','sound/vo/female/goblin/chuckle (4).ogg')
			if("giggle")
				used = list('sound/vo/female/goblin/giggle (1).ogg','sound/vo/female/goblin/giggle (2).ogg','sound/vo/female/goblin/giggle (3).ogg','sound/vo/female/goblin/giggle (4).ogg','sound/vo/female/goblin/giggle (5).ogg','sound/vo/female/goblin/giggle (6).ogg')
			if("laugh")
				used = list('sound/vo/female/goblin/laugh (1).ogg','sound/vo/female/goblin/laugh (2).ogg','sound/vo/female/goblin/laugh (3).ogg','sound/vo/female/goblin/laugh (4).ogg','sound/vo/female/goblin/laugh (5).ogg')


	if(!used) //we haven't found a racial specific sound so use generic
		used = ..(soundin)
	return used
