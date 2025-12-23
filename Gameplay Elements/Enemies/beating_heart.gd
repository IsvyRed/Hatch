extends AnimatedSprite2D
var breakAnims = ["BreakA","BreakB","BreakC"]
func die():
	set_animation(breakAnims[randi_range(0,2)])

func _on_animation_finished():
	Globals.debrisList.erase(self)
	queue_free()
