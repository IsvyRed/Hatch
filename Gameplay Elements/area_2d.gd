extends RigidBody2D

func destroy():
	pass
	
func _physics_process(_delta):
	move_and_collide(Globals.lastDirection/20)
