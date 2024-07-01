obj/unit_message
	layer = FLY_LAYER
	pixel_z = 8
	maptext_x = -16
	maptext_width = 48
	maptext_height = 32
	appearance_flags = RESET_COLOR | RESET_ALPHA

obj/unit_message/New(loc, maptext)
	..()
	src.maptext = "<span style=\"text-align: center;\">[maptext]</span>"
	animate(src, pixel_z = 24, time = 4)
	animate(alpha = 0, time = 20)

mob/verb/Message()
	var/obj/unit_message/um = new (null, "test")

	src.vis_contents += um

	spawn (30)
		src.vis_contents -= um
		um.loc = null
