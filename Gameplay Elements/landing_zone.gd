extends AnimatedSprite2D
func _ready():
	animation = str(randi_range(0,1))
	Globals.debrisList.append(self)
	play()
