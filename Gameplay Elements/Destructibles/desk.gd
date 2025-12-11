extends Area2D
var intact = true
var leftTexture = preload("res://Sprites/Destructibles/Desk/DeskL.png")
var rightTexture = preload("res://Sprites/Destructibles/Desk/DeskR.png")
var papers = preload("res://Gameplay Elements/Destructibles/papers.tscn")

func _ready():
	Globals.debrisList.append(self)

func destroy():
	var posTween = create_tween()
	posTween.tween_property(self,"position", position + Globals.lastDirection/randi_range(2,30), 0.3).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	if Globals.lastDirection == Vector2(-200,0):
		$Sprite2D.texture = leftTexture
		if intact:
			intact = false
			for i in range(3):
				var paperinst = papers.instantiate()
				add_child(paperinst)
				paperinst.position.x -= 10
				paperinst.setType(i)
	elif Globals.lastDirection == Vector2(200,0):
		$Sprite2D.texture = rightTexture
		if intact:
			intact = false
			for i in range(3):
				var paperinst = papers.instantiate()
				add_child(paperinst)
				paperinst.get_children()[i].flip_h = true
				paperinst.position.x += 10
				paperinst.setType(i)
		
	

	
func explode():
	Globals.debrisList.erase(self)
	print("debris destroyed")
	queue_free()
