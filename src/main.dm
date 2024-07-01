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

var/version/version
var/obj/chat/chat

proc/get_step_line(atom/ref, dir, dist = 1)
	var/list/turfs = list()
	var/turf/t

	if (dist < 1)
		return turfs

	for (var/i = 1 to dist)
		t = get_step((i == 1) ? ref : t, dir)
		turfs += t

	return turfs
