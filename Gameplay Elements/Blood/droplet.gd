extends RigidBody2D
var targetRotation = PI/2
var offset = -PI/2
var direction = Vector2(5,0)

var SPLATTER = preload("res://Gameplay Elements/Blood/splatter.tscn")

func _ready():
	$AnimatedSprite2D.animation = str(randi_range(0,2))
	$MaxLifespan.wait_time += randf_range(-0.3,0)
	$MaxLifespan.start()
	Globals.debrisList.append(self)
	
func start(directionIn = Vector2(0,0)):
	direction = directionIn
	
func _physics_process(_delta):
	move_and_collide(direction)
	$AnimatedSprite2D.rotation = targetRotation+offset
	offset *= 0.95

func _on_body_entered():
	var splatter = SPLATTER.instantiate()
	splatter.position = position
	add_sibling(splatter)
	Globals.debrisList.erase(self)
	queue_free()
