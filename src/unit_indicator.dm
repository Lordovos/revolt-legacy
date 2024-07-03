obj/unit_indicator
	layer = FLY_LAYER
	mouse_opacity = 0
	appearance_flags = RESET_COLOR | RESET_ALPHA | RESET_TRANSFORM

	var/list/corners

obj/unit_indicator/New()
	..()
	src.corners = list(
		"bl" = new /obj/unit_indicator/corner(null, "bl"),
		"br" = new /obj/unit_indicator/corner(null, "br"),
		"tl" = new /obj/unit_indicator/corner(null, "tl"),
		"tr" = new /obj/unit_indicator/corner(null, "tr")
	)
	for (var/c in src.corners)
		src.vis_contents += src.corners[c]

obj/unit_indicator/proc/Render()
	// Distance in pixels that the corners begin at.
	var/x_offset = 8
	var/y_offset = 8
	// Distance in pixels to animate the corners inwards towards the unit.
	var/dist = 2
	var/ticks = 4

	src.corners["bl"]?.Render(-x_offset, -y_offset, dist, dist, ticks)
	src.corners["br"]?.Render(x_offset, -y_offset, -dist, dist, ticks)
	src.corners["tl"]?.Render(-x_offset, y_offset, dist, -dist, ticks)
	src.corners["tr"]?.Render(x_offset, y_offset, -dist, -dist, ticks)

obj/unit_indicator/corner
	// I use parent_type here so that I can organize corners under unit_indicators without corners having their own internal list of corners.
	parent_type = /obj
	icon = 'assets/indicators.dmi'
	mouse_opacity = 0
	appearance_flags = RESET_COLOR | RESET_ALPHA | RESET_TRANSFORM
	vis_flags = VIS_INHERIT_LAYER

obj/unit_indicator/corner/New(loc, icon_state)
	..()
	src.icon_state = icon_state

obj/unit_indicator/corner/proc/Render(x_offset, y_offset, dist_w, dist_z, ticks)
	animate(src)
	src.pixel_x = x_offset
	src.pixel_y = y_offset
	animate(src, pixel_x = x_offset + dist_w, pixel_y = y_offset + dist_z, time = ticks, loop = -1)
	animate(pixel_x = x_offset, pixel_y = y_offset, time = ticks)
