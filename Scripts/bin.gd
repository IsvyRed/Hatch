extends RigidBody2D
var intact = true
var motion = Vector2(0,0)
var GARBAGE = preload("res://Gameplay Elements/Destructibles/garbage.tscn")
var locLastDirection
var animHash 
var falling = false

func _ready():
	Globals.debrisList.append(self)
	animHash = {Vector2(-200.0,0.0): $FallH, Vector2(200.0,0.0): $FallH, Vector2(0.0,200.0): $FallD, Vector2(0.0,-200.0): $FallU,}

func destroy(direction = Globals.lastDirection):
	locLastDirection = direction
	motion += direction/(randi_range(4,10))
	if intact:
		animHash[direction].play()
		animHash[direction].visible = true
		$IntactSprite.queue_free()
		intact = false
		
		for i in range(2):
			var trashinst = GARBAGE.instantiate()
			trashinst.destroy(direction*5)
			trashinst.position = position
			Globals.debrisList.append(trashinst)
			add_sibling(trashinst)
			trashinst.setType(i)
		
	
func _physics_process(_delta):
	move_and_collide(motion)
	if not falling:
		motion /= 1.5
	else:
		scale /= 1.5

	
func explode():
	Globals.debrisList.erase(self)
	print("debris destroyed")
	queue_free()

func fall(_body):
	falling = true
	var chance = abs(motion.x + motion.y)
	var judge = randi_range(0,30)
	if chance > judge:
		set_collision_layer_value(6,false)
		z_index = -2
		motion += locLastDirection/15
		gravity_scale = 6
		angular_velocity = motion.x/3
