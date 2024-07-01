mob/player
	density = FALSE

mob/player/verb/GetStepLine()
	var/obj/tile_indicator/indicator
	var/list/turfs = ::get_step_line(src, src.dir, 5)

	for (var/turf/t in turfs)
		indicator = new (t)
		animate(indicator, alpha = 0, time = 10, delay = 20)

		spawn (30)
			indicator.loc = null

mob/player/verb/GetStepLineInterrupt()
	var/obj/tile_indicator/indicator
	var/list/turfs = ::get_step_line(src, src.dir, 5)

	for (var/turf/t in turfs)
		indicator = new (t)
		animate(indicator, alpha = 0, time = 10, delay = 20)

		spawn (30)
			indicator.loc = null

		if (t.tile_type == TILE_WALL || t.tile_type == TILE_FOG)
			break

mob/player/verb/GetView()
	var/obj/tile_indicator/indicator
	var/list/turfs = oview(4, src) - src.loc

	for (var/turf/t in turfs)
		indicator = new (t)
		animate(indicator, alpha = 0, time = 10, delay = 20)

		spawn (30)
			indicator.loc = null
