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

obj/unit_indicator/proc/Update(mob/unit/u)
	// Use the unit's pixel offsets to calculate where the indicator corners should be placed.
	var/w = u.pixel_x + 8
	var/z = u.pixel_y + 4
	// Distance in pixels to animate inwards towards the unit.
	var/dist = 2
	var/ticks = 4

	src.corners["bl"]?.Update(-w, -z, dist, dist, ticks)
	src.corners["br"]?.Update(w, -z, -dist, dist, ticks)
	src.corners["tl"]?.Update(-w, z, dist, -dist, ticks)
	src.corners["tr"]?.Update(w, z, -dist, -dist, ticks)

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

obj/unit_indicator/corner/proc/Update(pixel_w, pixel_z, dist_w, dist_z, ticks)
	animate(src)
	src.pixel_w = pixel_w
	src.pixel_z = pixel_z
	animate(src, pixel_w = pixel_w + dist_w, pixel_z = pixel_z + dist_z, time = ticks, loop = -1)
	animate(pixel_w = pixel_w, pixel_z = pixel_z, time = ticks)
