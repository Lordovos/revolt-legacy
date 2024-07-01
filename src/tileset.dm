turf
	var/tile_type = TILE_UNKNOWN as anything in list(TILE_UNKNOWN, TILE_FLOOR, TILE_WALL, TILE_OBSTACLE, TILE_FOG)

turf/default
	icon = 'assets/tileset.dmi'
	icon_state = "default"
	tile_type = TILE_UNKNOWN

turf/tileset
	icon = 'assets/tileset.dmi'

turf/tileset/grass
	icon_state = "grass"
	tile_type = TILE_FLOOR

turf/tileset/stonewall
	icon_state = "stonewall"
	tile_type = TILE_WALL

turf/tileset/stonewalledge
	icon_state = "stonewalledge"
	tile_type = TILE_WALL

turf/tileset/water
	icon_state = "water"
	tile_type = TILE_OBSTACLE

turf/tileset/wateredgestone
	icon_state = "wateredgestone"
	tile_type = TILE_OBSTACLE

obj/indicator
	icon = 'assets/tileset.dmi'
	icon_state = "indicator"
	layer = FLY_LAYER

obj/indicator/New()
	..()
	src.SetColor(src.loc)

obj/indicator/proc/SetColor(turf/t)
	switch (t.tile_type)
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
