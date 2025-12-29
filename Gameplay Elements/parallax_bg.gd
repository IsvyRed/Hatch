extends Node

func dropLevel():
	for child in get_children():
		child.scroll_offset.y = (20 * child.scroll_scale.y) * - Globals.floor
