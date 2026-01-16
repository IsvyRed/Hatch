extends Marker2D
#STATE MACHINE FUNCTIONS
func enter():
	visible = true
func update():
	pass
func exit():
	get_parent().progress()
