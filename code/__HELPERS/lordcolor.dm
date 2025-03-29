GLOBAL_LIST_EMPTY(lordcolor)

GLOBAL_VAR(lordprimary)
GLOBAL_VAR(lordsecondary)

/obj/proc/lordcolor(primary,secondary)
	color = primary

/obj/item/clothing/cloak/lordcolor(primary,secondary)
	..()
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_cloak()


/turf/proc/lordcolor(primary,secondary)
	color = primary

/mob/proc/lord_color_choice()
	if(!client)
		addtimer(CALLBACK(src, PROC_REF(lord_color_choice)), 50)
		return
	var/list/lordcolors = list(
"PURPLE"="#8747b1", //RED AND BLACK
"RED"="#8b2323", 	//	 I DRESS
"BLACK"="#2b292e", 	//	  EAGLE
"BROWN"="#61462c", 	// ON MY CHEST
"GREEN"="#264d26", 	//IT'S GOOD TO BE
"BLUE"="#173266", 	// AN ALBANIAN
"YELLOW"="#ffcd43", // KEEP MY HEAD
"TEAL"="#249589", 	//	 UP HIGH
"AZURE"="#007fff", 	// FOR THE FLAG
"WHITE"="#ffffff",	//	  I DIE
"ORANGE"="#df8405",	//I'M PROUD TO BE
"MAGENTA"="#962e5c")// AN ALBANIAN
	var/prim
	var/sec
	var/choice = input(src, "Choose a Primary Color", "ROGUETOWN") as anything in lordcolors
	if(choice)
		prim = lordcolors[choice]
		lordcolors -= choice
	choice = input(src, "Choose a Secondary Color", "ROGUETOWN") as anything in lordcolors
	if(choice)
		sec = lordcolors[choice]
	if(!prim || !sec)
		GLOB.lordcolor = list()
		return
	GLOB.lordprimary = prim
	GLOB.lordsecondary = sec
	for(var/obj/O in GLOB.lordcolor)
		O.lordcolor(prim,sec)
		GLOB.lordcolor -= O
	for(var/turf/T in GLOB.lordcolor)
		T.lordcolor(prim,sec)
		GLOB.lordcolor -= T

/proc/lord_color_default()
	GLOB.lordprimary = "#007fff" //AZURE
	GLOB.lordsecondary = "#ffffff" //WHITE
	for(var/obj/O in GLOB.lordcolor)
		O.lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	for(var/turf/T in GLOB.lordcolor)
		T.lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
