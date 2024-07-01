mob/unit
	icon_state = "default"
	pixel_y = 4
	appearance_flags = PIXEL_SCALE

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
	pixel_x = 8
	pixel_y = 12
	bound_width = 32
	bound_height = 32

mob/unit/giant/New()
	..()
	src.transform *= 2
