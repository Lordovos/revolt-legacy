mob/player
	density = FALSE

mob/player/Login()
	..()
	::chat?.Update("Hello, world! Welcome to Revolt Legacy v[::version.Get()].")

mob/player/verb/Say(t as text)
	if (istext(t))
		::chat?.Update(t)

mob/player/verb/ClearChat()
	::chat?.Clear()

mob/player/verb/FillChat()
	for (var/i = 1 to 36)
		if (i == 2 || i == 3)
			::chat?.Update("\n")

		else
			// ::chat?.Update("012345678901234567890123456789012345678901234567")
			::chat?.Update(i)

mob/player/verb/TestMenu()
	var/maptext = "Inventory\n\n\n"
	var/i = 0

	for (var/color in list("#fff", COLOR_RED, COLOR_YELLOW, COLOR_BLUE, COLOR_GREEN, COLOR_GRAY, COLOR_LIGHT, COLOR_PURPLE))
		i += 1

		maptext += "<span style=\"color: [color]\">[i] Text</span>\n"

	for (var/color in list("#fff", COLOR_RED, COLOR_YELLOW, COLOR_BLUE, COLOR_GREEN, COLOR_GRAY, COLOR_LIGHT, COLOR_PURPLE))
		i += 1

		maptext += "<span style=\"color: [color]\">[i] Text</span>\n"

	maptext += "^ v =\n\n\n"
	maptext += "<span style=\"color: [COLOR_RED];\">Terra Enigma</span>\n\n\n<span style=\"color: [COLOR_RED];\">Legendary</span>\n\nAn ancient, two-headed weapon enchanted to strike with the force of a catastrophic earthquake. It was once wielded by a powerful member of the <span style=\"color: [COLOR_RED];\">Earth Tribe</span>... One side is a gnarly waraxe, the other a well-used warhammer.\n\n1d16+8\n"

	::chat?.Clear()
	::chat?.Update(maptext)

mob/player/verb/NextTurn()
	for (var/mob/unit/u in world)
		if (!u.is_dead)
			u.SetMove(u.max_move)

	if (src.client)
		src.client.selected_unit?.RenderMoves()

	::chat?.Update("Next turn.")
