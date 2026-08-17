extends Marker2D
func play():
	$AfterImage.play()
	$CPUParticles2D.emitting = true

func _on_after_image_animation_finished():
	queue_free()
