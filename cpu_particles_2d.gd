extends CPUParticles2D

func emit(directionIn):
	direction = directionIn
	direction.y += 0.3  
	emitting = true

func _on_finished():
	queue_free()
