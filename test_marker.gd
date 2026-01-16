extends PathFollow2D
func _physics_process(_delta):
	progress_ratio += 0.005
func die(temp):
	queue_free()
