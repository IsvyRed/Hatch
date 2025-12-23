extends AnimatedSprite2D
func die():
	Globals.debrisList.erase(self)
	queue_free()
