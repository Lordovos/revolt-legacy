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

mob/verb/GetView()
	var/obj/indicator/indicator = new ()
	var/list/turfs = view(src, 5)

	indicator.color = "#f83800"

	for (var/turf/t in turfs)
		t.vis_contents += indicator

	sleep (40)

	for (var/turf/t in turfs)
		t.vis_contents -= indicator
