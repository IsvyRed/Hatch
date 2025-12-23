extends AnimatedSprite2D

func _ready():
	if Globals.lastDirection.x == 200:
		flip_h = true
	play()

func _physics_process(_delta):
	scale *= 0.97
