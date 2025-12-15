extends Sprite2D

func _physics_process(_delta):
	#REPLACE TYPE AND ALL OF THIS WITH A PROPER ANIMATION
	scale /= 1.1
	position += Globals.lastDirection/100
	position.y += 10
	position.y += 2
