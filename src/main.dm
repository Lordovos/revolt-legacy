world
	name = "Revolt Legacy"
	hub = "LordAndrew.RevoltLegacy"
	icon_size = 16
	view = "25x19"
	fps = 40
	turf = /turf/default

mob
	icon = 'assets/units.dmi'
	icon_state = "default"

mob/Login()
	..()
	src << "Hello, world!"

proc/get_step_line(atom/ref, dir, dist = 1)
	var/list/turfs = list()
	var/turf/t

	if (dist < 1)
		return turfs

	for (var/i = 1 to dist)
		t = get_step((i == 1) ? ref : t, dir)
		turfs += t

	return turfs

mob/verb/GetStepLine()
	var/obj/indicator/indicator
	var/list/turfs = get_step_line(src, src.dir, 5)

	for (var/turf/t in turfs)
		indicator = new (t)

		if (t.tile_type == TILE_FLOOR)
			indicator.color = "#66ccff"

		else if (t.tile_type == TILE_WALL)
			indicator.color = "#f83800"

		else if (t.tile_type == TILE_OBSTACLE)
			indicator.color = "#f8b800"

		else if (t.tile_type == TILE_FOG)
			indicator.color = "#83d12c"

		else if (t.tile_type == TILE_UNKNOWN)
			indicator.color = "#d2d2c4"

		animate(indicator, alpha = 0, time = 10, delay = 20)

mob/verb/GetStepLineInterrupt()
	var/obj/indicator/indicator
	var/list/turfs = get_step_line(src, src.dir, 5)

	for (var/turf/t in turfs)
		indicator = new (t)

		if (t.density)
			indicator.color = "#f83800"

		animate(indicator, alpha = 0, time = 10, delay = 20)

		if (t.density)
			break

mob/verb/GetView()
	var/obj/indicator/indicator
	var/list/turfs = view(src, 5)

	for (var/turf/t in turfs)
		indicator = new (t)

		if (t.density)
			indicator.color = "#f83800"

		animate(indicator, alpha = 0, time = 10, delay = 20)
