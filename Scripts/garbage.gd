extends RigidBody2D
var selectedType = 0
var motion = Vector2(0,0)

func setType(type):
	$Anims.get_children()[type].visible = true
	$Anims.get_children()[type].play()
	selectedType = type

func destroy(direction = Globals.lastDirection):
	motion += direction/(randi_range(7,15))
	motion.x += randi_range(-10,10)
	motion.y += randi_range(-10,10)
	$Anims.get_children()[selectedType].play()
	
func _physics_process(_delta):
	move_and_collide(motion)
	motion /= 2
