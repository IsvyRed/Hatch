extends PathFollow2D
func _physics_process(delta):
	progress_ratio += 0.01
func die():
	#PLAY EXPLOSION ANIM
	queue_free()
