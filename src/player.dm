mob/player
	density = FALSE

mob/player/Login()
	..()
	::chat?.Update("Hello, world! Welcome to Revolt Legacy.")
	::chat?.Update("v[::version.Get()]")

mob/player/verb/GetStepLine()
	var/obj/tile_indicator/indicator
	var/list/turfs = ::get_step_line(src, src.dir, 5)

	for (var/turf/t in turfs)
		indicator = new (t)
		animate(indicator, alpha = 0, time = 10, delay = 20)
		t.maptext = "<span style=\"text-align: right; margin-right: 4px; color: #fff; text-shadow: 1px 1px 0 #000;\">[turfs[t]]</span>"

		spawn (30)
			indicator.loc = null
			t.maptext = null

		for (var/mob/unit/u in t)
			var/crit = rand(0, 10)
			var/damage_roll = "1d20"

			if (crit == 7)
				damage_roll += "+20"
				::chat?.Update("Critical hit!")

			else
				damage_roll += "+10"

			var/damage = roll(damage_roll)

			new /obj/unit_message(null, u, damage)
			u.SetHealth(u.health - damage)
			::chat?.Update("[u.name] takes [damage] damage! (HP [u.health]/[u.max_health])")

			if (u.health == 0)
				u.is_dead = TRUE
				u.Death()

mob/player/verb/GetStepLineInterrupt()
	var/obj/tile_indicator/indicator
	var/list/turfs = ::get_step_line(src, src.dir, 5)

	for (var/turf/t in turfs)
		indicator = new (t)
		animate(indicator, alpha = 0, time = 10, delay = 20)
		t.maptext = "<span style=\"text-align: right; margin-right: 4px; color: #fff; text-shadow: 1px 1px 0 #000;\">[turfs[t]]</span>"

		spawn (30)
			indicator.loc = null
			t.maptext = null

		if (t.tile_type == TILE_WALL || t.tile_type == TILE_FOG)
			break
/*
mob/player/verb/GetView()
	var/obj/tile_indicator/indicator
	var/list/turfs = oview(4, src) - src.loc

	for (var/turf/t in turfs)
		indicator = new (t)
		animate(indicator, alpha = 0, time = 10, delay = 20)

		spawn (30)
			indicator.loc = null
*/
mob/player/verb/FloodFill()
	var/obj/tile_indicator/indicator
	var/list/turfs = ::flood_fill(src.loc, 5)

	for (var/turf/t in turfs)
		if (turfs[t] == 0 || turfs[t] > 5)
			continue

		indicator = new (t)
		animate(indicator, alpha = 0, time = 10, delay = 20)
		t.maptext = "<span style=\"text-align: right; margin-right: 4px; color: #fff; text-shadow: 1px 1px 0 #000;\">[turfs[t]]</span>"

		spawn (30)
			indicator.loc = null
			t.maptext = null
