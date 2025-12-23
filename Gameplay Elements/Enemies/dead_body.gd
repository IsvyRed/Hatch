extends RigidBody2D
var airborne = true
var motion = Vector2(0,0)
var locLastDirection
var falling = false

func _ready():
	Globals.debrisList.append(self)
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
	else:
		scale *= 0.9
		if motion.y > 10:
			z_index = 2
	
func fall(_body):
	falling = true
	var chance = abs(motion.x + motion.y)
	var judge = randi_range(0,15)
	if chance > judge:
		$FallSpan.start()
		set_collision_mask_value(6,false)
		z_index = -2
		gravity_scale = 6
		angular_velocity = motion.x/3


func _on_fall_span_timeout():
	Globals.debrisList.erase(self)
	queue_free()
