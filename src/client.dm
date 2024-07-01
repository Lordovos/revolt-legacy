client
	var/mob/unit/selected_unit
	var/obj/unit_indicator/unit_indicator

client/New()
	src.unit_indicator = new ()
	src.screen += ::chat

	return ..()

obj/chat
	screen_loc = "1,1"
	maptext_width = 400
	maptext_height = 304

obj/chat/proc/Update(t)
	src.maptext += "<span style=\"text-align: right; margin-right: 4px; color: #fff; text-shadow: 1px 1px 0 #000;\">[t]</span>"
