mob/player
	density = FALSE

mob/player/Login()
	..()
	::chat?.Update("Hello, world! Welcome to Revolt Legacy.")
	::chat?.Update("v[::version.Get()]")

mob/player/verb/ClearChat()
	::chat?.Clear()

mob/player/verb/NextTurn()
	for (var/mob/unit/u in world)
		if (!u.is_dead)
			u.SetMove(u.max_move)

	if (src.client)
		src.client.selected_unit?.Unselect(src.client)

	::chat?.Update("Next turn.")
