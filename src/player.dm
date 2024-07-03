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

mob/player/verb/TestText()
	::chat?.Clear()

	var/maptext = "Text\n\n\n"

	for (var/t in icon_states('assets/text.dmi'))
		maptext += "<img src=\"assets/text.dmi\" iconstate=\"[t]\" width=\"8\" height=\"8\">"

	::chat?.Update(maptext)

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
	maptext += "<span style=\"color: [COLOR_PURPLE];\">Dark Orb</span>\n\n\nRarity <span style=\"color: [COLOR_PURPLE];\">Mythic</span>\n\nAn ancient, two-headed weapon enchanted to strike with the force of a catastrophic earthquake. It was once wielded by a powerful member of the <span style=\"color: [COLOR_RED];\">Earth Tribe</span>... One side is a gnarly waraxe, the other a well-used warhammer.\n\n1d16+8"

	::chat?.Clear()
	::chat?.Update(maptext)

mob/player/verb/TestMenu2()
	var/maptext = "Quest Log\n\n\n"
	var/rank = 6
	var/i = 0

	for (var/color in list("#fff", COLOR_RED, COLOR_YELLOW, COLOR_BLUE, COLOR_GREEN, COLOR_GRAY, COLOR_LIGHT, COLOR_PURPLE))
		i += 1

		maptext += "<span style=\"color: [color]\">[i] Text</span>\n"

	for (var/color in list("#fff", COLOR_RED, COLOR_YELLOW, COLOR_BLUE))
		i += 1

		maptext += "<span style=\"color: [color]\">[i] Text</span>\n"

	maptext += "^ v =\n\n\n"
	maptext += "Escape [::checkmark()]\n\n\nRank "

	for (var/r = 1 to rank)
		maptext += ::star()

	maptext += "\n\nYou have been incarcerated in one of the many prisons of the <span style=\"color: [COLOR_RED];\">Lyndolt Empire</span>. Regardless of why you are here, one thing is clear: you must escape. The Empire does not treat its prisoners kindly..."

	::chat?.Clear()
	::chat?.Update(maptext)

mob/player/verb/TestMenu3()
	var/list/abilities = list(
		"Shortsword" = list(
			"name" = "Shortsword",
			"type" = "Active",
			"range" = 1,
			"damage" = "1d4+2"
		),
		"Armor" = list(
			"name" = "Armor",
			"type" = "Passive",
			"effect" = "Physical damage taken reduced by 1."
		)
	)
	var/maptext = "Abilities\n\n\n"

	for (var/a in abilities)
		var/list/ability = abilities[a]
		var/type = ability["type"]

		maptext += "[ability["name"]]\n"
		maptext += "[type]\n"

		if (type == "Active")
			maptext += "Range  [ability["range"]]\n"
			maptext += "Damage [ability["damage"]]\n"

		else if (type == "Passive")
			maptext += "Effect [ability["effect"]]\n"

		maptext += "\n"

	::chat?.Clear()
	::chat?.Update(maptext)

proc/star()
	return "<img src=\"assets/text.dmi\" iconstate=\"star\" width=\"8\" height=\"8\">"

proc/checkmark()
	return "<img src=\"assets/text.dmi\" iconstate=\"checkmark\" width=\"8\" height=\"8\">"

mob/player/verb/NextTurn()
	for (var/mob/unit/u in world)
		if (!u.is_dead)
			u.SetMove(u.max_move)

	if (src.client)
		src.client.selected_unit?.RenderMoves()

	::chat?.Update("Next turn.")
