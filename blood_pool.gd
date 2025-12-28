extends AnimatedSprite2D
func _ready():
	Globals.debrisList.append(self)
	animation = str(randi_range(0,1))
	play()
