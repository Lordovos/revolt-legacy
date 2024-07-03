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
	var/w_offset = 8
	var/z_offset = 8
	// Distance in pixels to animate the corners inwards towards the unit.
	var/dist = 2
	var/ticks = 4

	src.corners["bl"]?.Render(-w_offset, -z_offset, dist, dist, ticks)
	src.corners["br"]?.Render(w_offset, -z_offset, -dist, dist, ticks)
	src.corners["tl"]?.Render(-w_offset, z_offset, dist, -dist, ticks)
	src.corners["tr"]?.Render(w_offset, z_offset, -dist, -dist, ticks)

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

obj/unit_indicator/corner/proc/Render(w_offset, z_offset, dist_w, dist_z, ticks)
	animate(src)
	src.pixel_w = w_offset
	src.pixel_z = z_offset
	animate(src, pixel_w = w_offset + dist_w, pixel_z = z_offset + dist_z, time = ticks, loop = -1)
	animate(pixel_w = w_offset, pixel_z = z_offset, time = ticks)
