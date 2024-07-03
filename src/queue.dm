queue
	var/list/elements

queue/New()
	src.elements = list()

queue/proc/Push(element)
	if (src.elements)
		src.elements += element

queue/proc/Pop()
	if (src.elements && src.elements.len > 0)
		var/element = src.elements[1]

		src.elements?.Cut(1, 2)
		return element

queue/proc/IsEmpty()
	return (src.elements && src.elements == 0)
