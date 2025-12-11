extends Marker2D

func setType(type):
	get_children()[type].visible = true
	get_children()[type].play()



func _on_animation_finished():
	queue_free()
