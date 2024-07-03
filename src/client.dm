client
	var/mob/unit/selected_unit
	var/obj/unit_indicator/unit_indicator

client/New()
	src.unit_indicator = new ()
	src.screen += ::chat

	return ..()

client/Move()
	return (!src.selected_unit && ..())

obj/chat
	screen_loc = "1,1"
	maptext_width = 400
	maptext_height = 304
	maptext_y = -8

// One line can display up to 48 characters.
obj/chat/proc/Update(t)
	src.maptext += "<span style=\"font-family: 'Public Pixel'; font-size: 6pt; line-height: 1; vertical-align: top; margin-right: 8px; margin-left: 8px; color: #fff; text-shadow: 1px 1px 0 #000;\">[t]</span>"

obj/chat/proc/Clear()
	src.maptext = null
