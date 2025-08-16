/obj/structure/threatboard
	name = "Threat Board"
	desc = "A board where wardens posts scout reports on threats in the area. This one looks strangely out of place."
	icon_state = "nboard00"
	density = FALSE
	anchored = TRUE
	max_integrity = 9999 // Fuck gamers
	var/notices = 0

/obj/structure/threatboard/attackby(obj/item/I, mob/living/user)
	if(!user.get_active_held_item())
		interact(user)
	return ..()

/obj/structure/threatboard/interact(mob/user)
	user.set_machine(src)
	var/datum/browser/menu = new(user, "Scout Report", "Scout Report", 600, 800, src)
	var/content = "<html>"
	var/list/regional_threats = SSregionthreat.get_threat_regions_for_display()
	content += "<hr>"
	for(var/T in regional_threats)
		var/datum/threat_region_display/TRS = T
		content += ("<div>[TRS?.region_name]: <font color=[TRS?.danger_color]>[TRS?.danger_level]</font></div>")
	content += "<hr>"
	content += "Scouts rate how dangerous a region is from Safe -> Low -> Moderate -> Dangerous -> Dire <br>"
	content += "A safe region is safe and travelers are unlikely to be ambushed by common creechurs and brigands <br>"
	content += "A low threat region is unlikely to manifest any great threat and brigands and creechurs are often found alone.<br>"
	content += "Only Azure Basin, Northern Grove, South Azurean Coast, and the Terrorbog can be rendered safe entirely. <br>" 
	content += "Regions not listed are beyond the charge of the warden. <br>"
	content += "Danger is reduced by luring villains and creechurs and killing them when they ambush you. The signal horns you have been issued can help with this. Take care with using it."
	content += "</html>"
	menu.set_content(content)
	menu.open()

// I am converting this to TGUI later - Coder who did not convert this to TGUI later - WeNeedMorePhoron

// /obj/structure/threatboard/ui_interact(mob/user, datum/tgui/ui)
// 	ui = SStgui.try_update_ui(user, src, ui)
// 	if(!ui)
// 		ui = new(user, src, "ThreatBoard", "ThreatBoard")
// 		ui.open()

// /obj/structure/threatboard/ui_data(mob/user)
// 	var/list/data = ..()
// 	data["threat_regions"] = SSregionthreat.get_threat_regions_for_display()
// 	return data
