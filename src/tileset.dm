turf
	var/tile_type = TILE_UNKNOWN as anything in list(TILE_UNKNOWN, TILE_FLOOR, TILE_WALL, TILE_OBSTACLE, TILE_FOG)

// Returns the unit standing on the turf, or null if there is nothing there. Only one unit can stand on any given turf... in theory.
turf/proc/GetUnit()
	var/mob/unit/u = locate() in src

	return u

turf/Click()
	var/client/c = usr.client

	if (c && c.selected_unit)
		var/mob/unit/u = c.selected_unit

		if (u.is_dead)
			new /obj/unit_message(null, u, "Dead")

		else if (u.is_busy)
			new /obj/unit_message(null, u, "Busy")

		else if (!(src in u.moves) || (src in u.moves) && u.moves[src] > u.move)
			new /obj/unit_message(null, u, "<span style=\"color: [COLOR_RED];\">X</span>")

		else if (src.tile_type in list(TILE_WALL, TILE_OBSTACLE))
			new /obj/unit_message(null, u, "<span style=\"color: [COLOR_RED];\">X</span>")

		else if (src.GetUnit())
			new /obj/unit_message(null, u, "<span style=\"color: [COLOR_RED];\">X</span>")

		else
			var/dist = get_dist(u, src)

			for (var/i = 1 to dist)
				if (u.move > 0)
					var/move = u.move - 1

					u.is_busy = TRUE
					step_towards(u, src)
					u.SetMove(move)
					c.mob.loc = u.loc

				sleep (world.tick_lag * 10)

			u.is_busy = FALSE

			var/obj/tile_indicator/indicator

			for (var/turf/t in u.moves)
				for (indicator in t)
					indicator.loc = null

			if (u.move > 0)
				u.RenderMoves()

			else
				u.moves = list()

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
