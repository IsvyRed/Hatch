extends RigidBody2D
var intact = true
var motion = Vector2(0,0)
var GARBAGE = preload("res://Gameplay Elements/Destructibles/garbage.tscn")

var animHash 

func _ready():
	Globals.debrisList.append(self)
	animHash = {Vector2(-200.0,0.0): $FallH, Vector2(200.0,0.0): $FallH, Vector2(0.0,200.0): $FallD, Vector2(0.0,-200.0): $FallU,}

func destroy(direction = Globals.lastDirection):
	motion += direction/(randi_range(4,10))
	if intact:
		animHash[direction].play()
		animHash[direction].visible = true
		$IntactSprite.queue_free()
		intact = false
		
		for i in range(2):
			var trashinst = GARBAGE.instantiate()
			trashinst.destroy(direction)
			add_child(trashinst)
			trashinst.setType(i)
		
	
func _physics_process(_delta):
	move_and_collide(motion)
	motion /= 1.5

	
func explode():
	Globals.debrisList.erase(self)
	print("debris destroyed")
	queue_free()
