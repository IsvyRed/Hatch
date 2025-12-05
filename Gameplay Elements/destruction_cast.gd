extends ShapeCast2D
func _physics_process(delta):
	var collisionCount = get_collision_count()
	for i in range(collisionCount):
		get_collider(i).destroy()
	queue_free()
