extends Marker2D
func play():
	$AfterImage.play()

func _on_after_image_animation_finished():
	queue_free()
