extends Marker2D
#STATE MACHINE FUNCTIONS
func enter():
	Globals.sceneCamera.targetPos = Vector2(0,0)
	Globals.sceneCamera.position = Vector2(0,0)
	visible = true
func update():
	pass
func exit():
	get_parent().progress()
