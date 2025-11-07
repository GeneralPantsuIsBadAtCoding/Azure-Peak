/obj/structure/roguemachine/Hoardmaster/attack_hand(mob/living/user)
	if(!HAS_TRAIT(user, TRAIT_COMMIE))
		return
	var/datum/antagonist/bandit/B = usr.mind.has_antag_datum(/datum/antagonist/bandit)
	. = ..()
	if(.)
		return
	if(!ishuman(user))
		return
	user.changeNext_move(CLICK_CD_INTENTCAP)
	var/contents
	contents = "<center>Wishes for the Free<BR>"
	contents += "<a href='?src=[REF(src)];change=1'>Your favor:</a> [B.favor]<BR>"


	var/list/unlocked_cats = list("Things")
	switch(usr.advjob)
		if("Brigand")
			unlocked_cats+="Brigand"
		if("Sellsword")
			unlocked_cats+="Sellsword"
		if("Sawbones")
			unlocked_cats+="Sawbones"
		if("Hedge Knight")
			unlocked_cats+="Knight"
		if("Rogue Mage")
			unlocked_cats+="Mage"
		if("Knave")
			unlocked_cats+="Knave"
		if("Iconoclast")
			unlocked_cats+="Iconoclast"
		if("Afreet")
			unlocked_cats+="Grenzelhoft Armory"			
   
	if(current_cat == "1")
		contents += "<center>"
		for(var/X in unlocked_cats)
			contents += "<a href='?src=[REF(src)];changecat=[X]'>[X]</a><BR>"
		contents += "</center>"
	else
		contents += "<center>[current_cat]<BR></center>"
		contents += "<center><a href='?src=[REF(src)];changecat=1'>\[RETURN\]</a><BR><BR></center>"
		var/list/pax = list()
		for(var/pack in SSmerchant.supply_packs)
			var/datum/supply_pack/PA = SSmerchant.supply_packs[pack]
			if(PA.group == current_cat)
				pax += PA
		for(var/datum/supply_pack/PA in sortList(pax))
			contents += "[PA.name] [PA.contains.len > 1?"x[PA.contains.len]":""] - ([PA.cost])<a href='?src=[REF(src)];buy=[PA.type]'>BUY</a><BR>"

	var/datum/browser/popup = new(user, "HOARDMASTER", "", 370, 600)
	popup.set_content(contents)
	popup.open()
