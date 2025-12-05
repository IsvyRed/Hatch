extends Area2D
var explodechance = randi_range(0,5)
func destroy():
	position += Globals.lastDirection/randi_range(2,30)
	rotate(randi_range(-3,3))
	if explodechance == 1:
		explode()
	
func explode():
	print("debris destroyed")
	queue_free()
