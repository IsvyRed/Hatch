extends Area2D
var explodechance = randi_range(0,5)

func _ready():
	Globals.debrisList.append(self)
	
func destroy():
	var posTween = create_tween()
	posTween.tween_property(self,"position", position + Globals.lastDirection/randi_range(2,30), 0.3).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	var rotateTween = create_tween()
	rotateTween.tween_property(self,"rotation",randi_range(-2,2),0.3).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	if explodechance == 1:
		explode()
	
func explode():
	Globals.debrisList.erase(self)
	print("debris destroyed")
	queue_free()
