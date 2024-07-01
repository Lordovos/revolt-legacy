mob/unit
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
	src.UpdateHealth(src.max_health)
	src.UpdateMagic(src.max_magic)
	src.UpdateAction(src.max_action)

mob/unit/verb/Test()
	set src in world

	for (var/v in src.vars)
		world << "[v] = [src.vars[v]]"

mob/unit/verb/Damage()
	set src in world

	if (src.is_dead)
		world << "[src.name] is already dead."

	else
		var/damage = rand(1, 10)

		new /obj/unit_message(null, src, damage)
		world << "[src.name] takes [damage] damage!"
		src.UpdateHealth(src.health - damage)

mob/unit/proc/UpdateHealth(n)
	src.health = clamp(n, 0, src.max_health)

	if (src.health == 0)
		src.is_dead = TRUE
		src.Death()

mob/unit/proc/UpdateMagic(n)
	src.magic = clamp(n, 0, src.max_magic)

mob/unit/proc/UpdateAction(n)
	src.action = clamp(n, 0, src.max_action)

mob/unit/proc/Death()
	world << "[src.name] dies."

mob/unit/test
	name = "Temporal Knight"
	color = COLOR_BLUE
	job = "Temporal Knight"
	level = 17
	move_dist = 5
	max_health = 30
	max_magic = 85
	magic_regen = 20
	max_action = 5

mob/unit/Click()
	var/client/c = usr?.client

	if (c)
		if (c.selected_unit == src)
			c.selected_unit.Unselect(c)

		else if (c.selected_unit != src)
			c.selected_unit?.Unselect(c)
			src.Select(c)

mob/unit/proc/Select(client/c)
	c.selected_unit = src
	c.unit_indicator?.Update(src)
	src.vis_contents += c.unit_indicator

mob/unit/proc/Unselect(client/c)
	c.selected_unit = null
	src.vis_contents -= c.unit_indicator

mob/unit/giant
	bound_width = 32
	bound_height = 32
	name = "Giant"
	color = COLOR_YELLOW
	job = "Berserker"
	level = 23
	move_dist = 3
	max_health = 60
	max_magic = 10
	magic_regen = 2
	max_action = 3

mob/unit/giant/New()
	..()
	// src.transform *= 2
