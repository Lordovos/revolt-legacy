world
	name = "Revolt Legacy"
	hub = "LordAndrew.RevoltLegacy"
	icon_size = 16
	view = "25x19"
	fps = 40
	turf = /turf/default
	mob = /mob/player

world/New()
	..()
	::version = new (0, 0, 1)
	::chat = new ()

var/list/additional_resources = list(
	/*
		Public Pixel font by GGBotNet (https://ggbot.itch.io/)
		Licensed under CC0 1.0 (https://creativecommons.org/publicdomain/zero/1.0/)
	*/
	'assets/fonts/PublicPixel.ttf'
)
var/version/version
var/obj/chat/chat

// Returns all turfs in a line up to max_dist, and encodes them with the distance from the ref.
proc/get_step_line(atom/ref, dir, max_dist = 1)
	var/list/turfs = list()
	var/turf/t

	if (max_dist < 1)
		return turfs

	for (var/i = 1 to max_dist)
		t = get_step((i == 1) ? ref : t, dir)
		turfs[t] = i

	return turfs

// Returns all turfs within max_dist of start that can be reached, and encodes them with the distance from start.
proc/flood_fill(turf/start, max_dist = 1)
	if (start && isturf(start))
		var/queue/q = new ()
		var/list/turfs = list()

		turfs[start] = 0
		q.Enqueue(start)

		while (!q.Empty())
			var/turf/current = q.Dequeue()

			for (var/d in list(NORTH, SOUTH, EAST, WEST, NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST))
				var/turf/t = get_step(current, d)

				if (t && !(t in turfs))
					var/dist = 1 + turfs[current]

					turfs[t] = dist

					if (t.GetUnit())
						continue

					if (t.tile_type == TILE_WALL || t.tile_type == TILE_OBSTACLE)
						continue

					if (dist > max_dist)
						break

					q.Enqueue(t)

		return turfs
