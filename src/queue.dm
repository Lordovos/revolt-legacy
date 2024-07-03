queue
	var/list/elements

queue/New()
	src.elements = list()

queue/proc/Push(element)
	if (src.elements)
		src.elements += element

queue/proc/Pop()
	if (!src.IsEmpty())
		var/element = src.elements[1]

		src.elements?.Cut(1, 2)
		return element

queue/proc/IsEmpty()
	return (src.elements?.len == 0)
