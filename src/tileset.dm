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
			::chat?.Update("[u.name] is dead.")

		else if (!(src in u.path) || (src in u.path) && u.path[src] > u.move)
			::chat?.Update("Beyond [u.name]'s movement range.")

		else if (src.tile_type == TILE_WALL || src.tile_type == TILE_OBSTACLE)
			::chat?.Update("[u.name] cannot move there.")

		else
			var/dist = get_dist(u, src)
			world << dist

			for (var/i = 1 to dist)
				if (u.move > 0)
					var/move = u.move - 1

					step_towards(u, src)
					u.SetMove(move)

				sleep (world.tick_lag * 10)

			var/obj/tile_indicator/indicator

			for (var/turf/t in u.path)
				t.maptext = null

				for (indicator in t)
					indicator.loc = null

			u.path = ::flood_fill(u.loc, u.move)

			for (var/turf/t in u.path)
				if (u.path[t] == 0 || u.path[t] > u.move)
					continue

				if (t.GetUnit())
					continue

				t.maptext = "<span style=\"text-align: right; margin-right: 4px; color: #fff; text-shadow: 1px 1px 0 #000;\">[u.path[t]]</span>"
				new /obj/tile_indicator(t)

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
