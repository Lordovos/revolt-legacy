obj/tile_indicator
	icon = 'assets/indicators.dmi'
	icon_state = "default"
	layer = FLY_LAYER
	mouse_opacity = 0

obj/tile_indicator/New()
	..()
	src.SetColor(src.loc)

obj/tile_indicator/proc/SetColor(turf/t)
	switch (t?.tile_type)
		if (TILE_UNKNOWN)
			src.color = COLOR_GRAY

		if (TILE_FLOOR)
			src.color = COLOR_BLUE

		if (TILE_WALL)
			src.color = COLOR_RED

		if (TILE_OBSTACLE)
			src.color = COLOR_YELLOW

		if (TILE_FOG)
			src.color = COLOR_GREEN
