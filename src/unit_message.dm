obj/unit_message
	layer = FLY_LAYER
	pixel_z = 8
	maptext_x = -16
	maptext_width = 48
	maptext_height = 32
	appearance_flags = RESET_COLOR | RESET_ALPHA | RESET_TRANSFORM

obj/unit_message/New(loc, mob/unit/u, maptext)
	..()
	u.vis_contents += src
	// TODO: Change this to a CSS class once we are far enough along to have an interface.
	src.maptext = "<span style=\"text-align: center; color: #fff; text-shadow: 1px 1px 0 #000;\">[maptext]</span>"
	animate(src, pixel_z = 24, time = 2)
	animate(alpha = 0, time = 14)

	spawn (30)
		u.vis_contents -= src
		src.loc = null
