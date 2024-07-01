version
	var/major = 0
	var/minor = 0
	var/patch = 0

version/New(major, minor, patch)
	src.major = major
	src.minor = minor
	src.patch = patch

version/proc/Get()
	return "[src.major].[src.minor].[src.patch]"
