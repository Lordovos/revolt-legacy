queue
	var/list/elements

queue/New()
	src.elements = list()

queue/proc/Enqueue(element)
	if (src.elements)
		src.elements += element

queue/proc/Dequeue()
	if (!src.Empty())
		var/element = src.Front()

		src.elements?.Cut(1, 2)
		return element

queue/proc/Empty()
	return (src.Size() == 0)

queue/proc/Front()
	if (!src.Empty())
		return src.elements[1]

queue/proc/Size()
	return src.elements?.len
