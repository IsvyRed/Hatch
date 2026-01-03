extends Node

func dropLevel(floor = Globals.floor):
	for child in get_children():
		child.scroll_offset.y = (20 * child.scroll_scale.y) * - floor
