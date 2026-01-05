extends RigidBody2D
var intact = true
var leftTexture = preload("res://Sprites/Destructibles/Printer/HitL.tres")
var rightTexture = preload("res://Sprites/Destructibles/Printer/HitR.tres")
var neutralTexture = preload("res://Sprites/Destructibles/Printer/HitN.tres")
var papers = preload("res://Gameplay Elements/Destructibles/papers.tscn")
var motion = Vector2(0,0)


func _ready():
	Globals.debrisList.append(self)

func destroy():
	motion += Globals.lastDirection/(randi_range(30,35))
	if Globals.lastDirection == Vector2(-200,0):
		$Sprite2D.sprite_frames = leftTexture
		$Sprite2D.play()
		if intact:
			intact = false
			for i in range(3):
				var paperinst = papers.instantiate()
				paperinst.scale = Vector2(5,5)
				add_child(paperinst)
				paperinst.position.x -= randi_range(-1,3)*5
				paperinst.setType(i)
	elif Globals.lastDirection == Vector2(200,0):
		$Sprite2D.sprite_frames = rightTexture
		$Sprite2D.play()
		if intact:
			intact = false
			for i in range(3):
				var paperinst = papers.instantiate()
				add_child(paperinst)
				paperinst.scale = Vector2(5,5)
				paperinst.get_children()[i].flip_h = true
				paperinst.position.x += randi_range(-1,4)*5
				paperinst.setType(i)
	else:
		$Sprite2D.sprite_frames = neutralTexture
		$Sprite2D.play()
		if intact:
			intact = false
			for i in range(2):
				var paperinst = papers.instantiate()
				add_child(paperinst)
				paperinst.scale = Vector2(5,5)
				var flip = randi()
				if flip % 2 == 0:
					paperinst.get_children()[i].flip_h = true
				paperinst.position.x += randi_range(-2,2)*5
				paperinst.setType(i)
func _physics_process(_delta):
	move_and_collide(motion)
	motion /= 1.5

	
func explode():
	queue_free()
