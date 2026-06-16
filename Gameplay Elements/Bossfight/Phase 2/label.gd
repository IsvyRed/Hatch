extends Label
func _physics_process(delta):
	text = str(get_parent().z_index)
