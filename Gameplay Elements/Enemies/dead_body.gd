extends RigidBody2D
var airborne = true
var motion = Vector2(0,0)
var locLastDirection
var falling = false
#stuff for blood
var BLOODTRAIL = preload("res://Gameplay Elements/Blood/blood_trail.tscn")
var BLOODPOOL = preload("res://Gameplay Elements/Blood/blood_pool.tscn")
var bleeding = false
var initPos
var pooling = false

func _ready():
	Globals.debrisList.append(self)
	initPos = position
	#Choose proper animation here
	$Sprite2D.set_animation("RightA")
	if Globals.lastDirection == Vector2(-200,0):
		$Sprite2D.flip_h = true
	if Globals.lastDirection == Vector2(0,200) or Globals.lastDirection == Vector2(0,-200):
		$Sprite2D.set_animation("UpA")
	$Sprite2D.play()
	
func destroy(direction = Globals.lastDirection):
	locLastDirection = direction
	motion += direction/(randi_range(4,5))
	
func _physics_process(_delta):
	move_and_collide(motion)
	if not falling:
		motion /= 1.5
		if bleeding and abs(position.x) > abs(initPos.x) + 40:
			var trail = BLOODTRAIL.instantiate()
			trail.position = position
			initPos = position 
			add_sibling(trail)
		elif bleeding and abs(position.y) > abs(initPos.y) + 40:
			var trail = BLOODTRAIL.instantiate()
			trail.rotation_degrees = 90
			trail.position = position
			initPos = position 
			add_sibling(trail)
		if bleeding and abs(motion.x) + abs(motion.y) < 1  and not pooling:
			pooling = true
			var pool = BLOODPOOL.instantiate()
			pool.position = position
			initPos = position 
			add_sibling(pool)
	else:
		scale *= 0.9
		if motion.y > 10:
			z_index = 2
	
func fall(_body):
	falling = true
	$FallSpan.start()
	set_collision_mask_value(6,false)
	z_index = -2
	gravity_scale = 6
	angular_velocity = motion.x/3


func _on_fall_span_timeout():
	queue_free()
