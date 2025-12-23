extends PathFollow2D
var HEART = preload("res://Gameplay Elements/Enemies/beating_heart.tscn")
var heart
func _physics_process(_delta):
	progress_ratio += 0.005
	heart.global_position = global_position + Vector2(640,360) + (Globals.sceneCamera.global_position * -1)
	
func _ready():
	heart = HEART.instantiate()
	heart.play()
	Globals.debrisList.append(heart)
	Globals.normalLayer.add_child(heart)

func die():
	#PLAY EXPLOSION ANIM
	heart.die()
	queue_free()
