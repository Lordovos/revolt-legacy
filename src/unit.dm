mob/unit
	icon = 'assets/units.dmi'
	icon_state = "default"
	pixel_y = 4
	appearance_flags = PIXEL_SCALE

	var/job as text
	var/level = 0 as num
	var/move_dist = 0 as num
	var/health = 0 as num
	var/max_health = 0 as num
	var/is_dead = FALSE as anything in list(TRUE, FALSE)
	var/magic = 0 as num
	var/max_magic = 0 as num
	var/magic_regen = 0 as num
	var/action = 0 as num
	var/max_action = 0 as num
	var/list/abilities

mob/unit/New()
	..()
	src.SetHealth(src.max_health)
	src.SetMagic(src.max_magic)
	src.SetAction(src.max_action)

mob/unit/Click()
	var/client/c = usr.client
	var/obj/tile_indicator/indicator
	var/list/turfs

	if (c)
		if (c.selected_unit == src)
			c.selected_unit.Unselect(c)

		else if (c.selected_unit != src)
			c.selected_unit?.Unselect(c)
			src.Select(c)

			if (!src.is_dead)
				turfs = oview(src.move_dist, src) - src.loc

				for (var/turf/t in turfs)
					indicator = new (t)
					animate(indicator, alpha = 0, time = 10, delay = 20)

					spawn (30)
						indicator.loc = null

mob/unit/proc/Select(client/c)
	c.selected_unit = src
	c.unit_indicator?.Draw()
	src.vis_contents += c.unit_indicator
	// c.chat?.Update("[src.name]\n[src.job], LV [src.level]\nMOVE [src.move_dist]\nHP [src.health]/[src.max_health]\nMP [src.magic]/[src.max_magic]\nREGEN [src.magic_regen]\nAP [src.action]/[src.max_action]")

mob/unit/proc/Unselect(client/c)
	c.selected_unit = null
	src.vis_contents -= c.unit_indicator

mob/unit/proc/SetHealth(n)
	src.health = clamp(n, 0, src.max_health)

mob/unit/proc/SetMagic(n)
	src.magic = clamp(n, 0, src.max_magic)

mob/unit/proc/SetAction(n)
	src.action = clamp(n, 0, src.max_action)

mob/unit/proc/Death()
	::chat?.Update("[src.name] dies.")
	src.icon_state = "grave"

mob/unit/verb/Damage()
	set src in world

	if (src.is_dead)
		::chat?.Update("[src.name] is already dead.")

	else
		var/damage = roll("1d6+3")

		new /obj/unit_message(null, src, damage)
		src.SetHealth(src.health - damage)
		::chat?.Update("[src.name] takes [damage] damage! (HP [src.health]/[src.max_health])")

		if (src.health == 0)
			src.is_dead = TRUE
			src.Death()

mob/unit/recruit
	name = "Recruit"
	icon_state = "recruit"
	job = "Recruit"
	level = 1
	move_dist = 4
	max_health = 20
	max_magic = 5
	magic_regen = 1
	max_action = 2

mob/unit/vagrant
	name = "Vagrant"
	icon_state = "vagrant"
	job = "Vagrant"
	level = 1
	move_dist = 3
	max_health = 10
	max_action = 2
