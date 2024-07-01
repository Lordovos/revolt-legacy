world
	name = "Revolt Legacy"
	hub = "LordAndrew.RevoltLegacy"
	icon_size = 16
	view = "25x19"
	fps = 40
	turf = /turf/default
	mob = /mob/player

mob
	icon = 'assets/units.dmi'

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
	var/obj/tile_indicator/indicator
	var/list/turfs = ::get_step_line(src, src.dir, 5)

	for (var/turf/t in turfs)
		indicator = new (t)
		animate(indicator, alpha = 0, time = 10, delay = 20)

		spawn (30)
			indicator.loc = null

mob/verb/GetStepLineInterrupt()
	var/obj/tile_indicator/indicator
	var/list/turfs = ::get_step_line(src, src.dir, 5)

	for (var/turf/t in turfs)
		indicator = new (t)
		animate(indicator, alpha = 0, time = 10, delay = 20)

		spawn (30)
			indicator.loc = null

		if (t.tile_type == TILE_WALL || t.tile_type == TILE_FOG)
			var/obj/unit_message/um = new (null, "WALL")

			t.vis_contents += um

			spawn (30)
				t.vis_contents -= um
				um.loc = null

			break

mob/verb/GetView()
	var/obj/tile_indicator/indicator
	var/list/turfs = oview(4, src) - src.loc

	for (var/turf/t in turfs)
		indicator = new (t)
		animate(indicator, alpha = 0, time = 10, delay = 20)

		spawn (30)
			indicator.loc = null

		if (t.tile_type == TILE_WALL || t.tile_type == TILE_FOG)
			var/obj/unit_message/um = new (null, "WALL")

			t.vis_contents += um

			spawn (30)
				t.vis_contents -= um
				um.loc = null
