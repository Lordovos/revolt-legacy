client
	var/mob/unit/selected_unit
	var/obj/unit_indicator/unit_indicator

client/New()
	src.unit_indicator = new ()

	return ..()
