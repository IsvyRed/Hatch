extends PathFollow2D
func _physics_process(_delta):
	progress_ratio += 0.005
func die():
	#PLAY EXPLOSION ANIM
	queue_free()
